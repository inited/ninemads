package hra
{
	import spark.components.TabbedViewNavigator;
	import spark.components.View;
	
	public class SettingsBase extends View
	{
		[Bindable]
		public var model:Model = Model.getInstance();
	
		public function goLogout():void {
			model.logoutUser();
			trace("Odhlasen");
			TabbedViewNavigator(navigator.parentNavigator).selectedIndex = 0;
//			navigator.popToFirstView();
		}
		
	}
}