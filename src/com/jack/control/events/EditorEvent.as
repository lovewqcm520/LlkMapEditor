package com.jack.control.events
{
	public class EditorEvent extends MyBaseEvent
	{
		public static const CREATE_PROJECT:String = "create_project";
		
		public function EditorEvent(type:String, params:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, params, bubbles, cancelable);
		}
	}
}