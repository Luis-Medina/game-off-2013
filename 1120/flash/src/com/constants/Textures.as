package com.constants
{
	import flash.display.Sprite;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class Textures
	{
		[Embed(source="../assets/textures/blank.png", mimeType="image/png")]
		public static const BLANK:Class;
		public static const BLANK_IMG:Texture = Texture.fromBitmap(new BLANK);
		public static const BLANK_TEXTURE:Texture = Texture.fromTexture(BLANK_IMG);
		
		[Embed(source="../assets/textures/splash2.png", mimeType="image/png")]
		public static const SPLASH:Class;
		public static const SPLASH_IMG:Texture = Texture.fromBitmap(new SPLASH);
		public static const SPLASH_TEXTURE:Texture = Texture.fromTexture(SPLASH_IMG);
		
		[Embed(source="../assets/textures/level_1_floor.png", mimeType="image/png")]
		public static const FLOOR:Class;
		public static const FLOOR_IMG:Texture = Texture.fromBitmap(new FLOOR);
		public static const FLOOR_TEXTURE:Texture = Texture.fromTexture(FLOOR_IMG);
		
		[Embed(source="../assets/textures/level_1_bg.png", mimeType="image/png")]
		public static const BG:Class;
		public static const BG_IMG:Texture = Texture.fromBitmap(new BG);
		public static const BG_TEXTURE:Texture = Texture.fromTexture(BG_IMG);
		
		[Embed(source="../assets/textures/label_change.png", mimeType="image/png")]
		public static const CHANGE_LABEL:Class;
		public static const CHANGE_LABEL_IMG:Texture = Texture.fromBitmap(new CHANGE_LABEL);
		public static const CHANGE_LABEL_TEXTURE:Texture = Texture.fromTexture(CHANGE_LABEL_IMG);
		
		[Embed(source="../assets/textures/label_time.png", mimeType="image/png")]
		public static const TIME_LABEL:Class;
		public static const TIME_LABEL_IMG:Texture = Texture.fromBitmap(new TIME_LABEL);
		public static const TIME_LABEL_TEXTURE:Texture = Texture.fromTexture(TIME_LABEL_IMG);
		
		[Embed(source="../assets/textures/button_exit.png", mimeType="image/png")]
		public static const BUTTON_EXIT:Class;
		public static const BUTTON_EXIT_IMG:Texture = Texture.fromBitmap(new BUTTON_EXIT);
		public static const BUTTON_EXIT_TEXTURE:Texture = Texture.fromTexture(BUTTON_EXIT_IMG);
		
		[Embed(source="../assets/textures/button_restart.png", mimeType="image/png")]
		public static const BUTTON_RESTART:Class;
		public static const BUTTON_RESTART_IMG:Texture = Texture.fromBitmap(new BUTTON_RESTART);
		public static const BUTTON_RESTART_TEXTURE:Texture = Texture.fromTexture(BUTTON_RESTART_IMG);
		
		[Embed(source="../assets/particles/texture.png")]
		public static const PARTICLE_TEXTURE:Class;
		public static const PARTICLE_TEXTURE_IMG:Texture = Texture.fromBitmap(new PARTICLE_TEXTURE);
		public static const PARTICLE_TEXTURE_TEXTURE:Texture = Texture.fromTexture(PARTICLE_TEXTURE_IMG);
		
		[Embed(source="../assets/particles/Atmosphere.pex", mimeType="application/octet-stream")]
		public static const ATMOSPHERE_CONFIG:Class;
		
		[Embed(source="../assets/particles/ProphetArrival.pex", mimeType="application/octet-stream")]
		public static const PROPHET_ARRIVAL_CONFIG:Class;
		
	}
}