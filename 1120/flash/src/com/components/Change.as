package objects
{
	import citrus.objects.platformer.nape.Coin;
	import nape.phys.BodyType;
	import nape.callbacks.InteractionCallback;
	
	public class Change extends Coin
	{
		public function Change(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override protected function defineBody():void {
			
			_bodyType = BodyType.DYNAMIC;
		}
		
	}
}