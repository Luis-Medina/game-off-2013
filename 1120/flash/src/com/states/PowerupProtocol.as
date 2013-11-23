package com.states
{
	import citrus.core.CitrusEngine;
	
	import com.components.GameButton;
	import com.constants.Audio;
	import com.constants.Game;
	import com.constants.Textures;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class PowerupProtocol extends Sprite
	{
		private var _overlay:Image;
		private var _background:Image;
		private var _closeButton:Button;
		private var _ce:CitrusEngine = CitrusEngine.getInstance()
		
		private var _powerups:Array = ["colossal", "barewalk", "lettuce", "crack"]
		
		public function PowerupProtocol()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_overlay = new Image(Textures.POWERUP_OVERLAY_TEXTURE);
			addChild(_overlay);
			
			// add background
			var _stageWidth:Number = Game.STAGE_WIDTH
			var _stageHeight:Number = Game.STAGE_HEIGHT;
			var _bgTexture:Texture = Textures.getTexture("menu_bg", Textures.POWERUP_TEXTURE_ATLAS);
			_background = new Image(_bgTexture);
			_background.x = Math.floor(_stageWidth * 0.5 - _bgTexture.width * 0.5);
			_background.y = Math.floor(_stageHeight * 0.5 - _bgTexture.height * 0.5) - 10;
			addChild(_background);
			
			_closeButton = GameButton.imageButton(Textures.BUTTON_EXIT_TEXTURE, "close_menu", 46, 46, 825, 75); 
			_closeButton.addEventListener(TouchEvent.TOUCH, buttonHandler);
			addChild(_closeButton);
			
			// this works b/c all the same width:
			var _descWidth:Number =  Textures.getTexture("desc_barewalk", Textures.POWERUP_TEXTURE_ATLAS).width;
			var _nameWidth:Number = Textures.getTexture("name_barewalk", Textures.POWERUP_TEXTURE_ATLAS).width;
			var _upWidth:Number = Textures.getTexture("up_barewalk", Textures.POWERUP_TEXTURE_ATLAS).width;
			
			var _descCenter:Number = _stageWidth*0.5 - _upWidth*0.5;
			var _layout:Array = [_descCenter - _descWidth, _descCenter - _descWidth/3,_descCenter + _descWidth/3, _descCenter + _descWidth];
			var _numPowerups:int = _powerups.length;
			var _powerupButton:Button;
			var _powerupButtonName:Image;
			var _powerupButtonDesc:Image;
			
			var _buttonTexture:Texture;
			var _buttonName:Image;
			var _buttonDesc:Image;
			for (var i:int = 0; i < _numPowerups; i++)
			{
				_buttonTexture = Textures.getTexture("up_" + _powerups[i], Textures.POWERUP_TEXTURE_ATLAS)
				_powerupButton = GameButton.imageButton(_buttonTexture, _powerups[i] + "_button", _buttonTexture.width, _buttonTexture.height, Math.floor(_layout[i]), Math.floor(_background.y + 50));
				addChild(_powerupButton);
				
				_buttonName = new Image(Textures.getTexture("name_" + _powerups[i], Textures.POWERUP_TEXTURE_ATLAS))
				_buttonName.x = Math.floor(_powerupButton.x - _nameWidth/4);
				_buttonName.y = Math.floor(_powerupButton.y + 130);
				addChild(_buttonName);
				
				_buttonDesc = new Image(Textures.getTexture("desc_" + _powerups[i], Textures.POWERUP_TEXTURE_ATLAS))
				_buttonDesc.x = Math.floor(_buttonName.x);
				_buttonDesc.y = Math.floor(_buttonName.y + 60);  
				addChild(_buttonDesc);
			}
			
			
		}
		
		public function buttonHandler(e:TouchEvent):void
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
						
					}	
					
				}
				
			}	
		}
		
		override public function dispose():void
		{
			_overlay.dispose();
			_background.dispose();
			_closeButton.dispose();
			
			super.dispose();
		}
	}
}