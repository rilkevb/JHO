// function updateCardModal(card) {
//   console.log("in updateCardInDOM function")
//   var id = card.id;
//   $inputs = $('.card-modal').find('fieldset').children('input')
//   debugger;
//   // $($inputs[0]).value(card.organization_name);
//   // $(inputs[1]).value(card.organization_summary);
// };

function updateCardTitle(card) {
  console.log("in updateCardTitle function")
  var cardTitle = $('#card' + card.id)[0];
  var cardDiv = $(cardTitle).find('.organization-name');
  $(cardDiv).text(card.organization_name);
  debugger;
}

function updateCardStarBar(card) {
  // jQuery + CSS modifications
  console.log("in updateCardStarBar function")
  debugger;
  // Need to modify stars here
}

function updateCard() {
  console.log("in updateCard function")
  // debugger;
  var $form = $('fieldset').closest('form');
  var $inputs = $form.children('fieldset').children('input');
  // var $values = [];
  // for (var i = 0; i < $inputs.length; i++) {
  //   $values.push($($inputs[i]).value);
  // };
  var organizationName = $inputs[0].value;
  var organizationSummary = $inputs[1].value;
  var url = $form.attr('action');

  debugger;

  var request = $.ajax({
    type: 'put',
    url: url,
    data: { organization_name: organizationName, organization_summary: organizationSummary },
  })

  request.done(function(response) {
    console.log("update card in DB success: ", response);
    // updateCardModal(response);
    updateCardTitle(response);
    updateCardStarBar(response);
  }).fail(function(response) {
    console.log("failure: ", response);
  })
};