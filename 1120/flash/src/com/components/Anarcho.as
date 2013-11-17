package com.components
{
	import citrus.objects.platformer.nape.Hero;
	
	public class Anarcho extends Hero
	{
		public function Anarcho(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override public function update(timeDelta:Number):void
		{
			// trace(y)
			super.update(timeDelta);
		}
		
		/*public override function set x(value:Number):void
		{
			super.x = Math.floor(value);
		}*/
		
		/*public override function set y(value:Number):void
		{
			super.y = Math.floor(value);
		}*/
		
		override protected function updateAnimation():void
		{
			var prevAnimation:String = _animation;
			
			var walkingSpeed:Number = _body.velocity.x;
			
			if (_hurt)
				_animation = "hurt";
				
			else if (!_onGround) {
				
				_animation = "jump";
				
				if (walkingSpeed < -acceleration)
					_inverted = false; // true
				else if (walkingSpeed > acceleration)
					_inverted = true; // false;
				
			} else if (_ducking)
				_animation = "duck";
				
			else {
				
				if (walkingSpeed < -acceleration) {
					_inverted = false; // true
					_animation = "walk";
					
				} else if (walkingSpeed > acceleration) {
					_inverted = true; // false
					_animation = "walk";
					
				} else
					_animation = "idle";
			}
			
			if (prevAnimation != _animation)
				onAnimationChange.dispatch();
		}
	}
}