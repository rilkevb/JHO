$(document).ready( function() {
  //console.log("in document.ready anonymous function");
  bindEvents();

  $(function() {
    //All of the lists
    var $unorderedLists = $('.connectedSortable');
    var sortableOptions = {
      connectWith: ".connectedSortable",
      placeholder: "ui-state-highlight"
    }
    // http://api.jquery.com/jQuery/#jQuery-elementArray
    $unorderedLists
      .sortable(sortableOptions)
      .disableSelection();
    //console.log("in anonymous function that activates connectedSortable")
  });

});

function bindEvents() {
  // console.log("in bindEvents function");
  $(".add-card").on("submit", "form", createCard);  //WORKS, had to update the HTML
  $('.list').droppable( {drop: createMovement} );  //Works, had to fix the controller

  $('.card-container').on("dblclick", '.card', handleDoubleclick);
  //  DON'T USE THIS: // $('.card-container').mouseup(".card", handleDoubleclick);
  // $('.card-modal').on('submit', updateCard);
}

function createCard() {
  event.preventDefault();
  console.log("in createCard function")
  // debugger;
  var that = this;
  var url = that.action;
  var data = {organization_name: $(that).children()[0].value}
  debugger;
  $.ajax({
    url: url,
    type: "POST",
    data: data
  })
  .done( function(response) {
    console.log("response from server when creating card: ", response)
    addCardToDOM(response);
    console.log("card should have been added to DOM");
  }).fail(function(response) {
    console.log("creating card failed :", response)
  });
}

function addCardToDOM(data) {
  // console.log("in addCardToDOM function")
  var newCard = "<li class='ui-state-default card ui-sortable-handle' id='card" + data.id + "'>"
                + "<div class='organization-name'>" + data.organization_name + "</div>"
                + "<div class='star-bar'>"
                + "<span class='fa fa-star'></span> "
                + "<span class='fa fa-star'></span> "
                + "<span class='fa fa-star'></span> "
                + "<span class='fa fa-star'></span> "
                + "<span class='fa fa-star'></span> "
                + "<span class='fa fa-star'></span> "
                + "<span class='fa fa-star-half-o'></span> "
                + "<span class='fa fa-star-o'></span> "
                + "</div>"
                + "</li>"
    // need to revise this HTML
    $('#sortable1').append(newCard);
    // console.log("card appended");
    // Don't really like this selector but it works so we can keep it for now
  };


  function findClickedCardId() {
    console.log("in findClickedCardId function")
    var clickedCardId = event.target.closest('.card').id.slice(4);
    // debugger;
    return clickedCardId
  };

  function createMovement() {
    event.preventDefault();
    console.log("in createMovement function")
    // var that = this;
    var cardId = findClickedCardId();
    var listId = this.id;
    var boardId =  $('.board').attr('id');
    console.log("cardId : ", cardId);
    console.log("listId : ", listId);
    console.log("boardId : ", boardId);
    debugger;

    var url = "/users/1/boards/" + boardId + "/lists/" + listId + "/cards/" + cardId + '/movements';
    // var data = {list_id: listId, card_id: cardId, board_id: boardId} ;

    $.ajax({
      url: url,
      type: "POST",
      // data: data  //This is not doing anything....
    }).done(function(response) {
      console.log("success: ", response);
    }).fail(function(response) {
      console.log("fail: ", response);
    });
  };

  function getCardFromServer(cardId) {
    event.preventDefault();
    console.log("in getCardFromServer function")
    // debugger;
    // var that = this;
    var listId = $('#card' + cardId).closest('.list').attr('id'); // .id instead?
    var boardId =  $('.board').attr('id');
    var url =  "/users/1/boards/" + boardId + "/lists/" + listId + "/cards/" + cardId
    console.log("listId is: ", listId, "boardId is: ", boardId, "cardId is: ", cardId, "url is: ", url);

    $.ajax({
      url: url,
      type: "GET",
    }).done(function(response) {
      // debugger;
      console.log("in getCardFromServer .done function with response: ", response);
      var card = response;
      console.log("success! Got card from server: ", response);
      fillCardModal(card);
      launchCardModal();
      console.log("in done function: modal should've launched");
    }).fail(function(response) {
      console.log("failed to get card from server: ", response);
    }).always(function(response) {
      console.log("response always: ", response)
    })
  };

// findClickedCardId >> getCardFromServer >> fillCardModal >> launchCardModal
  function handleDoubleclick() {
    var id = findClickedCardId();
    console.log("in handleDoubleclick, id is: ", id);
    // This retrieves the data, then fills and launches
    // the modal in the done callback
    getCardFromServer(id);
  };


