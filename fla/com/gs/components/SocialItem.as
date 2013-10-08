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
	import flash.display.*;
	import flash.net.*;
	import flash.text.*;

	import com.trycatch.display.*;
	import com.trycatch.ui.*;

	// 2nd Party Imports
	import com.trycatch.data.*;
	import com.trycatch.utils.*;

	/**   */
	public class SocialItem extends BaseButton {
		/** The name of the class */
		public static const CLASSNAME:String = "SocialItem";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		/**  */
		public var titleTxt:TextField;
		
		private var _origTextColor:Number;
		
		private var _hitSprite:RectSprite;
		
		private var _anchorDTO:AnchorDTO;

		public function get anchorDTO() : AnchorDTO { 
			return _anchorDTO; 
		}
		public function set anchorDTO( arg:AnchorDTO ) : void { 
			_anchorDTO = arg; 
		}
		
		public function get text() : String { 
			return titleTxt.text; 
		}
		public function set text( arg:String ) : void { 
			titleTxt.text = arg; 
			removeChild(_hitSprite);
			_hitSprite.width = width;
			_hitSprite.height = height;
			addChild(_hitSprite);
			//_hitSprite.width = titleTxt.width;
		}
		
		/** SocialItem constructor */
		public function SocialItem() : void {
			super();
			
			_hitSprite = new RectSprite(0, 0, width, height);
			_hitSprite.alpha = 0;
			addChild(_hitSprite);
			
			_origTextColor = titleTxt.textColor;
			//if(doTrace) DebugUtils.log("SocialItem instantiated");
		}
		
		override public function doMouseOver() : void {
			titleTxt.textColor = 0xc62a27;
		}
		
		override public function doMouseOut() : void {
			titleTxt.textColor = _origTextColor;
		}
		
		override public function doMouseUp() : void {
			navigateToURL(new URLRequest(_anchorDTO.href));
		}

		

	
		

	}

}