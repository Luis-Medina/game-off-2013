package com.states
{	
	import citrus.core.starling.StarlingState;
	
	import com.constants.Colors;
	import com.constants.Fonts;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.states.CarnageProtocol;
	
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.core.Starling;
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
		private var _fontFamily:String = "DestroyEarthRoughBB";
		private var _col:uint = Colors.WHITE;
		private var _hoverCol:uint = Colors.BLUE;
		private var _height:Number = 60;
		private var _width:Number = 100;
		
		public static const START:String = 'START';
		public static const EXIT:String = 'EXIT';
		
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
			
			/** SPLASH **/
			var bg:Image = new Image(Texture.fromBitmap(new Textures.SPLASH));
			this.addChild(bg);
			
			/** MENU **/
			var _buttons:Array = [START, EXIT];
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
				_button.width = _width;
				_button.height = _height;
				_button.x = Game.STAGE_WIDTH/2 - _width/2;
				_button.y = 100 + (Game.STAGE_HEIGHT/2) + (i * _size*1.5);
				_button.useHandCursor = true;
				_button.addEventListener(TouchEvent.TOUCH, buttonHandler);
				_button.name = _buttons[i];
				
				this.addChild(_button);
			}
			
			this.addEventListener(TouchEvent.TOUCH, buttonHandler);
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
					/** HANDLE HOVER **/
					if (touch.phase == TouchPhase.HOVER)
					{
						// HANDLING HOVER KINDA SUCKS.
					}
					
					/** HANDLE CLICKS **/	
					if(touch.phase == TouchPhase.BEGAN)
					{
					}
					else if(touch.phase == TouchPhase.ENDED)
					{
						if (button.name == START)
							create();
						else if (button.name == EXIT)
							terminate();
					}	
					else if(touch.phase == TouchPhase.MOVED)
					{
					}
					
				}
				
			}
			
		}
		
		private function create():void
		{
			// ** TODO: How should I be switching states?
			// dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: "CREATE"}, true));
			clear();
			var state:StarlingState = new CarnageProtocol;
		}
		
		private function terminate():void
		{
			clear();
			var state:StarlingState = new TerminateProtocol;
		}
		
		private function clear():void
		{
			this.removeChildren();
		}
		
	}
}