///
//	Delay v 2.1
//	Russell Lowke, June 19th 2011
//
//	Copyright (c) 2008-2011 Lowke Media
//	see http://www.lowkemedia.com for more information
//
//	Permission is hereby granted, free of charge, to any person obtaining a 
//	copy of this software and associated documentation files (the "Software"), 
//	to deal in the Software without restriction, including without limitation 
//	the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//	and/or sell copies of the Software, and to permit persons to whom the 
//	Software is furnished to do so, subject to the following conditions:
// 
//	The above copyright notice and this permission notice shall be included in 
//	all copies or substantial portions of the Software.
// 
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
//	IN THE SOFTWARE. 
//
//

package com.jack.util
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * DoLater v 2.1<br>
	 * Russell Lowke, June 19th 2011<p>
	 * 
	 * Used to tell ActionScript to call a function just once after a specified 
	 * interval.<p>
	 * 
	 * Usage: 
	 * <pre>
	 *	Delay.doIt(delay, funct, ... args); 
	 * </pre>
	 * 
	 * Where the function <code>funct</code> will be called and any 
	 * <code>args</code> passed to it after <code>delay</code> milliseconds.<p>
	 * 
	 * A reference to the Delay object is returned, but it is only useful if 
	 * you wish to close the delay before it occurs.<p>
	 * 
	 * For example, to call method afterASecond() after one second, and pass 
	 * it two arguments, 
	 * 
	 * <pre>
	 * public function triggerDelay():void 
	 * {
	 *	   Delay.doIt(1000, afterASecond, "hello", 12345);
	 * }
	 * 
	 * public function afterASecond(arg1:String, arg2:int):void 
	 * {
	 *	   trace("after a second (1000 milliseconds)");
	 *	   trace("Got arg1:" + arg1 + "	 and got arg2:" + arg2);
	 * } 
	 * </pre>
	 * 
	 * Delay should be used in preference to the deprecated 
	 * <code>flash.utils.setTimeout()</code>, which doesn't automatically clear	 
	 * from memory, requiring a subsequent <code>clearTimeout()</code> call. 
	 * Unlike <code>setTimeout()</code>, Delay will automatically clear itself 
	 * from memory once finished.<p>
	 * 
	 * Note: Delay listens for <code>Event.ENTER_FRAME</code> events and 
	 * compares time using <code>getTimer()</code>, which is more accurate than 
	 * the Flash Timer class but is limited to a minimum delay time governed by 
	 * the frame rate of the project.
	 * 
	 * @author Russell Lowke
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * @see http://www.lowkemedia.com
	 */
	public class Delay 
	{	 
		// a static _sprite is used to listen for ENTER_FRAME events
		private static var _sprite:Sprite = new Sprite();
		
		//
		// member variables
		private var _funct:Function;			// function to be called
		private var _args:Array;				// arguments to be sent to function
		private var _triggerTime:uint;			// time function should trigger 
		
		/**
		 * Calls the function <code>funct</code> after <code>delay</code> 
		 * milliseconds and passes to it any arguments in <code>args</code> </p>
		 * 
		 * The static function <code>Delay.doIt()</code> should be used in 
		 * preference to creating Delay objects directly.
		 * 
		 * @param delay Delay time waited (in milliseconds) before function 
		 *              <code>funct</code> is called.
		 * @param funct Function callback called after <code>delay</code> 
		 *              milliseconds.
		 * @param args Array of arguments passed to callback function 
		 *             <code>funct</code>
		 */
		public function Delay(delay:int,
							  funct:Function,
							  args:Array = null):void
		{
			_funct = funct;
			_args  = args;
			_triggerTime = getTimer() + delay;
			
			// delay must be positive
			if (delay <= 0) {
				// Note: Calling the funct immediately when delay is 0
				//	can be highly problematic in some situations.
				delay = 1;
			}
			
			// Note: this listener must be a hard listener and not soft
			//	as it is intended to be the only reference to the DoLater instance
			_sprite.addEventListener(Event.ENTER_FRAME, enterFrameEvent);
		}
		
		private function enterFrameEvent(evt:Event):void
		{	 
			if (getTimer() >= _triggerTime) {
				trigger();
			}
		}
		
		/**
		 * Triggers the callback and closes the Delay object.
		 */
		public function trigger():void
		{	
			// remove the listener
			close();
			
			// call the function, passing into it args
			if (_funct != null) {
				_funct.apply(null, _args);
			}
		}
		
		/**
		 * Closes Delay by removing the hard event listener, 
		 * this clears the DoLater object from memory.
		 */
		public function close():void 
		{	 
			// remove the event listener, clearing the DoLater.
			_sprite.removeEventListener(Event.ENTER_FRAME, enterFrameEvent);
		}
		
		/**
		 * Static helper function for creating delays.
		 * Calls the function <code>funct</code> after <code>delay</code> 
		 * milliseconds and passes to it any arguments in <code>... args</code> <p>
		 * 
		 * @param delay Delay time waited (in milliseconds) before function 
		 *              <code>funct</code> is called.
		 * @param funct Function callback called after <code>delay</code> 
		 *              milliseconds.
		 * @param ...args Arguments passed to callback function 
		 *                <code>funct</code>
		 * 
		 * @return Reference to the Delay object is returned so the delay can be 
		 *         triggered or closed early.
		 */
		public static function doIt(delay:int, 
									funct:Function, 
									...args):Delay 
		{
			return new Delay(delay, funct, args);
		}
	}
}