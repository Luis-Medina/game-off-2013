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

	public class CountdownToDestruction extends Sprite
	{
		private var _timer:Timer;
		private var _totalTime:Number = 10000;
		private var _rate:Number = 1000;
		private var _numTimes:int = _totalTime/_rate + 1;
		
		private var _count:int = 0;
		private var _timeRemaining:Number = _totalTime;
		
		private var _timerDisplay:TextField;
		private var _timerLabel:Image;
		
		public function CountdownToDestruction()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_timerDisplay = new TextField(80, 40, '', "ProtestPaintBB", 38, Colors.WHITE, false);
			_timerDisplay.x = 440;
			_timerDisplay.y = 12;
			addChild(_timerDisplay);
			
			if (!_timerLabel)
				_timerLabel = new Image(Texture.fromBitmap(new Textures.TIME_LABEL));
			
			_timerLabel.x = 375;
			_timerLabel.y = 12;
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
			_timerDisplay.text = (newTime/1000).toString();
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
			// trace("******** DESTROYED")
			dispatchEvent(new ElevenTwentyEvent(ElevenTwentyEvent.ELEVEN, {}, true));
			clear();
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
	}
}