package com.states
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Missile;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	
	import com.components.Anarcho;
	import com.components.Cannon;
	import com.constants.Game;
	import com.constants.Textures;
	import com.utils.ArrayUtils;
	
	import flash.display3D.textures.Texture;
	
	import nape.callbacks.InteractionCallback;
	
	import starling.textures.TextureAtlas;
	
	public class EnemyProtocol
	{

		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
		
		public static var xPos:Number = Game.STAGE_WIDTH/2;
		public static var yPos:Number = 100;
		
		public static var enemySprite:CitrusSprite;
		public static var enemyAnim:AnimationSequence;
		
		public static var cannon:Cannon;
				
		// LEVEL DIFFICULTY PARAMS
		private static var indices:Array = [0,1,2,3,4,5,6,7,8,9, 10, 11];
		// private static var cannonXPos:Array = [20, 940, 20, 940, 20, 940, 20, 940, 20, 940, 20, 940];
		// private static var cannonYPos:Array = [160, 160, 240, 240, 320, 320, 400, 400, 480, 480, 560, 560];
		private static var cannonPos:Array = [[20,160], [940, 160], [20, 240], [940, 240], [20,320], [940,320], [20, 400], [940, 400], [20, 480], [940, 480], [20, 560], [940, 560]]; 
		private static var fireRateArr:Array = [2200, 2200, 2200, 2200, 2200, 2200, 2100, 2100, 2000, 2000, 1000, 500, 800, 700];
		private static var numCannonsArr:Array = [1,1,2,2,3,3,4,4,5,5,6,6,8,8,10,10, 12];
		private static var speedArr:Array = [1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200];
		private static var speedVarArr:Array = [90, 90, 80, 80, 60, 60, 40, 40, 20, 20, 20, 20];
		
		/**
		 * enemy sits on top platform and unleashes attack for that round
		 * 
		 * canada - maple cannon - goes through platforms
		 * mustache - mustache cannon - doesnt go through platforms
		 * glasses - makes it rain kinematic objects? OR eyes-type deal (stream of damage-causing sensors)
		 * 
		 * */
		
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
			// _ce.state.add(enemySprite);
	
			createCannons();
		}
		
		public static function destroyEnemy():void
		{
			if (enemySprite)
				enemySprite.kill = true;
			
			// destroy attacking objects in CarnageProtocol
			
			if (cannon)
				cannon.kill = true;
		}
		
		public static function createCannons():void{

			var index:int = ArrayUtils.getRandomElementOf(indices);
			var numCannons:int = numCannonsArr[index];
			var xPos:int;
			var yPos:int;
			var fireRate:Number;
			var speed:Number;
			var speedVar:Number;
			var direction:String;
			
			ArrayUtils.arrayShuffle(cannonPos);
			ArrayUtils.arrayShuffle(fireRateArr);
			ArrayUtils.arrayShuffle(speedArr);
			ArrayUtils.arrayShuffle(speedVarArr);
			for (var i:int = 0; i < numCannons; i++){
				
				xPos = cannonPos[i][0];
				yPos = cannonPos[i][1];
				
				fireRate = fireRateArr[i];
				speedVar = speedVarArr[i];
				speed = ArrayUtils.randomRange(speedArr[i] - speedVar, speedArr[i] + speedVar);
				direction = (xPos < Game.STAGE_WIDTH/2) ? "right" : "left";
				cannon = new Cannon("cannon_" + i, {x:xPos, y:yPos, fireRate:fireRate, missileSpeed:speed, missileFuseDuration: 1000, missileExplodeDuration: 20, openFire: true, startingDirection: direction})
				cannon.onGiveDamage.add(cannonHit);
				_ce.state.add(cannon)
			}
		}
		
		public static function cannonHit(contact:NapePhysicsObject):void
		{
		  	if (contact.name == "hero")
			{
				Game.life.removeLife();
				_ce.sound.playSound("earthrot");
			}
		}
		
	}
}