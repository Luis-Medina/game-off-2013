package com.states
{	
	import citrus.core.starling.StarlingState;
	import citrus.input.Input;
	
	import com.constants.Colors;
	import com.constants.Fonts;
	import com.constants.Game;
	import com.constants.Textures;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class MenuProtocol extends StarlingState
	{
		private var _size:Number = 36;
		private var _fontFamily:String = "DestroyEarthRoughBB";
		private var _col:uint = Colors.BLUE;
		private var _hoverCol:uint = Colors.WHITE;
		private var _height:Number = 100;
		private var _width:Number = 300;
		
		private var _buttonTexture:Texture;
		private var _button:Button;
		
		public function MenuProtocol()
		{
			super();
			this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawMenu();
		}
		
		private function drawMenu():void
		{
			trace("MENU PROTOCOL 1120")		
			var _buttons:Array = ['START', 'EXIT'];
			_buttonTexture = Texture.fromBitmap(new Textures.BLANK);
			
			for (var i:int = 0; i < _buttons.length; i++)
			{
				_button = new Button(_buttonTexture);
				_button.visible = true;
				_button.fontSize = _size;
				_button.fontColor = _col;
				_button.fontName = _fontFamily;
				_button.text = _buttons[i];
				_button.enabled = true;
				_button.x = Game.STAGE_WIDTH/2 - _width/2;
				_button.y = (Game.STAGE_HEIGHT/2) + (i * _size*1.5);
				_button.useHandCursor = true;
				_button.name = _buttons[i];
				
				this.addChild(_button);
			}
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			this.visible = true;
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
				}
					
				else if(touch.phase == TouchPhase.ENDED)
				{
				}
					
				else if(touch.phase == TouchPhase.MOVED)
				{
					
				}
			}
			
		}
		
		private function create():void
		{
			
		}
		
		private function terminate():void
		{
		}
		
	}
}