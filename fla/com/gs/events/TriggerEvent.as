package com.gs.events {

	/**
	 * Copyright (c) 2010 JP DeVries, Nemo Design
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
	 *	@since 10/14/10
	 *	@description  
	 */
	
	import flash.events.Event;
	
	import com.gs.components.*;

	// 2nd Party Imports
	import com.trycatch.utils.*;

	/**   */
	public class TriggerEvent extends Event {
		/** The class name */
		public static const CLASSNAME:String = "TriggerEvent";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.holden.events" + CLASSNAME;
		}
		
		
		private var _clickedTrigger:Trigger;

		public function get clickedTrigger() : Trigger { 
			return _clickedTrigger; 
		}
		
		public static const TRIGGER_UP:String = "trigger_up";
		public static const TRIGGER_OVER:String = "trigger_over";
		public static const TRIGGER_OUT:String = "trigger_out";
		public static const LOADED:String = "loaded";
		public static const BULK_LOADED:String = "bulk_loaded";
		
		/** TriggerEvent constructor */
		public function TriggerEvent(_type:String, __clickedTrigger:Trigger, _bubbles:Boolean = true, _cancelable:Boolean = false) : void {
			super(_type, _bubbles, _cancelable);
			//if(doTrace) DebugUtils.log("TriggerEvent instantiated");
			_clickedTrigger = __clickedTrigger;
		}

		

	}

}