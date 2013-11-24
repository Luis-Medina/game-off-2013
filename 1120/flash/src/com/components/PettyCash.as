package com.components
{
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.ElevenTwentyEvent;
	import com.utils.ArrayUtils;
	
	import flash.events.TimerEvent;
	import flash.globalization.CurrencyFormatter;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class PettyCash extends Sprite
	{		
		private var _numDisplay:TextField;
		private var _numLabel:Image;
		
		public var startValue:String = '$0.00';
		public var numDisplayX:Number = Game.changeXPos + Game.horGap;
		public var numDisplayY:Number = Game.changeYPos;
		public var numDisplayWidth:Number = Game.globalWidth;
		public var numDisplayHeight:Number = Game.globalHeight;
		
		public var numLabelTexture:Texture = Texture.fromBitmap(new Textures.CHANGE_LABEL);
		public var numLabelX:Number = Game.changeXPos;
		public var numLabelY:Number = Game.changeYPos;
		
		public function PettyCash()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_numDisplay = new TextField(numDisplayWidth, numDisplayHeight, startValue, "ProtestPaintBB", Game.globalFontSize, Colors.WHITE, false);
			_numDisplay.hAlign = "left";
			_numDisplay.autoScale = false;
			_numDisplay.x = numDisplayX;
			_numDisplay.y = numDisplayY;
			addChild(_numDisplay);
			
			_numLabel = new Image(numLabelTexture);
			
			_numLabel.x = numLabelX;
			_numLabel.y = numLabelY;
			addChild(_numLabel);
		}
		
		public function updateDisplay(money:Number):void
		{
			var currentCash:String = currency(money);
			_numDisplay.text = currentCash;
		}
		
		public function clear():void
		{
			_numDisplay.dispose();
		}
		
		override public function dispose():void
		{
			clear();
			super.dispose();
		}
		
		// http://agione.tumblr.com/post/987054971/as3-currency-formatter
		public function currency(num:Number,decimalPlace:Number=2,currency:String="$"):String
		{
			//assigns true boolean value to neg in number less than 0
			var neg:Boolean = (num < 0);
			
			//make the number positive for easy conversion
			num = Math.abs(num)
			
			var roundedAmount:String = String(num.toFixed(decimalPlace));
			
			//split string into array for dollars and cents
			var amountArray:Array = roundedAmount.split(".");
			var dollars:String = amountArray[0];
			var cents:String = amountArray[1];
			
			//create dollar amount
			var dollarFinal:String = "";
			var i:int = 0
			for (i; i < dollars.length; i++)
			{
				if (i > 0 && (i % 3 == 0 ))
				{
					dollarFinal = "," + dollarFinal;
				}
				
				dollarFinal = dollars.substr( -i -1, 1) + dollarFinal;
			}   
			
			//create Cents amount and zeros if necessary
			var centsFinal:String = String(cents);
			
			var missingZeros:int = decimalPlace - centsFinal.length;
			
			if (centsFinal.length < decimalPlace)
			{
				for (var j:int = 0; j < missingZeros; j++) 
				{
					centsFinal += "0";
				}
			}
			
			var finalString:String = "";
			
			if (neg)
			{
				finalString = "-" + currency + dollarFinal;
			} else
			{
				finalString = currency + dollarFinal
			}
			
			if(decimalPlace > 0)
			{
				finalString += "." + centsFinal;
			} 
			
			return finalString;
		}
		
	}
}