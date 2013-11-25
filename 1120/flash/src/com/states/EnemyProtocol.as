package com.states
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Cannon;
	import citrus.objects.platformer.nape.Missile;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	
	import com.constants.Game;
	import com.constants.Textures;
	import com.utils.ArrayUtils;
	
	import flash.display3D.textures.Texture;
	
	import starling.textures.TextureAtlas;
	
	public class EnemyProtocol
	{
		/**
		 * enemy sits on top platform and unleashes attack for that round
		 * 
		 * canada - maple leaf missiles
		 * mustache - mustache cannon
		 * glasses - mushroom cannon
		 * 
		 * */
		
		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
		
		public static var xPos:Number = Game.STAGE_WIDTH/2;
		public static var yPos:Number = 100;
		
		public static var enemySprite:CitrusSprite;
		public static var enemyAnim:AnimationSequence;
		
		private static function chooseEnemy():String
		{
			var enemies:Array = ["mustache", "glasses", "canada"];
			var enemy:String = ArrayUtils.getRandomElementOf(enemies);
			return enemy;
		}
		
		public static function buildEnemy():void
		{
			var enemy:String = chooseEnemy();
			var textureAtlas:TextureAtlas = Textures.ENEMIES_TEXTURE_ATLAS;
			var enemyAnim:AnimationSequence = new AnimationSequence(textureAtlas, [enemy], enemy, 8, true, "none");
			
			StarlingArt.setLoopAnimations([enemy]);
			
			enemySprite = new CitrusSprite(enemy + "sprite", {view:enemyAnim, x: Math.floor(xPos - enemyAnim.width/2), y:yPos})
			_ce.state.add(enemySprite);

			
			// TODO: 
		}
		
		public static function destroyEnemy():void
		{
			if (enemySprite)
				enemySprite.kill = true;
		}
		
	}
}