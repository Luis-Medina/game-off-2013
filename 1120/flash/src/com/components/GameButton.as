package com.components
{
	import com.constants.*;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.textures.Texture;
	
	public class GameButton
	{
		public static function textButton(text:String, name:String, fontSize:Number, width:Number, height:Number, x:Number, y:Number):Button
		{
			var _buttonTexture:Texture = Texture.fromBitmap(new Textures.BLANK);
			var _button:Button = new Button(_buttonTexture);
			_button.visible = true;
			_button.fontSize = fontSize;
			_button.fontColor = Colors.WHITE;
			_button.fontName = "DestroyEarthRoughBB";
			_button.text = text;
			_button.enabled = true;
			_button.width = width;
			_button.height = height;
			_button.x = x;
			_button.y = y;
			_button.useHandCursor = true;
			_button.name = name;
			
			return _button;
		}
		
		public static function imageButton(imgTexture:*, name:String, width:Number, height:Number, x:Number, y:Number):Button
		{
			var _buttonTexture:Texture = Texture.fromBitmap(new imgTexture);
			var _button:Button = new Button(_buttonTexture);
			_button.visible = true;
			_button.enabled = true;
			_button.width = width;
			_button.height = height;
			_button.x = x;
			_button.y = y;
			_button.useHandCursor = true;
			_button.name = name;
			
			return _button;
		}

	}
}