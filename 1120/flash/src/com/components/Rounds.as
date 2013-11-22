package com.components
{
	import com.constants.Textures;
	import com.constants.Colors;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Rounds extends Sprite
	{
		
		private var _round:int = 0;
		public var xPos:Number = 700;
		public var yPos:Number = 0;
		
		private var _count:Image;
		private var _countTextField:TextField;
		
		public function Rounds()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_count = new Image(Texture.fromBitmap(new Textures.SCORE));
			_count.x = xPos;
			_count.y = yPos;
			addChild(_count);
			
			_countTextField = new TextField(_count.width, _count.height, _round.toString(), "ProtestPaintBB", 38, Colors.WHITE, false);
			
			_countTextField.x = xPos;
			_countTextField.y = yPos;
			addChild(_countTextField);
		}

		
		public function updateRound():void
		{
			_round++
			_countTextField.text = _round.toString();
		}
		
		public function getRound():int
		{
			return _round;
		}
		
		override public function dispose():void
		{
			_count.dispose();
			_countTextField.dispose();
			
			super.dispose();
		}
	}
}