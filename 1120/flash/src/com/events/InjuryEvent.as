package com.events
{
	import starling.events.Event;
	
	public class InjuryEvent extends Event
	{
		public static const INJURY:String = "INJURY";
		
		public var params:Object = {};
		
		public function InjuryEvent(type:String, _params:Object, bubbles:Boolean=true)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}