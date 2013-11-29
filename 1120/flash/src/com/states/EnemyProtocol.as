package com.states
{
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Missile;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.*;
	
	import com.components.Anarcho;
	import com.components.Cannon;
	import com.components.DynamicPlatform;
	import com.components.PlatformSprite;
	import com.constants.Game;
	import com.constants.GearTextures;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.events.InjuryEvent;
	import com.utils.ArrayUtils;
	
	import nape.callbacks.InteractionCallback;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.*;
	
	public class EnemyProtocol
	{

		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
		
		public static var xPos:Number = Game.STAGE_WIDTH/2;
		public static var yPos:Number = 100;
		
		public static var enemySprite:CitrusSprite;
		public static var enemyAnim:AnimationSequence;
		
		public static var cannon:Cannon;
		public static var _eventDispatcher:EventDispatcher = new EventDispatcher();
				
		// LEVEL DIFFICULTY PARAMS
		private static var indices:Array = [0,1,2,3,4,5,6,7,8,9, 10, 11];
		// private static var cannonXPos:Array = [20, 940, 20, 940, 20, 940, 20, 940, 20, 940, 20, 940];
		// private static var cannonYPos:Array = [160, 160, 240, 240, 320, 320, 400, 400, 480, 480, 560, 560];
		private static var cannonPos:Array = [[20,160], [940, 160], [20, 240], [940, 240], [20,320], [940,320], [20, 400], [940, 400], [20, 480], [940, 480], [20, 560], [940, 560]]; 
		private static var fireRateArr:Array = [1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1500, 1500, 1500, 1500, 2300, 2300];
		private static var numCannonsArr:Array = [1,1,2,2,3,3,4,4,5,5,6,6,8,8,10,10, 12];
		private static var speedArr:Array = [220, 220, 220, 220, 220, 220, 220, 180, 180, 180, 180, 180];
		private static var speedVarArr:Array = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10];
		
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
			// if (enemySprite)
			//	enemySprite.kill = true;
			
			//if (cannon)
			// 	cannon.kill = true;  
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
			var missileTexture:Texture;
			//var missileTextureVec:Vector.<Texture> = new Vector.<Texture>();
			//var missileMC:MovieClip;
			//var missileSprite:Sprite; 
			
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
				missileTexture = GearTextures.getRandomGearTexture();
				missileTexture.repeat = false; 

				/*
				missileTextureVec.push(missileTexture);
				missileMC = new MovieClip(missileTextureVec)
				missileMC.pivotX = missileMC.width/2;
				missileMC.pivotY = missileMC.height/2;
				missileMC.x = 0;*/
				
				cannon = new Cannon("cannon_" + i, {view: GearTextures.CANNON_TEXTURE, x:xPos, y:yPos, fireRate:fireRate, missileSpeed:speed, missileFuseDuration: 2000, missileExplodeDuration: 20, openFire: true, startingDirection: direction, missileView: missileTexture})
				cannon.onGiveDamage.add(cannonHit);
				cannon.updateCallEnabled = true;
				_ce.state.add(cannon);
			}
		}

		public static function cannonHit(contact:NapePhysicsObject):void
		{
		  	if (contact.name == "hero")
			{
				_ce.sound.playSound(Game.life.getNumLife() > 1 ? "earthrot" : "horror");
				Game.life.removeLife();
				
				if(Game.life.getNumLife() > 0)
				{
					_eventDispatcher.dispatchEvent(new InjuryEvent(InjuryEvent.INJURY, {}, true));
					// _ce.sound.playSound("earthrot");
				} else {
					return;
				}
				
			} else {
				
				if (contact.name.indexOf("row_") != -1 || contact.name.indexOf("col_") != -1)
				{
					// trace("break," + Game.BREAK_WALLS)
					if(Game.BREAK_WALLS == "no") return; 
						
					var _index:int = Game.getIndexByName(contact.name);
					Game.platforms.times_hit[_index] = Game.platforms.times_hit[_index] + 1;
					
					var _wall:PlatformSprite = _ce.state.getObjectByName(contact.name + "_sprite") as PlatformSprite;
					var intensity:Number = ArrayUtils.randomRange(3,10);
					_wall.x = Math.floor(_wall.x - (Math.random() * intensity - intensity / 2));
					
					if (Game.platforms.times_hit[_index] == 3)
					{
						var _platform:DynamicPlatform = _ce.state.getObjectByName(contact.name) as DynamicPlatform;
						_platform.kill = true;
						_wall.kill = true;
						
						Game.platforms.status[_index] = false
						Game.platforms.times_hit[_index] = 0;
					}
					
				}
			}
		}
		
	}
}