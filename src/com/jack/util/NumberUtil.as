package com.jack.util
{
	public class NumberUtil
	{
		public function NumberUtil()
		{
		}
		
		public static function isEven(n:int):Boolean
		{
			return ((n&1) == 0);
		}
	}
}