package com.managers
{
	import com.constants.Colors;
	import com.constants.Textures;
	import com.events.PowerupEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class PowerupManager extends Sprite
	{
		public static const ADDED_ROUNDS:int = 3; // 11; // idk why 11, tbh.. but I already made the sprites so...
		public static const INACTIVE_ALPHA:Number = 1;

		private var globalYPos:Number = 20 // 530// 
		private var startingXPos:Number = 380 // 750// 
		private var horGap:Number = 55;
		
		private var labelXOffset:Number = 0 // 10;
		private var labelYOffset:Number = 40; //10; 
		private var font:String = "ProtestPaintBB";
		private var fontSize:int = 24;
		private var col:uint = Colors.WHITE;
		private var textWidth:Number = 40;
		private var textHeight:Number = 40;
		
		public var colossalCount:int = 0;
		public var barewalkCount:int = 0;
		public var lettuceCount:int = 0;
		public var crackCount:int = 0;
		private var countArr:Array = [colossalCount, barewalkCount, lettuceCount, crackCount];	
		
		private var colossalStatus:Image;
		private var barewalkStatus:Image;
		private var lettuceStatus:Image;
		private var crackStatus:Image;
		
		private var colossalLabel:TextField;
		private var barewalkLabel:TextField;
		private var lettuceLabel:TextField;
		private var crackLabel:TextField;
		
		public function PowerupManager()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// could (should??) have looped this:
			colossalStatus = new Image(Textures.COLOSSAL_STATUS_TEXTURE);
			colossalStatus.alpha = INACTIVE_ALPHA;
			colossalStatus.y = globalYPos;
			colossalStatus.x = startingXPos;
			addChild(colossalStatus);
			
			colossalLabel = new TextField(textWidth, textHeight, colossalCount.toString(), font, fontSize, col, false);
			colossalLabel.x = colossalStatus.x + labelXOffset;
			colossalLabel.y = colossalStatus.y + labelYOffset;
			addChild(colossalLabel);
			
			startingXPos += horGap;
	
			barewalkStatus = new Image(Textures.BAREWALK_STATUS_TEXTURE);
			barewalkStatus.alpha = INACTIVE_ALPHA;
			barewalkStatus.y = globalYPos;
			barewalkStatus.x = startingXPos;
			addChild(barewalkStatus);
			
			barewalkLabel = new TextField(textWidth, textHeight, barewalkCount.toString(), font, fontSize, col, false);
			barewalkLabel.x = barewalkStatus.x + labelXOffset;
			barewalkLabel.y = barewalkStatus.y + labelYOffset;
			addChild(barewalkLabel);
			
			startingXPos += horGap;
			
			lettuceStatus = new Image(Textures.LETTUCE_STATUS_TEXTURE);
			lettuceStatus.alpha = INACTIVE_ALPHA;
			lettuceStatus.y = globalYPos;
			lettuceStatus.x = startingXPos;
			addChild(lettuceStatus);
			
			lettuceLabel = new TextField(textWidth, textHeight, lettuceCount.toString(), font, fontSize, col, false);
			lettuceLabel.x = lettuceStatus.x + labelXOffset;
			lettuceLabel.y = lettuceStatus.y + labelYOffset;
			addChild(lettuceLabel);
			
			startingXPos += horGap;
			
			crackStatus = new Image(Textures.CRACK_STATUS_TEXTURE);
			crackStatus.alpha = INACTIVE_ALPHA;
			crackStatus.y = globalYPos;
			crackStatus.x = startingXPos;	
			addChild(crackStatus);
			
			crackLabel = new TextField(textWidth, textHeight, crackCount.toString(), font, fontSize, col, false);
			crackLabel.x = crackStatus.x + labelXOffset;
			crackLabel.y = crackStatus.y + labelYOffset;
			addChild(crackLabel);
			
		}
		
		public function updateCount(type:String):void
		{
			if (type == "colossal")
				colossalCount += ADDED_ROUNDS;
			else if (type == "barewalk")
				barewalkCount += ADDED_ROUNDS;
			else if (type == "lettuce")
				lettuceCount += ADDED_ROUNDS;
			else if (type == "crack")
				crackCount += ADDED_ROUNDS;
			
			updateLabels();
		}
		
		public function roundHasEndedUpdateCount(update:Boolean):void
		{
			if (!update) return;
			
			colossalCount = Math.max(0, colossalCount - 1);
			barewalkCount = Math.max(0, barewalkCount - 1);
			lettuceCount = Math.max(0, lettuceCount - 1);
			crackCount = Math.max(0, crackCount - 1);
			
			hasPowerupEnded();
			updateLabels();
		}
		
		public function hasPowerupEnded():void
		{
			if (colossalCount == 0)
			{
				/// dispatchEvent(new PowerupEvent(PowerupEvent.POWERUP, {type: "colossal", sound: '', revert: true}, true));
			}
			
			if (barewalkCount == 0)
			{
				dispatchEvent(new PowerupEvent(PowerupEvent.POWERUP, {type: "barewalk", sound: '', revert: true}, true));
			}
			
			if (lettuceCount == 0)
			{
				dispatchEvent(new PowerupEvent(PowerupEvent.POWERUP, {type: "lettuce", sound: '', revert: true}, true));
			}
			
			if (crackCount == 0)
			{
				
			}
		}
		
		private function updateLabels():void
		{
			// update all labels.
			colossalLabel.text = colossalCount.toString();
			barewalkLabel.text = barewalkCount.toString();
			lettuceLabel.text = lettuceCount.toString();
			crackLabel.text = crackCount.toString();
		}
		
		override public function dispose():void
		{
			colossalStatus.dispose();
			barewalkStatus.dispose();
			lettuceStatus.dispose();
			crackStatus.dispose();
			
			colossalLabel.dispose()
			barewalkLabel.dispose();
			lettuceLabel.dispose();
			crackLabel.dispose();

			super.dispose();
		}
	}
}