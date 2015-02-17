$(document).ready(function() {
	$( '#sortable' ).sortable();
    $( '#sortable' ).disableSelection();
    
	$('#add-place').click(function() {
		var nb_places = $("tbody > tr").length;
		
		if (nb_places >= 4) {
			$('#add-place').hide();
		};
	});

	$(document).on('click', '#send-form', function(){
		//$('#new-place-form').fadeOut(200, function(){
		//	$('#new-place-form').find('input[type="text"]').val('');
		//})
		$('.md-close').click();
	});


	  $(document).bind('ajaxError', 'form#new_person', function(event, jqxhr, settings, exception){

	    // note: jqxhr.responseJSON undefined, parsing responseText instead
	    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

	  });
});

	(function($) {

	  $.fn.modal_success = function(){
	    // close modal
	    this.modal('hide');

	    // clear form input elements
	    // todo/note: handle textarea, select, etc
	    this.find('form input[type="text"]').val('');

	    // clear error state
	    this.clear_previous_errors();
	  };

	  $.fn.render_form_errors = function(errors){

	    $form = this;
	    this.clear_previous_errors();
	    model = this.data('model');

	    // show error messages in input form-group help-block
	    $.each(errors, function(field, messages){
	      $input = $('input[name="' + model + '[' + field + ']"]');
	      $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
	    });

	  };

	  $.fn.clear_previous_errors = function(){
	    $('.form-group.has-error', this).each(function(){
	      $('.help-block', $(this)).html('');
	      $(this).removeClass('has-error');
	    });
	  }
	}(jQuery));

var ModalEffects = (function() {

	function init() {

		var overlay = document.querySelector( '.md-overlay' );

		[].slice.call( document.querySelectorAll( '.md-trigger' ) ).forEach( function( el, i ) {
			var modal = document.querySelector( '#' + el.getAttribute( 'data-modal' ) ),
				close = modal.querySelector( '.md-close' );
			
			function removeModal( hasPerspective ) {
				classie.remove( modal, 'md-show' );
			}	
			console.log(el);
			console.log(modal);
			
			el.addEventListener( 'click', function( ev ) {
				classie.add( modal, 'md-show' );
				overlay.removeEventListener( 'click', removeModal );
				overlay.addEventListener( 'click', removeModal );


			});

			close.addEventListener( 'click', function( ev ) {
				ev.stopPropagation();
				removeModal();
			});

		} );

	}

	init();

})();
