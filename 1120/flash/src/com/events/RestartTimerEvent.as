package com.events
{
	import starling.events.Event;
	
	public class RestartTimerEvent extends Event
	{
		public static const RESTART:String = "RESTART";
		public var params:Object = {};
		
		public function RestartTimerEvent(type:String, _params:Object, bubbles:Boolean=true)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}