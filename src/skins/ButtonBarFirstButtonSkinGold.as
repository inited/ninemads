package skins
{
	import skins.assets.emptyButton;
	
	import spark.skins.mobile.ButtonBarFirstButtonSkin;
	
	public class ButtonBarFirstButtonSkinGold extends ButtonBarFirstButtonSkin
	{
		public function ButtonBarFirstButtonSkinGold()
		{
			super();
			upBorderSkin = emptyButton;
			downBorderSkin = emptyButton;
			selectedBorderSkin = emptyButton;
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			if (currentState.indexOf("Selected") >= 0) {
				return;
			}
			if (currentState.indexOf("down") >= 0) {
				return;
			}
			graphics.beginFill(0x400000);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();

			
		}
		
	}
}