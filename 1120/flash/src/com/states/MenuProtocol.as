package com.states
{	
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.sounds.CitrusSoundEvent;
	
	import com.components.GameButton;
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.managers.TipManager;
	import com.utils.ArrayUtils;
	
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.particles.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class MenuProtocol extends StarlingState
	{
		private var _size:Number = 26;
		private var _height:Number = 60;
		private var _width:Number = 200;
		
		private var _bg:CitrusSprite;
		private var _moon:CitrusSprite;
		private var _front:CitrusSprite;
		private var _logo:CitrusSprite;
		private var _atmoParticles:PDParticleSystem;
		private var _atmoParticlesSprite:CitrusSprite;
		
		private var _buttonTexture:Texture;
		private var _button:Button;
		private var _splashDelay:Timer;
		private var _delay:Timer;
		private var _repeatTimer:Timer;
		private var _shakeTimer:Timer;
		
		private var _carnage:CarnageProtocol;
		private var _terminate:TerminateProtocol;
		
		private var citrusSplash:Image;
		private var unimpressedTurtleSplash:Image;
		
		private var tips:TipManager = new TipManager();
		
		public function MenuProtocol()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super.initialize();
			trace("MENU PROTOCOL")

			if (!Game.ALREADY_INITIATED)
			{
				_splashDelay = new Timer(500, 1);
				_splashDelay.addEventListener(TimerEvent.TIMER, _splashDelayCallback);
				_splashDelay.start();
			}
			else 
			{
				drawMenu();
			}
		}
		
		private function _splashDelayCallback(e:TimerEvent):void
		{
			Game.ALREADY_INITIATED = true;
			_splashDelay.removeEventListener(TimerEvent.TIMER, _splashDelayCallback);
			
			nextSplash();
			// firstSplash();
		}
		
		private function firstSplash():void
		{			
			citrusSplash = new Image(Textures.CITRUS_TEXTURE);
			citrusSplash.alpha = 1;
			addChild(citrusSplash);
			
			Starling.juggler.tween(citrusSplash, 4, {
				transition: Transitions.EASE_IN,
				onComplete: nextSplash //,
				//alpha: 0
			});
		}
		
		private function nextSplash():void
		{
			removeChild(citrusSplash);
			
			unimpressedTurtleSplash = new Image(Textures.UNIMPRESSED_TEXTURE);
			// citrusSplash.alpha = 1;
			addChild(unimpressedTurtleSplash)
			
			Starling.juggler.tween(unimpressedTurtleSplash, 4, {
				transition: Transitions.EASE_IN,
				onComplete: drawMenu //,
				//alpha: 0
			});
		}
		
		private function drawMenu():void
		{
			if (unimpressedTurtleSplash)
				removeChild(unimpressedTurtleSplash);
			
			/** MENU BACKGROUNDS **/
			var _bgSrc:Texture = Textures.MENU_BACK_TEXTURE;
			_bg = new CitrusSprite("splash_img", {view:_bgSrc});
			add(_bg);
			
			var _moonSrc:Texture = Textures.MENU_MOON_TEXTURE;
			_moon = new CitrusSprite("moon_img", {view:_moonSrc});
			add(_moon);
			
			_atmoParticles = new PDParticleSystem(XML(new Textures.ATMOSPHERE_CONFIG()), Textures.MONEY_TEXTURE_TEXTURE);
			_atmoParticlesSprite = new CitrusSprite("atmo_particles_menu", {view: _atmoParticles, parallaxX:1.7, parallaxY:1.7});
			_atmoParticlesSprite.x = Game.STAGE_WIDTH / 2;
			add(_atmoParticlesSprite);
			_atmoParticles.start();
			
			var _frontSrc:Texture = Textures.MENU_FRONT_TEXTURE;
			_front = new CitrusSprite("front_img", {view:_frontSrc});
			add(_front);
			
			var _logoSrc:Texture = Textures.MENU_LOGO_TEXTURE;
			_logo = new CitrusSprite("splash_img", {view:_logoSrc});
			add(_logo);
			
			Starling.juggler.tween(_moon, 0.1, {
				transition: Transitions.EASE_IN,
				repeatCount: 0,
				y: _moon.y - 1.5
			})
						
			/** MENU BUTTONS **/
			var _buttons:Array = [Game.START, Game.INSTRUCTIONS, Game.EXIT, Game.DEADPLANET];			
			var x:Number, y:Number;
			for (var i:int = 0; i < _buttons.length; i++)
			{
				x = Game.STAGE_WIDTH/2 - _width/2;
				y = 100 + (Game.STAGE_HEIGHT/2) + (i * _size*1.5);
				_button = GameButton.textButton(_buttons[i], _buttons[i], _size, _width, _height, x, y); 
				_button.addEventListener(TouchEvent.TOUCH, buttonHandler);
				
				this.addChild(_button);
			} 
			
			addChild(tips);
			tips.visible = false;
			
			_delay = new Timer(500, 1);
			_delay.addEventListener(TimerEvent.TIMER, _delayTimerCallback);
			_delay.start();
		}
		
		private function _delayTimerCallback(e:TimerEvent):void
		{
			_delay.removeEventListener(TimerEvent.TIMER, _delayTimerCallback);
			_ce.sound.playSound("drone");
			playDrone();
		}
		
		private function playDrone():void
		{
			/// LOOPING THIS MANUALLY BECAUSE the "LOOP"/"TimesToRepeat" argument isn't doing jack shit.
			
			// logo shake
			var intensity:Number = ArrayUtils.randomRange(5, 50);
			var duration:Number = ArrayUtils.randomRange(50, 100);
			shake(duration, intensity);
			
			_repeatTimer = new Timer(7000, 1);
			_repeatTimer.addEventListener(TimerEvent.TIMER, droneRepeat);
			_repeatTimer.start();
		}
		
		private function droneRepeat(e:TimerEvent):void
		{
			_ce.sound.playSound("drone");
			
			playDrone();
		}

		
		private function shake(duration:Number, intensity:Number):void
		{
			_logo.x = Math.random() * intensity - intensity / 2;
			_logo.y = Math.random() * intensity - intensity / 2;
			
			_shakeTimer = new Timer(duration, 1);
			_shakeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeTimerCallback);
			_shakeTimer.start();
		}
		
		private function shakeTimerCallback(e:TimerEvent):void
		{
			_shakeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeTimerCallback);
			_logo.x = 0;
			_logo.y = 0;
		}

		private function buttonHandler(e:TouchEvent):void
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
						//button.removeEventListener(TouchEvent.TOUCH, buttonHandler);
						if (button.name == Game.START)
							dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.START}, true));
						else if (button.name == Game.EXIT)
							dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.EXIT}, true));
						else if (button.name == Game.INSTRUCTIONS)
							tips.show();
						else if (button.name == Game.DEADPLANET)
							dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.DEADPLANET}, true));
					}	
				}
			}
			
		}
		
		override public function destroy():void
		{
			_bg.destroy();
			_moon.destroy();
			_front.destroy();
			_logo.destroy();
			
			if (citrusSplash)
				citrusSplash.dispose();
			
			if (unimpressedTurtleSplash)
				unimpressedTurtleSplash.dispose();
			
			if (tips)
				tips.dispose();
			
			if(_atmoParticles)
				_atmoParticles.dispose();
			
			Starling.juggler.purge();
			
			_button.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			_repeatTimer.removeEventListener(TimerEvent.TIMER, droneRepeat);
			_delay.removeEventListener(TimerEvent.TIMER, _delayTimerCallback);
			_shakeTimer.removeEventListener(TimerEvent.TIMER, shakeTimerCallback);
			
			if (_splashDelay)
				_splashDelay.removeEventListener(TimerEvent.TIMER, _splashDelayCallback);
			
			this.removeChildren();
			// super.destroy(); // dont call this... 
		}
		
	}
}