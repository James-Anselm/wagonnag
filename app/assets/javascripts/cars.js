/*
 Place all the behaviors and hooks related to the matching controller here.
 All this logic will automatically be available in application.js.
 You can use CoffeeScript in this file: http://coffeescript.org/
 */
$(function(){
    $(".cars .list").on("click", ".odometer .cancel-changes-icon", function(){
        var carSelector = $(this.closest(".car"));
        carSelector.removeClass("update-odometer");
        carSelector.find(".form-container").empty();
    });
});