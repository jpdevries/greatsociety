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
	 *	@since 05/19/11
	 *	@description  
	 */

	import flash.events.*;

	// 2nd Party Imports
	import com.trycatch.utils.*;
	

	/**   */
	public class DataModel extends XMLParser {
		/** The class name */
		public static const CLASSNAME:String = "DataModel";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.data" + CLASSNAME;
		}
		
		private static var _instance:DataModel;
		
		/** DataModel is a Singelton class */
		public static function getInstance() : DataModel {
			return (_instance) ? _instance : new DataModel();
		}
		
		private var _parsedFired:Boolean = false;

		public function get parsedFired() : Boolean { 
			return _parsedFired; 
		}
		
		private var _curState:String;

		public function get curState() : String { 
			return _curState; 
		}
		public function set curState( arg:String ) : void { 
			if(_curState == arg) return;
			_curState = arg; 
			
			trace("_curState: " + _curState);
			
			_curPageDTO = PageDTO.getInstanceById(_curState);
			//trace("_curPageDTO.id: " + _curPageDTO.id);
			
			dispatchEvent(new Event(STAGE_CHANGED));
		}
		
		private var _swfFolder:String = "";

		public function get swfFolder() : String { 
			return _swfFolder; 
		}
		public function set swfFolder( arg:String ) : void { 
			_swfFolder = arg; 
		}
		
		
		
		public static const HOME:String = "home";
		public static const DOCTRINE:String = "doctrine";
		public static const COMRADES:String = "comrades";
		public static const SPEAKS_OUT:String = "speaks-out";
		public static const MEET_US:String = "meet_us";
		public static const FRUITS_OF_OUR_LABORS:String = "fruits_of_our_labors";
		public static const CONTACT:String = "contact";
		public static const DOG_FRIEND:String = "dog-friend";
		public static const ILLUSTRATION:String = "illustration";
		
		public static const STAGE_CHANGED:String = "stage_changed";
		
		/** DataModel constructor */
		public function DataModel() : void {
			super();
			_instance = this;
			//if(doTrace) DebugUtils.log("DataModel instantiated");
		}

		

	}

}