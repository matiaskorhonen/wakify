$(document).ready(function() {
  // Hide descriptions if JS is enabled
  $(".description").hide();
  
  // Hide the TOS if JS is enabled
  $("#toslink").show();
  $("#terms").hide();
  
  $("#toslink").click(function () {
    $(this).fadeOut('slow');
    $('#terms').slideDown('slow');
    return false;
  });

  /*  Add Chroma Hash to password fields
      You can generate a new salt using script/console and the following command:
      >> Digest::SHA1.hexdigest([Time.now, rand].join)
  */
  $("input:password:not(#captcha_attempt)").chromaHash({bars: 3, salt:"db0b3e7d4672a854def65e0dffbdf735bd195f10", minimum:6});
  
  // Form Validations
  $("#new_user").validate({
    rules: {
      "user[username]": {
        required: true
        },
      "user[email]": {
        required: true,
        email: true
      },
      "user[password]": {
        required: true,
        minlength: 6
      },
      "user[password_confirmation]": {
        required: true,
        equalTo: "#user_password"
      }
    }
  });

});

