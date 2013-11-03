package com.states
{
	import citrus.core.starling.StarlingState;
	
	public class TerminateProtocol extends StarlingState
	{
		public function TerminateProtocol() {
			
			trace("TERMINATE PROTOCOL")
			super();
			terminate();
		}
		
		public function terminate():void
		{
			
		}
	}
}