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
  $.ajax( {
    url: that.action,
    type: "POST",
    data: {organization_name: $(that).children()[0].value}
  }).done( function(response) {
    console.log("done :", response)
    var newCard = "<li class='ui-state-default' id='card" + response.id + "'>" +
                response.organization_name +
              "</li>"
    $('.list#1').children('ul').append(newCard);
  }).fail( function(response) {
    console.log("failed :", response)
  });
}
