package com.jack.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.filters.ColorMatrixFilter;
	
	public class DisplayUtil
	{
		public function DisplayUtil()
		{
		}
		
		/**
		 *  convert the image or movieclip to grayscale display
		 * @param image
		 */
		public static function convertToGrayscale(mc:DisplayObject, bMouseChildren:Boolean=false):void
		{
			var matrix:Array=[0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
			var grayscaleFilter:ColorMatrixFilter=new ColorMatrixFilter(matrix);
			var filters:Array=mc.filters;
			filters.push(grayscaleFilter);
			mc.filters=filters;
			if (mc is SimpleButton)
			{
				(mc as SimpleButton).mouseEnabled=bMouseChildren;
			}
			else if (mc is DisplayObjectContainer)
			{
				(mc as DisplayObjectContainer).mouseChildren=bMouseChildren;
				(mc as DisplayObjectContainer).mouseEnabled=bMouseChildren;
			}
		}
		
		/**
		 *
		 * @param image
		 * @param bMouseChildren
		 */
		public static function convertToNormal(mc:DisplayObject, bMouseChildren:Boolean=true):void
		{
			if (!mc)
				return;
			mc.filters=[];
			
			if (mc is SimpleButton)
			{
				(mc as SimpleButton).mouseEnabled=bMouseChildren;
			}
			else if (mc is DisplayObjectContainer)
			{
				(mc as DisplayObjectContainer).mouseChildren=bMouseChildren;
				(mc as DisplayObjectContainer).mouseEnabled=bMouseChildren;
			}
		}
	}
}