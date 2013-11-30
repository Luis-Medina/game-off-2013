package com.states
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	
	import com.components.GameButton;
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.utils.ArrayUtils;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class LifelessProtocol extends StarlingState
	{
		private var lifelessScreen:Image;
		
		private var _restartButton:Button;
		private var _splashButton:Button;
		
		private var rounds:TextField;
		private var net_cash_collected:TextField;
		private var tot_cash_collected:TextField;
		private var tot_cash_lost:TextField;
		private var three_ninety_event:TextField;
		
		private var fontSize:Number = 28;
		private var col:uint = Colors.WHITE;
		private var xPos:Number = 500;
		private var yPos:Number = 245;
		private var gap:Number = 33;
		private var _width:Number = 100;
		private var _height:Number = 32;
		private var _hAlign:String = "left";
		
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
			
			var _rounds:String = Game.ROUNDS_SURVIVED.toString();
			rounds = new TextField(_width, _height, _rounds, "ProtestPaintBB", fontSize, Colors.WHITE, false);
			rounds.hAlign = _hAlign;
			rounds.x = xPos;
			yPos += gap;
			rounds.y = yPos;
			
			var _net:String = ArrayUtils.currency(Game.coinCount);
			net_cash_collected = new TextField(_width, _height, _net, "ProtestPaintBB", fontSize, Colors.WHITE, false);
			net_cash_collected.hAlign = _hAlign;
			net_cash_collected.x = xPos;
			yPos += gap;
			net_cash_collected.y = yPos;
			
			var _390Events:String = Game.THREE_NINETY_EVENTS.toString();
			three_ninety_event = new TextField(_width, _height, _390Events, "ProtestPaintBB", fontSize, Colors.WHITE, false);
			three_ninety_event.hAlign = _hAlign;
			three_ninety_event.x = xPos;
			yPos += gap;
			three_ninety_event.y = yPos;
			
			addChild(rounds);
			addChild(net_cash_collected);
			addChild(three_ninety_event);
			
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
			
			removeChild(rounds);
			removeChild(net_cash_collected);
			removeChild(tot_cash_collected);
			removeChild(tot_cash_lost);
			
			lifelessScreen.dispose();
			_restartButton.dispose();
			_splashButton.dispose();
			
			this.removeChildren();
			
			// super.dispose();
		}
	}
}