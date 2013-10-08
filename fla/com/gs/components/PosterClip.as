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
	 *	@since 02/10/12
	 *	@description  
	 */

	// Native Imports
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	// 2nd Party Imports
	import com.trycatch.display.*;
	import com.trycatch.geom.*;
	import com.trycatch.utils.*;

	/**   */
	public class PosterClip extends ReverseClip {
		/** The name of the class */
		public static const CLASSNAME:String = "PosterClip";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;
		
		/**  */
		public var backBtn:Sprite;
		
		/**  */
		public var mailHit:Sprite;

		private var _origProps:PropSet;
				
		public function get origProps() : PropSet {
			return _origProps;
		}

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		/** PosterClip constructor */
		public function PosterClip() : void {
			super();
			_origProps = new PropSet(x,y,rotation);
			//if(doTrace) DebugUtils.log("PosterClip instantiated");
			DOUtils.enableClipCursors([backBtn,mailHit]);
			backBtn.addEventListener(MouseEvent.MOUSE_UP, _handleBackBtnClicked);
			mailHit.addEventListener(MouseEvent.MOUSE_UP, _handleMailHit);
		}
		
		private function _handleMailHit(e:MouseEvent) : void {
			navigateToURL(new URLRequest("mailto:" + 'scott@greatsociety.com'),"_self");
		}
		
		override public function play() : void {
			gotoAndPlay(2);
		}
		
		/**
		* 
		* @param	
		*/
		public function reset() : void {
			x = origProps.x;
			y = origProps.y;
			rotation = origProps.rotation;
		}
		
		
		/**
		* 
		* @param	
		*/
		public function hideBackButton() : void {
			TweenLite.to(backBtn,0.4,{x:310,delay:0,ease:'Quad.easeIn'});
		}
		
		
		/**
		* 
		* @param	
		*/
		public function showBackButton() : void {
			//if(doTrace) DebugUtils.log("showBackButton called >> " + classPath);
			TweenLite.to(backBtn,0.4,{x:380,ease:'Quad.easeOut'});
		}
		
		
		private function _handleBackBtnClicked(e:MouseEvent): void {
			dispatchEvent(new Event(Event.CLOSE));
		}
		

	}

}