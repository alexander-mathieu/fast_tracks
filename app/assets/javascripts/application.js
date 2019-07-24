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
