package
{
	import com.constants.Colors;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(width='960', height='600', backgroundColor='#080f13', frameRate='60', pageTitle='1120')]
	
	public class Preloader extends Sprite
	{
		private var backRect:Shape;
		private var loadRect:Shape;
		private var rectHeight:Number = 30;
		private var totWidth:Number = 400;
		private var loadWidth:Number = 1;
		
		public function Preloader()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			backRect = new Shape; 
			backRect.graphics.beginFill(Colors.WHITE); 
			backRect.graphics.drawRect(0, 0, totWidth, rectHeight); // (x spacing, y spacing, width, height)
			backRect.graphics.endFill();
			backRect.x = stage.stageWidth / 2 - backRect.width / 2;
			backRect.y = stage.stageHeight / 2 - backRect.height/2;
			addChild(backRect);
			
			loadRect = new Shape; 
			loadRect.graphics.beginFill(Colors.BLUE); 
			loadRect.graphics.drawRect(0, 0, loadWidth, rectHeight); // (x spacing, y spacing, width, height)
			loadRect.graphics.endFill();
			loadRect.x = stage.stageWidth / 2 - backRect.width / 2;
			loadRect.y = stage.stageHeight / 2 - backRect.height/2;
			addChild(loadRect);
			
			this.visible = true;
			startLoad();
		}
		
		private function startLoad():void
		{			
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest("../1120/flash/build/Main.swf");
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			mLoader.load(mRequest);
		}
		
		private function onCompleteHandler(loadEvent:Event):void
		{
			this.addChild(loadEvent.currentTarget.content);
			
			this.removeChild(loadRect);
			this.removeChild(backRect);
		}
		
		private function onProgressHandler(mProgress:ProgressEvent):void
		{
			var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
			
			loadRect.width = percent * totWidth;
		}
	}
	
}