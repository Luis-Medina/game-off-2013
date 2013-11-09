package com.states
{	
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	
	import com.components.GameButton;
	import com.constants.Colors;
	import com.constants.Fonts;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class MenuProtocol extends StarlingState
	{
		private var _size:Number = 32;
		private var _height:Number = 60;
		private var _width:Number = 100;
		
		private var _bg:CitrusSprite;
		private var _buttonTexture:Texture;
		private var _button:Button;
		
		private var _carnage:CarnageProtocol;
		private var _terminate:TerminateProtocol;
		
		public function MenuProtocol()
		{
			super();
			this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super.initialize();
			trace("MENU PROTOCOL")

			var _bgSrc:Texture = Textures.SPLASH_TEXTURE;
			_bg = new CitrusSprite("splash_img", {view:_bgSrc});
			add(_bg);
			
			drawMenu();
		}
		
		private function drawMenu():void
		{
			/** MENU **/
			var _buttons:Array = [Game.START, Game.EXIT];			
			var x:Number, y:Number;
			for (var i:int = 0; i < _buttons.length; i++)
			{
				x = Game.STAGE_WIDTH/2 - _width/2;
				y = 100 + (Game.STAGE_HEIGHT/2) + (i * _size*1.5);
				_button = GameButton.textButton(_buttons[i], _buttons[i], _size, _width, _height, x, y); 
				_button.addEventListener(TouchEvent.TOUCH, buttonHandler);
				
				this.addChild(_button);
			}
			
			this.visible = true;
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
						button.removeEventListener(TouchEvent.TOUCH, buttonHandler);
						if (button.name == Game.START)
							dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.START}, true));
						else if (button.name == Game.EXIT)
							dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.EXIT}, true));
					}	
				}
			}
			
		}
		
		override public function destroy():void
		{
			_bg.destroy();
			_button.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			this.removeChildren();
			// super.destroy(); // dont call this... 
		}
		
	}
}