// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require smart_listing
//= require materialize
//= require_tree .

function inplat_link(sum)  {
    return $.ajax('/user/inplat_link', {
        data: {
            sum: sum
        },
        async: false
    }).responseText
};

$(document).ready(function () {
    if ($('#deposit').length > 0) {
        $('#deposit').on('input', function (e) {
            sum = parseFloat(this.value);
            $('#inplat_invoke_btn').attr('href', inplat_link(sum));
        });
        $('#inplat_invoke_btn').on('click', function(e){
        })
    }
});