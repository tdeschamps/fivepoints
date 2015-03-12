$(document).ready(function(){

	function switching(el) {
		el.toggleClass('disabled');
		el = el.find('input');
		if (el.attr('disabled')) {
		        el.removeAttr('disabled');

		} else {  
			el.attr({'disabled':'disabled'});
		}
		el.toggleClass('white-background')
		el.focus();
		var tmpStr = el.val();
		el.val('');
		el.val(tmpStr);
	}

	$('.btn-user-form-activate').on('click', function() {
		var $this = $(this);
		console.log('toto');
		$this.hide();
		$this.next().toggleClass('hide');
		var input = $this.parent().parent().find('.form-group');
		switching(input);
	})

	$('.btn-user-form-cancel').on('click', function() {
		var $this = $(this);
		$this.parent().toggleClass('hide');
		$this.parent().parent().find('input').first().show();
		var input = $this.parentsUntil('.form-user').find('.form-group');
		switching(input);
	})
})