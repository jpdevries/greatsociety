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

	// 2nd Party Imports
	import com.trycatch.geom.*;
	import com.trycatch.media.*;
	import com.trycatch.utils.*;
	
	import com.gs.data.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.bumpslide.util.Delegate;

	/**   */
	public class ShopClip extends AudioClip {
		/** The name of the class */
		public static const CLASSNAME:String = "ShopClip";

		/** If false this class will suspend trace statements */
		public static var doTrace:Boolean = true;

		/** The full classPath */
		public static function get classPath() : String {
			return "com.gs.components" + CLASSNAME;
		}
		
		/**  */
		public var leftBtn:Sprite;
		
		/**  */
		public var rightBtn:Sprite;

		/**  */
		public var menuMask:Sprite;
		
		/**  */
		public var menuHolder:Sprite;
		
		/**  */
		public var coinOne:Sprite;
		
		/**  */
		public var coinTwo:Sprite;
		
		/**  */
		public var billClip:Sprite;
		
		/**  */
		public var returnClip:Sprite;
		
		private var _model:DataModel = DataModel.getInstance();
		
		private var _shopItemW:int = 190;
		
		private var _returnClipOrig:PropSet;
		private var _coinOneOrig:PropSet;
		private var _coinTwoOrig:PropSet;
		private var _billClipOrig:PropSet;
		
		private var _scrollIndex:int = 0;

		public function get scrollIndex() : int { 
			return _scrollIndex; 
		}
		public function set scrollIndex( arg:int ) : void { 
			_scrollIndex = arg; 
			(_scrollIndex < 1) ? _disableBtn(leftBtn) : _enableBtn(leftBtn);
			(_scrollIndex == _model.productDTOs.length - 4) ? _disableBtn(rightBtn) : _enableBtn(rightBtn);
		}
		
		private var _origMenuHolderX:Number = 0;
		
		
		/** ShopClip constructor */
		public function ShopClip() : void {
			super();
			//if(doTrace) DebugUtils.log("ShopClip instantiated");
			
			leftBtn.visible = rightBtn.visible = false;
			scrollIndex = 0;
			
			_origMenuHolderX = menuHolder.x;
			_returnClipOrig = new PropSet(returnClip.x, returnClip.y, returnClip.rotation);
			_coinOneOrig = new PropSet(coinOne.x, coinOne.y, coinOne.rotation);
			_coinTwoOrig = new PropSet(coinTwo.x, coinTwo.y, coinTwo.rotation);
			_billClipOrig = new PropSet(billClip.x, billClip.y, billClip.rotation);
		}
		
		private function _disableBtn(_btn:Sprite) : void {
			DOUtils.disableClipCursor(_btn);
			_btn.alpha = 0.5;
			_btn.removeEventListener(MouseEvent.MOUSE_UP, _handleScroll);
		}
		
		private function _enableBtn(_btn:Sprite) : void {
			DOUtils.enableClipCursor(_btn);
			_btn.alpha = 1;
			_btn.addEventListener(MouseEvent.MOUSE_UP, _handleScroll);
		}
		
		private function _handleScroll(e:MouseEvent) : void {
			switch(e.currentTarget) {
				case leftBtn:
				if(_scrollIndex > 0) _doScroll(-1);
				break;
				
				case rightBtn:
				if(_scrollIndex < _model.productDTOs.length - 4) _doScroll(1);
				break;
				
				default:
				break;
			}
		}
		
		private function _doScroll(_dir:int) : void {
			//if(_scrollIndex < 1 && _dir == -1 || _scrollIndex > _model.productDTOs.length - 4) return;
			scrollIndex += _dir;
			trace("_doScroll:: " + _dir); 
			var _destX:Number = _origMenuHolderX - (_shopItemW * _scrollIndex);
			TweenLite.to(menuHolder, Math.abs(_destX - menuHolder.x) / 300, {x:_destX, ease:'Quad.easeOut',delay:0});
		}
		
		/**
		* 
		* @param	
		*/
		public function doIntro() : void {
			//if(doTrace) DebugUtils.log("doIntro called >> " + classPath);
			DOUtils.disableClipCursors([billClip,coinOne,coinTwo]);
			billClip.mouseChildren = coinOne.mouseChildren = coinTwo.mouseChildren = false;
			TweenLite.to(this,0.6,{y:0, ease:'Quad.easeIn', delay:0});
			TweenLite.to(billClip,0.6,{y:430 - 30, rotation:0, x:440, ease:'Quad.easeIn', delay:.7});
			TweenLite.to(coinOne,0.6,{y:490, x:360, ease:'Quad.easeIn', delay:1.1, onComplete:function(){
				_drawProducts();
			}});
			TweenLite.to(coinTwo,0.6,{y:550, x:330, ease:'Quad.easeIn', delay:1.3});
			TweenLite.to(returnClip, 0.8, {y:384, alpha:1, rotation:-3, ease:'Quad.easeIn', delay:2.5, onComplete:function(){
				DOUtils.enableClipCursor(returnClip);
				returnClip.addEventListener(MouseEvent.MOUSE_UP, _handleGoBackClicked);
			}});
			
			Delegate.callLater(1350,function(){
				_playSound(new CoinB());
			});
			
			
		}
		
		private function _handleGoBackClicked(e:MouseEvent) : void {
			returnClip.removeEventListener(MouseEvent.MOUSE_UP, _handleGoBackClicked);
			DOUtils.disableClipCursor(returnClip);
			
			TweenLite.to(menuHolder,0.6,{alpha:0, ease:'Quad.easeIn', delay:0});
			
			TweenLite.to(returnClip, 0.6, {y:_returnClipOrig.y, alpha:0, rotation:_returnClipOrig.rotation, ease:'Quad.easeIn', delay:0.2});
			TweenLite.to(coinTwo,0.5,{y:_coinTwoOrig.y, x:_coinTwoOrig.x, ease:'Quad.easeIn', delay:0.5});
			TweenLite.to(coinOne,0.5,{y:_coinOneOrig.y, x:_coinOneOrig.x, ease:'Quad.easeIn', delay:0.7});
			
			
			
			TweenLite.to(billClip,0.9,{y:_billClipOrig.y, rotation:_billClipOrig.rotation, x:_billClipOrig.x, ease:'Quad.easeIn', delay:0.9});
			TweenLite.to(this,2,{y:stage.stageHeight + 600, ease:'Quad.easeIn', delay:1.275});
			
			Delegate.callLater(500,function(){
				_playSound(new CoinA());
			});
		}
		
		private function _drawProducts() : void {
			var _productDTOs:Vector.<ProductDTO> = _model.productDTOs;
			var l:int = _productDTOs.length;
			for (var i:int = 0; i < l; i++) {
				var _curProdDTO:ProductDTO = _productDTOs[i];
				var _curProd:ShopItem = new ShopItem();
				_curProd.shopData = _curProdDTO;
				_curProd.x = _shopItemW * i;
				menuHolder.addChild(_curProd);
			}
			
			// if there are any products
			if(l > 3) {
				// activate scroll btns
				leftBtn.visible = rightBtn.visible = true;
			}
		}
		
		

		


		

	}

}