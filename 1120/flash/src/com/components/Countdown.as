package com.components
{
	import com.constants.Colors;
	import com.constants.Game;
	import com.constants.Textures;
	import com.events.ElevenTwentyEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class Countdown extends Sprite
	{
		private var _timer:Timer;
		public var _totalTime:Number = 10000; // 10000;
		public var _rate:Number = 1000;
		private var _numTimes:int = _totalTime/_rate + 1;
		private var _paused:Boolean = false;
		
		private var _count:int = 0;
		private var _timeRemaining:Number = _totalTime;
		
		private var _timerDisplay:TextField;
		private var _timerLabel:Image;
		
		public function Countdown()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_timerDisplay = new TextField(Game.globalWidth, Game.globalHeight, '', "ProtestPaintBB", Game.globalFontSize, Colors.WHITE, false);
			_timerDisplay.hAlign = "left";
			_timerDisplay.x = Game.timeXPos + Game.horGap;
			_timerDisplay.y = Game.timeYPos;
			addChild(_timerDisplay);
			
			// TODO: not like this:
			_timerLabel = new Image(Texture.fromBitmap(new Textures.TIME_LABEL));
			
			_timerLabel.x = Game.timeXPos;
			_timerLabel.y = Game.timeYPos;
			addChild(_timerLabel);
			
			initTimer();
		}
		
		public function initTimer():void
		{
			_count = 0;
			_timeRemaining = _totalTime;
			updateDisplay(_timeRemaining);
			
			_timer = new Timer(_rate, _numTimes);
			_timer.addEventListener(TimerEvent.TIMER, handleTimeEvent);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimeDone);
			_timer.start()
		}
		
		private function updateDisplay(newTime:*):void
		{
			var timeToDisplay:int = newTime/1000;
			_timerDisplay.text = (timeToDisplay).toString();
			
			if (timeToDisplay < (_totalTime/1000)/2)
				_timerDisplay.color = Colors.RED;
			else
				_timerDisplay.color = Colors.WHITE;
		}
		
		private function handleTimeEvent(e:TimerEvent):void
		{
			_count = e.target.currentCount;
			_timeRemaining -= Math.max(0, _rate);
			updateDisplay(_timeRemaining);
				
			// trace("_count: " + _count)
			// trace("_timeRemaining: " + _timeRemaining);
				
		}
		
		private function handleTimeDone(e:TimerEvent):void
		{
			e.target.removeEventListener(TimerEvent.TIMER, handleTimeEvent);
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimeDone); 
			
			if (_count == _numTimes)
				destruction();
		}
				
		private function destruction():void
		{
			dispatchEvent(new ElevenTwentyEvent(ElevenTwentyEvent.ELEVEN, {}, true));
			clear();
			
			if (!_paused)
				initTimer();
		}
		
		public function pause():void
		{
			_paused = true;
		}
		
		public function unPause():void
		{
			_paused = false;
		}
		
		public function reset():void
		{
			pause();
			updateDisplay(_totalTime)
			
			if(_timer && _timer.running)
				clear();
		}
		
		public function restart():void
		{
			unPause();
			initTimer();
		}
	
		public function clear():void
		{
			if (_timer && _timer.hasEventListener(TimerEvent.TIMER))
			{
				_timer.removeEventListener(TimerEvent.TIMER, handleTimeEvent);
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimeDone);
				_timer = null;
			}
		}
		
		override public function dispose():void
		{
			clear();
			
			if(_timerDisplay)
				_timerDisplay.dispose();
			
			super.dispose();
		}
	}
}