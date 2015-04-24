$(document).ready(function() {
  // debugger;
  bindEvents();
})

function bindEvents() {
  $(".add-card").on("submit", "form", addNewCard);
}

function addNewCard(event) {
  event.preventDefault();
  var that = this;
  debugger;
  $.ajax( {
    url: that.action,
    type: "POST",
    data: {organization_name: $(that).children()[0].value}
  }).done( function(response) {
    console.log("done :", response)
    // addCardToDOM(response)
  }).fail( function(response) {
    console.log("failed :", response)
  });
}
