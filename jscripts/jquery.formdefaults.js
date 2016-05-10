(function($) {
  
  $.fn.formDefaults = function(options) {
    
    var opts = $.extend({}, $.fn.formDefaults.defaults, options);
    
    return this.each(function() {
      
      var $this = $(this);
      var $form = $this.parents("form");
      
      $this
        .data("defaultValue", this.value)
        .addClass("form-default-value-processed");
      
      if (opts.inactiveColor) {
        $this.css("color", opts.inactiveColor);
      }
      
      $this
        .focus(function() {
          if (this.value == $this.data("defaultValue")) {
            this.value = '';
            this.style.color = opts.activeColor;
			$this.css("font-style","normal");
          }
        })
        .blur(function() {
          if (this.value == '') {
            this.style.color = opts.inactiveColor;
            this.value = $this.data("defaultValue");
			$this.css("font-style","italic");
          }
        });
      
      if (!$form.data("defaultValueProcessed")) {
        $form
          .data("defaultValueProcessed", true)
          .submit(function(e) {
            $(this).find(".form-default-value-processed").each(function() {
              var $el = $(this);
              if ($el.data("defaultValue") == $el.val()) {
                $el.val('');
              }
            });
          });
      }
      
    });
    
  };
  
  $.fn.formDefaults.defaults = {
    activeColor: '#333333', // Color of text when form field is active
    inactiveColor: '#a6a5a5' // Color of text when form field is inactive (ignored when not specified)
  };

}(jQuery));
