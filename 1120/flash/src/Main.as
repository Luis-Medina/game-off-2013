package
{
	import citrus.core.starling.StarlingCitrusEngine;
	
	import com.constants.Game;
	import com.states.MenuProtocol;
	
	import starling.core.Starling;
		
	[SWF(width='960', height='600', backgroundColor='#191919', frameRate='30', pageTitle='1120')]
	
	public class Main extends StarlingCitrusEngine {

		public function Main() {
			
			setUpStarling(true);
	
			state = new MenuProtocol();
		}
	}
}