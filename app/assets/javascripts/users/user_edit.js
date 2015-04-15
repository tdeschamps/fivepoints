$(document).ready(function(){

	function switching(el) {
		el.toggleClass('disabled');
		el = el.find('input');
		if (el.attr('disabled')) {
		        el.removeAttr('disabled');

		} else {  
			el.attr({'disabled':'disabled'});
			el.find('.btn-user-form-activate').first().show();
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
		if ($this.val() == 'Edit') {
			$this.hide();
			$this.next().toggleClass('hide');
		} else if ($this.val() == 'Submit') {
			$this.parent().toggleClass('hide');
			$this.parent().parent().find('input').first().show();
		}	
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