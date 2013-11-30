package com.constants
{
	import com.utils.ArrayUtils;
	
	import flash.display.Sprite;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Textures
	{
		[Embed(source="../assets/textures/blank.png", mimeType="image/png")]
		public static const BLANK:Class;
		public static const BLANK_IMG:Texture = Texture.fromBitmap(new BLANK);
		public static const BLANK_TEXTURE:Texture = Texture.fromTexture(BLANK_IMG);
		
		[Embed(source="../assets/textures/immortal.png", mimeType="image/png")]
		public static const IMMORTALITY:Class;
		public static const IMMORTALITY_IMG:Texture = Texture.fromBitmap(new IMMORTALITY);
		public static const IMMORTALITY_TEXTURE:Texture = Texture.fromTexture(IMMORTALITY_IMG);
		
		[Embed(source="../assets/textures/powerup_states/immortal_sm.png", mimeType="image/png")]
		public static const IMMORTALITY_STATUS:Class;
		public static const IMMORTALITY_STATUS_IMG:Texture = Texture.fromBitmap(new IMMORTALITY_STATUS);
		public static const IMMORTALITY_STATUS_TEXTURE:Texture = Texture.fromTexture(IMMORTALITY_STATUS_IMG);
		
		[Embed(source="../assets/textures/screens/blank_splash.png", mimeType="image/png")]
		public static const BLANK_SPLASH:Class;
		public static const BLANK_SPLASH_IMG:Texture = Texture.fromBitmap(new BLANK_SPLASH);
		public static const BLANK_SPLASH_TEXTURE:Texture = Texture.fromTexture(BLANK_SPLASH_IMG);
		
		[Embed(source="../assets/textures/screens/splash_citrusengine.png", mimeType="image/png")]
		public static const CITRUS:Class;
		public static const CITRUS_IMG:Texture = Texture.fromBitmap(new CITRUS);
		public static const CITRUS_TEXTURE:Texture = Texture.fromTexture(CITRUS_IMG);
		
		[Embed(source="../assets/textures/screens/splash_unimpressedturtle.png", mimeType="image/png")]
		public static const UNIMPRESSED:Class;
		public static const UNIMPRESSED_IMG:Texture = Texture.fromBitmap(new UNIMPRESSED);
		public static const UNIMPRESSED_TEXTURE:Texture = Texture.fromTexture(UNIMPRESSED_IMG);
		
		[Embed(source="../assets/textures/screens/devoid_of_life.png", mimeType="image/png")]
		public static const LIFELESS:Class;
		public static const LIFELESS_IMG:Texture = Texture.fromBitmap(new LIFELESS);
		public static const LIFELESS_TEXTURE:Texture = Texture.fromTexture(LIFELESS_IMG);
		
		[Embed(source="../assets/textures/screens/black.png", mimeType="image/png")]
		public static const BLACK:Class;
		public static const BLACK_IMG:Texture = Texture.fromBitmap(new BLACK);
		public static const BLACK_TEXTURE:Texture = Texture.fromTexture(BLACK_IMG);
		
		[Embed(source="../assets/textures/splash2.png", mimeType="image/png")]
		public static const SPLASH:Class;
		public static const SPLASH_IMG:Texture = Texture.fromBitmap(new SPLASH);
		public static const SPLASH_TEXTURE:Texture = Texture.fromTexture(SPLASH_IMG);
		
		[Embed(source="../assets/textures/splash.png", mimeType="image/png")]
		public static const SPLASH_0:Class;
		public static const SPLASH_0_IMG:Texture = Texture.fromBitmap(new SPLASH_0);
		public static const SPLASH_0_TEXTURE:Texture = Texture.fromTexture(SPLASH_0_IMG);
		
		[Embed(source="../assets/textures/level_1_floor.png", mimeType="image/png")]
		public static const FLOOR:Class;
		public static const FLOOR_IMG:Texture = Texture.fromBitmap(new FLOOR);
		public static const FLOOR_TEXTURE:Texture = Texture.fromTexture(FLOOR_IMG);

		[Embed(source="../assets/textures/level_1_buildings.png", mimeType="image/png")]
		public static const BUILDINGS:Class;
		public static const BUILDINGS_IMG:Texture = Texture.fromBitmap(new BUILDINGS);
		public static const BUILDINGS_TEXTURE:Texture = Texture.fromTexture(BUILDINGS_IMG);
		
		[Embed(source="../assets/textures/label_change.png", mimeType="image/png")]
		public static const CHANGE_LABEL:Class;
		public static const CHANGE_LABEL_IMG:Texture = Texture.fromBitmap(new CHANGE_LABEL);
		public static const CHANGE_LABEL_TEXTURE:Texture = Texture.fromTexture(CHANGE_LABEL_IMG);
		
		[Embed(source="../assets/textures/label_time.png", mimeType="image/png")]
		public static const TIME_LABEL:Class;
		public static const TIME_LABEL_IMG:Texture = Texture.fromBitmap(new TIME_LABEL);
		public static const TIME_LABEL_TEXTURE:Texture = Texture.fromTexture(TIME_LABEL_IMG);
		
		[Embed(source="../assets/textures/label_left.png", mimeType="image/png")]
		public static const LEFT_LABEL:Class;
		public static const LEFT_LABEL_IMG:Texture = Texture.fromBitmap(new LEFT_LABEL);
		public static const LEFT_LABEL_TEXTURE:Texture = Texture.fromTexture(LEFT_LABEL_IMG);
		
		[Embed(source="../assets/textures/score.png", mimeType="image/png")]
		public static const SCORE:Class;
		public static const SCORE_IMG:Texture = Texture.fromBitmap(new SCORE);
		public static const SCORE_TEXTURE:Texture = Texture.fromTexture(SCORE_IMG);
		
		[Embed(source="../assets/textures/button_exit.png", mimeType="image/png")]
		public static const BUTTON_EXIT:Class;
		public static const BUTTON_EXIT_IMG:Texture = Texture.fromBitmap(new BUTTON_EXIT);
		public static const BUTTON_EXIT_TEXTURE:Texture = Texture.fromTexture(BUTTON_EXIT_IMG);
		
		[Embed(source="../assets/textures/button_restart.png", mimeType="image/png")]
		public static const BUTTON_RESTART:Class;
		public static const BUTTON_RESTART_IMG:Texture = Texture.fromBitmap(new BUTTON_RESTART);
		public static const BUTTON_RESTART_TEXTURE:Texture = Texture.fromTexture(BUTTON_RESTART_IMG);
		
		[Embed(source="../assets/textures/button_previous.png", mimeType="image/png")]
		public static const BUTTON_LEFT:Class;
		public static const BUTTON_LEFT_IMG:Texture = Texture.fromBitmap(new BUTTON_LEFT);
		public static const BUTTON_LEFT_TEXTURE:Texture = Texture.fromTexture(BUTTON_LEFT_IMG);
		
		[Embed(source="../assets/textures/button_next.png", mimeType="image/png")]
		public static const BUTTON_RIGHT:Class;
		public static const BUTTON_RIGHT_IMG:Texture = Texture.fromBitmap(new BUTTON_RIGHT);
		public static const BUTTON_RIGHT_TEXTURE:Texture = Texture.fromTexture(BUTTON_RIGHT_IMG);
		
		[Embed(source="../assets/textures/status_neutral.png", mimeType="image/png")]
		public static const STATUS_NEUTRAL:Class;
		public static const STATUS_NEUTRAL_IMG:Texture = Texture.fromBitmap(new STATUS_NEUTRAL);
		public static const STATUS_NEUTRAL_TEXTURE:Texture = Texture.fromTexture(STATUS_NEUTRAL_IMG);
		
		[Embed(source="../assets/textures/status_happy.png", mimeType="image/png")]
		public static const STATUS_HAPPY:Class;
		public static const STATUS_HAPPY_IMG:Texture = Texture.fromBitmap(new STATUS_HAPPY);
		public static const STATUS_HAPPY_TEXTURE:Texture = Texture.fromTexture(STATUS_HAPPY_IMG);
		
		[Embed(source="../assets/textures/status_angry.png", mimeType="image/png")]
		public static const STATUS_ANGRY:Class;
		public static const STATUS_ANGRY_IMG:Texture = Texture.fromBitmap(new STATUS_ANGRY);
		public static const STATUS_ANGRY_TEXTURE:Texture = Texture.fromTexture(STATUS_ANGRY_IMG);
		
		[Embed(source="../assets/textures/status_embarrassed.png", mimeType="image/png")]
		public static const STATUS_EMBARRASSED:Class;
		public static const STATUS_EMBARRASSED_IMG:Texture = Texture.fromBitmap(new STATUS_EMBARRASSED);
		public static const STATUS_EMBARRASSED_TEXTURE:Texture = Texture.fromTexture(STATUS_EMBARRASSED_IMG);
		
		[Embed(source="../assets/particles/texture.png")]
		public static const PARTICLE_TEXTURE:Class;
		public static const PARTICLE_TEXTURE_IMG:Texture = Texture.fromBitmap(new PARTICLE_TEXTURE);
		public static const PARTICLE_TEXTURE_TEXTURE:Texture = Texture.fromTexture(PARTICLE_TEXTURE_IMG);
		
		[Embed(source="../assets/particles/fire.png")]
		public static const FIRE_TEXTURE:Class;
		public static const FIRE_TEXTURE_IMG:Texture = Texture.fromBitmap(new FIRE_TEXTURE);
		public static const FIRE_TEXTURE_TEXTURE:Texture = Texture.fromTexture(FIRE_TEXTURE_IMG);
		
		[Embed(source="../assets/particles/texture.png")]
		public static const MONEY_TEXTURE:Class;
		public static const MONEY_TEXTURE_IMG:Texture = Texture.fromBitmap(new MONEY_TEXTURE);
		public static const MONEY_TEXTURE_TEXTURE:Texture = Texture.fromTexture(MONEY_TEXTURE_IMG);
		
		[Embed(source="../assets/textures/powerup_states/colossal_sm.png", mimeType="image/png")]
		public static const COLOSSAL_STATUS:Class;
		public static const COLOSSAL_STATUS_IMG:Texture = Texture.fromBitmap(new COLOSSAL_STATUS);
		public static const COLOSSAL_STATUS_TEXTURE:Texture = Texture.fromTexture(COLOSSAL_STATUS_IMG);
		
		[Embed(source="../assets/textures/powerup_states/barewalk_sm.png", mimeType="image/png")]
		public static const BAREWALK_STATUS:Class;
		public static const BAREWALK_STATUS_IMG:Texture = Texture.fromBitmap(new BAREWALK_STATUS);
		public static const BAREWALK_STATUS_TEXTURE:Texture = Texture.fromTexture(BAREWALK_STATUS_IMG);
		
		[Embed(source="../assets/textures/powerup_states/lettuce_sm.png", mimeType="image/png")]
		public static const LETTUCE_STATUS:Class;
		public static const LETTUCE_STATUS_IMG:Texture = Texture.fromBitmap(new LETTUCE_STATUS);
		public static const LETTUCE_STATUS_TEXTURE:Texture = Texture.fromTexture(LETTUCE_STATUS_IMG);
		
		[Embed(source="../assets/textures/powerup_states/crack_sm.png", mimeType="image/png")]
		public static const CRACK_STATUS:Class;
		public static const CRACK_STATUS_IMG:Texture = Texture.fromBitmap(new CRACK_STATUS);
		public static const CRACK_STATUS_TEXTURE:Texture = Texture.fromTexture(CRACK_STATUS_IMG);
		
		[Embed(source="../assets/textures/heart.png", mimeType="image/png")]
		public static const HEART:Class;
		public static const HEART_IMG:Texture = Texture.fromBitmap(new HEART);
		public static const HEART_TEXTURE:Texture = Texture.fromTexture(HEART_IMG);
		
		/** SPRITES **/
		[Embed(source="../assets/textures/prophet_sprite.xml", mimeType="application/octet-stream")]
		public static const PROPHET_CONFIG:Class;
		public static const PROPHET_XML:XML = new XML(new PROPHET_CONFIG());
		
		[Embed(source="../assets/textures/prophet_sprite.png")]
		public static const PROPHET:Class;
		public static const PROPHET_TEXTURE_IMG:Texture = Texture.fromBitmap(new PROPHET);
		public static const PROPHET_TEXTURE:Texture = Texture.fromTexture(PROPHET_TEXTURE_IMG);
		public static const PROPHET_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (PROPHET_TEXTURE, PROPHET_XML);
		
		[Embed(source="../assets/textures/coin_sprites.xml", mimeType="application/octet-stream")]
		public static const COIN_CONFIG:Class;
		public static const COIN_XML:XML = new XML(new COIN_CONFIG());
		
		[Embed(source="../assets/textures/coin_sprites.png")]
		public static const COIN:Class;
		public static const COIN_TEXTURE_IMG:Texture = Texture.fromBitmap(new COIN);
		public static const COIN_TEXTURE:Texture = Texture.fromTexture(COIN_TEXTURE_IMG);
		public static const COIN_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (COIN_TEXTURE, COIN_XML);
		
		[Embed(source="../assets/textures/green_sprites.xml", mimeType="application/octet-stream")]
		public static const GREEN_CONFIG:Class;
		public static const GREEN_XML:XML = new XML(new GREEN_CONFIG());
		
		[Embed(source="../assets/textures/green_sprites.png")] 
		public static const GREEN:Class;
		public static const GREEN_TEXTURE_IMG:Texture = Texture.fromBitmap(new GREEN);
		public static const GREEN_TEXTURE:Texture = Texture.fromTexture(GREEN_TEXTURE_IMG);
		public static const GREEN_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (GREEN_TEXTURE, GREEN_XML);
	
		[Embed(source="../assets/textures/platform_sprites.xml", mimeType="application/octet-stream")]
		public static const PLATFORMS_CONFIG:Class;
		public static const PLATFORMS_XML:XML = new XML(new PLATFORMS_CONFIG());
		
		[Embed(source="../assets/textures/platform_sprites.png")]
		public static const PLATFORMS:Class;
		public static const PLATFORMS_TEXTURE_IMG:Texture = Texture.fromBitmap(new PLATFORMS);
		public static const PLATFORMS_TEXTURE:Texture = Texture.fromTexture(PLATFORMS_TEXTURE_IMG);
		public static const PLATFORMS_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (PLATFORMS_TEXTURE, PLATFORMS_XML);
		
		[Embed(source="../assets/textures/powerup_sprites.xml", mimeType="application/octet-stream")]
		public static const POWERUP_CONFIG:Class;
		public static const POWERUP_XML:XML = new XML(new POWERUP_CONFIG());
		
		[Embed(source="../assets/textures/powerup_sprites.png")]
		public static const POWERUP:Class;
		public static const POWERUP_TEXTURE_IMG:Texture = Texture.fromBitmap(new POWERUP);
		public static const POWERUP_TEXTURE:Texture = Texture.fromTexture(POWERUP_TEXTURE_IMG);
		public static const POWERUP_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (POWERUP_TEXTURE, POWERUP_XML);
		
		[Embed(source="../assets/textures/powerup_overlay.png", mimeType="image/png")]
		public static const POWERUP_OVERLAY:Class;
		public static const POWERUP_OVERLAY_IMG:Texture = Texture.fromBitmap(new POWERUP_OVERLAY);
		public static const POWERUP_OVERLAY_TEXTURE:Texture = Texture.fromTexture(POWERUP_OVERLAY_IMG);
		
		[Embed(source="../assets/textures/enemies/enemies.xml", mimeType="application/octet-stream")]
		public static const ENEMIES_CONFIG:Class;
		public static const ENEMIES_XML:XML = new XML(new ENEMIES_CONFIG());
		
		[Embed(source="../assets/textures/enemies/enemies.png")]
		public static const ENEMIES:Class;
		public static const ENEMIES_TEXTURE_IMG:Texture = Texture.fromBitmap(new ENEMIES);
		public static const ENEMIES_TEXTURE:Texture = Texture.fromTexture(ENEMIES_TEXTURE_IMG);
		public static const ENEMIES_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (ENEMIES_TEXTURE, ENEMIES_XML);
		
		[Embed(source="../assets/textures/soc_media/twitter.png", mimeType="image/png")]
		public static const TWITTER:Class;
		public static const TWITTER_IMG:Texture = Texture.fromBitmap(new TWITTER);
		public static const TWITTER_TEXTURE:Texture = Texture.fromTexture(TWITTER_IMG);
		
		[Embed(source="../assets/textures/soc_media/facebook.png", mimeType="image/png")]
		public static const FACEBOOK:Class;
		public static const FACEBOOK_IMG:Texture = Texture.fromBitmap(new FACEBOOK);
		public static const FACEBOOK_TEXTURE:Texture = Texture.fromTexture(FACEBOOK_IMG);
		
		[Embed(source="../assets/textures/soc_media/github.png", mimeType="image/png")]
		public static const GITHUB:Class;
		public static const GITHUB_IMG:Texture = Texture.fromBitmap(new GITHUB);
		public static const GITHUB_TEXTURE:Texture = Texture.fromTexture(GITHUB_IMG);
		
		/** PARTICLE CONFIGS **/
		
		[Embed(source="../assets/particles/Atmosphere.pex", mimeType="application/octet-stream")]
		public static const ATMOSPHERE_CONFIG:Class;
		
		[Embed(source="../assets/particles/ProphetArrival.pex", mimeType="application/octet-stream")]
		public static const PROPHET_ARRIVAL_CONFIG:Class;
		
		[Embed(source="../assets/particles/SpareSomeChange.pex", mimeType="application/octet-stream")]
		public static const SPARE_SOME_CHANGE_CONFIG:Class;
		
		[Embed(source="../assets/particles/fire.pex", mimeType="application/octet-stream")]
		public static const FIRE_CONFIG:Class;
		
		[Embed(source="../assets/particles/Portal.pex", mimeType="application/octet-stream")]
		public static const PORTAL_CONFIG:Class;
		
		[Embed(source="../assets/particles/fireball.pex", mimeType="application/octet-stream")]
		public static const FIREBALL_CONFIG:Class;
		
		[Embed(source="../assets/particles/fireball.png")]
		public static const FIREBALL:Class;
		public static const FIREBALL_IMG:Texture = Texture.fromBitmap(new FIREBALL);
		public static const FIREBALL_TEXTURE:Texture = Texture.fromTexture(FIREBALL_IMG);

		/** FUNCTIONS **/
		
		public static function getTextureProperties(name:String, _textureAtlas:TextureAtlas):Array {
			var properties:Array = [];
			var texture:Texture = _textureAtlas.getTexture(name);
			var width:Number = texture.width;
			var height:Number = texture.height;
			properties = [texture, width, height];
			return properties;  
		}
		
		public static function getTexture(name:String, _textureAtlas:TextureAtlas):Texture {
			return _textureAtlas.getTexture(name);
		}
		
		public static function getPlatformTexture(isRow:Boolean):Texture
		{
			var _textureAtlas:TextureAtlas = PLATFORMS_TEXTURE_ATLAS;
			var _textureNames:Vector.<String> = _textureAtlas.getNames();
			
			var _text:String;
			var _index:String;
			_index = isRow ? "row" : "col";
			var arr:Array = [];
			for (var i:int = 0; i < _textureNames.length; i++)
			{
				_text = _textureNames[i];
				
				if (_text.indexOf(_index) != -1)
					arr.push(_text);
			}
			var _name:String = ArrayUtils.getRandomElementOf(arr);
			return _textureAtlas.getTexture(_name);

		}
		
		
		
	}
}