
$(function() {

 // DO PAGINATION AJAX
 $(".pagination a").live("click", function() {
		$(".pagination").html('<img alt="loading" src="/images/icons/blue_bg_ajax_loader.gif" />');
    $.getScript(this.href)
    return false;
  });

 // DO ACTIVE SEARCH AJAX
 $(".facet_form input:submit").hide();
 $(".facet_form").submit(function() {
     $.get(this.action, $(this).serialize(), null, "script");
     return false;
	});
 $(".facet_form input").live("keyup", function() {
		$(".spinner").html('<img alt="loading" src="/images/icons/loading.gif" />');
    $(".facet_form").submit();
		return false;		
	});
	
});


