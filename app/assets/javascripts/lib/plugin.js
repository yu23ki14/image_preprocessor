/*modalplugin*/

(function( $ ) {
  var methods = {
    init : function() {
      $("body").css("min-height", $(window).innerHeight() + "px");
      this.addClass("in");
      this.attr('aria-hidden', 'false');
      this.css('display', 'block');
      $("html").css("overflow-y", "hidden");
      if (this.children(".modal-backdrop").length == 0){
        this.prepend('<div class="modal-backdrop in" style="height: 100%">');
      }
      this.parents("body").addClass("modal-open");
    },
    show : function() {
      $("body").css("min-height", $(window).innerHeight() + "px");
      this.addClass("in");
      this.attr('aria-hidden', 'false');
      this.css('display', 'block');
      $("html").css("overflow-y", "hidden");
      if (this.children(".modal-backdrop").length == 0){
        this.prepend('<div class="modal-backdrop in" style="height: 100%">');
      }
      this.parents("body").addClass("modal-open");
    },
    hide : function() {
      this.removeClass("in");
      this.attr('aria-hidden', 'true');
      this.parents("body").removeClass("modal-open");
      this.css('display', 'none');
      $("html").css("overflow-y", "inherit");
    },
    update : function() {
    }
  };
  
  $.fn.modal = function(method) {
    if ( methods[method] ) {
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof method === 'object' || ! method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  method + ' does not exist on jQuery.tooltip' );
    }
  };
  
})( jQuery );