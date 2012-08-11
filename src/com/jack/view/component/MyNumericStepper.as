package com.jack.view.component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import spark.components.NumericStepper;
	
	/**
	 * Auto update value once mouse roll out the numeric stepper.
	 * @author Jack
	 */
	public class MyNumericStepper extends NumericStepper
	{
		public function MyNumericStepper()
		{
			super();
			
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut, false, 0, true); 
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage, false, 0, true);
		}
		
		protected function onRemoveFromStage(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			this.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
			var curValue:Number = Number(this.textDisplay.text);
			curValue = curValue < this.minimum ? this.minimum : curValue;
			curValue = curValue > this.maximum ? this.maximum : curValue;
			
			this.value = curValue;
		}
	}
}