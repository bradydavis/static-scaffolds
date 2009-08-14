$(function() {
	var loading = $('<img alt="loading" src="/images/icons/blue_bg_ajax_loader.gif" />').appendTo($('.pagination')).hide();
  $(".pagination a").live("click", function() {
		var loading = $('<img alt="loading" src="/images/icons/blue_bg_ajax_loader.gif" />').appendTo($('.pagination')).hide();	
		loading.show();
    $.getScript(this.href, function(){ loading.hide() })
    return false;
  });
});