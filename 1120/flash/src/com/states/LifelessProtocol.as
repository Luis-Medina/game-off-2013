package com.states
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	
	import com.components.GameButton;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class LifelessProtocol extends StarlingState
	{
		private var lifelessScreen:Image;
		
		private var _restartButton:Button;
		private var _splashButton:Button;
		
		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
		
		public function LifelessProtocol()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			lifelessScreen = new Image(Textures.LIFELESS_TEXTURE);
			addChild(lifelessScreen);
			
			_restartButton = GameButton.imageButton(Textures.BUTTON_RESTART_TEXTURE, Game.RESTART, 46, 46, 840, 10); 
			_splashButton = GameButton.imageButton(Textures.BUTTON_EXIT_TEXTURE, Game.SPLASH, 46, 46, 900, 10); 
			_restartButton.addEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.addEventListener(TouchEvent.TOUCH, handleUI);
			addChild(_restartButton);
			addChild(_splashButton);
			
			this.alpha = 0;
			
			Starling.juggler.tween(this, 3, {
				transition: Transitions.EASE_IN,
				alpha: 1
			})
		}
		
		public function handleUI(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				var button:Button = e.currentTarget as Button;
				if (button)
				{					
					if(touch.phase == TouchPhase.ENDED)
					{
						_ce.sound.playSound("click");
						if(button.name == Game.RESTART)
						{
							handleRestart();
						}else if (button.name == Game.SPLASH)
						{
							handleExit();
						}
					}	
					
				}
				
			}	
		}
		
		private function handleRestart():void
		{
			trace("RESTART")
			dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.RESTART}, true));
		}
		
		private function handleExit():void
		{
			trace("EXIT")
			dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.SPLASH}, true));
		}
		
		
		override public function destroy():void
		{
			Starling.juggler.purge();
			_restartButton.removeEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.removeEventListener(TouchEvent.TOUCH, handleUI);
			
			lifelessScreen.dispose();
			_restartButton.dispose();
			_splashButton.dispose();
			
			this.removeChildren();
			
			// super.dispose();
		}
	}
}