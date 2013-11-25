package com.components
{
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusGroup;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import com.constants.Game;
	import com.constants.Textures;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import nape.callbacks.InteractionCallback;
	
	import starling.extensions.particles.PDParticleSystem;
	
	public class ColossalHole
	{		
		public static var sensor1X:Number = 80;
		public static var sensor2X:Number = 890;
		public static var sensor1Y:Number = 150;
		public static var sensor2Y:Number = 540;
		
		public static var _height:Number = 130;
		public static var _width:Number = 130;
		
		public static var sensor1:Sensor;
		public static var sensor2:Sensor;
		
		public static var sensor1Sprite:CitrusSprite;
		public static var sensor2Sprite:CitrusSprite;
		
		public static var _portalConfig1:XML = XML(new Textures.PROPHET_ARRIVAL_CONFIG());
		public static var _portalConfig2:XML = XML(new Textures.PROPHET_ARRIVAL_CONFIG());
		public static var _portalParticles1:PDParticleSystem;
		public static var _portalParticles2:PDParticleSystem;
		
		public static var _s1PS:CitrusSprite;
		public static var _s2PS:CitrusSprite;
		
		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
			
		private static var isActive:Boolean = true;
		private static var timeOut:Number = 500;
		private static var _timer:Timer;
		
		private static var alreadyCreated:Boolean = false;
		
		public static function createColossalHole():void
		{	
			if (alreadyCreated) return;
			
			_portalParticles1 =  new PDParticleSystem(_portalConfig1, Textures.PARTICLE_TEXTURE_TEXTURE);
			sensor1 = new Sensor("sensor_1", {view: _portalParticles1, x: sensor1X, y: sensor1Y});
			sensor1.onBeginContact.add(handleSensor1Touch);
			
			_s1PS = new CitrusSprite("s1ps", {view: _portalParticles1, x: sensor1.x, y: sensor1.y});
			_ce.state.add(_s1PS);		
			
			_portalParticles2 =  new PDParticleSystem(_portalConfig2, Textures.PARTICLE_TEXTURE_TEXTURE);
			sensor2 = new Sensor("sensor_2", {view: _portalParticles2, x: sensor2X, y: sensor2Y});
			sensor2.onBeginContact.add(handleSensor2Touch);
			
			_s2PS = new CitrusSprite("s2ps", {view: _portalParticles2, x: sensor2.x, y: sensor2.y});
			_ce.state.add(_s2PS);
			
			_ce.state.add(sensor1);
			_ce.state.add(sensor2);
			_portalParticles1.start();
			_portalParticles2.start();
			
			alreadyCreated = true;
		}
		
		public static function destroyColossolalHole():void
		{
			if (sensor1)
				sensor1.kill = true;
			
			if(sensor2)
				sensor2.kill = true;
			
			if (_s1PS)
				_s1PS.kill = true;
			
			if (_s2PS)
				_s2PS.kill = true;
			
			if (_portalParticles2)
				_portalParticles2.stop();
			
			if (_portalParticles1)
				_portalParticles1.stop();
			
			alreadyCreated = false;
		}

		public static function handleSensor1Touch(interactionCallback:InteractionCallback):void
		{
			var _sensor1:Sensor = NapeUtils.CollisionGetObjectByType(Sensor, interactionCallback) as Sensor;
			var _hasTouched:Boolean = false;
			if (NapeUtils.CollisionGetOther(_sensor1, interactionCallback) is Anarcho && isActive)
			{
				isActive = false;
				Game.hero.x = sensor2X;
				Game.hero.y = sensor2Y;
				
				_timer = new Timer(timeOut, 1);
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimeOutComplete);
				_timer.start();
			}
		}
		
		public static function handleSensor2Touch(interactionCallback:InteractionCallback):void
		{
			var _sensor2:Sensor = NapeUtils.CollisionGetObjectByType(Sensor, interactionCallback) as Sensor;
			if (NapeUtils.CollisionGetOther(_sensor2, interactionCallback) is Anarcho && isActive)
			{
				isActive = false;
				Game.hero.x = sensor1X;
				Game.hero.y = sensor1Y;
				
				_timer = new Timer(timeOut, 1);
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimeOutComplete);
				_timer.start();
				
			}
		}
		
		public static function handleTimeOutComplete(e:TimerEvent):void
		{
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimeOutComplete);
			isActive = true;
		}
		
		public static function clear():void
		{
			if (_timer && _timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimeOutComplete);
				_timer = null;
			}
		}
	}
}