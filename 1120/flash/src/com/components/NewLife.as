package com.components
{
	import com.constants.Colors;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class NewLife extends Sprite
	{
		private var _xTextField:TextField;
		private var _lifeTextField:TextField;
		
		private var _width:Number = 80;
		private var _height:Number = 40;
		private var _life:int = 3; // what a cliche.
		private var _xPos:Number = 110;
		private var _yPos:Number = 60;
		
		public function NewLife()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_lifeTextField = new TextField(_width, _height, _life.toString(), "ProtestPaintBB", 46, Colors.DARK_RED, false);
			_lifeTextField.x = _xPos;
			_lifeTextField.y = _yPos;
			addChild(_lifeTextField);
			
			_xTextField = new TextField(_width, _height, "x", "ProtestPaintBB", 28, Colors.DARK_RED, false);
			_xTextField.x = _xPos - 16;
			_xTextField.y = _yPos + 4;
			addChild(_xTextField);
		}
		
		public function removeLife():void
		{
			_life--;
			updateLabel();
			
			if (_life == 0)
				devoidOfLife();
		}
		
		public function addLife():void
		{
			_life++;
			updateLabel();
		}
		
		public function devoidOfLife():void
		{
			trace("DEVOID OF LIFE")
		}
		
		private function updateLabel():void
		{
			_lifeTextField.text = _life.toString();
		}
		
		override public function dispose():void
		{
			_lifeTextField.dispose();
			super.dispose();
		}
	}
}