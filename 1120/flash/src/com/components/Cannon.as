package com.components
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Cannon;
	import citrus.objects.platformer.nape.Missile;
	
	import nape.phys.BodyType;
	
	public class Cannon extends citrus.objects.platformer.nape.Cannon
	{
		public function Cannon(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override protected function _damage(missile:Missile, contact:NapePhysicsObject):void {
			
			if (contact != null)
			{
				// hacky, but ok.
				// TODO *** FIGURE OUT HOW TO IGNORE 
				if(contact.body.type != BodyType.STATIC)
					onGiveDamage.dispatch(contact);

				//trace(contact.name)
				//trace(contact.type)
				//trace(contact.body)
				
				// if (contact.name.indexOf("row_") != -1 || contact.name.indexOf("col_") != -1)
			}
		}
	}
}