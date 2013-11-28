package com.constants
{
	import com.constants.Textures;
	import com.utils.ArrayUtils;
	
	import starling.textures.Texture;
	
	public class BackgroundTextures extends Textures
	{
		[Embed(source="../assets/textures/backgrounds/1.png", mimeType="image/png")]
		public static const BACKGROUND_1:Class;
		public static const BACKGROUND_1_IMG:Texture = Texture.fromBitmap(new BACKGROUND_1);
		public static const BACKGROUND_1_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_1_IMG);
		
		[Embed(source="../assets/textures/backgrounds/2.png", mimeType="image/png")]
		public static const BACKGROUND_2:Class;
		public static const BACKGROUND_2_IMG:Texture = Texture.fromBitmap(new BACKGROUND_2);
		public static const BACKGROUND_2_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_2_IMG);
		
		[Embed(source="../assets/textures/backgrounds/3.png", mimeType="image/png")]
		public static const BACKGROUND_3:Class;
		public static const BACKGROUND_3_IMG:Texture = Texture.fromBitmap(new BACKGROUND_3);
		public static const BACKGROUND_3_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_3_IMG);
		
		[Embed(source="../assets/textures/backgrounds/4.png", mimeType="image/png")]
		public static const BACKGROUND_4:Class;
		public static const BACKGROUND_4_IMG:Texture = Texture.fromBitmap(new BACKGROUND_4);
		public static const BACKGROUND_4_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_4_IMG);
		
		[Embed(source="../assets/textures/backgrounds/5.png", mimeType="image/png")]
		public static const BACKGROUND_5:Class;
		public static const BACKGROUND_5_IMG:Texture = Texture.fromBitmap(new BACKGROUND_5);
		public static const BACKGROUND_5_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_5_IMG);
		
		[Embed(source="../assets/textures/backgrounds/6.png", mimeType="image/png")]
		public static const BACKGROUND_6:Class;
		public static const BACKGROUND_6_IMG:Texture = Texture.fromBitmap(new BACKGROUND_6);
		public static const BACKGROUND_6_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_6_IMG);
		
		[Embed(source="../assets/textures/backgrounds/7.png", mimeType="image/png")]
		public static const BACKGROUND_7:Class;
		public static const BACKGROUND_7_IMG:Texture = Texture.fromBitmap(new BACKGROUND_7);
		public static const BACKGROUND_7_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_7_IMG);
		
		[Embed(source="../assets/textures/backgrounds/8.png", mimeType="image/png")]
		public static const BACKGROUND_8:Class;
		public static const BACKGROUND_8_IMG:Texture = Texture.fromBitmap(new BACKGROUND_8);
		public static const BACKGROUND_8_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_8_IMG);
		
		[Embed(source="../assets/textures/backgrounds/9.png", mimeType="image/png")]
		public static const BACKGROUND_9:Class;
		public static const BACKGROUND_9_IMG:Texture = Texture.fromBitmap(new BACKGROUND_9);
		public static const BACKGROUND_9_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_9_IMG);
		
		[Embed(source="../assets/textures/backgrounds/10.png", mimeType="image/png")]
		public static const BACKGROUND_10:Class;
		public static const BACKGROUND_10_IMG:Texture = Texture.fromBitmap(new BACKGROUND_10);
		public static const BACKGROUND_10_TEXTURE:Texture = Texture.fromTexture(BACKGROUND_10_IMG);
		
		[Embed(source="../assets/textures/backgrounds/filter.png", mimeType="image/png")]
		public static const FILTER:Class;
		public static const FILTER_IMG:Texture = Texture.fromBitmap(new FILTER);
		public static const FILTER_TEXTURE:Texture = Texture.fromTexture(FILTER_IMG);
		
		[Embed(source="../assets/textures/backgrounds/moon.png", mimeType="image/png")]
		public static const MOON:Class;
		public static const MOON_IMG:Texture = Texture.fromBitmap(new MOON);
		public static const MOON_TEXTURE:Texture = Texture.fromTexture(MOON_IMG);
		
		public static var BACKGROUND_TEXTURES_ARRAY:Array = [BACKGROUND_1_TEXTURE, BACKGROUND_2_TEXTURE, BACKGROUND_3_TEXTURE, BACKGROUND_4_TEXTURE, BACKGROUND_5_TEXTURE, BACKGROUND_6_TEXTURE, BACKGROUND_7_TEXTURE, BACKGROUND_8_TEXTURE, BACKGROUND_9_TEXTURE, BACKGROUND_10_TEXTURE];
		
		public static function getRandomGearTexture():Texture
		{
			return ArrayUtils.getRandomElementOf(BACKGROUND_TEXTURES_ARRAY);
		}
	}
}