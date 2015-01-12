$(document).ready(function() {
	$('#add-place').click(function() {
		var nb_places = $("tbody > tr").length;
		var input = "<div class='col-xs-10'><input id='user_input_foursquare' name='user_input_autocomplete_address' class='form-control' placeholder='Start typing your address...'></div>"
		
		function formGenerator() {
			var formWrapper = '<form role="form" class="col-xs-2" name="place" action="/places/create_from_city_guide" method="post" >';
			var placeToken = '<input type="hidden" id="name">';
			var placeName = '<input type="hidden" id="name">';
			var placeAddress = '<input type="hidden" id="address">';
			var placeCity = '<input type="hidden" id="city">';
			var placeCategory = '<input type="hidden" id="category">';
			var placeCategoryPic = '<input type="hidden" id="categoryPic">';
			var submitButton = '<input type="submit" id="commit" value="Create" class="btn btn-default">'

			return formWrapper + placeName + placeAddress + placeCity + placeCategory + placeCategoryPic + submitButton
		}

		var form = formGenerator(); 
		$('#sortable tbody').append("<tr  class="+"item"+"><td>toto</td><td>"+input + form + "</td></tr>");
		if (nb_places >= 4) {
			$('#add-place').hide();
		};
	});
});