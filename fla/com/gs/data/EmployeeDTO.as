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
	import com.trycatch.utils.*;

	/**   */
	public class EmployeeDTO extends Object {
		/** The class name */
		public static const CLASSNAME:String = "EmployeeDTO";

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
		
		private var _title:String;

		public function get title() : String { 
			return _title; 
		}
		
		private var _jobTitle:String;

		public function get jobTitle() : String { 
			return _jobTitle; 
		}
		
		private var _videoSRC:String;

		public function get videoSRC() : String { 
			return _videoSRC; 
		}
		
		private var _desc:String;

		public function get desc() : String { 
			return _desc; 
		}
		
		
		/** EmployeeDTO constructor */
		public function EmployeeDTO(_xml:XML) : void {
			super();
			//if(doTrace) DebugUtils.log("EmployeeDTO instantiated");
			_id = _xml.@id;
			_title = _xml.@title;
			_jobTitle = _xml.@jobTitle;
			_videoSRC = _xml.video.@src;
			_desc = _xml.p;
		}

		

	}

}