$(document).ready( function() {
  // debugger;
  debugger;
  bindEvents();

  $(function() {
    $( "#sortable1, #sortable2, #sortable3, #sortable4, #sortable5, #sortable6, #sortable7" ).sortable({
      connectWith: ".connectedSortable",
      placeholder: "ui-state-highlight"
    }).disableSelection();
  });

})

function bindEvents() {
  $(".add-card").on("submit", "form", addNewCard);
  // mouse down listener
  $('.card-container').mouseup(".card", findCardId);
  $('.list').droppable( {drop: findListId} );
  $('.card-container').on("dblclick", editCard);
}

var clickedCardId = null;
function editCard(event) {
  //find id of clicked card
  debugger;
  clickedCardId = event.target.id.slice(4);
  //make AJAX call to retrieve card information and launch modal
  retrieveCardInfo(clickedCardId);

}

function retrieveCardInfo(currentCardId) {
  event.preventDefault();
  var that = this;
  var listId = $('#card' + currentCardId).closest('.list').attr('id'); // .id instead?
  var boardId =  $('.board').attr('id');

  $.ajax( {
    url: "/users/1/boards/" + boardId + "/lists/" + listId + "/cards/" + cardId,
    type: "GET",
    // data: {} //{organization_name: $(that).children()[0].value}
  }).done( function(response) {
    //launch modal
    debugger;
    $("#dialog").empty();
    $("#dialog").append("<li> Organization name: " + response.organization_name + "</li>");
    $(function() {


      $( "#dialog" ).dialog();




    });

  }).fail( function(response) {
    console.log("failed :", response)
  });
}

function addNewCard(event) {
  event.preventDefault();
  var that = this;
  $.ajax( {
    url: that.action,
    type: "POST",
    data: {organization_name: $(that).children()[0].value}
    // Will need to edit this if we add more fields to this form
  }).done( function(response) {
    debugger;
    console.log("DONE!!!! :")
    console.log(response)
    var newCard = "<li class='ui-state-default' id='card" + response.id + "'>" + response.organization_name + "</li>"
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
