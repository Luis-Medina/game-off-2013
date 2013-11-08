package com.events
{
	import starling.events.Event;
	
	public class ElevenTwentyEvent extends Event
	{
		public static const ELEVEN:String = "ELEVEN";
		public var params:Object = {};
		
		public function ElevenTwentyEvent(type:String, _params:Object, bubbles:Boolean=true)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}