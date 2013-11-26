package com.utils
{
	/** MATH && ARRAY UTILS **/
	
	public class ArrayUtils
	{
		public static function getRandomElementOf(array:Array):*
		{
			var idx:int=Math.floor(Math.random() * array.length);
			return array[idx];
		}
		
		public static function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public static function chance(percent:Number):Boolean{
			var chance:Number = Math.random();
			return (chance<=percent);
		}
		
		public static function getNumRandomValuesInRange(minNum:Number, maxNum:Number, numberValues:int, ints:Boolean = true):Array
		{
			var arr:Array = [];
			var val:Number;
			var isRepeat:Boolean = false;
			while (arr.length < numberValues)
			{
				val = randomRange(minNum, maxNum);
				if (ints)
					val = int(val);
				
				// no repeats.
				isRepeat = false;
				for (var i:int = 0; i < arr.length; i++)
				{
					if (val == arr[i])
					{
						isRepeat = true;
						break;
					}
				}
				
				if (!isRepeat)
					arr.push(val);
			}
			
			return arr;
		}
		
		public static function trim(theNumber:Number, decPlaces:Number) : Number {
			if (decPlaces >= 0) {
				var temp:Number = Math.pow(10, decPlaces);
				return Math.round(theNumber * temp) / temp;
			}
			
			return theNumber;
		}
		
		public static function sumArray(arr:Array):Number
		{
			var sum:Number = 0;
			for (var i:int = 0; i < arr.length; i++)
			{
				sum += arr[i];
			}
				
			return sum;
		}
		
		public static function randomizeArray(array:Array):Array
		{
			var newArray:Array = new Array();
			while (array.length > 0)
			{
				var mn:int=Math.floor(Math.random()*array.length)
				newArray[newArray.length]=array[mn]
				array.splice(mn,1)
			}
			return newArray;
		}
		
		// http://swati61.blogspot.com/2011/06/as3-shuffle-array_16.html
		public static function arrayShuffle(array_arr:Array):Array
		{
			for(var i:Number = 0; i < array_arr.length; i++)
			{
				var randomNum_num:int = Math.floor(Math.random() * array_arr.length)
				var arrayIndex:*  = array_arr[i];
				array_arr[i] = array_arr[randomNum_num];
				array_arr[randomNum_num] = arrayIndex;
			}
			return array_arr;
		}  
		
	}
}