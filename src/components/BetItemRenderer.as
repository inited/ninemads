package components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import hra.Model;
	import hra.types.BetEvent;
	
	import spark.components.Button;
	import spark.components.LabelItemRenderer;
	import spark.components.RadioButton;
	
	
	/**
	 * 
	 * ASDoc comments for this item renderer class
	 * 
	 */
	public class BetItemRenderer extends LabelItemRenderer
	{
		protected var btnCancel:Button ;
		protected var btnAccept:Button;
		protected var btnEdit:Button;
		
		protected var bw:int = 150;
		protected var bh:int = 50;
		protected var lh:int = 100;
		
		[Bindable]
		public var model:Model = Model.getInstance();
		
		
		public function BetItemRenderer()
		{
			//TODO: implement function
			super();
			percentWidth = 100;
		}
		
		/**
		 * @private
		 *
		 * Override this setter to respond to data changes
		 */
		override public function set data(value:Object):void
		{
			super.data = value;
			// the data has changed.  push these changes down in to the 
			// subcomponents here
			if (!btnCancel) return;
			btnCancel.visible = btnEdit.visible = btnAccept.visible = ((value.status == "game1") && (value.player2 == model.mRegistrace.username));
//			btnCancel.visible = btnEdit.visible = false;
		} 
		
		/**
		 * @private
		 * 
		 * Override this method to create children for your item renderer 
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			labelDisplay.wordWrap=true;
			labelDisplay.multiline=true;
			if (!btnCancel) {
				btnCancel =  new Button();
				btnCancel.label = "Zrusit";
				btnCancel.x = 10;
				btnCancel.y = lh + 20;
				btnCancel.width = bw;
				btnCancel.height = bh;
				btnCancel.addEventListener(MouseEvent.CLICK, onClick);
				addChild(btnCancel);
			}
			if (!btnAccept) {
				btnAccept =  new Button();
				btnAccept.label = "Prijmout";
				btnAccept.x = width - 100 - 10;;
				btnAccept.y = lh + 20;
				btnAccept.width = bw;
				btnAccept.height = bh;
				btnAccept.addEventListener(MouseEvent.CLICK, onClick);
				addChild(btnAccept);
			}
			if (!btnEdit) {
				btnEdit =  new Button();
				btnEdit.label = "Zmenit";
				btnEdit.x = width / 2 - 75;
				btnEdit.y = lh + 20;
				btnEdit.width = bw;
				btnEdit.height = bh;
				btnEdit.addEventListener(MouseEvent.CLICK, onClick);
				addChild(btnEdit);
			}
			labelDisplay.x = 10;
			labelDisplay.y = 10;
			labelDisplay.width = width - 20;
			labelDisplay.height = lh;
		}
		
		/**
		 * @private
		 * 
		 * Override this method to change how the item renderer 
		 * sizes itself. For performance reasons, do not call 
		 * super.measure() unless you need to.
		 */ 
		override protected function measure():void
		{
			measuredMinWidth = measuredWidth = 0;
			measuredMinHeight = measuredHeight = lh + bh + 30;
		}
		
		/**
		 * @private
		 * 
		 * Override this method to change how the background is drawn for 
		 * item renderer.  For performance reasons, do not call 
		 * super.drawBackground() if you do not need to.
		 */
		override protected function drawBackground(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			// do any drawing for the background of the item renderer here      		
		}
		
		/**
		 * @private
		 *  
		 * Override this method to change how the background is drawn for this 
		 * item renderer. For performance reasons, do not call 
		 * super.layoutContents() if you do not need to.
		 */
		override protected function layoutContents(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			var paddingLeft:Number   = getStyle("paddingLeft");
			var paddingRight:Number  = getStyle("paddingRight");
			var paddingTop:Number    = getStyle("paddingTop");
			var paddingBottom:Number = getStyle("paddingBottom");
			var verticalAlign:String = getStyle("verticalAlign");
			
			var viewWidth:Number  = unscaledWidth  - paddingLeft - paddingRight;
			var viewHeight:Number = unscaledHeight - paddingTop  - paddingBottom;
			setElementSize(labelDisplay, viewWidth, lh);
			setElementPosition(labelDisplay, 10, 10);
			setElementPosition(btnCancel, 10, lh + 20);
			setElementPosition(btnEdit,   unscaledWidth / 2 - 75, lh + 20);
			setElementPosition(btnAccept, unscaledWidth - 150 - 20, lh + 20);
		}

		public function onClick(e:Event):void {
			if (data == null) return;
			if (e.currentTarget == btnCancel) dispatchEvent(new BetEvent("betCancel", data.id, true));
			if (e.currentTarget == btnEdit)   dispatchEvent(new BetEvent("betEdit",   data.id, true));
			if (e.currentTarget == btnAccept) dispatchEvent(new BetEvent("betAccept", data.id, true));
		}
		
	}
}