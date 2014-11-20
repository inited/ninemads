package hra.types
{
	import flash.events.Event;
	
	public class BetEvent extends Event
	{
		public var param:String;
		public function BetEvent(type:String, param:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.param = param;
		}
	}
}