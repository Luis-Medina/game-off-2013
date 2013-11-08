package com.utils
{
	public class ArrayUtils
	{
		public static function getRandomElementOf(array:Array):Object
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
	}
}