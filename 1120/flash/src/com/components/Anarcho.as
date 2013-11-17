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
			// trace(_animation);
			super.update(timeDelta);
		}

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
					_animation = "walk_left";
					
				} else if (walkingSpeed > acceleration) {
					_inverted = false; // false
					_animation = "walk_right";
					
				} else
					_animation = "idle";
			}
			
			if (prevAnimation != _animation)
				onAnimationChange.dispatch();
		}
	}
}