/* FDF */
var _init = false;
$(document).ready(function () {
	if(_init) return;
	
	swfobject.embedSWF('assets/swf/' + 'shell.swf?nocache=' + ((cachebust) ? Math.random().toString() : versionNo), 'flashReplace', '1216px', '886px', '10.1', 'expressinstall.swf', {domain: '*',swfFolder:swfFolder, xmlPath:xmlPath, swfCache:'?nocache=' + versionNo}, {allowscriptaccess: 'always', allowfullscreen: 'false', menu: 'false', wmode: 'transparent', scale: 'exactfit'}, {id: 'website'});
	if (!swfobject.hasFlashPlayerVersion("10.1")) window.location = 'http://greatsociety.com/work';
	_init = true;
}); 



function jsb_reel_video_modal() {
	$.fancybox({
		//'orig'			: $(this),
		'padding'		: 0,
		'content'		: '<iframe style="background-color:black" src="http://player.vimeo.com/video/' + '31228222' + '?title=0&amp;byline=0&amp;autoplay=1&amp;portrait=0" width="' + '1000' + '" height="' + '566' + '" frameborder="0"></iframe>',
		'title'   		: 'Our Reel',
		'transitionIn'	: 'elastic',
		'transitionOut'	: 'elastic',
		'overlayOpacity' : '1',
		'overlayColor' : '#000',
		'scrolling' : 'no',
		'onClosed':function(){
			console.log('attempting to play music');
			var _swf = swfobject.getObjectById("website");
			if(_swf) _swf.js_playMusic();
		}
	});
}