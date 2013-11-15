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
			super.update(timeDelta);
		}
	}
}