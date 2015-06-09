$(document).ready(function(){

      $('#user_input_foursquare').on('click', 
            function () {

                  var lat = $('#city-boundaries-coordinates').data('url')[0];
                  var lng = $('#city-boundaries-coordinates').data('url')[1];
                  initFoursquare({
                        ll : lat+","+lng
                        })
                  
      		var $this = $(this);
      		var $that = $this.parentsUntil($('form #new_place'));
      		console.log($that);
      		$this.autocomplete({
      			source: function(request, response) {
      					fs_suggest(response, {
      						ll: lat+","+lng, 
      						query: request.term
      						}
      					)
      				},
      			minLength : 3,
      			focus: function( event, ui ) {
      			        $this.val( ui.item.name );
      			        return false;
      			      },
      		  	select: function( event, ui ) {	
      		  	  fs_complete($that, ui.item)
      		  	  $this.val( ui.item.name );
      		  	  return false;
      		  	},	
      		});
      	});
});