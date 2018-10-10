require 'sinatra'

require 'securerandom'
require 'json'
require 'rest-client'

enable :sessions
set :session_secret, '*&(^B234'

GATEWAY = ENV['GATEWAY'] || "http://localhost:8080"
CALLBACK_URI = ENV['CALLBACK_URI'] || "https://quiet-eyrie-28276.herokuapp.com/callback"
APIGEE_URL = ENV['APIGEE_URL'] || "https://merrill-test.apigee.net"
EDGEMICRO_URL = ENV['EDGEMICRO_URL'] || "https://stageapi.core.merrillcorp.com"
APIGEE_APP_KEY = ENV['APIGEE_APP_KEY'] || "6r4yjxwdy1XcQJ2kjeZ6IoaoenmJZJeU"


get("/") do
  @state = SecureRandom.uuid
  session[:state] = @state
  erb :root
end

get("/callback") do
  @code = params[:code]
  @implicit_grant_access_token = params[:access_token]
  erb :root
end

post("/token") do
  begin
    grant_type = params[:grant_type]
    token_endpoint = params[:token_endpoint]
    apigee_service = params[:apigee_service]
    client_id = params[:client_id]
    redirect_uri = ""
    code = ""
    username = ""
    password = ""
    refresh_token = params[:refresh_token]
    if refresh_token == nil
      refresh_token = ""
    end
    if grant_type == "authorization_code"
      code = params[:code]
      redirect_uri = params[:redirect_uri]
    end
    if grant_type == "password"
      username = params[:username]
      password = params[:password]
    end
    scope = params[:scope]
    if scope == nil
      scope = ""
    end
    resource = params[:resource]
    if resource == nil
      resource = ""
    end
    sslValidate = params[:sslValidate]
    if sslValidate == nil
      sslValidate = false
    elsif sslValidate == "false"
      sslValidate = false
    elsif sslValidate == "true"
      sslValidate = true
    else
      sslValidate = false
    end
    puts "token_endpoint=" + token_endpoint
    puts "client_id=" + client_id
    puts "code=" + code
    puts "grant_type=" + grant_type
    puts "redirect_uri=" + redirect_uri
    puts "scope=" + scope
    puts "resource=" + resource
    puts "sslValidate=" + sslValidate.to_s
    puts "refreshToken =" + refresh_token
    parameterObject = {}
    if grant_type == "authorization_code"
      parameterObject = {
          grant_type: grant_type,
          client_id: client_id,
          code: code,
          redirect_uri: redirect_uri
      }
    elsif grant_type == "client_credentials"
      parameterObject = {
          grant_type: grant_type,
          client_id: client_id,
      }
    elsif grant_type == "password"
      parameterObject = {
          grant_type: grant_type,
          client_id: client_id,
          username: username,
          password: password
      }
    elsif grant_type == "refresh_token"
      parameterObject = {
          grant_type: grant_type,
          client_id: client_id,
          refresh_token: refresh_token
      }
    end
    if resource != ""
      parameterObject[:resource] = resource
    end
    if scope != ""
      parameterObject[:scope] = scope
    end
    puts "parameterObject=" + parameterObject.to_s
    accessTokenResult = RestClient::Request.execute(method: :post, url: token_endpoint, payload: parameterObject, verify_ssl: sslValidate)
    oauth2_token_response = JSON.parse(accessTokenResult)
    puts accessTokenResult
    @accessTokenResult = accessTokenResult

    apigeeServiceHeaders = {
        # params: {
        #     client_id: client_id
        # },
        "x-api-key" => client_id,
        :Authorization => "Bearer #{oauth2_token_response['access_token']}"
    }
    begin
      apigeeServiceResult = RestClient::Request.execute(method: :get, url: apigee_service, headers: apigeeServiceHeaders)
    rescue Exception => e
      apigeeServiceResult = e.response.body
    end
    puts apigeeServiceResult
    @apigeeServiceResult = apigeeServiceResult
    erb :root
      # content_type :json
      # accessTokenResult
  rescue RestClient::ExceptionWithResponse => e
    puts "An exception occured: " + e.message
    puts "Stacktrace: " + e.backtrace.inspect
    if e.response.code != nil
      status e.response.code
    else
      status 400
    end
    content_type :json
    e.response.body
  rescue Exception => e
    puts "Exception Message: " + e.message
    puts "Stacktrace " + e.backtrace.inspect
    status 500
    content_type :json
    {
        code: "500",
        error: e.message
    }.to_json
  end
end
