package skins
{
	import flash.events.Event;
	
	import spark.components.Group;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.TextInputSkin;

	public class TextEditDeleteSkin extends TextInputSkin
	{
		protected var deleteIcon:BitmapImage;
		protected var deleteIconHolder:Group;
		
		[Embed(source="images/textEditDelete.png")] 
		[Bindable] 
		public var imgDelete:Class;
		
		
		public function TextEditDeleteSkin()
		{
			super();
			layoutBorderSize = 0;
			borderClass = TextEditBorder;
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		

		private function deleteHandler(event:Event):void
		{
			textDisplay.text = "";
			commitCurrentState();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
				deleteIconHolder = new Group();
				addChild(deleteIconHolder);

				deleteIcon = new BitmapImage();
				deleteIcon.left = 0;
				deleteIcon.right = 0;
				deleteIcon.top = 0;
				deleteIcon.bottom = 0;
				deleteIcon.source = imgDelete;
				deleteIconHolder.addElement(deleteIcon);
				
				deleteIconHolder.addEventListener("mouseDown", deleteHandler);
			
		}
		
		override protected function layoutContents(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			if (deleteIconHolder) {
				
				var paddingLeft:Number = getStyle("paddingLeft");
				var paddingRight:Number = getStyle("paddingRight");
				var paddingTop:Number = getStyle("paddingTop");
				var paddingBottom:Number = getStyle("paddingBottom");
				
				var unscaledTextWidth:Number = unscaledWidth - paddingLeft - paddingRight;
				var unscaledTextHeight:Number = unscaledHeight - paddingTop - paddingBottom;
				
				
				deleteIconHolder.x = unscaledTextWidth - unscaledTextHeight;
				deleteIconHolder.y = paddingTop;
				deleteIconHolder.width = unscaledTextHeight;
				deleteIconHolder.height = unscaledTextHeight;				
			}
		}		
	}
}