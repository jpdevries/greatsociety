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
	 *	@since 05/31/11
	 *	@description  
	 */

	// Native Imports
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	
	import com.gs.data.*;

	// 2nd Party Imports
	import com.trycatch.media.*;
	import com.trycatch.utils.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	/**   */
	public class ShopItem extends AudioClip {
		/** The name of the class */
		public static const CLASSNAME:String = "ShopItem";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		/**  */
		public var outOfStock:Sprite;
		
		/**  */
		public var buyBtn:Sprite;
		
		/**  */
		public var titleTxt:TextField;
		
		/**  */
		public var copyTxt:TextField;
		
		/**  */
		public var aquireIt:Sprite;
		
		
		private var _shopData:ProductDTO;
		
		private var _img:Loader = new Loader();

		public function get shopData() : ProductDTO { 
			return _shopData; 
		}
		public function set shopData( arg:ProductDTO ) : void { 
			if(_shopData == arg) return; // prevent scary looping
			
			// set the property
			_shopData = arg; 
			
			// update the view...
			titleTxt.htmlText = _shopData.title;
			copyTxt.text = _shopData.desc;
			//outOfStock.visible = (_shopData.qty >= 1) ? false : true;
			outOfStock.visible = false;
			
			// if there is an image, load it and fade it in
			if(_shopData.img.src) {
				_img.alpha = 0;
				_img.contentLoaderInfo.addEventListener(Event.COMPLETE, _handleImageLoaded);
				addChild(_img);
				_img.load(new URLRequest(_shopData.img.src));
			}
			
			DOUtils.enableClipCursor(aquireIt);
			DOUtils.disableClipCursor(outOfStock);
			
			aquireIt.addEventListener(MouseEvent.MOUSE_UP, _handleAquireItClicked);
			aquireIt.addEventListener(MouseEvent.MOUSE_OVER, _handleAquireItOver);
			aquireIt.addEventListener(MouseEvent.MOUSE_OUT, _handleAquireItOut);
			
		}
		
		private function _handleAquireItOver(e:MouseEvent) : void {
			_playSound(new SmoothClick());
		}
		
		private function _handleAquireItClicked(e:MouseEvent) : void {
			outOfStock.scaleX = outOfStock.scaleY = 0;
			outOfStock.visible = true;
			TweenLite.to(outOfStock, 0.8, {scaleX:1, scaleY:1, ease:Back.easeOut});
		}
		
		private function _handleAquireItOut(e:MouseEvent) : void {
			TweenLite.to(outOfStock, 0.8, {scaleX:0, scaleY:0, ease:Back.easeInOut, onComplete:function(){
				outOfStock.visible = false;
			}});
		}

		/** ShopItem constructor */
		public function ShopItem() : void {
			super();
			//if(doTrace) DebugUtils.log("ShopItem instantiated");
			outOfStock.visible = false;
		}
		
		// once the image has loaded, fade it in
		private function _handleImageLoaded(e:Event) : void {
			TweenLite.to(_img,0.8,{alpha:1,ease:'Quad.easeOut',delay:0});
		}

		

		
		

	}

}