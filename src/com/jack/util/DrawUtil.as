package com.jack.util
{
	import flash.display.Graphics;
	import flash.display.Sprite;

	public class DrawUtil
	{
		private static var mapContainer:Sprite;

		private static var w:Number;
		private static var h:Number;
		private static var tw:Number;
		private static var th:Number;
		private static var col:int;
		private static var row:int;
		
		public function DrawUtil()
		{
		}
		
		public static function initMapEditContainer(mc:Sprite):void
		{
			mapContainer = mc;
			w = mapContainer.width;
			h = mapContainer.height;
		}
		
		public static function clear():void
		{
			mapContainer.graphics.clear();
		}
		
		public static function drawGridding(_col:int, _row:int):void
		{		
			col = _col;
			row = _row;
			tw = w/_col;
			th = h/_row;
			var sw:Number;
			var sh:Number;
			
			var graphics:Graphics = mapContainer.graphics;
			graphics.clear();
			graphics.beginFill(0xffffff, 1);
			graphics.drawRect(0, 0, w, h);
			graphics.lineStyle(1, 0x000000, 2);
		
			// draw big  rect border  first
			graphics.moveTo(0, 0);
			graphics.lineTo(w, 0);
			graphics.lineTo(w, h);
			graphics.lineTo(0, h);
			graphics.lineTo(0, 0);
			// draw grid
			for (var i:int = 0; i < col; i++) 
			{
				for (var j:int = 0; j < row; j++) 
				{
					sw = i*tw;
					sh = j*th;
					graphics.moveTo(sw, sh);
					graphics.lineTo(sw+tw, sh);
					graphics.lineTo(sw+tw, sh+th);
					graphics.lineTo(sw, sh+th);
					graphics.lineTo(sw, sh);
				}				
			}		
			// finish the graphic render
			graphics.endFill();
		}
		
		public static function colorTile(x:Number, y:Number, color:uint, alpha:Number=1.0):void
		{
			var graphics:Graphics = mapContainer.graphics;
			graphics.beginFill(color, alpha);
			
			var sw:Number = x*tw;
			var sh:Number = y*th;
			
			graphics.moveTo(sw, sh);
			graphics.lineTo(sw+tw, sh);
			graphics.lineTo(sw+tw, sh+th);
			graphics.lineTo(sw, sh+th);
			graphics.lineTo(sw, sh);
			// finish the graphic render
			graphics.endFill();
		}
		
		/**
		 * 画一个 diamond 菱形
		 * @param        uint
		 * @param        uint
		 * @return
		 */
		public static function drawDiamond(diamondWidth:int,diamondHeight:int):Sprite
		{        
			var diamond:Sprite = new Sprite();
			
			diamond.graphics.lineStyle(1, 0xffffff, 1);
			diamond.graphics.beginFill(0xCCCCCC, 0.3);
			diamond.graphics.moveTo(diamondHeight, 0);
			diamond.graphics.lineTo(diamondWidth, diamondHeight/2);
			diamond.graphics.lineTo(diamondHeight, diamondHeight);
			diamond.graphics.lineTo(0, diamondHeight/2);
			diamond.graphics.lineTo(diamondHeight, 0);
			diamond.graphics.endFill();
			
			
			return diamond;                                
		}
		
		
	}
}