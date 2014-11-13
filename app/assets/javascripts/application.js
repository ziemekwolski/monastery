// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// require jquery.turbolinks
//= require jquery_ujs
// require turbolinks
//= require bootstrap-sprockets
//= require jquery.jpanelmenu.min
//= require modernizr-2.6.2-respond-1.1.0.min
//= require_tree ./main

$(document).ready(function() {
  $('pre code').each(function(i, block) {
    //var pre = $(block).parent();
    //var lang = pre.attr('lang');
    //pre.find("code").addClass(lang);
    hljs.highlightBlock(block);
  });
});