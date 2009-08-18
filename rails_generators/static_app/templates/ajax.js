
$(function() {

 // DO PAGINATION AJAX
 $(".pagination a").live("click", function() {
		$(".spinner").html('<img alt="loading" src="/images/icons/loading.gif" />');
    $.getScript(this.href)
    return false;
  });

	// DO ACTIVE SEARCH AJAX
 $(".facet_form input:submit").hide();
 $(".facet_form").submit(function() {
		 $(".spinner").html('<img alt="loading" src="/images/icons/loading.gif" />');	
     $.get(this.action, $(this).serialize(), null, "script");
     return false;
	});

 $(".facet_form input").live("keyup", function() {
   clearTimeout($.data(this, "timer"));
   var ms = 500; //milliseconds
   var val = this.value;
   var wait = setTimeout(function() {
    $(".facet_form").submit();
   }, ms);
   $.data(this, "timer", wait);
	});
	
 $(".facet_form input:checkbox").live("keyup", function() {
		$(".spinner").html('<img alt="loading" src="/images/icons/loading.gif" />');
    $(".facet_form").submit();
		return false;		
	});	
	
});


