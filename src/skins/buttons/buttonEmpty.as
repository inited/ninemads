package skins.buttons
{

	import skins.assets.emptyButton;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class buttonEmpty extends ButtonSkin
	{
		private var colorized:Boolean = false;
		
		public function buttonEmpty()
		{
			super();
			
			// replace FXG asset classes
			upBorderSkin = skins.assets.emptyButton;
			downBorderSkin = skins.assets.emptyButton; 
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
	}
}