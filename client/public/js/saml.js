
$(document).ready(function () {
  console.log("Entering ready function().");
})

function OnSubmitForm() {
  console.log("Entering OnSubmitForm().");
  document.getElementById("auth_external_authorization_endpoint").value = document.getElementById("external_authorization_endpoint").value;
  document.getElementById("auth_external_idp").value = document.getElementById("external_idp").value;
  document.getElementById("auth_redirect_uri").value = document.getElementById("redirect_uri").value;
  console.log("Leaving OnSubmitForm().");
  return true;
}