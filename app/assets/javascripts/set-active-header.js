function handleNavClick() {
  var target = this;
  $(this).addClass('active-nav-link');
}

function bindEvents() {
  $('.nav li a').on('click', handleNavClick);
}

$(document).ready(function() {
  bindEvents();
})