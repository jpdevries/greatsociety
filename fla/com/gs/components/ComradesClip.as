package com.gs.components {

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

	// Native Imports
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	// 2nd Party Imports
	import com.trycatch.data.*;
	import com.trycatch.media.*;
	import com.trycatch.geom.*;
	import com.trycatch.utils.*;
	
	import com.gs.data.*;

	/**   */
	public class ComradesClip extends AudioClip {
		/** The name of the class */
		public static const CLASSNAME:String = "ComradesClip";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;
		
		/**  */
		public var holderClip:Sprite;
		
		/**  */
		public var backBtn:Sprite;
		
		/**  */
		public var paperGraphic:Sprite;
		
		private var _origProps:PropSet;
		private var _origBackBtnX:Number;
		
		public static const OPEN:String = "open";
		public static const CLOSE:String = "close";
		public static const OUTRO_COMPLETE:String = "outro_complete";
		
		private var _model:DataModel = DataModel.getInstance();

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		/** ComradesClip constructor */
		public function ComradesClip() : void {
			super();
			//if(doTrace) DebugUtils.log("ComradesClip instantiated");
			
			_model.addEventListener(XMLParser.XML_PARSED, _handleXMLParsed);
			
			_origProps = new PropSet(x,y,rotation);
			_origBackBtnX = backBtn.x;
			
			DOUtils.enableClipCursor(backBtn);
			
		}
		
		private function _handleXMLParsed(e:Event) : void {
			var _comradeLinks:Vector.<AnchorDTO> = _model.comradeLinks;
			var l:int = _comradeLinks.length;
			for (var i:int = 0; i < l; i++) {
				var _curLink:AnchorDTO = _comradeLinks[i];
				var _comItem:ComradeItem = new ComradeItem();
				_comItem.text = _curLink.title;
				_comItem.anchorDTO = _curLink;
				_comItem.y = i * 20;
				holderClip.addChild(_comItem);
			}
		}
		
		private function _handleBackBtnClicked(e:MouseEvent) : void {
			trace("_handleBackBtnClicked");
			dispatchEvent(new Event(CLOSE));
		}
		
		/**
		* 
		* @param	
		*/
		public function doIntro() : void {
			//if(doTrace) DebugUtils.log("doIntro called >> " + classPath);
			backBtn.addEventListener(MouseEvent.MOUSE_UP, _handleBackBtnClicked);
			visible = true;
			var _x:TweenLite = new TweenLite(this, 0.6, {x:88,y:34,delay:0.1,ease:'Quad.easeInOut'});
			var _y:TweenLite = new TweenLite(this, 0.6, {rotation:0,delay:0.1,ease:'Quad.easeInOut',overwrite:false});
			var _z:TweenLite = new TweenLite(backBtn, 0.6, {x:376,delay:0.3,ease:'Quad.easeIn',overwrite:false});
			
			_playSound(new CrowdCheer());
		}
		
		/**
		* 
		* @param	
		*/
		public function doOutro() : void {
			//if(doTrace) DebugUtils.log("doOutro called >> " + classPath);
			backBtn.removeEventListener(MouseEvent.MOUSE_UP, _handleBackBtnClicked);
			var _x:TweenLite = new TweenLite(this.backBtn, 0.25, {x:_origBackBtnX,delay:0.2,ease:'Quad.easeIn'});
			var _y:TweenLite = new TweenLite(this, 1, {rotation:_origProps.rotation,delay:0.5,ease:'Quad.easeInOut',overwrite:false});
			var _z:TweenLite = new TweenLite(this, 1, {x:_origProps.x,y:_origProps.y,delay:0.5,ease:'Quad.easeInOut',overwrite:false,onComplete:function(){
				visible = false;
				dispatchEvent(new Event(OUTRO_COMPLETE));
			}});
		}

		
		

	}

}