package com.constants
{
	import com.constants.Textures;
	import com.utils.ArrayUtils;
	
	import starling.textures.Texture;
	
	public class DarknessTextures extends Textures
	{
		[Embed(source="../assets/textures/darkness/1.png", mimeType="image/png")]
		public static const DARKNESS_1:Class;
		public static const DARKNESS_1_IMG:Texture = Texture.fromBitmap(new DARKNESS_1);
		public static const DARKNESS_1_TEXTURE:Texture = Texture.fromTexture(DARKNESS_1_IMG);
		
		[Embed(source="../assets/textures/darkness/2.png", mimeType="image/png")]
		public static const DARKNESS_2:Class;
		public static const DARKNESS_2_IMG:Texture = Texture.fromBitmap(new DARKNESS_2);
		public static const DARKNESS_2_TEXTURE:Texture = Texture.fromTexture(DARKNESS_2_IMG);
		
		[Embed(source="../assets/textures/darkness/3.png", mimeType="image/png")]
		public static const DARKNESS_3:Class;
		public static const DARKNESS_3_IMG:Texture = Texture.fromBitmap(new DARKNESS_3);
		public static const DARKNESS_3_TEXTURE:Texture = Texture.fromTexture(DARKNESS_3_IMG);
		
		[Embed(source="../assets/textures/darkness/4.png", mimeType="image/png")]
		public static const DARKNESS_4:Class;
		public static const DARKNESS_4_IMG:Texture = Texture.fromBitmap(new DARKNESS_4);
		public static const DARKNESS_4_TEXTURE:Texture = Texture.fromTexture(DARKNESS_4_IMG);
		
		[Embed(source="../assets/textures/darkness/5.png", mimeType="image/png")]
		public static const DARKNESS_5:Class;
		public static const DARKNESS_5_IMG:Texture = Texture.fromBitmap(new DARKNESS_5);
		public static const DARKNESS_5_TEXTURE:Texture = Texture.fromTexture(DARKNESS_5_IMG);
		
		[Embed(source="../assets/textures/darkness/6.png", mimeType="image/png")]
		public static const DARKNESS_6:Class;
		public static const DARKNESS_6_IMG:Texture = Texture.fromBitmap(new DARKNESS_6);
		public static const DARKNESS_6_TEXTURE:Texture = Texture.fromTexture(DARKNESS_6_IMG);
		
		[Embed(source="../assets/textures/darkness/7.png", mimeType="image/png")]
		public static const DARKNESS_7:Class;
		public static const DARKNESS_7_IMG:Texture = Texture.fromBitmap(new DARKNESS_7);
		public static const DARKNESS_7_TEXTURE:Texture = Texture.fromTexture(DARKNESS_7_IMG);
		
		[Embed(source="../assets/textures/darkness/8.png", mimeType="image/png")]
		public static const DARKNESS_8:Class;
		public static const DARKNESS_8_IMG:Texture = Texture.fromBitmap(new DARKNESS_8);
		public static const DARKNESS_8_TEXTURE:Texture = Texture.fromTexture(DARKNESS_8_IMG);
		
		[Embed(source="../assets/textures/darkness/9.png", mimeType="image/png")]
		public static const DARKNESS_9:Class;
		public static const DARKNESS_9_IMG:Texture = Texture.fromBitmap(new DARKNESS_9);
		public static const DARKNESS_9_TEXTURE:Texture = Texture.fromTexture(DARKNESS_9_IMG);
		
		[Embed(source="../assets/textures/darkness/10.png", mimeType="image/png")]
		public static const DARKNESS_10:Class;
		public static const DARKNESS_10_IMG:Texture = Texture.fromBitmap(new DARKNESS_10);
		public static const DARKNESS_10_TEXTURE:Texture = Texture.fromTexture(DARKNESS_10_IMG);
		
		public static var DARKNESS_TEXTURES_ARRAY:Array = [DARKNESS_1_TEXTURE, DARKNESS_2_TEXTURE, DARKNESS_3_TEXTURE, DARKNESS_4_TEXTURE, DARKNESS_5_TEXTURE, DARKNESS_6_TEXTURE, DARKNESS_7_TEXTURE, DARKNESS_8_TEXTURE, DARKNESS_9_TEXTURE, DARKNESS_10_TEXTURE];
		
		public static function getArrayOfRandomDarkessTextures(num:int = 10):Array
		{
			var darknessArr:Array = [];
			
			while(darknessArr.length < num)
			{
				darknessArr.push(ArrayUtils.getRandomElementOf(DARKNESS_TEXTURES_ARRAY))
			}
			return darknessArr;
		}
	}
}