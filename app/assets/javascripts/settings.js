// Calls Show method on Member Controller to get JSON data
function getMemberRecord(memberId) {
  $.getJSON('/members/' + memberId + '.json', function(data) {
    $('#first_name').val(data.first_name);
    $('#last_name').val(data.last_name);
    $('#phone_number').val(data.phone_number);
    $('#address1').val(data.address1);
    $('#address2').val(data.address2);
    $('#city').val(data.city);
    $('#state').val(data.state);
    $('#zipcode').val(data.zipcode);
  });
}

function clearMemberRecord() {
  $('#first_name').val('');
    $('#last_name').val('');
    $('#phone_number').val('');
    $('#address1').val('');
    $('#address2').val('');
    $('#city').val('');
    $('#state').val('');
    $('#zipcode').val('');
}