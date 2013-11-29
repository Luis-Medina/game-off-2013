package com.constants
{
	import com.components.Anarcho;
	import com.components.NewLife;

	public class Game
	{
		public static var ALREADY_INITIATED:Boolean = false;

		// RESULT SCREEN VARS
		public static var END_CASH:Number = 0;
		public static var TOTAL_CASH_LOST:Number = 0;
		public static var TOTAL_CASH_COLLECTED:Number = 0;
		public static var ROUNDS_SURVIVED:Number = 0;
		
		// CONSTANTS
		public static const PAGE_TITLE:String = '1120';
		public static const FRAME_RATE:int = 30;
		public static const STAGE_WIDTH:Number = 960;
		public static const STAGE_HEIGHT:Number = 600;
		
		// COMPONENTS THAT NEED TO GET ACCESSED BY MULTIPLE CLASSES DUE TO POOR DESIGN
		public static var hero:Anarcho;
		public static var life:NewLife = new NewLife();
		public static var heroStartX:Number = 150;
		public static var heroStartY:Number = Game.STAGE_HEIGHT - 20
		
		// EVENTS
		public static const START:String = "START";
		public static const RESTART:String = "RESTART";
		public static const SPLASH:String = "SPLASH";
		public static const EXIT:String = "EXIT";
		public static const ELEVEN_TWENTY:String = "ELEVEN_TWENTY"
		public static const ELEVEN_TWENTY_HALF:String = "ELEVEN_TWENTY_HALF"
		public static const DEATH:String = "DEATH"
			
		// MENU-INFO
		public static const globalFontSize:Number = 24;
		public static const horGap:Number = 120;
		public static const changeXPos:Number = 120;
		public static const timeXPos:Number = 120;
		public static const leftXPos:Number = 120;
		public static const changeYPos:Number = 20;
		public static const leftYPos:Number = 50;
		public static const timeYPos:Number = 80; 
		public static const globalWidth:Number = 60;
		public static const globalHeight:Number = 20;
			
		// POWERUPS
		public static var accelerationOrig:Number = 4;
		public static var accelerationBoost:Number = 8;
		public static var velocityOrig:Number = 80;
		public static var velocityBoost:Number = 100;
		public static var BREAK_WALLS:String = "yes";
		public static var IMMORTALITY:Boolean = false;
		
		public static var timeBoost:Number = 12000;
		public static var timeOrig:Number = 10000;
			
		// GAME STATES (for tracking && for results screen)
		public static var coinCount:Number;
		public static var THREE_NINETY:Number = 3.90;
		public static var THREE_NINETY_EVENTS:int = 0;
			
		// PLATFORM MANAGEMENT
		public static const platforms:Object = {}; 
		
		platforms.xCoords = [137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714];
		platforms.yCoords = [545, 545, 545, 545, 545, 545, 464, 464, 464, 464, 464, 464, 383, 383, 383, 383, 383, 383, 302, 302, 302, 302, 302, 302, 221, 221, 221, 221, 221, 221, 505.36, 505.36, 505.36, 505.36, 505.36, 505.36, 424.36, 424.36, 424.36, 424.36, 424.36, 424.36, 343.36, 343.36, 343.36, 343.36, 343.36, 343.36, 262.36, 262.36, 262.36, 262.36, 262.36, 262.36, 181.36, 181.36, 181.36, 181.36, 181.36, 181.36];
		platforms.names = ["col_0", "col_1", "col_2", "col_3", "col_4", "col_5", "col_6", "col_7", "col_8", "col_9", "col_10", "col_11", "col_12", "col_13", "col_14", "col_15", "col_16", "col_17", "col_18", "col_19", "col_20", "col_21", "col_22", "col_23", "col_24", "col_25", "col_26", "col_27", "col_28", "col_29", "row_0", "row_1", "row_2", "row_3", "row_4", "row_5", "row_6", "row_7", "row_8", "row_9", "row_10", "row_11", "row_12", "row_13", "row_14", "row_15", "row_16", "row_17", "row_18", "row_19", "row_20", "row_21", "row_22", "row_23", "row_24", "row_25", "row_26", "row_27", "row_28", "row_29"];
		platforms.status = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
		platforms.texture = [];
		platforms.texture_index = [];
		platforms.times_hit = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		
		public static function getIndexByName(name:String):int
		{
			var index:int;
			for (var i:int = 0; i < platforms.xCoords.length; i++)
			{
				if (platforms.names[i] == name)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		public static function resetGameParams():void
		{
			coinCount = 0;
			life.resetLife();
			life = new NewLife();
			
			END_CASH = 0;
			TOTAL_CASH_LOST = 0;
			TOTAL_CASH_COLLECTED = 0;
			ROUNDS_SURVIVED = 0;
			THREE_NINETY_EVENTS = 0;
			Game.IMMORTALITY = false;
		}
	}
}