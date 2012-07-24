package com.jack.util 
{
	/**
	 * ...
	 * @author Jack
	 */
	public class ArrayUtil 
	{
		
		public function ArrayUtil() 
		{
			
		}
		
		public static function isEmpty(array:Array):Boolean
		{
			return (array == null || array.length == 0) ? true : false;
		}
		
		/**
		 * Shuffles the position of the elements of the given <code>array</code>.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import com.jack.util.ArrayUtil;
		 * 
		 * var arr:Array = ["abc", "def", 123, 1, 2, 3, "abc", 7];
		 * 
		 * ArrayUtil.shuffle(arr)    // [123,abc,2,def,abc,7,3,1]
		 * </listing>
		 * 
		 * @param  	array 	the array to shuffle. May be <code>null</code>.
		 * @return 	the modified array.
		 */
		public static function shuffle(array:Array):Array
		{
			if (isEmpty(array))	return array;;
			
			var i:uint = 0;
			var n:int = array.length;
			var r:int;
			var e:*;
			
			for (i; i < n; i++)
			{
				r = int(Math.random() * n);
				e = array[i];
				array[i] = array[r];
				array[r] = e;
			}
			
			return array;
		}
		
		public static function shuffleMultiDemensionArray():Array
		{
			return [];
		}
		
	}

}