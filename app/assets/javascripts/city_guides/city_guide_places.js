$(document).ready(function() {
	$('#add-place').click(function() {
		var nb_places = $("tbody > tr").length;
		var input = "<input id="+"user_input_foursquare"+" name="+"user_input_autocomplete_address"+" class="+"form-control"+" placeholder="+"Start typing your address..."+">"
		
		$('#sortable tbody').append("<tr  class="+"item"+"><td>toto</td><td>"+input+"</td></tr>");
		if (nb_places >= 4) {
			$('#add-place').hide();
		};
	});
});