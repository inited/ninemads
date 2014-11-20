package hra
{
	import mx.events.FlexEvent;
	
	import spark.components.CheckBox;
	import spark.components.View;
	
	public class RegAcceptBase extends View
	{
		[Bindable]
		public var model:Model = Model.getInstance();
		
		public var cbAccept1:CheckBox;
		public var cbAccept2:CheckBox;
		public var cbAccept3:CheckBox;
		

		public function doAgree(i:int):void {
			switch(i) {
				case 0:
					model.mRegistrace.agreement1 = new Date();
					break;
				case 1:
					model.mRegistrace.agreement2 = new Date();
					break;
				case 2:
					model.mRegistrace.agreement3 = new Date();
					break;
			}
			model.saveAcceptance();
			navigator.popView();
		}

		
		protected function regacceptbase1_addHandler(event:FlexEvent):void
		{
			cbAccept1.selected = (model.mRegistrace.agreement1 != null);
			cbAccept2.selected = (model.mRegistrace.agreement2 != null);
			cbAccept3.selected = (model.mRegistrace.agreement3 != null);
		}
		
		
	}
}