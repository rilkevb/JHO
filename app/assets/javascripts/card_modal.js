function launchCardModal() {
  console.log("in fillCardModal function");
  var dialogOptions = {
        height: 300,
        width: 350,
        modal: true,
        position: { my: "center", at: "center", of: window },
        show: { effect: "slideDown", duration: 800 },
        buttons: {
          Save: function() {
            updateCard();
          },
          Cancel: function() {
            dialog.dialog( "close" );
          }
        }
      }
  debugger;
  dialog = $('.card-modal').dialog(dialogOptions);
  console.log("modal should have launched");
}

function fillCardModal(card) {
  console.log("in fillCardModal function");
  debugger;
  var $card = $(event.target).closest('.card');
  var currentCardId = $card.attr('id').slice(4);
  var boardId = $('.board').attr('id');
  var listId = $card.closest('.list').attr('id');
  /// DOESN'T address lack of server response
  $(function(card, boardId, listId) {
    var dialog;
    var formHtml = '<form id=' + card.id + ' action=/users/1/boards/'
    + boardId + '/lists/' + listId + '/cards/'
    + currentCardId + '> '
    + ' <input type="hidden" name="_method" value="PUT"/>'
    + ' <fieldset> '
    + ' <input type="text" name="organization-name" id="organization-name" value='
    + card.organization_name
    + ' class="text ui-widget-content ui-corner-all">'
    + ' <input type="text" name="organization-summary" id="organization-summary" value='
    + card.organization_summary
    + ' class="text ui-widget-content ui-corner-all">'
    + ' <input type="submit" value="Save" tabindex="-1" style="position:absolute; top:-1000px"> </fieldset></form>';

    $(".card-modal").empty();
    $(".card-modal").append(formHtml);
  });
};