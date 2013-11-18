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
			
			var _yPos:Number = (Game.STAGE_HEIGHT - _colHeight/2) - 22;
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
			
			var FIX:Number = -0.14; // ................................
			
			// assets 

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
					_platform = new DynamicPlatform(_name, {x:_xPos, y:_yPos-1, width:_width, height: _height + 10, view: Textures.COL_TEXTURE});
					_rowXPosArr.push(_platform.x);
					_rowYPosArr.push(_platform.y);
					add(_platform);
					
					_allXPos.push(_platform.x);
					_allYPos.push(_platform.y);
					_allName.push(_platform.name);
					
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
					
					if (!isNaN(_xPos))
					{
						// ROWS
						_platform = new DynamicPlatform(_name, {x:_xPos, y: _yPos + FIX, width:_rowWidth - _colWidth - 0.5, height: _rowHeight, view:Textures.ROW_TEXTURE});
						add(_platform);
						
						_allXPos.push(_platform.x);
						_allYPos.push(_platform.y);
						_allRowXPos.push(_platform.x);
						_allRowYPos.push(_platform.y);
						_allName.push(_platform.name);
						
						// GAPS
						_platform = new DynamicPlatform("gap_" + _gapCount, {x:_rowXPosArr[_rowCount] , y:_yPos + FIX, width:_colWidth, height: _rowHeight});
						add(_platform);
						
						_allXPos.push(_platform.x);
						_allYPos.push(_platform.y);
						_allName.push(_platform.name);
						
						_rowCount++
						_gapCount++
					
					}
				}
				
				if (!isNaN(_xPos))
				{
					_lastXPosArr.push(Math.floor(_xPos) + _rowWidth);
					_lastYPosArr.push(Math.floor(_yPos))
				}
			}
			var _endY:Number;
			for (var y:int = 0; y < _lastXPosArr.length; y++)
			{
				// LAST ROWS
				_xPos = _lastXPosArr[y];
				_yPos = _lastYPosArr[y] + FIX + 0.5;
				
				if (y < _lastXPosArr.length - 2)
				{
					_endY = _lastYPosArr[y + 1];
				} else {
					_endY = _yPos;
					_movingPlatform = new MovingPlatform("row_" + _rowCount, {x:_xPos , y:_yPos, width:_rowWidth - _gapWidth, height: _rowHeight, startX:_xPos, endX: _xPos, startY: _yPos, endY:_endY, speed: 12, waitForPassenger:false, touchable: false, view: Textures.ROW_TEXTURE});
					add(_movingPlatform);
				}
				
				_rowCount++
			}
			
			trace(_allXPos.length);
			trace(_allYPos.length);
			trace(_allName.length);
			trace(_allName)
			
			return _platformGroup;
		}
