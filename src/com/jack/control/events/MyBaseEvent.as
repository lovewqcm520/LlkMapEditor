package com.jack.control.events
{
	import flash.events.Event;
	
	public class MyBaseEvent extends Event
	{
		public var params:Object;
		
		public function MyBaseEvent(type:String, params:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.params = params;
			super(type, bubbles, cancelable);
		}
	}
}