package com.states
{
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	
	import com.components.GameButton;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class CarnageProtocol extends StarlingState
	{
		private var _bg:Image;
		private var _restartButton:Button;
		private var _splashButton:Button;
		
		public function CarnageProtocol() {
			
			trace("CARNAGE PROTOCOL")
			
			super();
		}

		override public function initialize():void {
			
			super.initialize();
			
			if (!_bg)
				_bg = new Image(Texture.fromBitmap(new Textures.LEVEL_1_BG));
			
			addChild(_bg);
			
			var box2d:Box2D = new Box2D("box2d");
			box2d.visible = true;
			add(box2d);
			
			var hero:Hero = new Hero("hero", {x:210, y:100, width:20, height:20});
			hero.acceleration = 100;
			hero.jumpAcceleration = 5;
			add(hero);
			
			/** WALLS **/
			add(new Platform("bottom", {x:stage.stageWidth / 2, y:stage.stageHeight, width:stage.stageWidth, height: 20}));
			add(new Platform("roof", {x:stage.stageWidth / 2, y:0, width:stage.stageWidth, height: 10}));
			add(new Platform("left_wall", {x:0, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));
			add(new Platform("right_wall", {x: stage.stageWidth, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));
			
			
			/** UI **/
			_restartButton = GameButton.textButton('O', Game.RESTART, 42, 40, 40, 860, 15); 
			_splashButton = GameButton.textButton('X', Game.SPLASH, 42, 40, 40, 900, 15); 
			_restartButton.addEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.addEventListener(TouchEvent.TOUCH, handleUI);
			addChild(_restartButton);
			addChild(_splashButton);
			
			this.visible = true;
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
						 clear();
						 if(button.name == Game.RESTART)
						 	dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.RESTART}, true));
						 else if (button.name == Game.SPLASH)
							 dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.SPLASH}, true));
					}	
					
				}
				
			}	
		}
		
		private function clear():void
		{
			if (_bg)
				_bg = null;
			
			if (_restartButton)
			{
				_restartButton.removeEventListener(TouchEvent.TOUCH, handleUI);
				_restartButton = null;
			}
			
			if (_splashButton)
			{
				_splashButton.removeEventListener(TouchEvent.TOUCH, handleUI);
				_splashButton = null;
			}
			
			this.removeEventListener(TouchEvent.TOUCH, handleUI);
			this.removeChildren();
			this.dispose();
		}
		
	}
}