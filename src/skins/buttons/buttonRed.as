package skins.buttons
{

	import skins.assets.emptyButton;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class buttonRed extends ButtonSkin
	{
		private var colorized:Boolean = false;
		
		public function buttonRed()
		{
			super();
			
			// replace FXG asset classes
			upBorderSkin = skins.assets.emptyButton;
			downBorderSkin = skins.assets.emptyButton; 
			
			//measuredDefaultHeight = 44;
			//measuredDefaultWidth = 220;
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// omit call to super.drawBackground() to apply tint instead and don't draw fill
			//var chromeColor:uint = getStyle("chromeColor");
			
			if (currentState == "up") {
				graphics.beginFill(0xbd266d);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
			}           
			else{

				graphics.beginFill(0xda2178);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				graphics.endFill();
			}
		}
	}
}