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
    // $("#card-modal").empty();
    // $("#card-modal").append("<li> Organization name: " + response.organization_name + "</li>");
    // $(function() {
    //   $( "#dialog" ).dialog();
    // });

    //Populate hidden form

    //Open as modal
    $(function() {
      var dialog;
      var form;
      // var $organizationName = $('#organization-name');
      // var $organizationSummary = $('#organization-summary');
      var formHtml = '<input type="text" name="name" id="organization-name" value=' + response.organization_name + ' class="text ui-widget-content ui-corner-all"> <input type="text" name="email" id="organization-summary" value=' + response.organization_summary + ' class="text ui-widget-content ui-corner-all"> <input type="submit" tabindex="-1" style="position:absolute; top:-1000px"> '

      $("#card-modal").empty();
      $("#card-modal").append(formHtml);

      // var $inputs = $('#card-modal').children('form').children('fieldset').children('input');
      // $inputs[0].val(response.organization_name);
      // $inputs[1].val(response.organization_summary);
      debugger;

      dialog = $('#card-modal').dialog({
        height: 300,
        width: 350,
        modal: true,
        buttons: {
          "SaveUpdat": "dfgdfg" ,//updateCard,
          Cancel: function() {
            dialog.dialog( "close" );
          }
        }
      });
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
