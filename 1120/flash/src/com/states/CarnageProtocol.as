package com.states
{

	import citrus.core.CitrusEngine;
	import citrus.core.CitrusGroup;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.MovingPlatform;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.Nape;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	
	import com.components.Anarcho;
	import com.components.Cannon;
	import com.components.Coin;
	import com.components.ColossalHole;
	import com.components.Countdown;
	import com.components.DynamicPlatform;
	import com.components.GameButton;
	import com.components.Immortality;
	import com.components.Life;
	import com.components.NewLife;
	import com.components.PettyCash;
	import com.components.PlatformSprite;
	import com.components.Rounds;
	import com.components.ShiftingBackground;
	import com.constants.BackgroundTextures;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.events.ElevenTwentyEvent;
	import com.events.InjuryEvent;
	import com.events.PowerupEvent;
	import com.events.RestartTimerEvent;
	import com.managers.PowerupManager;
	import com.utils.ArrayUtils;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	import starling.utils.*;

	public class CarnageProtocol extends StarlingState
	{
		private var _dynamicBackground:ShiftingBackground;
		private var _dynamicBackgroundSprite:CitrusSprite;
		private var _floor:CitrusSprite;
		private var _fg:Image;
		private var _restartButton:Button;
		private var _splashButton:Button;
		
		private var physics:Nape;
		
		private var _countDown:Countdown; 
		private var _cash:PettyCash;
		private var _remaining:PettyCash;
		private var _unstablePlatform:CitrusGroup;
		private var _spareChangeGroup:CitrusGroup;
		private var _round:Rounds;
		private var increaseRound:Boolean = false;
		private var _powerups:PowerupProtocol;
		private var _powerupStatus:PowerupManager;
		private var _lifeSprite:CitrusSprite;
		
		private var _colossalHole:CitrusGroup;
		
		private var _numCols:Number = 7;
		private var _numRows:Number = 7;
		private var _colHeight:Number = 91.5;
		private var _colWidth:Number = 12;
		private var _rowHeight:Number = 12;
		private var _rowWidth:Number = (Game.STAGE_WIDTH / (_numCols));
		
		private var currentCoinCount:Number = 0;            
		private var currentRemainingCount:Number = 0;
		private var possibleCoinValues:Array = [0.01, 0.05, 0.11, 0.17, 0.23, 0.35];
		private var coinSizes:Array = [11, 15, 23, 37, 45, 57];
		private var currCoinNames:Array = [];
		private var currCoinValues:Array = [];
		
		private var _prophetConfig:XML = XML(new Textures.PROPHET_ARRIVAL_CONFIG());
		private var prophetParticles:PDParticleSystem = new PDParticleSystem(_prophetConfig, Textures.PARTICLE_TEXTURE_TEXTURE);
		private var prophetParticlesSprite:CitrusSprite;
		private var prophetCoordinates:Point = new Point(900,150);
		
		private var _immortalityConfig:XML = XML(new Textures.PROPHET_ARRIVAL_CONFIG());
		private var _immortalityParticles:PDParticleSystem = new PDParticleSystem(_immortalityConfig, Textures.IMMORTALITY_TEXTURE);
		private var	_immortalityParticlesSprite:CitrusSprite;
		
		private var _fireConfig:XML = XML(new Textures.FIRE_CONFIG());
		private var _fireParticles:PDParticleSystem = new PDParticleSystem(_fireConfig, Textures.FIRE_TEXTURE_TEXTURE);
		private var _fireParticlesSprite:CitrusSprite;
		
		private var greenStatus:CitrusSprite;
		private var green:CitrusSprite;
		
		private var _prophetGroup:CitrusGroup;
		private var isProphetAdded:Boolean = false;
		private var prophetSensor:Sensor;
		private var _prophetIdle:Array = Textures.getTextureProperties("prophet_idle", Textures.PROPHET_TEXTURE_ATLAS);
		private var _prophetAttack:Array = Textures.getTextureProperties("prophet_attack", Textures.PROPHET_TEXTURE_ATLAS);
		private var _pSprite:CitrusSprite = new CitrusSprite("p_idle", {view: _prophetIdle[0]})

		private var prophetSpeechSprite:CitrusSprite;
		
		private var shakeTween:Tween;
		private var _shakeTimer:Timer;
			
		private var _loopTimer:Timer;
		
		public function CarnageProtocol() {
			
			trace("CARNAGE PROTOCOL")        
			super(); 
		}

		override public function initialize():void {
			
			super.initialize();
			
			/** PHYSICS **/
			physics = new Nape("physics"); 
			physics.gravity = new Vec2(0, 188);
			// physics.visible = true;    
			add(physics);
			
			// reset params
			Game.resetGameParams();
			
			// background
			_dynamicBackground = new ShiftingBackground();
			_dynamicBackgroundSprite = new CitrusSprite("dynamic_background", {view: _dynamicBackground});
			add(_dynamicBackgroundSprite);
			
			// floor
			_fg = new Image(Textures.FLOOR_TEXTURE);
			addChild(_fg);

			/** WALLS **/
			add(new Platform("bottom", {x: (stage.stageWidth / 2), y: stage.stageHeight - 0.14 + 0.5, width: stage.stageWidth, height: 40}));
			add(new Platform("roof", {x:stage.stageWidth / 2, y:-6, width:stage.stageWidth, height: 10}));
			add(new Platform("left_wall", {x:-6, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));
			add(new Platform("right_wall", {x: stage.stageWidth + 5, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));

			/** UI **/
			_restartButton = GameButton.imageButton(Textures.BUTTON_RESTART_TEXTURE, Game.RESTART, 46, 46, 840, 10); 
			_splashButton = GameButton.imageButton(Textures.BUTTON_EXIT_TEXTURE, Game.SPLASH, 46, 46, 900, 10); 
			_restartButton.addEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.addEventListener(TouchEvent.TOUCH, handleUI);
			addChild(_restartButton);
			addChild(_splashButton);
			
			greenStatus = new CitrusSprite("status_icon", {view: Textures.STATUS_NEUTRAL_TEXTURE, x: 20, y: 15});
			add(greenStatus);
			
			_round = new Rounds();
			var _roundSprite:CitrusSprite = new CitrusSprite("round_sprite", {view:_round})
			add(_roundSprite);
				
			this.visible = true;
			
			createUnstablePlatform();
			this.addEventListener(ElevenTwentyEvent.ELEVEN, updateUnstablePlatform);
			this.addEventListener(RestartTimerEvent.RESTART, restartTimer);
			this.addEventListener(PowerupEvent.POWERUP, powerup);
			EnemyProtocol._eventDispatcher.addEventListener(InjuryEvent.INJURY, injury);
						
			_countDown = new Countdown();
			var _countDownSprite:CitrusSprite = new CitrusSprite("countdown_sprite", {view:_countDown})
			add(_countDownSprite);
				
			_cash = new PettyCash();
			var _cashSprite:CitrusSprite = new CitrusSprite("cash_sprite", {view:_cash});
			add(_cashSprite);
			
			_remaining = new PettyCash();
			_remaining.numLabelX = Game.leftXPos;
			_remaining.numLabelY = Game.leftYPos;
			_remaining.numDisplayX = Game.leftXPos + Game.horGap;
			_remaining.numDisplayY = Game.leftYPos - 5;
			_remaining.numLabelTexture = Texture.fromBitmap(new Textures.LEFT_LABEL);
			var _remainingSprite:CitrusSprite = new CitrusSprite("remaining_sprite", {view:_remaining})
			add(_remainingSprite);
			
			/** POWERUPS **/
			_powerups = new PowerupProtocol();
			_powerups.hide();
			addChild(_powerups); // THIS IS OK AS !CitrusSprite
			
			_powerupStatus = new PowerupManager();
			// addChild(_powerupStatus);
			var _powerupStatusSprite:CitrusSprite = new CitrusSprite("powerup_statuses", {view:_powerupStatus});		
			add(_powerupStatusSprite);
						
			prophetParticlesSprite = new CitrusSprite("prophet_arrival", {view: prophetParticles, parallaxX:1.7, parallaxY:1.7});
			moveEmitter(prophetParticlesSprite, prophetCoordinates.x, prophetCoordinates.y);
			add(prophetParticlesSprite);
			
			_immortalityParticlesSprite = new CitrusSprite("immortality_sprite", {view: _immortalityParticles, parallaxX:1.7, parallaxY:1.7});
			moveEmitter(_immortalityParticlesSprite, 0, 0);
			add(_immortalityParticlesSprite)
			
			_fireParticlesSprite = new CitrusSprite("fire_particles", {view: _fireParticles});
			moveEmitter(_fireParticlesSprite, 0, 0);
			add(_fireParticlesSprite)
			
			_lifeSprite = new CitrusSprite("lives", {view: Game.life});
			add(_lifeSprite);
			
			var heroAnim:AnimationSequence = new AnimationSequence(Textures.GREEN_TEXTURE_ATLAS, ["walk_left", "walk_right", "jump_left", "jump_right", "idle", "dance"], "idle", 	10, true, "none");
			StarlingArt.setLoopAnimations(["walk_left"]);
			StarlingArt.setLoopAnimations(["walk_right"]);
			StarlingArt.setLoopAnimations(["jump_left"]);
			StarlingArt.setLoopAnimations(["jump_right"]);
			StarlingArt.setLoopAnimations(["dance"]);
			 
			/** PROTAGONIST **/
			Game.hero = new Anarcho("hero", {x: Game.heroStartX, y: Game.heroStartY, width: 30, height: 56, view: heroAnim});
			Game.hero.canDuck = false;
			Game.hero.acceleration = Game.accelerationOrig; // default is 30
			Game.hero.jumpAcceleration = 1.2; // default is 9
			Game.hero.maxVelocity = Game.velocityOrig; // default is 240
			Game.hero.jumpHeight = 195; // default is 330
			add(Game.hero);
			
			playDrone();
		}
		
		override public function update(timeDelta:Number):void
		{		
			Game.coinCount = currentCoinCount; // fail-safe
			Game.END_CASH = currentCoinCount
			
			// fail-safe
			if (Game.hero.x < 0 || Game.hero.x > Game.STAGE_WIDTH)
			{
				Game.hero.x = Game.heroStartX;
				Game.hero.y = Game.heroStartY;
			}
			
			if (currentCoinCount >= Game.THREE_NINETY){	
				moveEmitter(prophetParticlesSprite, prophetCoordinates.x, prophetCoordinates.y);
				greenStatus.view = Textures.STATUS_HAPPY_TEXTURE;
				
				if(isProphetAdded)
				{
					prophetSensor.onBeginContact.add(handleProphetTouch);
					prophetParticles.start();
					_pSprite.view = _prophetAttack[0];
				}
				
			} else if (currentCoinCount < Game.THREE_NINETY) {
				
				greenStatus.view = Textures.STATUS_NEUTRAL_TEXTURE;
				
				if (isProphetAdded)
				{
					prophetParticles.stop();
					_pSprite.view = _prophetIdle[0];
				}
				
			}
			
			if (Game.hero.acceleration == Game.accelerationBoost){
				_fireParticles.start();
				_fireParticles.x = Math.floor(Game.hero.x); 
				_fireParticles.y = Math.floor(Game.hero.y + Game.hero.height / 2);
			}
			else 
			{
				_fireParticles.stop();
			}
			
			if(Game.IMMORTALITY)
			{
				_immortalityParticles.start();
				_immortalityParticles.x = Math.floor(Game.hero.x); 
				_immortalityParticles.y = Math.floor(Game.hero.y);
			} else {
				_immortalityParticles.stop()
			}
			
			super.update(timeDelta);
		}
		
		private function moveEmitter(sprite:CitrusSprite, x:int, y:int):void
		{
			(sprite.view as PDParticleSystem).emitterX = x;
			(sprite.view as PDParticleSystem).emitterY = y;
		}
		
		public function createUnstablePlatform():void
		{
			var _platform:DynamicPlatform;
			var _movingPlatform:MovingPlatform;
			var _platFormSprite:PlatformSprite;
			var _movingPlatformSprite:CitrusSprite;
			var _name:String;
			var _xPos:Number;
			var _yPos:Number;
			var _width:Number;
			var _height:Number;
			var _texture:Texture;
			var _isRow:Boolean;
			for (var i:int = 0; i < Game.platforms.xCoords.length; i++)
			{
				_name = Game.platforms.names[i];
				_xPos = Game.platforms.xCoords[i];
				_yPos = Game.platforms.yCoords[i];
				
				_isRow = _name.indexOf("row_") != -1;
				_height = _isRow ? _rowHeight : _colHeight;
				_width = _isRow ? _rowWidth : _colWidth;
				_texture = Textures.getPlatformTexture(_isRow); 
				// _texture = _isRow ? Textures.ROW_TEXTURE : Textures.COL_TEXTURE; 
				
				_platform = new DynamicPlatform(_name, {x: _xPos, y : _yPos, width: _width, height: _height});
				add(_platform);  
				
				_platFormSprite = new PlatformSprite(_name + "_sprite", {x: Math.floor(_platform.x - _texture.width/2), y: Math.floor(_platform.y - _texture.height/2), view: _texture});
				add(_platFormSprite);
			}
			
			_xPos = prophetCoordinates.x - 7;
			_yPos = prophetCoordinates.y + 31;
			_movingPlatform = new MovingPlatform("prophet_platform", {x:_xPos , y:_yPos, width:_rowWidth, height: _rowHeight, startX:_xPos, endX: _xPos, startY: _yPos, endY:_yPos, speed: 12, waitForPassenger:false})
			add(_movingPlatform);
			
			var _movingPlatformTexture:Texture = Textures.getPlatformTexture(true);
			_movingPlatformSprite = new CitrusSprite("prophet_platform_sprite", {x: Math.floor(_xPos - _movingPlatformTexture.width/2), y: Math.floor(_yPos - _movingPlatformTexture.height/2), view:  Textures.getPlatformTexture(true)});
			add(_movingPlatformSprite);
			
			if(!isProphetAdded)
			{
				prophetSensor = new Sensor("prophet", {width: 33, height: 53, x: prophetCoordinates.x, y: prophetCoordinates.y});
				prophetSensor.onBeginContact.add(handleProphetTouch);
				add(prophetSensor);
				
				_pSprite.width = prophetSensor.width;
				_pSprite.height = prophetSensor.height;
				_pSprite.x = Math.floor(prophetSensor.x - _prophetIdle[1]/2);
				_pSprite.y =  Math.floor(prophetSensor.y - _prophetIdle[2]/2);
				
				add(_pSprite);
				isProphetAdded = true;
			}
				
		}
		
		public function powerup(Event:PowerupEvent):void
		{
			var type:String = Event.params.type
			var sound:String = Event.params.sound;
			var revert:Boolean = Event.params.revert;
			// trace("powerup", type, sound, revert)
			
			if (sound != '')
				_ce.sound.playSound(sound);
			
			if (!revert)
			{ 	// HANDLE MADE A PURCHASE
				currentCoinCount -= Game.THREE_NINETY; // subtract cost of powerup
				currentCoinCount = currentCoinCount;
				_cash.updateDisplay(currentCoinCount);
				Game.coinCount = currentCoinCount;
				_powerupStatus.updateCount(type);
				Game.THREE_NINETY_EVENTS++;
			}
			
			if (type == "colossal")
			{
				if (!revert)
				{
					ColossalHole.createColossalHole();
				} else 
				{
					ColossalHole.destroyColossolalHole();
				}
				
					
			} else if (type == "barewalk")
			{
				if (!revert)
				{
					Game.hero.acceleration = Game.accelerationBoost;
					Game.hero.maxVelocity = Game.velocityBoost;
				} else 
				{
					Game.hero.acceleration = Game.accelerationOrig;	
					Game.hero.maxVelocity = Game.velocityOrig;
				}
				
			} else if (type == "lettuce")
			{
				
				if (!revert)
				{
					_countDown._totalTime = Game.timeBoost;
					_countDown.recalculate();
					_countDown.reset();
				} else {
					
					_countDown._totalTime = Game.timeOrig;
					_countDown.recalculate();
					_countDown.restart();
				}
				
				
			} else if (type == "crack") 
			{
				
				if (!revert)
				{
					Game.BREAK_WALLS = "no";		
				} else 
				{
					Game.BREAK_WALLS = "yes"	
				}
			}
				
		}
		
		public function restartTimer(Event:RestartTimerEvent):void
		{
			currentRemainingCount = 0;
			_countDown.restart();
			increaseRound = false;
			
		}

		public function updateUnstablePlatform(Event:ElevenTwentyEvent):void
		{
			_ce.sound.playSound(_round.getRound() % 2 == 0 ? "rumble" : "rumble_v1");
			
			currentCoinCount -= currentRemainingCount;
			_cash.updateDisplay(currentCoinCount);
			_round.updateRound(increaseRound);
			_powerupStatus.roundHasEndedUpdateCount(increaseRound);
			
			destroyImmortality();
			destroyEnemy();
			destroyLife();
			destroyCoins();
			createCoins();
			createLife();
			createEnemy();
			createImmortality();
			
			var _jitter:Number = Math.floor(Math.random() * 30);
			var _allPlatforms:Vector.<CitrusObject> = getObjectsByType(DynamicPlatform);
			var _allPlatformsSprites:Vector.<CitrusObject> = getObjectsByType(PlatformSprite);
			var _toChange:Array = ArrayUtils.getNumRandomValuesInRange(0, Game.platforms.xCoords.length - 1, _jitter);
			var _platform:DynamicPlatform;
			var _platformSprite:PlatformSprite;
			var _idx:int;
			
			var _isRow:Boolean;
			var _name:String;
			var _width:Number;
			var _height:Number;
			var _texture:Texture;
			var _xPos:Number;
			var _yPos:Number;
			var _status:Boolean;
			var _pIndex:int;
			var _pName:String;
			for (var i:int = 0; i < _toChange.length; i++)
			{
				_idx = _toChange[i];
				_status = Game.platforms.status[_idx];
				// trace("_status", _status);
				if (_status == false)
				{
					// trace("KILLED")
					Game.platforms.status[_idx] = true;
					
					for (var y:int = 0; y < _allPlatforms.length; y++)
					{
						_pName = (_allPlatforms[y] as DynamicPlatform).name;
						if (_pName ==  Game.platforms.names[_idx])
						{
							_pIndex = y;
							break;
						}
							
					}
					
					_platform = _allPlatforms[_pIndex] as DynamicPlatform;
					_platform.kill = true;
					
					_platformSprite = _allPlatformsSprites[_pIndex] as PlatformSprite;
					_platformSprite.kill = true;
					
				} else {
					
					// trace("ADDED")
					Game.platforms.status[_idx] = false;
					Game.platforms.times_hit[_idx] = 0;
					_name = Game.platforms.names[_idx];
					_xPos = Game.platforms.xCoords[_idx];
					_yPos = Game.platforms.yCoords[_idx];
					
					_isRow = _name.indexOf("row_") != -1;
					_height = _isRow ? _rowHeight : _colHeight;
					_width = _isRow ? _rowWidth : _colWidth;
					_texture = Textures.getPlatformTexture(_isRow); 
					// _texture = _isRow ? Textures.ROW_TEXTURE : Textures.COL_TEXTURE; 
					
					_platform = new DynamicPlatform(_name, {x: _xPos, y : _yPos, width: _width, height: _height, view: _texture});
					add(_platform);
					
					_platformSprite = new PlatformSprite(_name + "_sprite", {x: Math.floor(_platform.x - _texture.width/2), y: Math.floor(_platform.y - _texture.height/2), view: _texture});
					add(_platformSprite);
					
				}
			}
			
			increaseRound = true;
		}
		
		private function createCoins():void
		{				
			var numCoins:int = Math.floor(ArrayUtils.randomRange(1, 5));
			var coin:Coin;
			var idx:int;
			var _coinIdx:int;
			var coinSize:Number;
			var coinValue:Number;
			var xPos:Number;
			var yPos:Number;
			var coins:Array = [];
			var texture:String;
			currCoinNames = [];
			currCoinValues = [];
			coins = ArrayUtils.getNumRandomValuesInRange(Game.platforms.xCoords.length - 26, Game.platforms.xCoords.length - 1, numCoins);
			for (var i:int = 0; i < numCoins; i++)
			{
				idx = coins[i];
				_coinIdx = Math.floor(ArrayUtils.randomRange(0, possibleCoinValues.length - 1));
				coinValue = possibleCoinValues[_coinIdx]; 
				coinSize = coinSizes[_coinIdx]; // also name.
				texture = coinSize.toString();
				xPos = Math.floor(Game.platforms.xCoords[idx]);
				yPos = Math.floor(Game.platforms.yCoords[idx] - (8 +  coinSize/2));
				coin = new Coin("coin_" + i, {x:xPos, y:yPos, width:coinSize, height:coinSize, view: Textures.getTexture(texture, Textures.COIN_TEXTURE_ATLAS)});
				coin.onBeginContact.add(handleCoinTouch);
				currCoinNames.push(coin.name);
				currCoinValues.push(coinValue);
				add(coin);
				
				// tween
				Starling.juggler.tween(coin, 0.05, {
					transition: Transitions.LINEAR,
					delay: 0,
					repeatCount: 0,
					reverse: false,
					rotation: deg2rad(360)
				});
			}
			
			// UPDATE
			currentRemainingCount = Math.max(0, ArrayUtils.sumArray(currCoinValues));
			_remaining.updateDisplay(currentRemainingCount)
		}
		
		private function destroyCoins():void
		{
			var _allActiveCoins:Vector.<CitrusObject> = getObjectsByType(Coin);
			var _coin:Coin;
			for (var x:int = 0; x < _allActiveCoins.length; x++)
			{
				Starling.juggler.removeTweens((_coin))
						
				_coin = _allActiveCoins[x] as Coin;
				_coin.kill = true;
			}
		}
		
		private function createLife():void
		{
			var _createLife:Boolean = ArrayUtils.chance(0.15);
			if (!_createLife) return; 
			
			// *** TODO: don't choose same index as coins, maybe
			var idx:int = ArrayUtils.getNumRandomValuesInRange(Game.platforms.xCoords.length - 26, Game.platforms.xCoords.length - 1, 1)[0];
			var texture:Texture = Textures.HEART_TEXTURE;
			var xPos:int = Math.floor(Game.platforms.xCoords[idx]);
			var yPos:int = Math.floor(Game.platforms.yCoords[idx] - (texture.height/2) - 8);
			var heart:Life = new Life("life", {x:xPos, y:yPos, view: texture});
			heart.onBeginContact.add(handleHeartTouch);
			add(heart);	
			_ce.sound.playSound("heart");
			Starling.juggler.tween(heart, 0.05, {
				transition: Transitions.EASE_IN,
				repeatCount: 0,
				reverse: false,
				x: heart.x -1
			});
		}
		
		private function destroyLife():void
		{
			var _allActiveLife:Vector.<CitrusObject> = getObjectsByType(Life);
			var _life:Life;
			for (var x:int = 0; x < _allActiveLife.length; x++)
			{
				Starling.juggler.removeTweens((_life))
						
				_life = _allActiveLife[x] as Life;
				_life.kill = true;
			}
		}
		
		private function createImmortality():void
		{
			var _createImmortality:Boolean = ArrayUtils.chance(0.15);
			if (!_createImmortality) return; 
			
			var idx:int = ArrayUtils.getNumRandomValuesInRange(Game.platforms.xCoords.length - 26, Game.platforms.xCoords.length - 1, 1)[0];
			var texture:Texture = Textures.IMMORTALITY_TEXTURE;
			var xPos:int = Math.floor(Game.platforms.xCoords[idx]);
			var yPos:int = Math.floor(Game.platforms.yCoords[idx] - (texture.height/2) - 8);
			var immortality:Immortality = new Immortality("temporary_immortality", {x:xPos, y:yPos, view: texture});
			immortality.onBeginContact.add(handleImmortality);
			add(immortality);
			
			_ce.sound.playSound("heart");
			Starling.juggler.tween(immortality, 0.05, {
				transition: Transitions.EASE_IN,
				repeatCount: 0,
				reverse: false,
				x: immortality.x -1
			});
		}
		
		private function destroyImmortality():void
		{
			var _allImmortality:Vector.<CitrusObject> = getObjectsByType(Immortality);
			var _imm:Immortality;
			for (var x:int = 0; x < _allImmortality.length; x++)
			{
				Starling.juggler.removeTweens((_imm))
				
				_imm = _allImmortality[x] as Immortality;
				_imm.kill = true;
			}
		}
		
		private function createEnemy():void
		{
			var _createEnemies:Boolean = ArrayUtils.chance(0.65 + _round.getRound()/100); 
			if (!_createEnemies) return;
			
			EnemyProtocol.buildEnemy();
		}
		
		private function destroyEnemy():void
		{
			EnemyProtocol.destroyEnemy();
			
			var _allCannons:Vector.<CitrusObject> = getObjectsByType(Cannon);
			var _cannon:Cannon;
			for (var x:int = 0; x < _allCannons.length; x++)
			{
				_cannon = _allCannons[x] as Cannon;
				_cannon.kill = true;
				_cannon.destroy();
			}
		}
		
		private function injury():void
		{
			var intensity:Number = ArrayUtils.randomRange(5, 50);
			var duration:Number = ArrayUtils.randomRange(50, 100);
			shake(duration, intensity);
		}

		private function shake(duration:Number, intensity:Number):void
		{
			this.x = Math.random() * intensity - intensity / 2;
			this.y = Math.random() * intensity - intensity / 2;
			
			_shakeTimer = new Timer(duration, 1);
			_shakeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeTimerCallback);
			_shakeTimer.start();
		}
		
		private function shakeTimerCallback(e:TimerEvent):void
		{
			_shakeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeTimerCallback);
			this.x = 0;
			this.y = 0;
		}
		
		private function handleHeartTouch(interactionCallback:InteractionCallback):void
		{
			var _heart:Life = NapeUtils.CollisionGetObjectByType(Life, interactionCallback) as Life;
			if ((NapeUtils.CollisionGetOther(_heart, interactionCallback) is Anarcho) == false) return;
			
			Starling.juggler.removeTweens(_heart)
			_ce.sound.playSound("hit_pick");
			Game.life.addLife();
		}
		
		private function handleImmortality(interactionCallback:InteractionCallback):void
		{
			var _imm:Immortality = NapeUtils.CollisionGetObjectByType(Immortality, interactionCallback) as Immortality;
			if ((NapeUtils.CollisionGetOther(_imm, interactionCallback) is Anarcho) == false) return;
			
			Starling.juggler.removeTweens(_imm)
			_ce.sound.playSound("hit_pick");
			
			Game.IMMORTALITY = true;
			_powerupStatus.updateCount("immortality");
		}
		
		private function handleCoinTouch(interactionCallback:InteractionCallback):void
		{
			var _coin:Coin = NapeUtils.CollisionGetObjectByType(Coin, interactionCallback) as Coin;
			if ((NapeUtils.CollisionGetOther(_coin, interactionCallback) is Anarcho) == false) return;
			
			Starling.juggler.removeTweens(_coin)
			_ce.sound.playSound("veloid2");
			var _moneyConfig:XML = XML(new Textures.SPARE_SOME_CHANGE_CONFIG());
			var _spareSomeChangeTexture:Texture = Textures.MONEY_TEXTURE_TEXTURE;
			var _spareSomeChangeDawg:PDParticleSystem = new PDParticleSystem(_moneyConfig, _spareSomeChangeTexture);
			_spareSomeChangeDawg.start(0.25);
			
			var _particleSprite:CitrusSprite = new CitrusSprite("spared_some_change", {view: _spareSomeChangeDawg});
			moveEmitter(_particleSprite, _coin.x, _coin.y); 
			add(_particleSprite);
			
			var num:Number = 0;
			for (var i:int = 0; i < coinSizes.length; i++)
			{
				if (_coin.width == coinSizes[i]){
					num = possibleCoinValues[i];
					break;
				}
			}

			currentCoinCount += num;
			// currentCoinCount = Math.max(0, ArrayUtils.trim(currentCoinCount, 2));
			_cash.updateDisplay(currentCoinCount);
			
			// remaining
			currentRemainingCount -= num;
			currentRemainingCount = Math.max(0, ArrayUtils.trim(currentRemainingCount, 2));
			_remaining.updateDisplay(currentRemainingCount);
		}

		private function handleProphetTouch(interactionCallback:InteractionCallback):void
		{
			var _prophet:Sensor = NapeUtils.CollisionGetObjectByType(Sensor, interactionCallback) as Sensor;
			if (NapeUtils.CollisionGetOther(_prophet, interactionCallback) is Anarcho)
			{
				if (currentCoinCount < Game.THREE_NINETY)
				{
					trace("YOU ARE NOT WORTHY")
				} else {
					destroyCoins();
					
					_countDown.reset();
					_remaining.updateDisplay(0);
					_powerups.show();
					destroyEnemy();
				}
			}
		}
		
		public function handleUI(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				var button:Button = e.currentTarget as Button;
				if (button)
				{					
					 if(touch.phase == TouchPhase.ENDED)
					{
						 _ce.sound.playSound("click");
						 if(button.name == Game.RESTART){
						 	dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.RESTART}, true));
						 }else if (button.name == Game.SPLASH){
							 dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.SPLASH}, true));
						 }
					}	
					
				}
				
			}	
		}
		
		private function playDrone():void
		{
			/// LOOPING THIS MANUALLY BECAUSE the "LOOP"/"TimesToRepeat" argument isn't doing jack shit.
			
			_loopTimer = new Timer(3800, 1);
			_loopTimer.addEventListener(TimerEvent.TIMER, playDroneCallback);
			_loopTimer.start();
		}
		
		private function playDroneCallback(e:TimerEvent):void
		{
			_ce.sound.playSound("warkle");
			
			playDrone();
		}

		override public function destroy():void
		{		
			Starling.juggler.purge();
			
			this.removeEventListener(TouchEvent.TOUCH, handleUI);
			this.removeEventListener(ElevenTwentyEvent.ELEVEN, updateUnstablePlatform);
			this.removeEventListener(RestartTimerEvent.RESTART, restartTimer);
			this.removeEventListener(PowerupEvent.POWERUP, powerup);
			EnemyProtocol._eventDispatcher.removeEventListener(InjuryEvent.INJURY, injury);
			
			_loopTimer.removeEventListener(TimerEvent.TIMER, playDroneCallback);

			_splashButton.removeEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.dispose();
			
			_restartButton.removeEventListener(TouchEvent.TOUCH, handleUI);
			_restartButton.dispose();
			
			if(_countDown){
			_countDown.clear();
			_countDown.dispose();
			}
			
			if(_round)
				_round.dispose();
			
			if(_powerups)
				_powerups.dispose();
			
			if(_powerupStatus)
				_powerupStatus.dispose();
			
			if(_fireParticles)
				_fireParticles.dispose();
			
			if(_dynamicBackground)
				_dynamicBackground.dispose();

			if(_cash)
				_cash.dispose();
			
			if(_remaining)
				_remaining.dispose();
			
			if(_unstablePlatform)
				_unstablePlatform.destroy();
			
			if(_spareChangeGroup)
				_spareChangeGroup.destroy();

			if(_lifeSprite)
				_lifeSprite.destroy();
			
			if(_colossalHole)
				_colossalHole.destroy();

			// super.destroy();
			destroyEnemy();
		}		
	}
}