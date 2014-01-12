package com.managers
{
	import citrus.core.CitrusEngine;
	
	import com.components.GameButton;
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class TipManager extends Sprite
	{
		private var _overlay:Image;
		private var _overlay2:Image;
		private var _background:Image;
		private var _closeButton:Button;
		private var _previousButton:Button;
		private var _nextButton:Button;
		
		private var currentTip:TextField;
		private var index:int = 0;
		
		private var _ce:CitrusEngine = CitrusEngine.getInstance()
			
		private var tips:Array = 
			[
			"The prophet requires $3.90 for his assistance.",
			"All uncollected change within a round becomes negative.",
			"Hits hurt unless you achieve temporary immortality.",
			"Survive."
			];
		
		public function TipManager()
		{
			super()
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
		
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//_overlay2 = new Image(Textures.SPLASH_TEXTURE);
			//addChild(_overlay2);   
			
			_overlay = new Image(Textures.POWERUP_OVERLAY_TEXTURE);
			addChild(_overlay);
			
			// add background
			var _stageWidth:Number = Game.STAGE_WIDTH
			var _stageHeight:Number = Game.STAGE_HEIGHT;
			var _bgTexture:Texture = Textures.getTexture("menu_bg", Textures.POWERUP_TEXTURE_ATLAS);
			_background = new Image(_bgTexture);
			_background.x = Math.floor(_stageWidth * 0.5 - _bgTexture.width * 0.5);
			_background.y = Math.floor(_stageHeight * 0.5 - _bgTexture.height * 0.5) + 10;
			addChild(_background);
			
			_closeButton = GameButton.imageButton(Textures.BUTTON_EXIT_TEXTURE, "close_menu", 46, 46, 820, 100); 
			_closeButton.addEventListener(TouchEvent.TOUCH, buttonHandler);
			addChild(_closeButton);
			
			currentTip = new TextField(400, 100, tips[index], "ProtestPaintBB", Game.globalFontSize + 6, Colors.WHITE, false);
			currentTip.hAlign = "center"
			currentTip.autoScale = false;
			currentTip.x = Game.STAGE_WIDTH / 2 - currentTip.width/2;
			currentTip.y = Game.STAGE_HEIGHT / 2 - currentTip.height/2;
			addChild(currentTip);
			
			_previousButton = GameButton.imageButton(Textures.BUTTON_LEFT_TEXTURE, "left", 46, 46, Game.STAGE_WIDTH / 2 - 280, currentTip.y); 
			_previousButton.addEventListener(TouchEvent.TOUCH, buttonHandler);
			addChild(_previousButton);
			
			_nextButton = GameButton.imageButton(Textures.BUTTON_RIGHT_TEXTURE, "right", 46, 46, Game.STAGE_WIDTH / 2 + 280, currentTip.y); 
			_nextButton.addEventListener(TouchEvent.TOUCH, buttonHandler);
			addChild(_nextButton);
			
			update();
		}
		
		public function buttonHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if(touch)
			{
				var button:Button = e.currentTarget as Button;
				if (button)
				{
					if(touch.phase == TouchPhase.ENDED)
					{ 
						var _name:String = button.name;
						if (_name == "close_menu")
						{
							hide();
						} else if (_name == "left"){
							
							index = Math.max(0, index - 1);
							update();
						} else if (_name == "right"){
							
							index = Math.min(index + 1, tips.length - 1);
							update();
						}
						_ce.sound.playSound("click");
					}
				
				}	
			}
		}
		
		public function update():void
		{
			currentTip.text = tips[index];
			
			if (index == 0)
				_previousButton.visible = false;
			else
				_previousButton.visible = true;
			
			if (index == tips.length - 1)
				_nextButton.visible = false;
			else
				_nextButton.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		
		override public function dispose():void
		{
			_closeButton.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			_nextButton.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			_previousButton.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			
			_closeButton.dispose();
			_previousButton.dispose();
			_nextButton.dispose();
			
			_background.dispose();
			_overlay.dispose();
			//_overlay2.dispose();
			
			super.dispose();
		}
	}
}