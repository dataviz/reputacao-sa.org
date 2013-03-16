$(function () {
  if ($('#root').hasClass('companies-page')) {
    incrementCounter($('.global'));
    // TOGGLE MENU
    $('.toggle-menu').on('click', function (e) {
      e.preventDefault();
      $('nav.nav').toggleClass('open-nav');
    });
    // TOGGLE SEARCH
    $('.open-search').on('click', function (e) {
      e.preventDefault();
      $('.panel.search-panel').toggleClass('open');
    });
  }

  // HIGHLIGHT SEARCH ON FOCUS
  if ($('#root').hasClass('home-page')) {
    $('.search input, .search .search-button').focus(function(){
      $('.search').addClass('focused');
    }).blur(function(){
      $('.search').removeClass('focused');
    });
  }
});

function incrementCounter(element) {
  $self = element;
  var counter_till = $self.data('counter');
  var text = parseFloat($self.text());
  $self.text(parseFloat(text)+1);
  if ($self.text() < counter_till) {
    setTimeout("incrementCounter($self), 40");
  }
}
