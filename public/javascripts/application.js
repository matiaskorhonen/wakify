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
        required: true,
        minlength: 3,
        username: true
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
  
  $(".edit_user").validate({
    rules: {
      "user[username]": {
        required: true,
        minlength: 3,
        username: true
        },
      "user[email]": {
        required: true,
        email: true
      },
      "user[password]": {
        required: false,
        minlength: 6
      },
      "user[password_confirmation]": {
        required: false,
        equalTo: "#user_password"
      }
    }
  });

  $("#requests_form").validate({
    rules: {
      email: {
        required: true,
        email: true
      }
    }
  });
  
  $("#new_computer,.edit_computer").validate({
    rules: {
      "computer[name]": {
        required: true
      },
      "computer[host]": {
        required: true,
        address: true
      },
      "computer[port]": {
        required: true,
        digits: true,
        min: 0
      },
      "computer[mac]": {
        required: true,
        mac_address: true
      },
      "computer[description]": {
        required: false
      }
    }
  });
  
  $("#new_message").validate({
    rules: {
      "message[firstname]": {
        required: true
      },
      "message[lastname]": {
        required: true
      },
      "message[email]": {
        required: true,
        email: true
      },
      "message[subject]": {
        required: true
      },
      "message[message]": {
        required: true
      }
    }
  });
});

jQuery.validator.addMethod("mac_address", function(value, element) { 
  return this.optional(element) || /^(\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2}:\S{1,2})?$/.test(value); 
}, "Please specify a valid MAC address");

jQuery.validator.addMethod("address", function(value, element) { 
  return this.optional(element) || /(^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$)|(^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$)/.test(value); 
}, "Please specify a host (either an IP address or a hostname)");

jQuery.validator.addMethod("username", function(value, element) { 
  return this.optional(element) || /^[-\w\._@]+$/i.test(value); 
}, "Should only contain letters, numbers, or .-_@");