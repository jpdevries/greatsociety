package com.gs.data {

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


	// 2nd Party Imports
	import com.trycatch.data.*;
	import com.trycatch.utils.*;

	/**   */
	public class ProductDTO extends Object {
		/** The class name */
		public static const CLASSNAME:String = "ProductDTO";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;
		
		private var _sku:String;

		public function get sku() : String { 
			return _sku; 
		}
		
		private var _qty:int;

		public function get qty() : int { 
			return _qty; 
		}

		private var _img:ImageDTO;

		public function get img() : ImageDTO { 
			return _img; 
		}

		private var _desc:String = "";

		public function get desc() : String { 
			return _desc; 
		}

		private var _title:String;

		public function get title() : String { 
			return _title; 
		}

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.data" + CLASSNAME;
		}
		
		/** ProductDTO constructor */
		public function ProductDTO(_xml:XML) : void {
			super();
			//if(doTrace) DebugUtils.log("ProductDTO instantiated");

			_sku = _xml.@sku;
			_title = _xml.title;
			_qty = int(_xml.@qty);
			_img = new ImageDTO(_xml.img.@src);
			trace("_xml.img.@src: " + _xml.img.@src);
			trace("_img.src: " + _img.src);
			_desc = _xml.p;
		}
		
		

		

	}

}