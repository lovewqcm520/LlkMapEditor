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
		
		public var numTotalItems:int;
		public var numNormalItems:int;
		public var numToolItems:int;
		public var numStoneItems:int;
		
		public var numRefreshTool:int;
		public var numBombTool:int;
		public var numFindTool:int;
		
		public var totalTime:int;
		public var warningTime:int;
		
		private var actualWidth:int;
		private var actualHeight:int;

		public static var ITEM_EMPTY:int = -1;
		public static var ITEM_NORMAL:int = 1;
		public static var ITEM_TOOL:int = 2;
		public static var ITEM_STONE:int = -2;
		
		private var map:Array2;


		public function MapVO()
		{
			
		}
		
		public function clone():MapVO
		{
			var m:MapVO = new MapVO();
			m.name = this.name;
			m.level = this.level;
		    m.setMapSize(this.width, this.height);
			
			m.numTotalItems = this.numTotalItems;
			m.numToolItems = this.numToolItems;
			m.numNormalItems = this.numNormalItems;
			m.numStoneItems = this.numStoneItems;
			
			m.numRefreshTool = this.numRefreshTool;
			m.numBombTool = this.numBombTool;
			m.numFindTool = this.numFindTool;
			
			m.totalTime = this.totalTime;
			m.warningTime = this.warningTime;
			
			for (var x:int = 0; x < width; x++) 
			{
				for (var y:int = 0; y < height; y++) 
				{
					m.setItem(x, y, this.getItem(x, y));
				}				
			}	
			
			return m;
		}
		
		public function toString():String
		{
			return name;
		}
		
		public function setMapSize(w:int, h:int):void
		{
			width = w;
			height = h;
			actualWidth = w+2;
			actualHeight = h+2;
			map = new Array2(actualWidth, actualHeight);
			// default value was -1;
			for (var x:int = 0; x < actualWidth; x++) 
			{
				for (var y:int = 0; y < actualHeight; y++) 
				{
					map.set(x, y, ITEM_EMPTY);
				}				
			}		
			
			// update the items type collection
			updateItemsCollection();
		}
		
		public function getItem(x:int, y:int):int
		{
			if(x >=0 && x < width && y >= 0 && y < height)
			{
				return int(map.get(x+1, y+1));
			}
			
			return -2;
		}
		
		public function setItem(x:int, y:int, value:int):void
		{
			if(x >=0 && x < width && y >= 0 && y < height)
			{
				map.set(x+1, y+1, value);
				
				// update the items type collection
				updateItemsCollection();
			}
		}
		
		public function random(totalItems:int, toolItems:int, stoneItems:int):void
		{
			if(!NumberUtil.isEven(totalItems) || !NumberUtil.isEven(toolItems) || !NumberUtil.isEven(stoneItems))
			{
				return;
			}

			numTotalItems = totalItems;
			numToolItems = toolItems;
			numStoneItems = stoneItems;
			
			var arr:Array = new Array(width*height);			
			var len:int = arr.length;
			var k:int;
			for (k = 0; k < len; k++) 
			{
				arr[k] = ITEM_EMPTY;
			}			
			for (k = 0; k < toolItems; k++) 
			{
				arr[k] = ITEM_TOOL;
			}
			for (k = toolItems; k < toolItems+stoneItems; k++) 
			{
				arr[k] = ITEM_STONE;
			}
			for (k = toolItems+stoneItems; k < totalItems; k++) 
			{
				arr[k] = ITEM_NORMAL;
			}
			
			// shuffle the array
			ArrayUtil.shuffle(arr);
			
			for (var x:int = 0; x < width; x++) 
			{
				for (var y:int = 0; y < height; y++) 
				{
					map.set(x+1, y+1, arr[x*height+y]);
				}				
			}			
			
			// update the items type collection
			updateItemsCollection();
		}
		
		private function updateItemsCollection():void
		{
			var index:int;
			var totalItems:int=0;
			var normalItems:int=0;
			var toolItems:int=0;
			var stoneItems:int=0;
			for (var x:int = 0; x < width; x++) 
			{
				for (var y:int = 0; y < height; y++) 
				{
					index = int(map.get(x+1, y+1));
					if(index != ITEM_EMPTY)
						totalItems++;
					switch(index)
					{
						case ITEM_NORMAL:
						{
							normalItems++;
							break;
						}
						case ITEM_TOOL:
						{
							toolItems++;
							break;
						}
						case ITEM_STONE:
						{
							stoneItems++;
							break;
						}
					}
				}				
			}	
			
			numTotalItems = totalItems;
			numStoneItems = stoneItems;
		}
		
		public function exportToString():String
		{
			var str:String = "";
			for (var x:int = 0; x < actualHeight; x++) 
			{
				for (var y:int = 0; y < actualWidth; y++) 
				{
					str += (String(map.get(y, x)) + ",");
				}			
			}	
			str = str.substring(0, str.length-1);
			return str;
		}
		
		public function exportAsXML():XML
		{
			var str:String = exportToString();			
			warningTime = totalTime*0.85;
			
			var map:XML =
			<map name={name}
			level={level}
			width={width}
			height={height}
			actualWidth={actualWidth}
			actualHeight={actualHeight}
			numTotalItems={numTotalItems}
			numToolItems={numToolItems}
			numStoneItems={numStoneItems}
			numRefreshTool={numRefreshTool}
			numBombTool={numBombTool}
			numFindTool={numFindTool}
			totalTime={totalTime}
			warningTime={warningTime}
			data={str}/>;			
			
			return map;
		}
		
		public function importFromXML(x:XML):void
		{
			var data:String;
			
			name = 				x.attribute("name");
			level = 			x.attribute("level");
			width = 			x.attribute("width");
			height = 			x.attribute("height");
			actualWidth = 		x.attribute("actualWidth");
			actualHeight = 		x.attribute("actualHeight");
			numTotalItems =		x.attribute("numTotalItems");
			numToolItems = 		x.attribute("numToolItems");
			numStoneItems =	 	x.attribute("numStoneItems");
			numRefreshTool = 	x.attribute("numRefreshTool");
			numBombTool = 		x.attribute("numBombTool");
			numFindTool = 		x.attribute("numFindTool");
			totalTime = 		x.attribute("totalTime");
			warningTime = 		x.attribute("warningTime");
			data = 				x.attribute("data");
			
			// init the map data
			setMapSize(width, height);
			// set the item data
			var arr:Array = data.split(",");
			// default set all data
			for (var i:int = 0; i < actualHeight; i++) 
			{
				for (var j:int = 0; j < actualWidth; j++) 
				{
					map.set(j, i, int(arr[i*actualWidth + j]));
				}				
			}		
			// update the items type collection
			updateItemsCollection();
		}

		
	}
}