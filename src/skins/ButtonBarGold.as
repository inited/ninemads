package skins
{
	import spark.components.ButtonBarButton;
	import spark.components.DataGroup;
	import spark.components.supportClasses.ButtonBarHorizontalLayout;
	import spark.skins.mobile.ButtonBarSkin;
	import spark.skins.mobile.supportClasses.ButtonBarButtonClassFactory;
	
	public class ButtonBarGold extends ButtonBarSkin
	{
		public function ButtonBarGold()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			// Set up the class factories for the buttons
			if (!firstButton)
			{
				firstButton = new ButtonBarButtonClassFactory(ButtonBarButton);
//				firstButton.skinClass = spark.skins.mobile.ButtonBarFirstButtonSkin;
				firstButton.skinClass = ButtonBarFirstButtonSkinGold;
			}
			
			if (!lastButton)
			{
				lastButton = new ButtonBarButtonClassFactory(ButtonBarButton);
//				lastButton.skinClass = spark.skins.mobile.ButtonBarLastButtonSkin;
				lastButton.skinClass = ButtonBarFirstButtonSkinGold;
			}
			
			if (!middleButton)
			{
				middleButton = new ButtonBarButtonClassFactory(ButtonBarButton);
//				middleButton.skinClass = spark.skins.mobile.ButtonBarMiddleButtonSkin;
				middleButton.skinClass = ButtonBarFirstButtonSkinGold;
			}
			
			// create the data group to house the buttons
			if (!dataGroup)
			{
				dataGroup = new DataGroup();
				var hLayout:ButtonBarHorizontalLayout = new ButtonBarHorizontalLayout();
				hLayout.gap = 0;
				dataGroup.layout = hLayout;
				addChild(dataGroup);
			}
		}
		
		
	}
}