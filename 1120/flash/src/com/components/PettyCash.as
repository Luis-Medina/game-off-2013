package com.components
{
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.ElevenTwentyEvent;
	
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
		
		public function PettyCash()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_numDisplay = new TextField(80, 40, '$0.00', "ProtestPaintBB", 38, Colors.WHITE, false);
			_numDisplay.x = 280;
			_numDisplay.y = 12;
			addChild(_numDisplay);
			
			// TODO: not like this:
			_numLabel = new Image(Texture.fromBitmap(new Textures.CHANGE_LABEL));
			
			_numLabel.x = 175;
			_numLabel.y = 12;
			addChild(_numLabel);
		}
		
		public function updateDisplay(money:Number):void
		{
			var currentCash:String = "$" + money;
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