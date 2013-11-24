package com.events
{
	import starling.events.Event;
	
	public class PowerupEvent extends Event
	{
		public static const POWERUP:String = "POWERUP";
		
		public var params:Object = {};
		
		public function PowerupEvent(type:String, _params:Object, bubbles:Boolean=true)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}