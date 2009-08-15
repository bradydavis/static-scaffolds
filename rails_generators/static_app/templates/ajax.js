
$(function() {
 $(".pagination a").live("click", function() {
		$(".pagination").html('<img alt="loading" src="/images/icons/blue_bg_ajax_loader.gif" />');
    $.getScript(this.href)
    return false;
  });
});

