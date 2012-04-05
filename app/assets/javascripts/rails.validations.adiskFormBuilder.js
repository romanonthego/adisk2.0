clientSideValidations.formBuilders["AdiskFormBuilder"] = {
  add: function (element, settings, message) {
    console.log(element.data('is-valid'));
    if (element.data('is-valid') !== false) {
      element.attr('data-is-valid', false);
      var $wraper = element.parent('.input-custom');
      $wraper.addClass('error');
      var $icon = $wraper.find('span.add-on');
      $icon.attr('data-normal-title', $icon.attr('data-original-title')).attr('data-original-title', message);
    }
    else {
      var $icon = element.parent('.input-custom').find('span.add-on');
      $icon.attr('data-original-title', message);
    }
  },

  remove: function (element, settings) {
    element.attr('data-is-valid', true);
    var $wraper = element.parent('.input-custom');
    $wraper.removeClass('error');
    var $icon = $wraper.find('span.add-on');
    $icon.attr('data-original-title', $icon.attr('data-normal-title')).attr('data-original-title', message);
  }
  // add: function (element, settings, message) {
  //   if (element.data('valid') !== false) {
  //     element.data('valid', false);
  //     var $parent = element.closest('.controls');
  //     $parent.parent().addClass('error');
  //     $('<span/>').addClass('help-inline').text(message).appendTo($parent);
  //   } else {
  //     element.parent().find('span.help-inline').text(message);
  //   }
  // },
  // remove: function (element, settings) {
  //   var $parent = element.closest('.controls');
  //   $parent.parent().removeClass('error');
  //   $parent.find('span.help-inline').remove();
  //   element.data("valid", true);
  //   element.removeClass('error');
  // }
};