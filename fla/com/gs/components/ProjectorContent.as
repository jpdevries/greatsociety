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
	import flash.text.*;

	// 2nd Party Imports
	import com.trycatch.utils.*;

	/**   */
	public class ProjectorContent extends Sprite {
		/** The name of the class */
		public static const CLASSNAME:String = "ProjectorContent";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		/**  */
		public var viewBtn:Sprite;
		
		/**  */
		public var titleTxt:TextField;
		
		/**  */
		public var subTitleTxt:TextField;
		
		/**  */
		public var copyTxt:TextField;
		
		/**  */
		public var scrollClip:ScrollClip;
		
		public function get upBtn() : Sprite { 
			return scrollClip.upBtn; 
		}
		
		public function get downBtn() : Sprite { 
			return scrollClip.downBtn; 
		}
		
		/**  */
		public var mouseCopyTxt:TextField;
		

		/** ProjectorContent constructor */
		public function ProjectorContent() : void {
			super();
			if(doTrace) DebugUtils.log("ProjectorContent instantiated");
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