function updateCardInDatabase() {
  console.log("in updateCardInDatabase function")
  debugger;
  var $form = $('fieldset').closest('form');
  var $inputs = $form.children('fieldset').children('input');
  var $values = [];
  for (var i = 0; i < $inputs.length; i++) {
    $values.push($inputs[i].value);
  };
  var organizationName = $values[0];
  var organizationSummary = $values[1];
  var url = $form.attr('action');

  var request = $.ajax({
    type: 'put',
    url: url,
    data: { organization_name: organizationName, organization_summary: organizationSummary },
  })

  request.done(function(response) {
    console.log("success: ", response);
    updateModal(response);
    updateCardTitle(response);
    updateCardStarBar(response);
  }).fail(function(response) {
    console.log("failure: ", response);
  })
};

function updateCardModal(card) {
  console.log("in updateCardInDOM function")
  debugger;
  var id = card.id;
  $inputs = $('.card-modal').find('fieldset').children('input')
  $inputs[0].value(card.organization_name);
  $inputs[1].value(card.organization_summary);
};

function updateCardTitle(card) {
  console.log("in updateCardTitle function")
  debugger;
  var cardTitle = $('#card' + card.id)[0];
  cardTitle.innerHTML = card.organization_name;
}

function updateCardStarBar(card) {
  // jQuery + CSS modifications
  console.log("in updateCardStarBar function")
  debugger;
}