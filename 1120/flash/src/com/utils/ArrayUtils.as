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
		
		public static function getNumRandomValuesInRange(minNum:Number, maxNum:Number, numberValues:int, ints:Boolean = true):Array
		{
			var arr:Array = [];
			var val:Number;
			while (arr.length < numberValues)
			{
				val = randomRange(minNum, maxNum);
				if (ints)
					val = int(val);
				
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
			for (var i in arr) sum += arr[i];
			return sum;
		}
	}
}