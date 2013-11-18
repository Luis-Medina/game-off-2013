package com.components {
	
	import citrus.objects.NapePhysicsObject;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionType;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreFlag;
	import nape.callbacks.PreListener;
	import nape.phys.BodyType;

	public class DynamicPlatform extends NapePhysicsObject {
		
		public static const ONEWAY_PLATFORM:CbType = new CbType();
		
		private var _oneWay:Boolean = true;
		private var _preListener:PreListener;
		
		public function DynamicPlatform(name:String, params:Object = null) {
			
			super(name, params);
		}
		
		override public function destroy():void {
			
			if (_preListener)
				_body.space.listeners.remove(_preListener);
			
			super.destroy();
		}
		
		public function get oneWay():Boolean
		{
			return _oneWay;
		}
		
		[Inspectable(defaultValue="false")]
		public function set oneWay(value:Boolean):void
		{
			if (_oneWay == value)
				return;
			
			_oneWay = value;
			
			if (_oneWay && !_preListener)
			{
				_preListener = new PreListener(InteractionType.COLLISION, DynamicPlatform.ONEWAY_PLATFORM, CbType.ANY_BODY, handlePreContact,0,true);
				_body.space.listeners.add(_preListener);
				_body.cbTypes.add(ONEWAY_PLATFORM);
			}
			else
			{
				if (_preListener) {
					_preListener.space = null;
					_preListener = null;
				}
				_body.cbTypes.remove(ONEWAY_PLATFORM);
			}
		}
		
		override public function update(timeDelta:Number):void {
			
			super.update(timeDelta);
		}
		
		override protected function defineBody():void {
			
			_bodyType = BodyType.STATIC;
		}
		
		override protected function createMaterial():void {
			
			super.createMaterial();
			
			_material.elasticity = 0;
		}
		
		override protected function createConstraint():void {
			
			super.createConstraint();
			
			if (_oneWay) {
				_preListener = new PreListener(InteractionType.COLLISION, ONEWAY_PLATFORM, CbType.ANY_BODY, handlePreContact,0,true);
				_body.cbTypes.add(ONEWAY_PLATFORM);
				_body.space.listeners.add(_preListener);
			}
		}
		
		override public function handlePreContact(callback:PreCallback):PreFlag
		{
			if ((callback.arbiter.collisionArbiter.normal.y > 0) != callback.swapped)
				return PreFlag.IGNORE;
			else
				return PreFlag.ACCEPT;
		}
	}
}