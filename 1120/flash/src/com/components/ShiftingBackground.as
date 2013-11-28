package com.components
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import citrus.view.starlingview.*;
	
	import com.constants.BackgroundTextures;
	import com.constants.Textures;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.particles.PDParticleSystem;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	
	public class ShiftingBackground extends Sprite
	{
		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
			
		private var currentBackground:CitrusSprite;
		private var nextBackground:CitrusSprite;
		private var filterBackground:CitrusSprite;
		private var _atmoParticles:PDParticleSystem = new PDParticleSystem(XML(new Textures.ATMOSPHERE_CONFIG()), Textures.MONEY_TEXTURE_TEXTURE);
		private var _atmoParticlesSprite:CitrusSprite;
		private var foreGround:CitrusSprite;
		private var moon:CitrusSprite;
		private var cIndex:int = 0;
		private var nIndex:int = cIndex + 1;
		
		private var topImg:Tween;
		private var bottomImg:Tween;
		
		private var delay:int = 5;
		private var fade:int = 25;
		private var max:int = BackgroundTextures.BACKGROUND_TEXTURES_ARRAY.length;
		
		public function ShiftingBackground()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			currentBackground = new CitrusSprite("current_color_background", {view: BackgroundTextures.BACKGROUND_TEXTURES_ARRAY[cIndex]})
			nextBackground = new CitrusSprite("next_color_background", {view: BackgroundTextures.BACKGROUND_TEXTURES_ARRAY[nIndex]})
			
			_ce.state.add(nextBackground);
			_ce.state.add(currentBackground);
			
			moon = new CitrusSprite("moon", {view: BackgroundTextures.MOON_TEXTURE})
			_ce.state.add(moon);
			Starling.juggler.tween(moon, 0.05, {
				transition: Transitions.EASE_IN,
				repeatCount: 2,
				reverse: true,
				onComplete: finishedMoon,
				y: moon.y - 1.5
			})
				
			// TODO*** filter alpha
			// filterBackground = new CitrusSprite("filter_background", {view: BackgroundTextures.FILTER_IMG});
			//_ce.state.add(filterBackground);
			
			// atmoparticles 
			_atmoParticlesSprite = new CitrusSprite("atmo_particles", {view: _atmoParticles, parallaxX:1.7, parallaxY:1.7});
			//moveEmitter(_atmoParticlesSprite, Game.STAGE_WIDTH / 2, Game.STAGE_HEIGHT / 2);
			_ce.state.add(_atmoParticlesSprite);
			_atmoParticles.start();
			
			foreGround = new CitrusSprite("foreground", {view: Textures.BUILDINGS_TEXTURE})
			_ce.state.add(foreGround);	

			initShift();
			
		}
		
		private function finishedMoon():void
		{
			Starling.juggler.tween(moon, 0.05, {
				transition: Transitions.EASE_IN,
				repeatCount: 2,
				reverse: true,
				onComplete: finishedMoon,
				y: moon.y - 1
			})
		}
		
		private function initShift():void
		{
			topImg = new Tween(_ce.state.view.getArt(currentBackground), fade);
			topImg.animate("alpha", 0);
			topImg.onComplete = fadeOutComplete;
			Starling.juggler.add(topImg);
			
			bottomImg = new Tween(_ce.state.view.getArt(nextBackground), fade);
			bottomImg.delay = delay; 
			bottomImg.animate("alpha", 1);
			bottomImg.onComplete = fadeInComplete;
			Starling.juggler.add(bottomImg);
		}
		
		private function fadeOutComplete():void
		{
			cIndex++;			
			if (cIndex == max)
				cIndex = 0;	
			
			currentBackground.view = getTexture(cIndex);
			var _alpha:int = _ce.state.view.getArt(currentBackground).alpha == 1 ? 0 : 1;
			topImg = new Tween(_ce.state.view.getArt(currentBackground), fade);
			topImg.animate("alpha", _alpha);
			topImg.onComplete = fadeOutComplete;
			Starling.juggler.add(topImg);
			

		}
		
		private function fadeInComplete():void
		{
			nIndex++;
			if (nIndex == max)
				nIndex = 0;	
				
			nextBackground.view = getTexture(cIndex);
			var _alpha:int = _ce.state.view.getArt(nextBackground).alpha == 1 ? 0 : 1;
			bottomImg = new Tween(_ce.state.view.getArt(nextBackground), fade);
			bottomImg.animate("alpha", _alpha);
			bottomImg.delay = 0;
			bottomImg.onComplete = fadeInComplete;
			Starling.juggler.add(bottomImg);
		}
		
		private function getTexture(index:int):Texture
		{
			return BackgroundTextures.BACKGROUND_TEXTURES_ARRAY[index];
		}
		
		override public function dispose():void
		{			
			super.dispose();
		}
	}
}