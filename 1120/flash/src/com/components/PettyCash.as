package com.components
{
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.ElevenTwentyEvent;
	import com.utils.ArrayUtils;
	
	import flash.events.TimerEvent;
	import flash.globalization.CurrencyFormatter;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class PettyCash extends Sprite
	{		
		private var _numDisplay:TextField;
		private var _numLabel:Image;
		
		public var startValue:String = '$0.00';
		public var numDisplayX:Number = Game.changeXPos + Game.horGap;
		public var numDisplayY:Number = Game.changeYPos - 5;
		public var numDisplayWidth:Number = Game.globalWidth;
		public var numDisplayHeight:Number = Game.globalHeight;
		
		public var numLabelTexture:Texture = Texture.fromBitmap(new Textures.CHANGE_LABEL);
		public var numLabelX:Number = Game.changeXPos;
		public var numLabelY:Number = Game.changeYPos;
		
		public function PettyCash()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_numDisplay = new TextField(numDisplayWidth, numDisplayHeight, startValue, "ProtestPaintBB", Game.globalFontSize, Colors.WHITE, false);
			_numDisplay.hAlign = "left";
			_numDisplay.vAlign = "center"
			_numDisplay.autoScale = false;
			_numDisplay.x = numDisplayX;
			_numDisplay.y = numDisplayY;
			_numDisplay.height = Game.globalFontSize + 2;
			addChild(_numDisplay);
			
			_numLabel = new Image(numLabelTexture);
			
			_numLabel.x = numLabelX;
			_numLabel.y = numLabelY;
			addChild(_numLabel);
		}
		
		public function updateDisplay(money:Number):void
		{
			var currentCash:String = ArrayUtils.currency(money);
			_numDisplay.text = currentCash;
		}
		
		public function clear():void
		{
			_numDisplay.dispose();
		}
		
		override public function dispose():void
		{
			clear()
			
			if(_numDisplay)
				_numDisplay.dispose();
			
			if(_numLabel)
				_numLabel.dispose();
			
			super.dispose();
		}
		
	}
}