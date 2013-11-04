package
{
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.objects.CitrusSprite;
	
	import com.constants.Game;
	import com.events.CreateEvent;
	import com.states.CarnageProtocol;
	import com.states.MenuProtocol;
	import com.states.TerminateProtocol;
	
	import flash.events.Event;
		
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
			_starling.stage.addEventListener(CreateEvent.CREATE, switchStates);
			
			state = new MenuProtocol();
			
		}
		
		private function switchStates(Event:CreateEvent):void
		{
			var type:String = Event.params.type
			state.destroy();
				
			if(type == Game.START || type == Game.RESTART)
				state = new CarnageProtocol();
			else if (type == Game.SPLASH)
				state = new MenuProtocol();
			else if (type == Game.EXIT)
				state = new TerminateProtocol();
		}

	}
}