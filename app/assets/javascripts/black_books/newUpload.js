$(document).ready(function() {
  var $realInputField;
  $realInputField = $('#file-upload');
  $realInputField.change(function() {
    return $('.upload label').text($(this).val().replace(/^.*[\\\/]/, ''));
  });
  return $('form .upload').click(function() {
    return $realInputField.click();
  });
});