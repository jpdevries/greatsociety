/* Author: 

*/

var _tenetDL = '';
var tenetsJSON;
var _hasFlash = false;
var useHTML5Video = false;

var ua = navigator.userAgent.toLowerCase();
var isAndroid = (ua.indexOf("android") > 0) ? true : false;

var is_chrome = (ua.indexOf('chrome') > -1);

var _iOS = (ua.match(/like Mac OS X/i)) ? true : false;

var origFigTitle = '';
var origFigCapt = '';

var doAddress = true;

var _init = false;

$(document).ready(function() {
	// i dunno why this gets double fired sometimes but it does
	if(_init) return;
	
	if($('#container').hasClass('work') || $('#container').hasClass('worktag')) {
		var _tag = $.getUrlVar('tag') || 'case-study';
		if(!_tag) return;
		$('nav.tagnav li').removeClass('active');
		 processTag($('.tagnav a[rel*=' + _tag + ']').parent().addClass('active').end());
	}
	
	// scroll to top of page
	$('a.topPage').click(function(){
		$('html, body').animate({scrollTop:0}, 'fast');
	});
	
	// tag nav listeners
	$('#container.work nav.tagnav a').click(function(e) {
		e.preventDefault();
		if($(this).parent().hasClass('active')) return;
		$('nav.tagnav li').removeClass('active');
		$(this).parent().addClass('active');
		processTag($(this));
	});
	
	//$('a[rel*=vimeo],a[rel*=youtube]').click(function(e) {
	$('a.video').click(function(e) {
		e.preventDefault();
		var _vimeo = $(this).attr('rel').indexOf('vimeo') > -1;
		var _youtube = $(this).attr('rel').indexOf('youtube') > -1;
		
		var _p = $(this).parent();
		var _pw = _p.width();
		var _ph = _p.height();
		
		if(_vimeo || _youtube) {
			var _fs;
			var _vid;
			if(_vimeo) {
				_fs = $(this).attr('href').split('/');
				_vid = _fs[_fs.length-1];
			}
			
			var _title = '';
			
			var _w = _pw;
			var _h = _ph;
			
			//var _w = 832;
			//var _h = 468;

			var _vs = (_vimeo) ? '<iframe src="http://player.vimeo.com/video/' + _vid + '?title=0&amp;byline=0&amp;autoplay=1&amp;portrait=0" width="' + _w + '" height="' + _h + '" frameborder="0"></iframe>' : '<iframe class="youtube-player" type="text/html" width="' + _w + '" height="' + _h + '" src="' + $(this).data('video-link') + '" frameborder="0"></iframe>';;
			//_vs = '<iframe src="http://player.vimeo.com/video/26598529?title=0&amp;byline=0&amp;portrait=0" width="400" height="265" frameborder="0"></iframe><p><a href="http://vimeo.com/26598529">LOVE/HATE- FORGASH AND WITTLAKE</a> from <a href="http://vimeo.com/user2780008">HOLDEN OUTERWEAR</a> on <a href="http://vimeo.com">Vimeo</a>.</p>';
			$(this).replaceWith(_vs);
		} else {
			// h264 click to play
			if (Modernizr.video && Modernizr.video.h264) {
				// can play h.264. let's build a video tag.
				$poster = $(this).children('img');

				/*$video = $( document.createElement( 'video' ) )
					.attr({
						src: $(this).attr('href'),
						poster: $poster.attr('src'),
						height: $poster.attr('height'),
						width: $poster.attr('width')
					})
					.addClass( );
					$(this).replaceWith( $video );*/
					
				var _videoString = '<video poster="' + $poster.attr('src')  + '" controls="true" autoplay="true">';
				_videoString += '<source src="' + $(this).attr('href') + '" type="video/mp4" />';
				_videoString += '</video>';
				$(this).replaceWith(_videoString);
					
			} else {
				// can't play h.264. let's give them flash...
				
				embedFlashVideo($(this).attr('href'),_pw,_ph,_p.attr('id'));
			}
		}

	});
	
	/*$('a[rel*=quickvideo]').click(function(e){
		if(_iOS) return;
		e.preventDefault();
		var _videoString = '<video poster="' + $(this).find('img').attr('src')  + '" controls="true" autoplay="true">';
		_videoString += '<source src="' + $(this).attr('href') + '" type="video/mp4" />';
		_videoString += '</video>';
		$(this).replaceWith(_videoString);
		console.log(_videoString);
	});*/
	

	
	$('.defer').deferLoad();

	// don't let it happen again
	_init = true;
});

function embedFlashVideo(_videoPath, _w, _h, _vid) {
	swfobject.embedSWF('/assets/swf/StageTest.swf?no_cache=' + version_number,_vid,_w,_h,'10.1','/assets/swf/expressInstall.swf',{domain: '*', videoURL:_videoPath, tryStageVideo:(jQuery.browser.msie && jQuery.browser.version < 9) ? 'false' : 'true',stageWidth:_w,stageHeight:_h}, {allowscriptaccess: 'always', allowfullscreen: 'true', menu: 'false', bgcolor:'#000000', wmode: 'direct', scale: 'exactfit'},{id:_vid});
}

function fadeReelIn(_tag) {
	// css li.visible:nth-of-type(4n) doesn't seem to update async :(
	// having to resort to removing margin on every 4th block in js
	if(_tag == 'all') {
		$('div.workReel li').show().css({marginRight:'16px'}).addClass('visible');
	} else {
		var _vi = 1;
		$('div.workReel li').hide().css({marginRight:'16px'}).removeClass('visible').each(function(){
			var _t = $(this);
			var _isEnd = (_vi % 4 == 0) ? true : false;
			if(_t.attr('class').indexOf(_tag) > -1) {
				_t.addClass('visible').show();
				_vi++;
			}
			if(_isEnd) _t.css({marginRight:0});
			
		});
	}

	$('div.workReel').removeClass('out');
}

function processTag(_tagBtn) {
	var _tag = _tagBtn.attr('rel').toLowerCase();
	console.log(_tag);
	
	$('nav.reel li.' + _tag + ' a:not(.case-study a)').each(function(){
		$(this).attr('href',$(this).data('orig-href') + '?tag=' + _tag);
		//console.log($(this).attr('href'));
	});
	//log('processTag tag: ' + _tag);
	
	$('div.workReel').addClass('out');
	setTimeout("fadeReelIn('" + _tag + "')",700);
	
	$('div.workReel header h4').html(_tagBtn.html());
}






// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-log/
function log(){
  log.history = log.history || [];   // store logs to an array for reference
  log.history.push(arguments);
  arguments.callee = arguments.callee.caller;  
  if(this.console) console.log( Array.prototype.slice.call(arguments) );
};
// make it safe to use console.log always
(function(b){function c(){}for(var d="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),a;a=d.pop();)b[a]=b[a]||c})(window.console=window.console||{});

