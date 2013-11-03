package
{
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.objects.CitrusSprite;
	
	import com.constants.Game;
	import com.states.MenuProtocol;
	
	import flash.events.Event;
	
	import starling.core.Starling;
		
	[SWF(width='960', height='600', backgroundColor='#191919', frameRate='30', pageTitle='1120')]
	
	public class Main extends StarlingCitrusEngine {

		public function Main() {
			
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			setUpStarling(true);
			state = new MenuProtocol();
		}
	}
}