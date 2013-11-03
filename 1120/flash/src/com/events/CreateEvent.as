package com.events
{
	import starling.events.Event;

	public class CreateEvent extends Event
	{
		public static const CREATE:String = "CREATE";
		
		public var params:Object = {};
		
		public function CreateEvent(type:String, _params:Object, bubbles:Boolean=true)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}