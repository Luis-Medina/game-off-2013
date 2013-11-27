package com.constants
{
	import com.constants.Textures;
	import com.utils.ArrayUtils;
	
	import starling.textures.Texture;
	
	public class GearTextures extends Textures
	{
		[Embed(source="../assets/textures/gears/gear1.png", mimeType="image/png")]
		public static const GEAR_1:Class;
		public static const GEAR_1_IMG:Texture = Texture.fromBitmap(new GEAR_1);
		public static const GEAR_1_TEXTURE:Texture = Texture.fromTexture(GEAR_1_IMG);
		
		[Embed(source="../assets/textures/gears/gear2.png", mimeType="image/png")]
		public static const GEAR_2:Class;
		public static const GEAR_2_IMG:Texture = Texture.fromBitmap(new GEAR_2);
		public static const GEAR_2_TEXTURE:Texture = Texture.fromTexture(GEAR_2_IMG);
		
		[Embed(source="../assets/textures/gears/gear3.png", mimeType="image/png")]
		public static const GEAR_3:Class;
		public static const GEAR_3_IMG:Texture = Texture.fromBitmap(new GEAR_3);
		public static const GEAR_3_TEXTURE:Texture = Texture.fromTexture(GEAR_3_IMG);
		
		[Embed(source="../assets/textures/gears/gear4.png", mimeType="image/png")]
		public static const GEAR_4:Class;
		public static const GEAR_4_IMG:Texture = Texture.fromBitmap(new GEAR_4);
		public static const GEAR_4_TEXTURE:Texture = Texture.fromTexture(GEAR_4_IMG);
		
		[Embed(source="../assets/textures/gears/gear5.png", mimeType="image/png")]
		public static const GEAR_5:Class;
		public static const GEAR_5_IMG:Texture = Texture.fromBitmap(new GEAR_5);
		public static const GEAR_5_TEXTURE:Texture = Texture.fromTexture(GEAR_5_IMG);
		
		[Embed(source="../assets/textures/gears/gear6.png", mimeType="image/png")]
		public static const GEAR_6:Class;
		public static const GEAR_6_IMG:Texture = Texture.fromBitmap(new GEAR_6);
		public static const GEAR_6_TEXTURE:Texture = Texture.fromTexture(GEAR_6_IMG);
		
		[Embed(source="../assets/textures/gears/gear7.png", mimeType="image/png")]
		public static const GEAR_7:Class;
		public static const GEAR_7_IMG:Texture = Texture.fromBitmap(new GEAR_7);
		public static const GEAR_7_TEXTURE:Texture = Texture.fromTexture(GEAR_7_IMG);
		
		[Embed(source="../assets/textures/gears/gear8.png", mimeType="image/png")]
		public static const GEAR_8:Class;
		public static const GEAR_8_IMG:Texture = Texture.fromBitmap(new GEAR_8);
		public static const GEAR_8_TEXTURE:Texture = Texture.fromTexture(GEAR_8_IMG);
		
		[Embed(source="../assets/textures/gears/gear9.png", mimeType="image/png")]
		public static const GEAR_9:Class;
		public static const GEAR_9_IMG:Texture = Texture.fromBitmap(new GEAR_9);
		public static const GEAR_9_TEXTURE:Texture = Texture.fromTexture(GEAR_9_IMG);
		
		[Embed(source="../assets/textures/gears/gear10.png", mimeType="image/png")]
		public static const GEAR_10:Class;
		public static const GEAR_10_IMG:Texture = Texture.fromBitmap(new GEAR_10);
		public static const GEAR_10_TEXTURE:Texture = Texture.fromTexture(GEAR_10_IMG);
		
		public static var GEAR_TEXTURES_ARRAY:Array = [GEAR_1_TEXTURE, GEAR_2_TEXTURE, GEAR_3_TEXTURE, GEAR_4_TEXTURE, GEAR_5_TEXTURE, GEAR_6_TEXTURE, GEAR_7_TEXTURE, GEAR_8_TEXTURE, GEAR_9_TEXTURE, GEAR_10_TEXTURE];
		
		public static function getRandomGearTexture():Texture
		{
			return ArrayUtils.getRandomElementOf(GEAR_TEXTURES_ARRAY);
		}
	}
}