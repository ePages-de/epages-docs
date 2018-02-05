$(function() {
  $('#support_form').submit(function(e) {
    e.preventDefault();

    var supportForm =       $(this),
        supportFormButton = $('input[type=submit]', supportForm);

    $.ajax({
      url: supportForm.prop('action'),
      type: 'POST',
      crossDomain: true,
      headers : {
        'accept' : 'application/javascript',
      },
      data: supportForm.serialize(),
      beforeSend: function() {
        supportFormButton.prop('disabled', 'disabled');
      }
    })
    .done(function(response) {
      clearForm();
      $('.form-feedback span').html('Your email was sent');
      $('.form-feedback').css('display', 'flex');
      supportFormButton.prop('disabled', false);
    })
    .fail(function(response) {
      clearForm();
      $('.form-feedback span').html('Oops, this didn\'t work. Please try again.');
      $('.form-feedback').css('display', 'flex');
      supportFormButton.prop('disabled', false);
    })

  });

  $('.form-feedback').click(function() {
    $(this).slideUp();
  });

  function clearForm() {
    $('#support_form input:not([type="submit"])').val('');
    $('#support_form textarea').val('');

    // Remove yellow color from autocompleted input fields
    if (navigator.userAgent.toLowerCase().indexOf('chrome') >= 0) {
      $('input:-webkit-autofill').each(function() {
        var text = $(this).val();
        var name = $(this).attr('name');
        $(this).after(this.outerHTML).remove();
        $('input[name=' + name + ']').val(text);
      });
    }
  }
});
