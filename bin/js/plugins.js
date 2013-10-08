/* image deffering */
$.fn.deferLoad = function(options) {
	console.log('deferLoad');
	$.fn.deferLoad.defaults = {
		'datakey':'img-src'
	}
	
	// merge the provided options with the default options
	$.fn.deferLoad.opts = $.extend({}, $.fn.deferLoad.defaults, options);

	return this.each(function() {
		$(this).attr('src',$(this).data($.fn.deferLoad.opts.datakey)).removeClass('defer-load');
		return $(this);
	});	
};

$.extend({
  getUrlVars: function(){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
      hash = hashes[i].split('=');
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
    }
    return vars;
  },
  getUrlVar: function(name){
    return $.getUrlVars()[name];
  }
});