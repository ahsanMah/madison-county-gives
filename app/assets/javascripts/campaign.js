// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require jquery

$(document).ready(function() {
  $('#donationButton').click(function(e) {
    if ($('#donationAmount').val() === "") {
      e.preventDefault();
      alert('Please enter the amount to donate.');
    }
  });
});
