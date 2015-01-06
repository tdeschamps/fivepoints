$(document).ready(function() {
	$('#add-place').click(function() {
		var nb_places = $("tbody > tr").length;
		$('#sortable tbody').append("<tr  class="+"item"+"><td>toto</td><td>toto</td></tr>");
		if (nb_places >= 4) {
			$('#add-place').hide();
		};
	});
});