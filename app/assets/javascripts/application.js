// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require jquery_ujs
//= require_tree .
//= require Chart.bundle.min

$(document).ready(function(){
	$("#refresh-recs").click(function(){
		var params = $('#refresh-recs').attr('data_api_params')
    $.ajax({
     type: "Get",
     contentType: "application/json; charset=utf-8",
     url: "https://fast-tracks-flask.herokuapp.com/api/v1/recommended",
     data : params,
     dataType: "json",
     success: function (new_recommended) {
				var i
				for (i = 0; i < 5; i++) {
					$('.recommended-iframe')[i].src = 'https://open.spotify.com/embed/track/' + new_recommended[i].spotify_id
				}
     },
    });
  });
});
