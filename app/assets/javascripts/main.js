$(function () {
  $(window).scroll(function () {
    var body = $('body');
    var currentClass = body.attr('class');
    var newClass = newClassName();
    if (newClass && currentClass !== newClass) {
      body.toggleClass(currentClass + ' ' + newClass);
    }
    $('section').find('.section-info-wrapper').hide();
    $('section[data-section-name=' + newClass + ']').find('.section-info-wrapper').show();
  });
  newClassName();
  incrementCounter($('.global'));
});

function newClassName() {
  var sections = $('section');
  var windowTop = $(window).scrollTop();
  for (var i = sections.length - 1; i >= 0; i--) {
    var section = $(sections[i]);
    if (windowTop >= section.offset().top) {
      return section.data('section-name');
    }
  }
}

function incrementCounter(element) {
  $self = element;
  var counter_till = $self.data('counter');
  var text = parseFloat($self.text());
  $self.text(parseFloat(text)+1);
  if ($self.text() < counter_till) {
    setTimeout("incrementCounter($self), 40");
  }
}
