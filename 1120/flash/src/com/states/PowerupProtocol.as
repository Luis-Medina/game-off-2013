package com.states
{
	import citrus.core.CitrusEngine;
	
	import com.components.GameButton;
	import com.constants.Audio;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.PowerupEvent;
	import com.events.RestartTimerEvent;
	
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
		private var _alreadyPlayed:Boolean = false;
		
		private var _colossalButton:Button;
		private var _barewalkButton:Button;
		private var _lettuceButton:Button;
		private var _crackButton:Button;
		private var _powerupButtons:Array = [_colossalButton, _barewalkButton, _crackButton];
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
			_background.y = Math.floor(_stageHeight * 0.5 - _bgTexture.height * 0.5) + 10;
			addChild(_background);
			
			_closeButton = GameButton.imageButton(Textures.BUTTON_EXIT_TEXTURE, "close_menu", 46, 46, 820, 100); 
			_closeButton.addEventListener(TouchEvent.TOUCH, buttonHandler);
			addChild(_closeButton);
			
			// this works b/c all the same width:
			var _descWidth:Number =  Textures.getTexture("desc_barewalk", Textures.POWERUP_TEXTURE_ATLAS).width;
			var _nameWidth:Number = Textures.getTexture("name_barewalk", Textures.POWERUP_TEXTURE_ATLAS).width;
			var _upWidth:Number = Textures.getTexture("up_barewalk", Textures.POWERUP_TEXTURE_ATLAS).width;
			
			var _descCenter:Number = _stageWidth*0.5 - _upWidth*0.5;
			var _layout:Array = [_descCenter - _descWidth, _descCenter - _descWidth/3,_descCenter + _descWidth/3, _descCenter + _descWidth];
			var _numPowerups:int = _powerups.length;
			var _powerupButtonName:Image;
			var _powerupButtonDesc:Image;
			
			var _buttonTexture:Texture;
			var _buttonName:Image;
			var _buttonDesc:Image;
			for (var i:int = 0; i < _numPowerups; i++)
			{
				_buttonTexture = Textures.getTexture("up_" + _powerups[i], Textures.POWERUP_TEXTURE_ATLAS)
				_powerupButtons[i] = GameButton.imageButton(_buttonTexture, _powerups[i] + "_button", _buttonTexture.width, _buttonTexture.height, Math.floor(_layout[i]), Math.floor(_background.y + 60));
				_powerupButtons[i].addEventListener(TouchEvent.TOUCH, buttonHandler);
				addChild(_powerupButtons[i]);
				
				_buttonName = new Image(Textures.getTexture("name_" + _powerups[i], Textures.POWERUP_TEXTURE_ATLAS))
				_buttonName.x = Math.floor(_powerupButtons[i].x - _nameWidth/4);
				_buttonName.y = Math.floor(_powerupButtons[i].y + 130);
				addChild(_buttonName);
				
				_buttonDesc = new Image(Textures.getTexture("desc_" + _powerups[i], Textures.POWERUP_TEXTURE_ATLAS))
				_buttonDesc.x = Math.floor(_buttonName.x);
				_buttonDesc.y = Math.floor(_buttonName.y + 60);  
				addChild(_buttonDesc);
			}

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
							_ce.sound.playSound("click");
							dispatchEvent(new RestartTimerEvent(RestartTimerEvent.RESTART, {}, true));
						
						} else if (Game.coinCount >= Game.THREE_NINETY) {

							var params:Object = new Object();
							if (_name == "colossal_button")
							{
								params.type = "colossal"
								params.sound = ""
								
							} else if (_name == "barewalk_button") 
							{
								params.type = "barewalk"
								params.sound = ""
									
							} else if (_name == "lettuce_button") 
							{
									
								params.type = "lettuce"
								params.sound = ""
									
							} else if (_name == "crack_button")	
							{
								params.type = "crack"
								params.sound = ""
							}
							
							params.sound = "click" // for now;
							params.revert = false;
							dispatchEvent(new PowerupEvent(PowerupEvent.POWERUP, params, true));
							
						} else {
							
							// NOT ENOUGH CASH, BRAH!
							// _ce.sound.playSound("earthrot");
						}
						updateClickability(); // update button status after each 'purchase'
					}	
					
				}
				
			}	
		}
		
		public function updateClickability():void
		{
			if (Game.coinCount >= Game.THREE_NINETY)
				updateButtonStatus(true);
			else
				updateButtonStatus(false);		
		}
		
		public function updateButtonStatus(enabled:Boolean):void
		{
			for (var i:int = 0; i < _powerupButtons.length; i++)
			{
				_powerupButtons[i].enabled = enabled;
			}
		}
		
		public function hide():void
		{
			this.visible = false;
			_alreadyPlayed = false; // reset
		}
		
		public function show():void
		{
			updateClickability();
			this.visible = true;
			
			if (!_alreadyPlayed)
			{
				_alreadyPlayed = true;
				_ce.sound.playSound("lick_chord");
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