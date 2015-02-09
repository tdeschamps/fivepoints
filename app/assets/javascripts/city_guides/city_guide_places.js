
$(document).ready(function() {
	$('#add-place').click(function() {
		var nb_places = $("tbody > tr").length;
		var input = "<div class='col-xs-10'><input id='user_input_foursquare' name='user_input_autocomplete_address' class='form-control' placeholder='Start typing your address...'></div>"
		
		function formGenerator() {
			var formWrapper = '<form role="form" class="col-xs-2" name="place" action="/places/create_from_city_guide" method="post" >';
			var placeToken = '<input id="token" name="place[request_forgery_protection_token]">';
			var placeName = '<input type="hidden" id="name" name="place[name]">';
			var placeAddress = '<input type="hidden" id="address" name="place[address]">';
			var placeCity = '<input type="hidden" id="city" name="place[city]">';
			var placeCategory = '<input type="hidden" id="category" name="place[category]">';
			var placeCategoryPic = '<input type="hidden" id="categoryPic" name="place[categoryPic]">';
			var submitButton = '<input type="submit" id="commit" value="Create" class="btn btn-default">'

			return formWrapper + placeToken + placeName + placeAddress + placeCity + placeCategory + placeCategoryPic + submitButton
		}

		var form = formGenerator(); 
		$('#sortable tbody').append("<tr  class="+"item"+"><td>toto</td><td>"+input + form + "</td></tr>");
		if (nb_places >= 4) {
			$('#add-place').hide();
		};
	});

	$(document).on('click', '#send-form', function(){
		$('#new-place-form').fadeOut(200, function(){
			$('#new-place-form').find('input[type="text"]').val('');
		})
	});
});