package com.jack.vo
{
	import com.jack.util.ArrayUtil;
	import com.jack.util.NumberUtil;
	
	import de.polygonal.ds.Array2;

	public class MapVO
	{
		public var name:String;
		public var width:int;
		public var height:int;

		private var TAG_EMPTY:int = -1;
		private var ITEM_EXIST:int = 1;
		
		private var array:Array2;

		
		public function MapVO()
		{
			
		}
		
		public function setMapSize(w:int, h:int):void
		{
			width = w;
			height = h;
			array = new Array2(width, height);
			// default value was -1;
			for (var i:int = 0; i < width; i++) 
			{
				for (var j:int = 0; j < height; j++) 
				{
					array.set(i, j, TAG_EMPTY);
				}				
			}		
		}
		
		public function getItem(x:int, y:int):int
		{
			if(x >=0 && x < width && y >= 0 && y < height)
			{
				return int(array.get(x, y));
			}
			
			return -2;
		}
		
		public function updateItem(x:int, y:int, value:int):void
		{
			if(x >=0 && x < width && y >= 0 && y < height)
			{
				array.set(x, y, value);
			}
		}
		
		public function random():void
		{
			var nRandoms:int = width*height;
			if(!NumberUtil.isEven(nRandoms) || nRandoms < 2)
			{
				return;
			}
			
			var tmp:int = nRandoms;
			var arr:Array=[];
			while(tmp > 0)
			{
				arr.push(ITEM_EXIST);
				arr.push(ITEM_EXIST);
				tmp -= 2;
			}
			// shuffle the items
			ArrayUtil.shuffle(arr);
			
			for (var i:int = 0; i < width; i++) 
			{
				for (var j:int = 0; j < height; j++) 
				{
					array.set(i, j, arr[i*height+j]);
				}				
			}			
		}
		
		public function shuffleMap():void
		{
			
		}
		
		public function exportToString():String
		{
			var str:String = "";
			str += (width.toString() + "x" + height.toString() + "\n");
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					str += (String(array.get(j, i)) + ",");
				}			
				str = str.substring(0, str.length);
				str += "\n";
			}	
			trace(str);
			return str;
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
			
			width = w;
			height = h;
			array = new Array2(width, height);
			// default value was -1;
			for (var i:int = 0; i < height; i++) 
			{
				for (var j:int = 0; j < width; j++) 
				{
					array.set(j, i, int(arr[i*width + j]));
				}				
			}		
		}
		
		public function update():void
		{
			
		}
	}
}