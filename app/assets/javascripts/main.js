$(document).ready(function() {
  var controller = $.superscrollorama();
  controller.addTween('.ranking-plus-info-content', TweenMax.from( $('#fade-it'), .5, {css:{opacity: 0}}));


  controller.pin($('.time-matrices'), 1000, {
      anim: new TimelineLite(),
      onPin: function () { alert('pinned'); },
      onUnpin: function () { alert('unpinnd'); }
  })

});
$(function () {
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
