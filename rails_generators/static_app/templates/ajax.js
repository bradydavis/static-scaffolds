
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

 // ACTIVE_FILTER WATCH TEXT BOXES
 $(".facet_form input").live("keyup", function() {
   clearTimeout($.data($(".facet_form"), "timer"));
   var ms = 1000; //milliseconds
   var wait = setTimeout(function() {
		  $(".spinner").html('<img alt="loading" src="/images/icons/loading.gif" />');	
    	$.get($(".facet_form").action, $(".facet_form").serialize(), null, "script");
   }, ms);
   $.data($(".facet_form"), "timer", wait);
	});
	
 // ACTIVE_FILTER WATCH CHECK BOXES
 $(".facet_form input:checkbox").live("click", function() {
   clearTimeout($.data($(".facet_form"), "timer"));
   var ms = 300; //milliseconds
   var wait = setTimeout(function() {
		 	$(".spinner").html('<img alt="loading" src="/images/icons/loading.gif" />');	
    	$.get($(".facet_form").action, $(".facet_form").serialize(), null, "script");
   }, ms);
   $.data($(".facet_form"), "timer", wait);
	});
	
	// ACTIVE_FILTER ACCORDION FILTERS
	jQuery(document).ready(function(){
		$('.facet_form .head').click(function() {
			$(this).next().toggle('slow');
			return false;
		});
	});	
	
});

