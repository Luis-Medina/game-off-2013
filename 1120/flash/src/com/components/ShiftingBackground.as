package com.components
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	
	import com.constants.BackgroundTextures;
	import com.constants.Textures;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.particles.PDParticleSystem;
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
			_ce.state.add(currentBackground);
			
			moon = new CitrusSprite("moon", {view: BackgroundTextures.MOON_TEXTURE})
			_ce.state.add(moon);
				
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

			
			
		}
	}
}