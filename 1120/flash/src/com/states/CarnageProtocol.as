package com.states
{

	import citrus.core.CitrusGroup;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Coin;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.MovingPlatform;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.Nape;
	import citrus.physics.nape.NapeUtils;
	
	import com.components.Countdown;
	import com.components.DynamicPlatform;
	import com.components.GameButton;
	import com.components.PettyCash;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.events.ElevenTwentyEvent;
	import com.utils.ArrayUtils;
	
	import flash.geom.Point;
	
	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	
	public class CarnageProtocol extends StarlingState
	{
		private var _bg:CitrusSprite;
		private var _floor:CitrusSprite;
		private var _restartButton:Button;
		private var _splashButton:Button;
		private var _atmoParticles:PDParticleSystem;
		
		private var physics:Nape;
		private var hero:Hero;
		
		private var _countDown:Countdown;
		private var _cash:PettyCash;
		private var _remaining:PettyCash;
		private var _unstablePlatform:CitrusGroup;
		private var _spareChangeGroup:CitrusGroup;
		private var _allXPos:Array = [];
		private var _allYPos:Array = [];
		private var _allRowXPos:Array = [];
		private var _allRowYPos:Array = [];
		
		private var currentCoinCount:Number = 0;
		private var currentRemainingCount:Number = 0;
		private var possibleCoinValues:Array = [0.01, 0.05, 0.11, 0.17, 0.23, 0.35];
		private var coinSizes:Array = [11, 15, 23, 37, 45, 57];
		private var currCoinNames:Array = [];
		private var currCoinValues:Array = [];
		
		private var _prophetConfig:XML = XML(new Textures.PROPHET_ARRIVAL_CONFIG());
		private var prophetParticles:PDParticleSystem = new PDParticleSystem(_prophetConfig, Textures.PARTICLE_TEXTURE_TEXTURE);
		private var prophetParticlesSprite:CitrusSprite;
		private var prophetCoordinates:Point = new Point(0,0);
		
		private var greenStatus:CitrusSprite;
		private var green:CitrusSprite;
		
		private var prophet:Sensor;
		private var _prophetIdle:Array = Textures.getTextureProperties("prophet_idle", Textures.PROPHET_TEXTURE_ATLAS);
		private var _prophetAttack:Array = Textures.getTextureProperties("prophet_attack", Textures.PROPHET_TEXTURE_ATLAS);
		
		public function CarnageProtocol() {
			
			trace("CARNAGE PROTOCOL")
			
			super();
		}

		override public function initialize():void {
			
			super.initialize();
			
			/** PHYSICS **/
			physics = new Nape("physics");
			physics.visible = true;
			// physics.gravity = new Vec2(0, 620);
			add(physics);

			_bg = new CitrusSprite("bg", {view: Textures.BG_TEXTURE});
			add(_bg);
			
			/** PARTICLES **/
			// var _atmoPsConfig:XML = XML(new Textures.ATMOSPHERE_CONFIG());
			// var _atmoPsTexture:Texture = Textures.PARTICLE_TEXTURE_TEXTURE;
			// _atmoParticles = new PDParticleSystem(_atmoPsConfig, _atmoPsTexture);
			// _atmoParticles.start();
			
			// var psv:CitrusSprite = new CitrusSprite("atmosphere", {view: _atmoParticles, parallaxX:1.7, parallaxY:1.7});
			// moveEmitter(psv, stage.stageWidth >> 1, stage.stageHeight >> 1);
			// add(psv);
						
			/** WALLS **/
			add(new Platform("bottom", {x: stage.stageWidth / 2, y: stage.stageHeight, width: stage.stageWidth, height: 20}));
			add(new Platform("roof", {x:stage.stageWidth / 2, y:-6, width:stage.stageWidth, height: 10}));
			add(new Platform("left_wall", {x:-6, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));
			add(new Platform("right_wall", {x: stage.stageWidth + 5, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));
			
			var _floorSrc:Texture = Textures.FLOOR_TEXTURE;
			_floor = new CitrusSprite("floor_img", {view: _floorSrc, x: 0, y : Game.STAGE_HEIGHT - 10});
			add(_floor);
				
			/** UI **/
			_restartButton = GameButton.imageButton(Textures.BUTTON_RESTART_TEXTURE, Game.RESTART, 46, 46, 840, 10); 
			_splashButton = GameButton.imageButton(Textures.BUTTON_EXIT_TEXTURE, Game.SPLASH, 46, 46, 900, 10); 
			_restartButton.addEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.addEventListener(TouchEvent.TOUCH, handleUI);
			addChild(_restartButton);
			addChild(_splashButton);
			
			this.visible = true;
			
			_unstablePlatform = createUnstablePlatform();
			this.addEventListener(ElevenTwentyEvent.ELEVEN, updateUnstablePlatform);
			addEntity(_unstablePlatform);
			
			_spareChangeGroup = new CitrusGroup("visible_coins");
			addEntity(_spareChangeGroup)
			
			_countDown = new Countdown();
			addChild(_countDown);
			
			_cash = new PettyCash();
			addChild(_cash);
			
			_remaining = new PettyCash();
			_remaining.numLabelX = 500;
			_remaining.numDisplayX = 570;
			_remaining.numLabelTexture = Texture.fromBitmap(new Textures.LEFT_LABEL);
			addChild(_remaining);
			
			greenStatus = new CitrusSprite("status_icon", {view: Textures.STATUS_NEUTRAL_TEXTURE, x: 20, y: 15});
			add(greenStatus);
			
			prophetCoordinates.x = 900;
			prophetCoordinates.y = 158;
			
			prophetParticlesSprite = new CitrusSprite("prophet_arrival", {view: prophetParticles, parallaxX:1.7, parallaxY:1.7});
			moveEmitter(prophetParticlesSprite, prophetCoordinates.x, prophetCoordinates.y);
			add(prophetParticlesSprite);
			
			/** PROTAGONIST **/
			hero = new Hero("hero", {x: 0, y: stage.height - 16, width: 33, height: 53});
			hero.acceleration = 10; // default is 30
			hero.jumpAcceleration = 7; // default is 9
			hero.maxVelocity = 120; // default is 240
			hero.jumpHeight = 290; // default is 330
			add(hero);
			
			prophet = new Sensor("prophet", {view: _prophetIdle[0], width: _prophetIdle[1], height: _prophetIdle[2], x: prophetCoordinates.x, y: prophetCoordinates.y});
			add(prophet);
		}
		
		override public function update(timeDelta:Number):void
		{		
			if (currentCoinCount >= 3.90){	
				moveEmitter(prophetParticlesSprite, prophetCoordinates.x, prophetCoordinates.y);
				greenStatus.view = Textures.STATUS_HAPPY_TEXTURE;
				prophetParticles.start();
				prophet.view = _prophetAttack[0];
			} else if (currentCoinCount < 3.90) {
				prophetParticles.stop();
				greenStatus.view = Textures.STATUS_NEUTRAL_TEXTURE;
				prophet.view = _prophetIdle[0];
			}
			
			super.update(timeDelta);
		}
		
		private function moveEmitter(sprite:CitrusSprite, x:int, y:int):void
		{
			(sprite.view as PDParticleSystem).emitterX = x;
			(sprite.view as PDParticleSystem).emitterY = y;
		}
		
		public function createUnstablePlatform(name:String="UnstablePlatform"):CitrusGroup
		{
			var _platformGroup:CitrusGroup = new CitrusGroup(name);
			
			var _numCols:int = 7;
			var _numRows:int = 7;
			var _colHeight:Number = 64;
			var _colWidth:Number = 12;
			var _rowHeight:Number = 12;
			var _gapHeight:Number = _rowHeight;
			var _gapWidth:Number = _colWidth;
			var _rowWidth:Number = (Game.STAGE_WIDTH / (_numCols));
			
			var _yPos:Number = (Game.STAGE_HEIGHT - _colHeight/2) - 11;
			var _xPos:Number = 0;
			var _platform:DynamicPlatform;
			var _movingPlatform:MovingPlatform;
			var _name:String;
			var _count:int = 0;
			
			var _gapYPos:Number = 0;
			var _rowXPosArr:Array = [];
			var _rowYPosArr:Array = [];
			
			var _width:Number = 0;
			var _height:Number = 0;

			/** ADD COLUMNS **/
			for (var i:int = 1; i < _numCols; i++)
			{
				_xPos = _rowWidth;
				for (var j:int = 2; j < _numRows + 1; j++)
				{
					_name = "col_" + _count;
					_height = _colHeight;
					_width = _colWidth;
					
					// COLUMNS
					_platform = new DynamicPlatform(_name, {x:_xPos, y:_yPos-1, width:_width, height: _height + 10});
					_rowXPosArr.push(_platform.x);
					_rowYPosArr.push(_platform.y);
					add(_platform);
					
					_allXPos.push(_platform.x);
					_allYPos.push(_platform.y);
					
					_xPos = j * _rowWidth;
					_count++
				}
				_yPos -= (_colHeight + _rowHeight*1.5) - 1;
			}
			
			/** ADD ROWS **/
			var _lastXPosArr:Array = [];
			var _lastYPosArr:Array = [];
			var _rowCount:int = 0;
			var _gapCount:int = 0;
			for (var k:int = 0; k < _numCols; k++)
			{
				for (var l:int = 1; l < _numRows; l++)
				{
					_name = "row_" + _rowCount;		
					_xPos = _rowXPosArr[_rowCount] - _rowWidth/2;
					_yPos = _rowYPosArr[_rowCount] - _colHeight/2 - _rowHeight/2 - 1.5;
					
					// ROWS
					_platform = new DynamicPlatform(_name, {x:_xPos, y:_yPos, width:_rowWidth - _colWidth - 0.5, height: _rowHeight});
					add(_platform);
					
					_allXPos.push(_platform.x);
					_allYPos.push(_platform.y);
					_allRowXPos.push(_platform.x);
					_allRowYPos.push(_platform.y);
					
					// GAPS
					_platform = new DynamicPlatform("gap_" + _gapCount, {x:_rowXPosArr[_rowCount] , y:_yPos, width:_colWidth, height: _rowHeight});
					add(_platform);
					
					_allXPos.push(_platform.x);
					_allYPos.push(_platform.y);
					
					_rowCount++
					_gapCount++
				}
				
				if (!isNaN(_xPos))
				{
					_lastXPosArr.push(_xPos + _rowWidth);
					_lastYPosArr.push(_yPos)
				}
			}
			var _endY:Number;
			for (var y:int = 0; y < _lastXPosArr.length; y++)
			{
				// LAST ROWS
				_xPos = _lastXPosArr[y];
				_yPos = _lastYPosArr[y];
				
				if (y < _lastXPosArr.length - 2)
					_endY = _lastYPosArr[y + 1];
				else
					_endY = _yPos;
				
				_movingPlatform = new MovingPlatform("row_" + _rowCount, {x:_xPos , y:_yPos, width:_rowWidth - _gapWidth, height: _rowHeight, startX:_xPos, endX: _xPos, startY: _yPos, endY:_endY, speed: 12, waitForPassenger:false});
				add(_movingPlatform);
				
				_rowCount++
			}
			
			return _platformGroup;
		}

		public function updateUnstablePlatform(Event:ElevenTwentyEvent):void
		{
			currentCoinCount -= currentRemainingCount;
			currentCoinCount = Math.max(0, ArrayUtils.trim(currentCoinCount, 2));
			_cash.updateDisplay(currentCoinCount);
			
			var _allActiveCoins:Vector.<CitrusObject> = getObjectsByType(Coin);
			var _coin:Coin;
			for (var x:int = 0; x < _allActiveCoins.length; x++)
			{
				_coin = _allActiveCoins[x] as Coin;
				_coin.kill = true;
			}
			_spareChangeGroup = createCoins();
			
			var _jitter:Number = Math.floor(Math.random() * 30);
			
			var _allPlatforms:Vector.<CitrusObject> = getObjectsByType(DynamicPlatform);
			var _toChange:Array = ArrayUtils.getNumRandomValuesInRange(0, _allPlatforms.length - 6, _jitter);
			
			var _platForm:DynamicPlatform;
			var _idx:int;
			var _name:String;
			for (var i:int = 0; i < _toChange.length; i++)
			{
				_idx = _toChange[i];
				_platForm = _allPlatforms[_idx] as DynamicPlatform;
				_name = _platForm.name;
				if (_name.indexOf("row_") != -1 || _name.indexOf("col_") != -1)
				{
					if(_platForm.x != -100)
					{
						// MOVE OUT OF THE SCREEN
						_platForm.x = -100; 
						
					} else {
						// MOVE BACK TO ORIGINAL LOC
						_platForm.x = _allXPos[_idx]; 
					}					
				}
			}
			
		}
		
		private function createCoins():CitrusGroup
		{				
			var currCoins:CitrusGroup = new CitrusGroup("visible_coins")
			var numCoins:int = Math.floor(ArrayUtils.randomRange(1, 5));
			var coin:Coin;
			var idx:int;
			var _coinIdx:int;
			var coinSize:Number;
			var coinValue:Number;
			var xPos:Number;
			var yPos:Number;
			currCoinNames = [];
			currCoinValues = [];
			for (var i:int = 0; i < numCoins; i++)
			{
				idx = Math.floor(ArrayUtils.randomRange(5, _allRowXPos.length - 10));
				_coinIdx = Math.floor(ArrayUtils.randomRange(0, possibleCoinValues.length - 1));
				coinValue = possibleCoinValues[_coinIdx];
				coinSize = coinSizes[_coinIdx];
				xPos = _allRowXPos[idx];
				yPos = _allRowYPos[idx] - (6 +  coinSize/2);
				coin = new Coin("coin_" + i, {x:xPos, y:yPos, width:coinSize, height:coinSize, collectorClass:Hero});
				coin.onBeginContact.add(handleCoinTouch);
				currCoinNames.push(coin.name);
				currCoinValues.push(coinValue);
				add(coin);
			}
			
			// UPDATE
			currentRemainingCount = ArrayUtils.sumArray(currCoinValues);
			currentRemainingCount = Math.max(0, ArrayUtils.trim(currentRemainingCount, 2));
			_remaining.updateDisplay(currentRemainingCount)
			
			return currCoins;
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
			
			_unstablePlatform.destroy();
			
			// super.destroy();
			
		}		
	}
}