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

		[Embed(source="../assets/textures/level_1_buildings.png", mimeType="image/png")]
		public static const BUILDINGS:Class;
		public static const BUILDINGS_IMG:Texture = Texture.fromBitmap(new BUILDINGS);
		public static const BUILDINGS_TEXTURE:Texture = Texture.fromTexture(BUILDINGS_IMG);
		BUILDINGS_TEXTURE.repeat = true;
		
		[Embed(source="../assets/textures/platform_row.png", mimeType="image/png")]
		public static const ROW:Class;
		public static const ROW_IMG:Texture = Texture.fromBitmap(new ROW);
		public static const ROW_TEXTURE:Texture = Texture.fromTexture(ROW_IMG);
		
		[Embed(source="../assets/textures/platform_col.png", mimeType="image/png")]
		public static const COL:Class;
		public static const COL_IMG:Texture = Texture.fromBitmap(new COL);
		public static const COL_TEXTURE:Texture = Texture.fromTexture(COL_IMG);	
		
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
		
		[Embed(source="../assets/textures/colossal_hole.png", mimeType="image/png")]
		public static const COLOSSAL_HOLE:Class;
		public static const COLOSSAL_HOLE_IMG:Texture = Texture.fromBitmap(new COLOSSAL_HOLE);
		public static const COLOSSAL_HOLE_TEXTURE:Texture = Texture.fromTexture(COLOSSAL_HOLE_IMG);
		
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
		
		[Embed(source="../assets/textures/prophet_speech.xml", mimeType="application/octet-stream")]
		public static const PROPHET_SPEECH_CONFIG:Class;
		public static const PROPHET_SPEECH_XML:XML = new XML(new PROPHET_SPEECH_CONFIG());
		
		[Embed(source="../assets/textures/prophet_speech.png")]
		public static const PROPHET_SPEECH:Class;
		public static const PROPHET_SPEECH_TEXTURE_IMG:Texture = Texture.fromBitmap(new PROPHET_SPEECH);
		public static const PROPHET_SPEECH_TEXTURE:Texture = Texture.fromTexture(PROPHET_SPEECH_TEXTURE_IMG);
		public static const PROPHET_SPEECH_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (PROPHET_SPEECH_TEXTURE, PROPHET_SPEECH_XML);
		
		[Embed(source="../assets/textures/platform_sprites.xml", mimeType="application/octet-stream")]
		public static const PLATFORMS_CONFIG:Class;
		public static const PLATFORMS_XML:XML = new XML(new PLATFORMS_CONFIG());
		
		[Embed(source="../assets/textures/platform_sprites.png")]
		public static const PLATFORMS:Class;
		public static const PLATFORMS_TEXTURE_IMG:Texture = Texture.fromBitmap(new PLATFORMS);
		public static const PLATFORMS_TEXTURE:Texture = Texture.fromTexture(PLATFORMS_TEXTURE_IMG);
		public static const PLATFORMS_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (PLATFORMS_TEXTURE, PLATFORMS_XML);
		
		[Embed(source="../assets/textures/eyes_sprites.xml", mimeType="application/octet-stream")]
		public static const EYES_CONFIG:Class;
		public static const EYES_XML:XML = new XML(new EYES_CONFIG());
		
		[Embed(source="../assets/textures/eyes_sprites.png")]
		public static const EYES:Class;
		public static const EYES_TEXTURE_IMG:Texture = Texture.fromBitmap(new EYES);
		public static const EYES_TEXTURE:Texture = Texture.fromTexture(EYES_TEXTURE_IMG);
		public static const EYES_TEXTURE_ATLAS:TextureAtlas = new TextureAtlas (EYES_TEXTURE, EYES_XML);
		
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