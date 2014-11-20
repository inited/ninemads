package skins
{
	import spark.skins.mobile.CheckBoxSkin;
	
	public class CheckBoxGoldSkin extends CheckBoxSkin
	{
		public function CheckBoxGoldSkin()
		{
			super();

			upIconClass = CheckBoxGold_downSymbol;
			upSymbolIconClass = CheckBoxGold_downSymbol;
			
			
//			downIconClass = CheckBoxGold_up;
//			downSelectedIconClass = CheckBoxGold_up;

			upSelectedIconClass = CheckBoxGold_upSymbol;
			upSymbolIconSelectedClass = CheckBoxGold_upSymbol;
			
			downSymbolIconClass = CheckBoxGold_up;
			downSymbolIconSelectedClass = CheckBoxGold_up;
		}

		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		
	}
}