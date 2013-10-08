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
	 *	@since 05/17/11
	 *	@description  
	 */

	// Native Imports
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;

	// 2nd Party Imports
	import com.trycatch.media.*;
	import com.trycatch.ui.*;
	import com.trycatch.utils.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	/**   */
	public class Trigger extends AudioClip {
		/** The name of the class */
		public static const CLASSNAME:String = "Trigger";
		
		/** The frame label for the default state */
		public static var DEFAULT:String = "default";
		/** The frame label for the over state  */
		public static var OVER:String = "over";
		/** The frame label for the down state  */
		public static var DOWN:String = "down";
		
		private var _hover:Boolean = false;
		
		private var _reversing:Boolean = false;

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = false;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		/**  */
		public var hitClip:Sprite;
		
		/**  */
		public var highlightClip:Sprite;
		
		/**  */
		public var triggerId:String;
		
		private var _OverSound:Class;

		public function get OverSound() : Class { 
			return _OverSound; 
		}
		public function set OverSound( arg:Class ) : void { 
			_OverSound = arg; 
		}
		
		private var _OutSound:Class;

		public function get OutSound() : Class { 
			return _OutSound; 
		}
		public function set OutSound( arg:Class ) : void { 
			_OutSound = arg; 
		}
		
		private var _loops:int = 0;
		
		public function get loops() : int {
			return _loops;
		}
		
		public function set loops(arg:int):void {
			_loops = arg;
		}
		
		private var _reverseOnOut:Boolean = false;
		
		public function get reverseOnOut() : Boolean {
			return _reverseOnOut;
		}
		
		public function set reverseOnOut(arg) : void {
			_reverseOnOut = arg;
		}
		
		private var _reverseStartFrame:int = 0;
				
		public function get reverseStartFrame() : int {
			return _reverseStartFrame;
		}
				
		public function set reverseStartFrame(arg:int) : void {
			_reverseStartFrame = arg;
		}
		
		private var _trackAudio:Boolean = false;
				
		public function get trackAudio() : Boolean {
			return _trackAudio;
		}
				
		public function set trackAudio(arg:Boolean) : void {
			_trackAudio = arg;
		}
		
		
		
		
		/**  */
		public var bubbleClip:Sprite;
		
		private var _overSoundLength:int = 0;
		
		
		
		/** Trigger constructor */
		public function Trigger() : void {
			super();
			//if(doTrace) DebugUtils.log("Trigger instantiated");
			
			if(highlightClip) DOUtils.disableClipCursor(highlightClip);
			hitArea = hitClip;
			
			
			
			addEventListener(MouseEvent.MOUSE_OVER, _handleMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, _handleMouseOut);
			
			if(bubbleClip) {
				bubbleClip.scaleX = bubbleClip.scaleY = 0;
				bubbleClip.visible = false;
			}
		}
		
		private function _handleMouseOver(e:MouseEvent) : void {
			doMouseOver();
			if(bubbleClip) TweenLite.to(bubbleClip, 0.4, {scaleX:1, scaleY:1, ease:Back.easeOut, onStart:function(){ bubbleClip.visible = true }});
		}
		
		private function _handleMouseOut(e:MouseEvent) : void {
			doMouseOut();
			if(bubbleClip) TweenLite.to(bubbleClip, 0.3, {scaleX:0, scaleY:0, ease:Back.easeIn, onComplete:function(){ bubbleClip.visible = true }});
		}
		
		public function doMouseOver() : void {
			//if(_hover) return;
			//trace("\ndoMouseOver: " + name);
			//removeEventListener(MouseEvent.MOUSE_OVER, _handleMouseOver, false);
			gotoAndPlay(OVER);
			_hover = true;
			if(highlightClip) var _x:TweenLite = new TweenLite(highlightClip, 0.1275, {delay:0,alpha:1,ease:'Quad.easeIn'});
			if(_OverSound) {
				//try { _rolloverSoundChannel.stop(); } catch (e:Error) { }
				var _sound:Sound = new OverSound();
				_overSoundLength = _sound.length;
				_killOverSound();
				_rolloverSoundChannel = _playSound(_sound, _rolloverSoundChannel, (_trackAudio) ? _soundPos : 0, _loops);
			}
		}
		
		public function doMouseOut() : void {
			//addEventListener(MouseEvent.MOUSE_OVER, _handleMouseOver);
			trace("doMouseOut: " + name + "\n");
			_hover = false;
			//if(_reversing) return;
			if(_reverseOnOut) {
				reverse();
			} else {
				stop();
				gotoAndStop(1);
			}
			
			//reverse();
			if(highlightClip) var _x:TweenLite = new TweenLite(highlightClip, 0.3, {delay:0,alpha:0,ease:'Quad.easeOut'});
			if(_OutSound) _rolloutSoundChannel = _playSound(new OutSound(), _rolloverSoundChannel, _soundPos, _loops);
			
			_killOverSound();
		}  
		
		private function _killOverSound() : void {
			if(_rolloverSoundChannel) {
				_soundPos = _rolloverSoundChannel.position;
				if(_soundPos > _overSoundLength) _soundPos = 0;
				try { _rolloverSoundChannel.stop(); } catch (e:Error) { }
			}
		}
		
		/**
		* 
		* @param	
		*/
		public function reverse() : void {
			trace("reverse: " + name);
			if(_reverseStartFrame) gotoAndStop(_reverseStartFrame);
			addEventListener(Event.ENTER_FRAME, _handleEnterFrame);
			_reversing = true;
		}
		
		private function _handleEnterFrame(e:Event) : void {
			if(currentFrame > 1) prevFrame();
			else {
				removeEventListener(Event.ENTER_FRAME, _handleEnterFrame);
				_reversing = false;
			}
		}
		

		

	}

}