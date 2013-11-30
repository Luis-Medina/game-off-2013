package com.states
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	
	import com.constants.Game;
	import com.constants.Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LoadingProtocol extends Sprite
	{	
		private var lifelessScreen:Image;
		private var heroAnimSprite:CitrusSprite;

		public function LoadingProtocol()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
			lifelessScreen = new Image(Textures.BLANK_SPLASH_TEXTURE);
			addChild(lifelessScreen);
			
			var heroAnim:AnimationSequence = new AnimationSequence(Textures.GREEN_TEXTURE_ATLAS, ["dance"], "dance",  10, true, "none");
			StarlingArt.setLoopAnimations(["dance"]);

			heroAnimSprite = new CitrusSprite("hero_loading", {view:heroAnim});
			heroAnim.x = Math.min(Game.STAGE_WIDTH/2 - heroAnim.width/2);
			heroAnim.y = Math.min(Game.STAGE_HEIGHT/2 - heroAnim.width/2);
			
			addChild(heroAnim);
		}
		
		override public function dispose():void
		{		
			lifelessScreen.dispose();
			
			if (heroAnimSprite)
				heroAnimSprite.destroy();

			this.removeChildren();
			
			// super.dispose();
		}
	}
}