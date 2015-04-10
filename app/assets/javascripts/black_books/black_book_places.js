$(document).ready(function() {
	$( '#sortable' ).sortable();
    $( '#sortable' ).disableSelection();

	$(document).on('click', '#send-form', function(){
		//$('#new-place-form').fadeOut(200, function(){
		//	$('#new-place-form').find('input[type="text"]').val('');
		//})
		$('.md-close').click();
	});

	 $(document).bind('ajaxError', 'form#new-place-form', function(event, jqxhr, settings, exception){

	   // note: jqxhr.responseJSON undefined, parsing responseText instead
	   $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

	});

	$(document).on('click', '#send-to-archive', function() {
		var tile = $(this).parents('li');
		tile.fadeOut(400, function() {
			tile.remove();
			tile.find('.rank-square').remove();
			tile.find('#send-to-archive').remove();
			tile.appendTo($('#archived-places-list > ul')).fadeIn(200);
			var newPlace = document.getElementById('new-place').parentNode;
			classie.remove( newPlace, 'hidden');
			$('#black_book-full').remove();
			$('#new-place').show(200);
			$('#place_black_book_places_attributes_0_position').val(parseInt($('#place_black_book_places_attributes_0_position').val()) - 1);
		})
	})
});

	(function($) {

	  $.fn.modal_success = function(){
	    
	    // clear form input elements
	    // todo/note: handle textarea, select, etc
	    $('#place_black_book_places_attributes_0_position').val( parseInt($('#place_black_book_places_attributes_0_position').val()) + 1 );
	    // clear error state
	    this.find('form input[type="text"]').val('');
	    this.find('form .input--filled').removeClass('input--filled');
	    this.find('form textarea').val('');
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
			
			function removeModal() {
				classie.remove( modal, 'md-show' );
			}	
			
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

(function() {
	// trim polyfill : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim
	if (!String.prototype.trim) {
		(function() {
			// Make sure we trim BOM and NBSP
			var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
			String.prototype.trim = function() {
				return this.replace(rtrim, '');
			};
		})();
	}

	[].slice.call( document.querySelectorAll( 'input.input__field' ) ).forEach( function( inputEl ) {
		// in case the input is already filled..
		if( inputEl.value.trim() !== '' ) {
			classie.add( inputEl.parentNode, 'input--filled' );
		}

		// events:
		inputEl.addEventListener( 'focus', onInputFocus );
		inputEl.addEventListener( 'blur', onInputBlur );
	} );

	function onInputFocus( ev ) {
		classie.add( ev.target.parentNode, 'input--filled' );
	}

	function onInputBlur( ev ) {
		if( ev.target.value.trim() === '' ) {
			classie.remove( ev.target.parentNode, 'input--filled' );
		}
	}
})();
