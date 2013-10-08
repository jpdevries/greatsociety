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
	 *	@since 05/31/11
	 *	@description  
	 */


	// 2nd Party Imports
	import com.trycatch.utils.*;

	/**   */
	public class PageDTO extends Object {
		/** The class name */
		public static const CLASSNAME:String = "PageDTO";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = false;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.data" + CLASSNAME;
		}
		
		private var _id:String;

		public function get id() : String { 
			return _id; 
		}
		
		private var _className:String;

		public function get className() : String { 
			return _className; 
		}
	
		private var _audio:Boolean = false;

		public function get audio() : Boolean { 
			return _audio; 
		}
		
		private var _href:String;

		public function get href() : String { 
			return _href; 
		}
		
		private static var _instances:Vector.<PageDTO> = new Vector.<PageDTO>();
		
		public static function getInstanceById(_id:String) : PageDTO {
			var l:int = _instances.length;
			for (var i:int = 0; i < l; i++) {
				var _pageDTO:PageDTO = _instances[i];
				//trace("_pageDTO.id.toLowerCase(): " + _pageDTO.id.toLowerCase());
				if(_pageDTO.id.toLowerCase() == _id.toLowerCase()) return _pageDTO;
			}
			return null;
		}

		/** PageDTO constructor */
		public function PageDTO(__id:String, __className:String = "", __audio:Boolean = false, __href:String = "") : void {
			super();
			//if(doTrace) DebugUtils.log("PageDTO instantiated");
			_id = __id;
			_className = __className;
			_audio = __audio;
			_href = __href;
			
			trace("_id: " + _id);
			trace("_className: " + _className);
			trace("_audio: " + _audio);
			trace("_href: " + _href);
			
			_instances.push(this);
		}

		

	}

}