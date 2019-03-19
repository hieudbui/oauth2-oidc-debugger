
$(document).ready(function () {
  console.log("Entering ready function().");
})

function OnSubmitForm() {
  console.log("Entering OnSubmitForm().");
  document.getElementById("auth_saml_idp_endpoint").value = document.getElementById("saml_idp_endpoint").value;
  document.getElementById("auth_saml_partner_id").value = document.getElementById("saml_partner_id").value;
  console.log("Leaving OnSubmitForm().");
  return true;
}