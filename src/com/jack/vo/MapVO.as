package com.jack.vo
{
	import com.jack.util.ArrayUtil;
	import com.jack.util.NumberUtil;
	
	import de.polygonal.ds.Array2;

	public class MapVO extends Object
	{
		public var name:String;
		public var level:int;
		public var width:int;
		public var height:int;
		private var realWidth:int;
		private var realHeight:int;

		private var TAG_EMPTY:int = -1;
		private var ITEM_POKER:int = 1;
		private var ITEM_TOOL:int = 2;
		
		public var map:Array2;

		public function MapVO()
		{
			
		}
		
		public function toString():String
		{
			return name;
		}
		
		public function setMapSize(w:int, h:int):void
		{
			realWidth = w;
			realHeight = h;
			width = realWidth+2;
			height = realHeight+2;
			map = new Array2(width, height);
			// default value was -1;
			for (var i:int = 0; i < width; i++) 
			{
				for (var j:int = 0; j < height; j++) 
				{
					map.set(i, j, TAG_EMPTY);
				}				
			}		
		}
		
		public function getItem(x:int, y:int):int
		{
			if(x >=0 && x < width && y >= 0 && y < height)
			{
				return int(map.get(x+1, y+1));
			}
			
			return -2;
		}
		
		public function updateItem(x:int, y:int, value:int):void
		{
			if(x >=0 && x < width && y >= 0 && y < height)
			{
				map.set(x+1, y+1, value);
			}
		}
		
		public function random(nPoker:int, nTool:int):void
		{
			if(!NumberUtil.isEven(nPoker) || !NumberUtil.isEven(nTool))
			{
				return;
			}
			
			var arr:Array=new Array(width*height);
			for (var i2:int = 0; i2 < arr.length; i2++) 
			{
				arr[i2] = TAG_EMPTY;
			}
			
			var k:int;
			for (k = 0; k < nPoker; k++) 
			{
				arr[k] = ITEM_POKER;
			}
			for (k = nPoker; k < nPoker+nTool; k++) 
			{
				arr[k] = ITEM_TOOL;
			}
			
			// shuffle the items
			ArrayUtil.shuffle(arr);
			
			for (var i:int = 0; i < width; i++) 
			{
				for (var j:int = 0; j < height; j++) 
				{
					map.set(i, j, arr[i*height+j]);
				}				
			}			
		}
		
		public function exportToString():String
		{
			var str:String = "";
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					str += (String(map.get(j, i)) + ",");
				}			
			}	
			str = str.substring(0, str.length-1);
			trace(str);
			return str;
		}
		
		public function exportAsXML():XML
		{
			var str:String = exportToString();
			
			var map:XML =
				<map>
				</map>;			
			map.appendChild(<name>{name}</name>);
			map.appendChild(<level>{level}</level>);
			map.appendChild(<width>{width}</width>);
			map.appendChild(<height>{height}</height>);
			map.appendChild(<realWidth>{realWidth}</realWidth>);
			map.appendChild(<realHeight>{realHeight}</realHeight>);
			map.appendChild(<data>{str}</data>);
			
			return map;
		}
		
		public function importFromString(str:String):void
		{
			var arr:Array = str.split("\n"); 
			for (var k:int = 0; k < arr.length; k++) 
			{
				trace(arr[k]);
			}
			
			// get the map dimension
			var dimension:String = arr[0];
			var w:int = int(dimension.substring(0, dimension.indexOf("x")));
			var h:int = int(dimension.substring(dimension.indexOf("x")+1));
			if(w <=0 || h <= 0)
			{
				return;
			}
			// get each position data
			arr.shift();
			var tmp:String = arr.join("");
			arr = tmp.split(",");
			
			realWidth = w;
			realHeight = h;
			width = realWidth+2;
			height = realHeight+2;
			map = new Array2(width, height);
			// default value was -1;
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					map.set(j, i, int(arr[i*width + j]));
				}				
			}		
		}

	}
}