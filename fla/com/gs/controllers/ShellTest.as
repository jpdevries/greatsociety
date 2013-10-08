package com.gs.controllers {

	/**
	 * Copyright (c) 2011 JP DeVries, Nemo Design
	 * 
	 * Permission is hereby granted, free of charge, to any person
	 * obtaining a copy of this software and associated documentation
	 * files (the "Software"), to deal in the Software without
	 * restriction, including without limitation the rights to use,
	 * copy, modify, merge, publish, distribute, sublicense, and/or sell
	 * copies of the Software, and to permit persons to whom the
	 * Software is furnished to do so, subject to the following
	 * conditions:
	 * 
	 * The above copyright notice and this permission notice shall be
	 * included in all copies or substantial portions of the Software.
	 * 
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	 * OTHER DEALINGS IN THE SOFTWARE.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 10.0
	 *	@author JP DeVries
	 *	@since 05/29/11
	 *	@description  
	 */

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.external.*;

	// 2nd Party Imports
	import com.trycatch.utils.*;

	import br.com.stimuli.loading.*;

	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.trycatch.display.*;
	import com.trycatch.utils.*;

	/**   */
	public class ShellTest extends MovieClip {
		/** The name of the class */
		public static const CLASSNAME:String = "ShellTest";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;
		
		/** The initial site watch clock indeterminate loader */
		public var loadWatch:Sprite;
		
		private var _frameClip:FlashFrame = new FlashFrame();
		
		private var _paramList:Object;
		
		private var _main:MovieClip;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.controllers" + CLASSNAME;
		}
		
		/** ShellTest constructor */
		public function ShellTest() : void {
			super();
			
			Security.loadPolicyFile('http://greatsociety.s3.amazonaws.com/crossdomain.xml');
			Security.allowDomain('http://greatsociety.com');
			Security.allowDomain('http://c0654.paas1.tx.modxcloud.com');
			Security.allowDomain('http://c0650.paas2.tx.modxcloud.com');
			Security.allowDomain('http://tgs.greatsociety.modxcloud.com');
			Security.allowDomain('http://greatsociety.s3.amazonaws.com');
			
			if(doTrace) DebugUtils.log("ShellTest instantiated");
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			_paramList = this.root.loaderInfo.parameters;
			var _swfFolder:String = _paramList.swfFolder || '';
			var _xmlPath:String = _paramList.xmlPath || 'main.xml';
			var _swfCache:String = _paramList.swfCache || '';
			
			DOUtils.disableClipCursor(_frameClip);
			
			_frameClip.alpha = 0;
			addChild(_frameClip);
			
			var _x:TweenLite = new TweenLite(loadWatch, 1, {delay:0.4,ease:'Quad.easeInOut',onComplete:function(){
				var _bl:BulkLoader = new BulkLoader('preloader');

				_bl.addEventListener(BulkLoader.COMPLETE, _onCompleteHandler);
				//_bl.addEventListener(BulkLoader.PROGRESS, _onProgressHandler);

				_bl.add(_swfFolder + "gs.swf"+_swfCache,{id:"index",context:new LoaderContext(false, ApplicationDomain.currentDomain)});
				//_xmlPath = 'http://greatsociety.com/flash/flash-xml.xml';
				_bl.add(_xmlPath,{id:"main-xml"});
				_bl.start();
			}});
			
			ExternalInterface.addCallback('js_playMusic',_handleJSPlay);
		}
		
		private function _handleJSPlay() : void {
			DebugUtils.log("js_playMusic");
			try {
				_main.playMusic();
			} catch (e:Error) {
				
			} finally {
				
			}
		}
		
		private function _onCompleteHandler(e:BulkProgressEvent) : void {
			var _bl:BulkLoader = e.currentTarget as BulkLoader;
			
			_main = _bl.getMovieClip("index");
			
			var _swfFolder:String = _paramList.swfFolder || '';
			Object(_main).swfFolder = _swfFolder;

			var _xml:XML = _bl.getXML("main-xml");
			_main.alpha = 0;
			
			_main.setXML(_xml);
			
			var _paramList:Object = this.root.loaderInfo.parameters;
			//if(_paramList) _main.model.paramList = _paramList;
			
			_bl.removeEventListener(BulkLoader.COMPLETE, _onCompleteHandler);
			//_bl.removeEventListener(BulkLoader.PROGRESS, _onProgressHandler);
			
			_main.x = 100;
			_main.y = 100;
			
			_bl.removeAll();
			
			addChildAt(_main,0);
			
			var _mask:RectSprite = new RectSprite(_main.x,_main.y,1046,700);
			_main.mask = _mask;
			addChild(_mask);
			
			var _y:TweenLite = new TweenLite(loadWatch, 0.6, {delay:0,alpha:0,ease:'Quad.easeOut',onComplete:function(){
				removeChild(loadWatch);
			}});
			var _x:TweenLite = new TweenLite(_main, 0.8, {delay:0.44,alpha:1,ease:'Quad.easeInOut'});
			var _z:TweenLite = new TweenLite(_frameClip, 0.6, {delay:0.4,alpha:1,ease:'Quad.easeIn'});
			
		}
		
		private function _onProgressHandler(e:ProgressEvent) : void {
			//var perc:Number = e.bytesLoaded / e.bytesTotal;
		}
		

		

		/**
		* Clears the DisplayList
		* @return Whether or not any children were removed when cleared, If _displayList.numChildren &lt; 1, false is returned.
		* @see <a href="http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObject.html" target="_blank" alt="DisplayObject">DisplayObject</a>
		*/
		public function clearDisplayList() : Boolean {
			return DOUtils.clearDisplayList(this);
		}

		/**
		* Handles garbage collection
		*/
		public function destroy() : void {
			clearDisplayList();
		}
		

	}

}