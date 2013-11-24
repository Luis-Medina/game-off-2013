package com.components
{
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.ElevenTwentyEvent;
	import com.utils.ArrayUtils;
	
	import flash.events.TimerEvent;
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
		public var numDisplayY:Number = Game.changeYPos;
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
			_numDisplay.x = numDisplayX;
			_numDisplay.y = numDisplayY;
			addChild(_numDisplay);
			
			_numLabel = new Image(numLabelTexture);
			
			_numLabel.x = numLabelX;
			_numLabel.y = numLabelY;
			addChild(_numLabel);
		}
		
		public function updateDisplay(money:Number):void
		{
			var currentCash:String = "$" + setPrecision(money, 2); // ((money == 0) ? "0.00" : money);
			_numDisplay.text = currentCash;
		}
		
		public function clear():void
		{
			_numDisplay.dispose();
		}
		
		override public function dispose():void
		{
			clear();
			super.dispose();
		}
		
		// http://stackoverflow.com/questions/632802/how-to-deal-with-number-precision-in-actionscript
		private function setPrecision(number:Number, precision:int):Number
		{
			precision = Math.pow(10, precision);
			return (Math.round(number * precision)/precision);
		}
	}
}