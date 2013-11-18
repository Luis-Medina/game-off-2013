package com.constants
{
	public class Game
	{
		// CONSTANTS
		public static const PAGE_TITLE:String = '1120';
		public static const FRAME_RATE:int = 30;
		public static const STAGE_WIDTH:Number = 960;
		public static const STAGE_HEIGHT:Number = 600;
		
		// EVENTS
		public static const START:String = "START";
		public static const RESTART:String = "RESTART";
		public static const SPLASH:String = "SPLASH";
		public static const EXIT:String = "EXIT";
		public static const ELEVEN_TWENTY:String = "ELEVEN_TWENTY"
		public static const ELEVEN_TWENTY_HALF:String = "ELEVEN_TWENTY_HALF"
			
		// PLATFORM MANAGEMENT
		public static const platforms:Object = {};
		
		platforms.xCoords = [137.142857142857,274.285714285714,411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 137.142857142857, 274.285714285714, 411.428571428571, 548.571428571428, 685.714285714285, 822.857142857142, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714, 68.5714285714285, 205.714285714285, 342.857142857142, 480, 617.142857142857, 754.285714285714];
		platforms.yCoords = [545, 545, 545, 545, 545, 545, 464, 464, 464, 464, 464, 464, 383, 383, 383, 383, 383, 383, 302, 302, 302, 302, 302, 302, 221, 221, 221, 221, 221, 221, 140, 140, 140, 140, 140, 140, 505.36, 505.36, 505.36, 505.36, 505.36, 505.36, 424.36, 424.36, 424.36, 424.36, 424.36, 424.36, 343.36, 343.36, 343.36, 343.36, 343.36, 343.36, 262.36, 262.36, 262.36, 262.36, 262.36, 262.36, 181.36, 181.36, 181.36, 181.36, 181.36, 181.36, 100.36, 100.36, 100.36, 100.36, 100.36, 100.36];
		platforms.names = ["col_0", "col_1", "col_2", "col_3", "col_4", "col_5", "col_6", "col_7", "col_8", "col_9", "col_10", "col_11", "col_12", "col_13", "col_14", "col_15", "col_16", "col_17", "col_18", "col_19", "col_20", "col_21", "col_22", "col_23", "col_24", "col_25", "col_26", "col_27", "col_28", "col_29", "col_30", "col_31", "col_32", "col_33", "col_34", "col_35", "row_0", "row_1", "row_2", "row_3", "row_4", "row_5", "row_6", "row_7", "row_8", "row_9", "row_10", "row_11", "row_12", "row_13", "row_14", "row_15", "row_16", "row_17", "row_18", "row_19", "row_20", "row_21", "row_22", "row_23", "row_24", "row_25", "row_26", "row_27", "row_28", "row_29", "row_30", "row_31", "row_32", "row_33", "row_34", "row_35"]
		platforms.status = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];		
		
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
		
	}
}