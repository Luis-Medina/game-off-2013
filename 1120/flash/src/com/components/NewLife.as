package com.components
{
	import citrus.core.CitrusEngine;
	
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class NewLife extends Sprite
	{
		private var _xTextField:TextField;
		private var _lifeTextField:TextField;
		private var blackness:Image;
		
		private var _startingLife:int = 3;
		private var _width:Number = 80;
		private var _height:Number = 40;
		private var _life:int = _startingLife;
		private var _xPos:Number = 105;
		private var _yPos:Number = 50;
		
		private var _ce:CitrusEngine = CitrusEngine.getInstance()
		
		public function NewLife()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			resetLife();
			_lifeTextField = new TextField(_width, _height, _life.toString(), "ProtestPaintBB", 46, Colors.DARK_RED, false);
			_lifeTextField.x = _xPos;
			_lifeTextField.y = _yPos;
			_lifeTextField.height = 47;
			addChild(_lifeTextField);
			
			_xTextField = new TextField(_width, _height, "x", "ProtestPaintBB", 28, Colors.DARK_RED, false);
			_xTextField.x = _xPos - 16;
			_xTextField.y = _yPos + 12;
			_xTextField.height = 29;
			addChild(_xTextField);
			
			_lifeTextField.alpha = 1;
			_xTextField.alpha = 1;
		}
		
		public function resetLife():void
		{
			_life = _startingLife;
		}
		
		public function removeLife():void
		{
			_life--;
			_life = Math.max(0, _life);
			
			updateLabel();
			
			if (_life < 1)
				devoidOfLife();
		}
		
		public function addLife():void
		{
			_life++;
			updateLabel();
		}
		
		public function getNumLife():int
		{
			return _life;
		}
		
		public function devoidOfLife():void
		{
			trace("DEVOID OF LIFE")
			// Game.hero.controlsEnabled = false;
			/*
			blackness = new Image(Textures.BLACK_TEXTURE);
			addChild(blackness);
			blackness.alpha = 0;
			
			Starling.juggler.tween(blackness, 3, {
				transition: Transitions.EASE_IN,
				alpha: 1,
				onComplete: finishedFade
			})*/
			sendDeathEvent();
		}
		
		private function finishedFade():void
		{
			sendDeathEvent();
		}
		
		public function sendDeathEvent():void
		{
			dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.DEATH}, true));
		}
		
		private function updateLabel():void
		{
			resetAlpha();
			Starling.juggler.tween(_lifeTextField, 0.5, {
				transition: Transitions.EASE_IN,
				delay: 0,
				repeatCount: 2,
				onComplete: resetAlpha,
				reverse: true,
				alpha: 0
			});
			
			Starling.juggler.tween(_xTextField, 0.5, {
				transition: Transitions.EASE_IN,
				delay: 0,
				repeatCount: 2,
				reverse: true,
				alpha: 0
			});
			
			_lifeTextField.text = _life.toString();
		}
		
		public function resetAlpha():void
		{
			_lifeTextField.alpha = 1;
			_xTextField.alpha = 1;
			
		}
		
		override public function dispose():void
		{
			Starling.juggler.purge();
			
			if (_lifeTextField)
				_lifeTextField.dispose();
			
			if (blackness)
				blackness.dispose();
			
			super.dispose();
		}
	}
}