package com.events
{
	import starling.events.Event;
	
	public class ElevenTwentyEvent extends Event
	{
		public var params:Object = {};
		
		public function CreateEvent(type:String, _params:Object, bubbles:Boolean=true)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}