package com.components
{
	import citrus.core.CitrusEngine;
	import citrus.physics.nape.NapeUtils;
	
	import com.constants.Game;
	import com.constants.Textures;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import nape.callbacks.InteractionCallback;

	public class EyesInTheShadows
	{
		public static var _timer:Timer;
		
		public static var lifeTime:Number = 1500;
		public static var timeToGrab:Number = 500; // if hero touching eyes for >= 500, take away a life
		
		public static var eyes:Eyes;
		
		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
		
		public static function createEyesInTheShadows(rate:Number = 5000, jitter:Number=300):void
		{
			eyes = new Eyes("eye", {view: Textures.EYES_TEXTURE})
			eyes.onBeginContact.add(handleEyesTouch);
			
			// for now:
			var xPos:Number = Math.random()*960;
			var yPos:Number = Math.random()*500;
			eyes.x = xPos;
			eyes.y = yPos;
			
			_ce.state.add(eyes);
			
			_timer = new Timer(rate, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, backToTheShadows);
			_timer.start();
		}
		
		public static function handleEyesTouch(interactionCallback:InteractionCallback):void
		{
			var _eyes:Eyes = NapeUtils.CollisionGetObjectByType(Eyes, interactionCallback) as Eyes;
			if (NapeUtils.CollisionGetOther(_eyes, interactionCallback) is Anarcho)
			{
				// CALCULATE TIME TOUCHING
				trace("TOUCHING")
				Game.life.removeLife();
				
			}
		}
		
		public static function backToTheShadows(e:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, backToTheShadows);
			
			if (eyes)
				eyes.kill = true;
			
			createEyesInTheShadows();
		}
		
	}
}