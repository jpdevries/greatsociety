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
	 *	@since 05/17/11
	 *	@description  
	 */

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	// 2nd Party Imports
	import com.trycatch.utils.*;
	
	import br.com.stimuli.loading.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	/**   */
	public class ShellController extends MovieClip {
		/** The class name */
		public static const CLASSNAME:String = "ShellController";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;
		
		/** The initial site watch clock indeterminate loader */
		public var loadWatch:Sprite;
		
		private var _xmlData:XML;

		public function get xmlData() : XML { 
			return _xmlData; 
		}
		public function set xmlData( arg:XML ) : void { 
			_xmlData = arg; 
		}
		

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.controllers" + CLASSNAME;
		}
		
		/** ShellController constructor */
		public function ShellController() : void {
			super();
			trace("ShellController instantiated");
			return;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var _x:TweenLite = new TweenLite(loadWatch, 1, {delay:0.4,y:340,ease:'Quad.easeInOut',onComplete:function(){
				var _bl:BulkLoader = new BulkLoader('preloader');

				_bl.addEventListener(BulkLoader.COMPLETE, _onCompleteHandler);
				//_bl.addEventListener(BulkLoader.PROGRESS, _onProgressHandler);

				_bl.add("gs.swf",{id:"index"});
				_bl.add("main.xml",{id:"main-xml"});
				_bl.start();
			}});
			
			
		}
		
		private function _onCompleteHandler(e:BulkProgressEvent) : void {
			return;
			var _bl:BulkLoader = e.currentTarget as BulkLoader;
			var _main:MovieClip = _bl.getMovieClip("index");
			var _xml:XML = _bl.getXML("main-xml");
			_main.alpha = 0;
			
			var _paramList:Object = this.root.loaderInfo.parameters;
			//if(_paramList) _main.model.paramList = _paramList;
			
			_bl.removeEventListener(BulkLoader.COMPLETE, _onCompleteHandler);
			//_bl.removeEventListener(BulkLoader.PROGRESS, _onProgressHandler);
			
			_bl.removeAll();
			
			addChildAt(_main,0);
			
			var _x:TweenLite = new TweenLite(_main, 0.6, {delay:0.2,alpha:1,ease:'Quad.easeInOut'});
			var _y:TweenLite = new TweenLite(loadWatch, 0.6, {delay:0.6,y:-300,ease:'Quad.easeInOut'});
		}
		
		private function _onProgressHandler(e:ProgressEvent) : void {
			//var perc:Number = e.bytesLoaded / e.bytesTotal;
		}

		

	}

}