package components
{
	import spark.components.LabelItemRenderer;
	import spark.components.RadioButton;
	
	
	/**
	 * 
	 * ASDoc comments for this item renderer class
	 * 
	 */
	public class CountryItemRenderer extends LabelItemRenderer
	{
//		private var rb:RadioButton;
		
		public function CountryItemRenderer()
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
		} 
		
		/**
		 * @private
		 * 
		 * Override this method to create children for your item renderer 
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
/*
			if (!rb) {
				rb = new RadioButton();
				rb.x = 2;
				rb.y = 2;
				rb.width = 32;
				rb.height = 32;
				rb.selected = false;
				addChild(rb);
			}
*/			
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
			super.measure();
			// measure all the subcomponents here and set measuredWidth, measuredHeight, 
			// measuredMinWidth, and measuredMinHeight      
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
			super.layoutContents(unscaledWidth, unscaledHeight);
/*			
			var paddingLeft:Number   = getStyle("paddingLeft"); 
			var paddingRight:Number  = getStyle("paddingRight");
			var paddingTop:Number    = getStyle("paddingTop");
			var paddingBottom:Number = getStyle("paddingBottom");
			var verticalAlign:String = getStyle("verticalAlign");
			
			var viewWidth:Number  = unscaledWidth  - paddingLeft - paddingRight;
			var viewHeight:Number = unscaledHeight - paddingTop  - paddingBottom;
			
			var vAlign:Number;
			if (verticalAlign == "top")
				vAlign = 0;
			else if (verticalAlign == "bottom")
				vAlign = 1;
			else // if (verticalAlign == "middle")
				vAlign = 0.5;
			
			// measure the label component
			// text should take up the rest of the space width-wise, but only let it take up
			// its measured textHeight so we can position it later based on verticalAlign
			var labelWidth:Number = Math.max(viewWidth, 0); 
			var labelHeight:Number = 0;
			
			if (label != "")
			{
				labelDisplay.commitStyles();
				
				// reset text if it was truncated before.
				if (labelDisplay.isTruncated)
					labelDisplay.text = label;
				
				labelHeight = getElementPreferredHeight(labelDisplay);
			}
			
			var rbWidth:int = getElementPreferredWidth(rb);
			labelWidth = labelWidth - rbWidth;
			
			setElementSize(labelDisplay, labelWidth, labelHeight);    
			
			// We want to center using the "real" ascent
			var labelY:Number = Math.round(vAlign * (viewHeight - labelHeight))  + paddingTop;
			setElementPosition(labelDisplay, paddingLeft + rbWidth, labelY);
			
			// attempt to truncate the text now that we have its official width
			labelDisplay.truncateToFit();
*/			
		}
		
	}
}