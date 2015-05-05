$(document).ready(function() {
  // debugger;
  console.log("in document.ready anonymous function");
  bindEvents();

  $(function() {
    var unorderedLists = $('.connectedSortable');
    // grabs the card container from each list
    // debugger;
    var sortableOptions = {
      connectWith: ".connectedSortable",
      placeholder: "ui-state-highlight"
    }
// http://api.jquery.com/jQuery/#jQuery-elementArray
    $(unorderedLists)
    .sortable(sortableOptions)
    .disableSelection();
    console.log("in anonymous function that activates connectedSortable")
  });
});


function bindEvents() {
  console.log("in bindEvents function");
  $(".add-card").on("submit", "form", createCard);
  $('.card-container').on("dblclick", launchCardModal);
  $('.card-container').mouseup(".card", handleDoubleclick);
  $('.list').droppable( {drop: createMovement} );
  $('.card-modal').on('submit', updateCardInDatabase);
}

function createCard() {
  event.preventDefault();
  console.log("in createCard function")
  debugger;
  var that = this;
  var url = that.action;
  var data = {organization_name: $(that).children()[0].value}

  $.ajax({
    url: url,
    type: "POST",
    data: data
  })
  .done( function(response) {
    console.log("response from server when creating card: ", response)
    addCardToDOM(response);
  }).fail(function(response) {
    console.log("creating card failed :", response)
  });
}

function addCardToDOM(data) {
  console.log("in addCardToDOM function")
  debugger;
  var newCard = "<li class='ui-state-default' id='card" + data.id + "'>" + data.organization_name + "</li>"
    // need to revise this HTML
    $('#sortable1').append(newCard);
    // Don't really like this selector but it works so we can keep it for now
  };


  function findClickedCardId(event) {
    console.log("in findClickedCardId function")
    debugger;
    var clickedCardId = event.target.id.slice(4);
    return clickedCardId // or cardId?
  };

  function getCardFromServer(cardId) {
    event.preventDefault();
    console.log("in getCardFromServer function")
    debugger;
    var that = this;
    var listId = $('#card' + cardId).closest('.list').attr('id'); // .id instead?
    var boardId =  $('.board').attr('id');
    var url =  "/users/1/boards/" + boardId + "/lists/" + listId + "/cards/" + cardId

    $.ajax({
      url: url,
      type: "GET",
    })
    .done(function(response) {
      var card = response; // JSON card?
      return card;
    })
  };

// findClickedCardId >> getCardFromServer >> fillCardModal >> launchCardModal
  function handleDoubleclick() {
    var id = findClickedCardId();
    var card =  getCardFromServer(id);
    fillCardModal(card);
    launchCardModal();
  };

function createMovement(event) {
  event.preventDefault();
  console.log("in createMovement function")
  debugger;
  var that = this;
  var cardId = findClickedCardId();
  var listId = that.id;
  var boardId =  $('.board').attr('id');

  var url = "/users/1/boards/" + boardId + "/lists/" + listId + "/cards/" + cardId + '/movements'
  var data = {list_id: listId, card_id: cardId, board_id: boardId}

  $.ajax({
    url: url,
    type: "POST",
    data: data
  }).done(function(response) {
    console.log("success: ", response);
  }).fail(function(response) {
    console.log("fail: ", response);
  });
};