package com.jack.util
{
	/**
	 * String Util Class.
	 * @author jack
	 */
	public class StringUtil
	{
		/**
		 * Trims all leading whitespace and trailing whitespace from the input
		 * @param input
		 * @return
		 */
		public static function trim(input:String):String
		{
			return StringUtil.ltrim(StringUtil.rtrim(input));
		}

		/**
		 * Trims all leading whitespace from the input
		 * @param input
		 * @return
		 */
		public static function ltrim(input:String):String
		{
			return input.replace(/^\s+/, "");
		}

		/**
		 * Trims all trailing whitespace from the input
		 * @param input
		 * @return
		 */
		public static function rtrim(input:String):String
		{
			return input.replace(/\s+$/, "");
		}

	}

}


