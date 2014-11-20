package skins.buttons
{
	
	import flash.display.DisplayObject;
	
	import skins.assets.emptyButton;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class buttonGrey extends ButtonSkin
	{
		public function buttonGrey()
		{
			super();
			upBorderSkin = GreyButtonImageUp;
			downBorderSkin = GreyButtonImageUp;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		
		override protected function commitCurrentState():void
		{   
			super.commitCurrentState();
			if (currentState == "down") {
				getChildAt(0).alpha = 0.8;
			} else {
				getChildAt(0).alpha = 1;
			}
		}
	}
}