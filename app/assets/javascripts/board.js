$(document).ready(function() {
  // debugger;
  bindEvents();
})

function bindEvents() {
  $(".add-card").on("submit", "form", addNewCard);
  // mouse down listener
  $('.card-container').mouseup(".card", findCardId);
  $('.list').droppable( {drop: findListId} )
}

function addNewCard(event) {
  event.preventDefault();
  var that = this;
  $.ajax( {
    url: that.action,
    type: "POST",
    data: {organization_name: $(that).children()[0].value}
    // Will need to edit this is we add more fields to this form
  }).done( function(response) {
    console.log("done :", response)
    var newCard = "<li class='ui-state-default' id='card" + response.id + "'>" +
                response.organization_name +
              "</li>"
    // debugger;
    $('#sortable1').append(newCard)
    // $('.list#1.card-container').children('ul').append(newCard);
  }).fail( function(response) {
    console.log("failed :", response)
  });
}

function findCardId(event) {
  cardId = $(event.target).attr('id').slice(4);  //BE AWARE OF GLOBAL VARIABLE
}

function findListId(event) {
  event.preventDefault();
  var that = this;
  var listId = that.id;
  var boardId =  $('.board').attr('id');

  // debugger;
  $.ajax( {
    url: "/users/1/boards/" + boardId + "/lists/" + listId + "/cards/" + cardId,
    type: "PUT",
    data: {list_id: listId, card_id: cardId, board_id: boardId}
  }).done(function(response) {
    console.log(response, "success")
  }).fail(function(response) {
    console.log(response, "fail")
  })
}
