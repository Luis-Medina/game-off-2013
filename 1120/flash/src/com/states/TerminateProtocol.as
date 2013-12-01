package com.states
{
	import citrus.core.starling.StarlingState;
	
	import com.components.GameButton;
	import com.constants.Game;
	import com.constants.Textures;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class TerminateProtocol extends StarlingState
	{
		private var _loading:LoadingProtocol = new LoadingProtocol();
		private var twitter:Button;
		private var facebook:Button;
		private var github:Button;
		
		public function TerminateProtocol() {
			
			trace("TERMINATE PROTOCOL")
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChild(_loading);
			
			// lazy:
			var height:int = 120;
			var width:int = 120;
			var yPos:int = Game.STAGE_HEIGHT/2 - width/2;
			var gap:int = 150;
			var xPos:Array = [Game.STAGE_WIDTH/2 - width/2 - gap, Game.STAGE_WIDTH/2 - width/2, Game.STAGE_WIDTH/2 - width/2 + gap];
			twitter = GameButton.imageButton(Textures.TWITTER_TEXTURE, "twitter", width, height, xPos[0], yPos);
			github = GameButton.imageButton(Textures.GITHUB_TEXTURE, "github", width, height, xPos[1], yPos);
			facebook = GameButton.imageButton(Textures.FACEBOOK_TEXTURE, "facebook", width, height, xPos[2], yPos);
					
			addChild(twitter)
			addChild(github);
			addChild(facebook);
			
			twitter.addEventListener(TouchEvent.TOUCH, buttonHandler);
			github.addEventListener(TouchEvent.TOUCH, buttonHandler);
			facebook.addEventListener(TouchEvent.TOUCH, buttonHandler);
		}
		
		private function buttonHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				var button:Button = e.currentTarget as Button;
				if (button)
				{	
					if(touch.phase == TouchPhase.ENDED)
					{
						_ce.sound.playSound("click");
						// todo use ExternalController instead.
						button.removeEventListener(TouchEvent.TOUCH, buttonHandler);
						if (button.name == "twitter")
							navigateToURL(new URLRequest("http://www.twitter.com/uni_turtle"), "_blank");
						else if (button.name == "github")
							navigateToURL(new URLRequest("http://www.github.com/josegallegos07"), "_blank");
						else if (button.name == "facebook")
							navigateToURL(new URLRequest("http://www.facebook.com/unimpressedturtle"), "_blank");
					}	
				}
			}
			
		}
		
		override public function dispose():void
		{
			twitter.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			github.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			facebook.removeEventListener(TouchEvent.TOUCH, buttonHandler);
			
			_loading.dispose();
			
			twitter.dispose();
			facebook.dispose();
			github.dispose();
			
			// super.dispose();
		}
	}
}