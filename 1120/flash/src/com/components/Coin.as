package com.components {
	
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import flash.utils.getDefinitionByName;
	
	import nape.callbacks.InteractionCallback;

	public class Coin extends Sensor {
		
		protected var _collectorClass:Class = Anarcho;
		
		public function Coin(name:String, params:Object = null) {
			
			super(name, params);
		}
		

		[Inspectable(defaultValue="com.components.Anarcho")]
		public function set collectorClass(value:*):void {
			
			if (value is String)
				_collectorClass = getDefinitionByName(value as String) as Class;
			else if (value is Class)
				_collectorClass = value;
		}
		
		override public function handleBeginContact(interactionCallback:InteractionCallback):void {
			
			super.handleBeginContact(interactionCallback);
			
			if (_collectorClass && NapeUtils.CollisionGetOther(this, interactionCallback) is _collectorClass)
				kill = true;
		}
	}
}