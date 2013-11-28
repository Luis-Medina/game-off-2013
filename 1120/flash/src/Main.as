package
{
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.objects.CitrusSprite;
	
	import com.constants.Audio;
	import com.constants.Game;
	import com.events.CreateEvent;
	import com.states.CarnageProtocol;
	import com.states.MenuProtocol;
	import com.states.TerminateProtocol;
	
	import flash.events.Event;
		
	[SWF(width='960', height='600', backgroundColor='#080f13', frameRate='60', pageTitle='1120')]
	
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
			
			
			sound.addSound("click", {sound: Audio.CLICK});
			sound.addSound("hit_pick", {sound: Audio.HIT_PICK});
			sound.addSound("rumble", {sound: Audio.RUMBLE});
			sound.addSound("rumble_v1", {sound: Audio.RUMBLE_V1});
			sound.addSound("lick_chord", {sound: Audio.LICK_CHORD});
			sound.addSound("drone", {sound: Audio.DRONE});
			sound.addSound("veloid2", {sound: Audio.VELOID_2, volume: 0.4});
			sound.addSound("earthrot", {sound: Audio.EARTHROT, volume: 0.05});
			sound.addSound("heart", {sound: Audio.HEART, volume: 0.1});
			
			// sound.addSound("jump", {sound: Audio.JUMP, volume: 0.4});
			// sound.addSound("walk", {sound: Audio.WALK, volume: 0.4});

			state = new MenuProtocol();
			
		}
		
		private function switchStates(Event:CreateEvent):void
		{
			var type:String = Event.params.type
			
			if(type == Game.START || type == Game.RESTART)
				state = new CarnageProtocol();
			else if (type == Game.SPLASH)
				state = new MenuProtocol();
			else if (type == Game.EXIT)
				state = new TerminateProtocol();
		}
	}
}