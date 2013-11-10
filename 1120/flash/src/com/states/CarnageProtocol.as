package com.states
{

	import citrus.core.CitrusGroup;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.MovingPlatform;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	
	import com.components.Countdown;
	import com.components.DynamicPlatform;
	import com.components.GameButton;
	import com.components.PettyCash;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.CreateEvent;
	import com.events.ElevenTwentyEvent;
	import com.utils.ArrayUtils;
	
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
		private var _unstablePlatform:CitrusGroup;
		private var _allXPos:Array = [];
		private var _allYPos:Array = [];
		
		public function CarnageProtocol() {
			
			trace("CARNAGE PROTOCOL")
			
			super();
		}

		override public function initialize():void {
			
			super.initialize();
			
			/** PHYSICS **/
			physics = new Nape("physics");
			physics.visible = true;
			add(physics);
			
			var _bgSrc:Texture = Textures.BG_TEXTURE;
			_bg = new CitrusSprite("bg", {view:_bgSrc});
			add(_bg);
			
			/** PARTICLES **/
			var _atmoPsConfig:XML = XML(new Textures.PARTICLE_CONFIG());
			var _atmoPsTexture:Texture = Textures.PARTICLE_TEXTURE_TEXTURE;
			_atmoParticles = new PDParticleSystem(_atmoPsConfig, _atmoPsTexture);
			_atmoParticles.start();
			
			var psv:CitrusSprite = new CitrusSprite("atmosphere", {view: _atmoParticles, parallaxX:1.7, parallaxY:1.7});
			moveEmitter(psv, stage.stageWidth >> 1, stage.stageHeight >> 1);
			add(psv);
			
			/** PROTAGONIST **/
			hero = new Hero("hero", {x: 15, y: stage.height - 16, width:20, height:20});
			hero.acceleration = 2.1;
			hero.jumpAcceleration = 4;
			add(hero);
			
			/** WALLS **/
			add(new Platform("bottom", {x: stage.stageWidth / 2, y: stage.stageHeight, width: stage.stageWidth, height: 20}));
			add(new Platform("roof", {x:stage.stageWidth / 2, y:-6, width:stage.stageWidth, height: 10}));
			add(new Platform("left_wall", {x:-6, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));
			add(new Platform("right_wall", {x: stage.stageWidth + 5, y: stage.stageHeight,  width:10, height: stage.stageHeight * 2}));
			
			var _floorSrc:Texture = Textures.FLOOR_TEXTURE;
			_floor = new CitrusSprite("floor_img", {view: _floorSrc, x: 0, y : Game.STAGE_HEIGHT - 10});
			add(_floor);
				
			/** UI **/
			_restartButton = GameButton.imageButton(Textures.BUTTON_RESTART_TEXTURE, Game.RESTART, 46, 46, 845, 15); 
			_splashButton = GameButton.imageButton(Textures.BUTTON_EXIT_TEXTURE, Game.SPLASH, 46, 46, 900, 15); 
			_restartButton.addEventListener(TouchEvent.TOUCH, handleUI);
			_splashButton.addEventListener(TouchEvent.TOUCH, handleUI);
			addChild(_restartButton);
			addChild(_splashButton);
			
			this.visible = true;
			
			_unstablePlatform = createUnstablePlatform();
			this.addEventListener(ElevenTwentyEvent.ELEVEN, updateUnstablePlatform);
			
			addEntity(_unstablePlatform);
			
			_countDown = new Countdown();
			addChild(_countDown);
			
			_cash = new PettyCash();
			addChild(_cash);
		}
		
		override public function update(timeDelta:Number):void
		{
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
				
				_movingPlatform = new MovingPlatform("row_" + _rowCount, {x:_xPos , y:_yPos, width:_rowWidth - _gapWidth, height: _rowHeight, startX:_xPos, endX: _xPos, startY: _yPos, endY:_endY, speed: 8, waitForPassenger:false});
				add(_movingPlatform);
				
				_rowCount++
			} 
			
			return _platformGroup;
		}

		public function updateUnstablePlatform(Event:ElevenTwentyEvent):void
		{
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
			
			_atmoParticles.stop();

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