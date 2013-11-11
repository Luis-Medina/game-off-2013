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
		public var numDisplayX:Number = 280;
		public var numDisplayY:Number = 12;
		public var numDisplayWidth:Number = 100;
		public var numDisplayHeight:Number = 40;
		
		public var numLabelTexture:Texture = Texture.fromBitmap(new Textures.CHANGE_LABEL);
		public var numLabelX:Number = 185;
		public var numLabelY:Number = 12;
		
		public function PettyCash()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_numDisplay = new TextField(numDisplayWidth, numDisplayHeight, startValue, "ProtestPaintBB", 38, Colors.WHITE, false);
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
			var currentCash:String = "$" + ((money == 0) ? "0.00" : money);
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
	}
}