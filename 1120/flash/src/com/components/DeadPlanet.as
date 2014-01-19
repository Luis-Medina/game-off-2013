package com.components
{ 
	import citrus.core.CitrusEngine;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import com.constants.Game;
	
	import nape.callbacks.InteractionCallback;
	import nape.dynamics.Contact;
	import nape.geom.AABB;
	import nape.geom.Geom;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	
	public class DeadPlanet extends NapePhysicsObject
	{			
		private var _sensor:Sensor;
		private var _sensorName:String;
		
		public var touchZone:Number = 110;
		
		private static var _ce:CitrusEngine = CitrusEngine.getInstance();
		
		public function DeadPlanet(name:String, params:Object = null) {
			
			super(name, params);

		}
		
		override public function update(timeDelta:Number):void {

			super.update(timeDelta);
		}
		
		override protected function defineBody():void {
			
			_bodyType = BodyType.KINEMATIC;
		}
		
		override protected function createBody():void {
			
			_body = new Body(_bodyType, new Vec2(_x + _width / 2, _y + _height / 2));
			_body.userData.myData = this;
			_body.angularVel = 0.10;
			
			// add sensor
			_sensorName = this.name + "_" + "sensor";
			_sensor = new Sensor(_sensorName, {radius: _width/2 + touchZone, x: _x + _width / 2, y: _y + _height / 2});
			_sensor.onBeginContact.add(handleDeadZone);
			_sensor.onEndContact.add(handleDeadZoneDeath);
			_ce.state.add(_sensor);
		}
		
		private function handleDeadZone(interactionCallback:InteractionCallback):void
		{
			var _sensor:Sensor = NapeUtils.CollisionGetObjectByType(Sensor, interactionCallback) as Sensor;
			if ((NapeUtils.CollisionGetOther(_sensor, interactionCallback) is Anarcho) == false) return;
			
			var dx:Number = 0
			var dy:Number = -1000;
			
			var impulse:Vec2 = Vec2.weak(dx, dy);
			Game.hero.body.applyImpulse(impulse);
		}
		
		private function handleDeadZoneDeath(interactionCallback:InteractionCallback):void
		{
			var _sensor:Sensor = NapeUtils.CollisionGetObjectByType(Sensor, interactionCallback) as Sensor;
			if ((NapeUtils.CollisionGetOther(_sensor, interactionCallback) is Anarcho) == false) return;
			
		}
		
		override protected function createShape():void {
		
			_body.shapes.add(new Circle(_width/2, null, _material));
			_body.rotate(new Vec2(_x + _width / 2, _y + _height / 2), _rotation);
			
		}
		
		override protected function createConstraint():void {
			
			_body.space = _nape.space;             
			_body.cbTypes.add(PHYSICS_OBJECT);
			
		}
		
		override public function destroy():void {
			
			_ce.state.remove(_sensor)
			_nape.space.bodies.remove(_body);
			
			super.destroy();
		}
		
	}
	
}