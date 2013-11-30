package com.components
{
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.constants.Fonts;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Rounds extends Sprite
	{
		
		private var _round:int = 0;
		public var xPos:Number = 700;
		public var yPos:Number = 5;
		
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
			_countTextField.hAlign = "center"
			_countTextField.x = xPos;
			_countTextField.y = yPos + 10;
			addChild(_countTextField);
		}

		
		public function updateRound(increase:Boolean):void
		{
			if (increase)
				_round++
			else
				return;
				
			Starling.juggler.tween(_countTextField, 0.5, {
				transition: Transitions.EASE_IN,
				delay: 0,
				repeatCount: 2,
				reverse: true,
				alpha: 0
			});
			
			_countTextField.text = _round.toString();
			Game.ROUNDS_SURVIVED = _round;
			
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