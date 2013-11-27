package com.components
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	
	import com.constants.DarknessTextures;
	import com.constants.Textures;
	import com.utils.ArrayUtils;
	
	import flash.utils.setTimeout;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.*;
	
	public class Darkness extends Sprite
	{
		private static var _ce:CitrusEngine = CitrusEngine.getInstance()
		private var _dark:CitrusSprite;
		private var index:int = 0;	
		private var textArr:Array = [];
		
		public function Darkness()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function initDarkness():void
		{			
			var num:int = ArrayUtils.randomRange(10, 30); // wonder if this is "dark" enough tho
			textArr = DarknessTextures.getArrayOfRandomDarkessTextures(num);
			index = 0;
			_dark = new CitrusSprite("dark_" + index, {view: textArr[index], touchable:false});
			_ce.state.add(_dark);
			
			Starling.juggler.tween(_dark, 1, {
				transition: Transitions.LINEAR,
				delay: 0,
				reverse: true,
				repeatCount: 2, 
				onComplete : finishedTween
			});
		}
		
		private function finishedTween():void
		{
			if (index > textArr.length - 1) return;
			
			index++
			_dark.view = textArr[index];
			Starling.juggler.tween(_dark, 1, {
				transition: Transitions.LINEAR,
				delay: 0,
				reverse: true,
				repeatCount: 2,
				onComplete : finishedTween
			});
		}
		
		public function addDark():void
		{

		}
		
		public function stopDarkness():void
		{
			if (_dark)
				_dark.destroy();

		}
		
		override public function dispose():void
		{
			if (_dark)
				_dark.destroy();
			
			super.dispose();
		}
	}
}