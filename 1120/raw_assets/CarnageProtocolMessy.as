package com.states
{

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
	import com.components.Coin;
	import com.components.Countdown;
	import com.components.DynamicPlatform;
	import com.components.GameButton;
	import com.components.PettyCash;
	import com.components.PlatformSprite;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.events.ElevenTwentyEvent;
	import com.utils.ArrayUtils;
	import com.utils.ObjectUtils;
	
	import flash.geom.Point;
	
	import nape.callbacks.InteractionCallback;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class CarnageProtocol extends StarlingState
	{
		private var _bg:CitrusSprite;
		private var _floor:CitrusSprite;
		private var _restartButton:Button;
		private var _splashButton:Button;
		private var _atmoParticles:PDParticleSystem;
		
		private var physics:Nape;
		private var hero:Anarcho;
		
		private var _countDown:Countdown;
		private var _cash:PettyCash;
		private var _remaining:PettyCash;
		private var _unstablePlatform:CitrusGroup;
		private var _spareChangeGroup:CitrusGroup;
		
		private var _numCols:Number = 7;
		private var _numRows:Number = 7;
		private var _colHeight:Number = 91.5;
		private var _colWidth:Number = 12;
		private var _rowHeight:Number = 12;
		private var _rowWidth:Number = (Game.STAGE_WIDTH / (_numCols));
		
		public static const THREE_NINETY:Number = 3.90;
		private var currentCoinCount:Number = 0;
		private var currentRemainingCount:Number = 0;
		private var possibleCoinValues:Array = [0.01, 0.05, 0.11, 0.17, 0.23, 0.35];
		private var coinSizes:Array = [11, 15, 23, 37, 45, 57];
		private var currCoinNames:Array = [];
		private var currCoinValues:Array = [];
		
		private var _toChange:Array = [];
		private var _allPlatforms:Vector.<CitrusObject>;
		private var _allPlatformsSprites:Vector.<CitrusObject>;
		
		private var _prophetConfig:XML = XML(new Textures.PROPHET_ARRIVAL_CONFIG());
		private var prophetParticles:PDParticleSystem = new PDParticleSystem(_prophetConfig, Textures.PARTICLE_TEXTURE_TEXTURE);
		private var prophetParticlesSprite:CitrusSprite;
		private var prophetCoordinates:Point = new Point(900,150);
		
		private var greenStatus:CitrusSprite;
		private var green:CitrusSprite;
		
		private var _prophetGroup:CitrusGroup;
		private var isProphetAdded:Boolean = false;
		private var prophetSensor:Sensor;
		private var _prophetIdle:Array = Textures.getTextureProperties("prophet_idle", Textures.PROPHET_TEXTURE_ATLAS);
		private var _prophetAttack:Array = Textures.getTextureProperties("prophet_attack", Textures.PROPHET_TEXTURE_ATLAS);
		private var _pSprite:CitrusSprite = new CitrusSprite("p_idle", {view: _prophetIdle[0]})

		private var prophetSpeechSprite:CitrusSprite;
		
		public function CarnageProtocol() {
			
			trace("CARNAGE PROTOCOL")  
			
			super();
		}

		override public function initialize():void {
			
			super.initialize();
			
			/** PHYSICS **/
			physics = new Nape("physics");
			// physics.visible = true;  
			add(physics);

			_bg = new CitrusSprite("bg", {view: Textures.BG_TEXTURE});
			add(_bg);

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
			
			this.visible = true;
			
			createUnstablePlatform();
			this.addEventListener(ElevenTwentyEvent.ELEVEN, updateUnstablePlatform);
						
			_countDown = new Countdown();
			addChild(_countDown);
			
			_cash = new PettyCash();
			addChild(_cash);
			
			_remaining = new PettyCash();
			_remaining.numLabelX = 500;
			_remaining.numDisplayX = 570;
			_remaining.numLabelTexture = Texture.fromBitmap(new Textures.LEFT_LABEL);
			addChild(_remaining);
						
			prophetParticlesSprite = new CitrusSprite("prophet_arrival", {view: prophetParticles, parallaxX:1.7, parallaxY:1.7});
			moveEmitter(prophetParticlesSprite, prophetCoordinates.x, prophetCoordinates.y);
			add(prophetParticlesSprite);
			
			var heroAnim:AnimationSequence = new AnimationSequence(Textures.GREEN_TEXTURE_ATLAS, ["walk_left", "walk_right", "jump_left", "jump_right", "idle", "dance"], "idle", 	10, true, "none");
			StarlingArt.setLoopAnimations(["walk_left"]);
			StarlingArt.setLoopAnimations(["walk_right"]);
			StarlingArt.setLoopAnimations(["jump_left"]);
			StarlingArt.setLoopAnimations(["jump_right"]);
			StarlingArt.setLoopAnimations(["dance"]);
			 
			/** PROTAGONIST **/
			hero = new Anarcho("hero", {x: 20, y: Game.STAGE_HEIGHT - 20, width: 30, height: 56, view: heroAnim});
			hero.canDuck = false;
			hero.acceleration = 10; // default is 30
			hero.jumpAcceleration = 7; // default is 9
			hero.maxVelocity = 120; // default is 240
			hero.jumpHeight = 290; // default is 330
			add(hero);
			
			/** PROPHET SPEECH **/
			var prophetSpeechAnim:AnimationSequence = new AnimationSequence(Textures.PROPHET_SPEECH_TEXTURE_ATLAS, ["prophet_laugh", "prophet_neutral"], "prophet_neutral", 6, true, "none");
			StarlingArt.setLoopAnimations(["prophet_neutral"]);
			
			prophetSpeechSprite = new CitrusSprite("prophet_speech", {view:prophetSpeechAnim, x: Game.STAGE_WIDTH - 250, y: Game.STAGE_HEIGHT - 270});
			// add(prophetSpeechSprite);

		}
		
		override public function update(timeDelta:Number):void
		{			
			if (currentCoinCount >= THREE_NINETY){	
				moveEmitter(prophetParticlesSprite, prophetCoordinates.x, prophetCoordinates.y);
				greenStatus.view = Textures.STATUS_HAPPY_TEXTURE;
				
				if(isProphetAdded)
				{
					prophetSensor.onBeginContact.add(handleProphetTouch);
					prophetParticles.start();
					_pSprite.view = _prophetAttack[0];
				}
				
			} else if (currentCoinCount < THREE_NINETY) {
				
				greenStatus.view = Textures.STATUS_NEUTRAL_TEXTURE;
				
				if (isProphetAdded)
				{
					prophetParticles.stop();
					_pSprite.view = _prophetIdle[0];
				}
				
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
			var _textureName:String;
			for (var i:int = 0; i < Game.platforms.xCoords.length; i++)
			{
				_name = Game.platforms.names[i];
				_xPos = Game.platforms.xCoords[i];
				_yPos = Game.platforms.yCoords[i];
				
				_isRow = _name.indexOf("row_") != -1;
				_height = _isRow ? _rowHeight : _colHeight;
				_width = _isRow ? _rowWidth : _colWidth;
				_textureName = _isRow ? "row_1" : "col_1";
				_texture = Textures.getTexture(_textureName, Textures.PROPHET_PLATFORMS_TEXTURE_ATLAS);
				
				Game.platforms.texture.push(_textureName);
				Game.platforms.texture_index.push(1); // always 1.
				
				_platform = new DynamicPlatform(_name, {x: _xPos, y : _yPos, width: _width, height: _height});
				add(_platform);
				
				_platFormSprite = new PlatformSprite(_name + "_sprite", {x: Math.floor(_platform.x - _texture.width/2), y: Math.floor(_platform.y - _texture.height/2), view: _texture});
				add(_platFormSprite);
			}
			
			_xPos = prophetCoordinates.x - 7;
			_yPos = prophetCoordinates.y + 31;
			_movingPlatform = new MovingPlatform("prophet_platform", {x:_xPos , y:_yPos, width:_rowWidth, height: _rowHeight, startX:_xPos, endX: _xPos, startY: _yPos, endY:_yPos, speed: 12, waitForPassenger:false})
			add(_movingPlatform);
			
			_movingPlatformSprite = new CitrusSprite("prophet_platform_sprite", {x: Math.floor(_xPos - Textures.ROW_TEXTURE.width/2), y: Math.floor(_yPos - Textures.ROW_TEXTURE.height/2), view: Textures.ROW_TEXTURE});
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

		private function updateUnstablePlatform(Event:ElevenTwentyEvent):void
		{
			var _count:int = Event.params.count;
			var _numTimes:int = Event.params.num_times;
			if (_count == _numTimes)
			{
				// choose platforms to change
				_allPlatforms = getObjectsByType(DynamicPlatform);
				_allPlatformsSprites = getObjectsByType(PlatformSprite);
				var _jitter:Number = Math.floor(Math.random() * 30);
				_toChange = ArrayUtils.getNumRandomValuesInRange(0, Game.platforms.xCoords.length - 1, _jitter);	
				
				// init coins for round
				var _allActiveCoins:Vector.<CitrusObject> = getObjectsByType(Coin);
				var _coin:Coin;
				for (var x:int = 0; x < _allActiveCoins.length; x++)
				{
					_coin = _allActiveCoins[x] as Coin;
					_coin.kill = true;
				}
				createCoins();
			}
			
			if (_count % 2 != 0 || _count == 0)
			{
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
				var _currIdx:int = 1;
				var _textureName:String;
				var _textureIndex:int;
				for (var i:int = 0; i < _toChange.length; i++)
				{
					_idx = _toChange[i];
					_status = Game.platforms.status[_idx];
					
					_name = Game.platforms.names[_idx];
					_xPos = Game.platforms.xCoords[_idx];
					_yPos = Game.platforms.yCoords[_idx];
					_textureName = 	Game.platforms.texture[_idx];
					_textureIndex = Game.platforms.texture_index[_idx];
					
					_isRow = _name.indexOf("row_") != -1;
					_height = _isRow ? _rowHeight : _colHeight;
					_width = _isRow ? _rowWidth : _colWidth;

					if (_status == false)
					{					
						for (var y:int = 0; y < _allPlatforms.length; y++)
						{
							_pName = (_allPlatforms[y] as DynamicPlatform).name;
							if (_pName ==  Game.platforms.names[_idx])
							{
								_pIndex = y;
								break;
							}
								
						}

						/** UPDATE IMAGE **/
						_platformSprite = _allPlatformsSprites[_pIndex] as PlatformSprite;
	
						if (_count != 0) {
						Game.platforms.texture_index[_idx] = Math.min(_textureIndex + 1, 5);
						Game.platforms.texture[_idx] = _isRow ? "row_" + Game.platforms.texture_index[_idx] : "col_" + Game.platforms.texture_index[_idx];
						_platformSprite.view = Textures.getTexture(Game.platforms.texture[_idx], Textures.PROPHET_PLATFORMS_TEXTURE_ATLAS);
						trace(_platformSprite.name, _pName, _name, Game.platforms.names[_pIndex]);
						
						} else {
							// KILL
							_platform = _allPlatforms[_pIndex] as DynamicPlatform;
							_platform.kill = true;
							_platformSprite.kill = true;
							Game.platforms.status[_idx] = true;
						}
						
					} else {
						
						for (var z:int = 0; z < _allPlatforms.length; z++)
						{
							_pName = (_allPlatforms[z] as DynamicPlatform).name;
							if (_pName ==  Game.platforms.names[_idx])
							{
								_pIndex = z;
								break;
							}
							
						}	
						
						if (_count != 0) 
						{
							_platformSprite = _allPlatformsSprites[_pIndex] as PlatformSprite;
							Game.platforms.texture_index[_idx] = Math.min(_textureIndex - 1, 5);
							Game.platforms.texture[_idx] = _isRow ? "row_" + Game.platforms.texture_index[_idx] : "col_" + Game.platforms.texture_index[_idx];
							_platformSprite.view = Textures.getTexture(Game.platforms.texture[_idx], Textures.PROPHET_PLATFORMS_TEXTURE_ATLAS);					
						} else {
							////
							Game.platforms.status[_idx] = false;
							_platform = new DynamicPlatform(_name, {x: _xPos, y : _yPos, width: _width, height: _height});
							add(_platform);

							_textureName = _isRow ? "row_5" : "col_5";
							_texture = Textures.getTexture(_textureName, Textures.PROPHET_PLATFORMS_TEXTURE_ATLAS);
							
							_platformSprite = new PlatformSprite(_name + "_sprite", {x: Math.floor(_platform.x - _texture.width/2), y: Math.floor(_platform.y - _texture.height/2), view: _texture});
							add(_platformSprite);
						}
					}
				}
			}
			
			if (_count == 0)
			{
				// update coins
				currentCoinCount -= currentRemainingCount;
				currentCoinCount = Math.max(0, ArrayUtils.trim(currentCoinCount, 2));
				_cash.updateDisplay(currentCoinCount);
			}
			
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
			currCoinNames = [];
			currCoinValues = [];
			coins = ArrayUtils.getNumRandomValuesInRange(Game.platforms.xCoords.length - 34, Game.platforms.xCoords.length - 1, numCoins);
			for (var i:int = 0; i < numCoins; i++)
			{
				idx = coins[i];
				_coinIdx = Math.floor(ArrayUtils.randomRange(0, possibleCoinValues.length - 1));
				coinValue = possibleCoinValues[_coinIdx];
				coinSize = coinSizes[_coinIdx];
				xPos = Game.platforms.xCoords[idx];
				yPos = Game.platforms.yCoords[idx] - (6 +  coinSize/2);
				coin = new Coin("coin_" + i, {x:xPos, y:yPos, width:coinSize, height:coinSize, view: Textures.PARTICLE_TEXTURE_TEXTURE});
				coin.onBeginContact.add(handleCoinTouch);
				currCoinNames.push(coin.name);
				currCoinValues.push(coinValue);
				add(coin);
			}
			
			// UPDATE
			currentRemainingCount = ArrayUtils.sumArray(currCoinValues);
			currentRemainingCount = Math.max(0, ArrayUtils.trim(currentRemainingCount, 2));
			_remaining.updateDisplay(currentRemainingCount)
		}
		
		private function handleCoinTouch(interactionCallback:InteractionCallback):void
		{
			var _coin:Coin = NapeUtils.CollisionGetObjectByType(Coin, interactionCallback) as Coin;
			
			var _moneyConfig:XML = XML(new Textures.SPARE_SOME_CHANGE_CONFIG());
			var _spareSomeChangeTexture:Texture = Textures.MONEY_TEXTURE_TEXTURE;
			var _spareSomeChangeDawg:PDParticleSystem = new PDParticleSystem(_moneyConfig, _spareSomeChangeTexture);
			_spareSomeChangeDawg.start(0.05);
			
			var _particleSprite:CitrusSprite = new CitrusSprite("spared_some_change", {view: _spareSomeChangeDawg, parallaxX:1.7, parallaxY:1.7});
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
			currentCoinCount = Math.max(0, ArrayUtils.trim(currentCoinCount, 2));
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
				if (currentCoinCount < THREE_NINETY)
					trace("YOU ARE NOT WORTHY")
				else
					trace("COME TO ME CHILD, FOR THIS IS THE PROPHECY")
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
						 if(button.name == Game.RESTART)
						 	dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.RESTART}, true));
						 else if (button.name == Game.SPLASH)
							 dispatchEvent(new CreateEvent(CreateEvent.CREATE, {type: Game.SPLASH}, true));
					}	
					
				}
				
			}	
		}
		
		override public function destroy():void
		{
			this.removeEventListener(TouchEvent.TOUCH, handleUI);
			this.removeEventListener(ElevenTwentyEvent.ELEVEN, updateUnstablePlatform);
			
			// _atmoParticles.stop();

			_splashButton.removeEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.dispose();
			
			_restartButton.removeEventListener(TouchEvent.TOUCH, handleUI);
			_restartButton.dispose();
			
			_countDown.clear();
			_countDown.dispose();
			
			// super.destroy();
			
		}		
	}
}