package com.gs.components {

	/**
	 * Copyright (c) 2012 JP DeVries, Nemo Design
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
	 *	@since 02/12/12
	 *	@description  
	 */

	// Native Imports
	import flash.display.Sprite;
	import flash.events.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.gs.data.*;

	// 2nd Party Imports
	import com.trycatch.utils.*;
	import com.trycatch.geom.*;
	
	import com.trycatch.data.*;

	/**   */
	public class SocialBook extends Sprite {
		/** The name of the class */
		public static const CLASSNAME:String = "SocialBook";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;
		
		public static const OUTRO_COMPLETE:String = "outro_complete";

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		private var _model:DataModel = DataModel.getInstance();
		
		private var _orig:PropSet;
		private var _backOrig:PropSet;
		
		/**  */
		public var backBtn:Sprite;
		
		
		/** SocialBook constructor */
		public function SocialBook() : void {
			super();
			
			_model.addEventListener(XMLParser.XML_PARSED, _handleXMLParsed);
			
			_orig = new PropSet(x,y,rotation);
			_backOrig = new PropSet(backBtn.x,backBtn.y,backBtn.rotation);
			//if(doTrace) DebugUtils.log("SocialBook instantiated");
			DOUtils.enableClipCursor(backBtn);
			backBtn.addEventListener(MouseEvent.MOUSE_UP, _backClicked);
		}
		
		private function _handleXMLParsed(e:Event) : void {
			var _socialLinks:Vector.<AnchorDTO> = _model.socialLinks;
			var l:int = _socialLinks.length;
			for (var i:int = 0; i < l; i++) {
				var _curLink:AnchorDTO = _socialLinks[i];
				var _socItem:SocialItem = new SocialItem();
				_socItem.text = _curLink.title.toUpperCase();
				_socItem.anchorDTO = _curLink;
				_socItem.y = i * 26;
				holderClip.addChild(_socItem);
			}
		}
		
		
		/**
		* 
		* @param	
		*/
		public function doIntro() : void {
			TweenLite.to(this, .6, {x:334, delay:0, overwrite:false, y:-171, rotation:5.7, ease:'Quad.easeOut'});
			TweenLite.to(backBtn, .4, {x:620, delay:0.5, y:478, ease:'Quad.easeOut'});
		}
		
		/**
		* 
		* @param	
		*/
		public function doOutro() : void {
			TweenLite.to(this, .8, {x:_orig.x, delay:0.20, overwrite:true, y:_orig.y, rotation:_orig.rotation, ease:'Quad.easeInOut',onComplete:function(){
				dispatchEvent(new Event(OUTRO_COMPLETE));
			}});
			TweenLite.to(backBtn, .3, {x:_backOrig.x, delay:0, overwrite:true, y:_backOrig.y, ease:'Quad.easeIn'});
		}
		
		private function _backClicked(e:MouseEvent) : void {
			doOutro();
		}
		
		
		
		/**
		* 
		* @param	
		*/
		public function reset() : void {
			if(doTrace) DebugUtils.log("reset called >> " + classPath);
			
			PropSet.reset(this,_orig);
			PropSet.reset(backBtn,_backOrig);
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