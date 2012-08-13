package com.jack.util
{
	import com.jack.vo.MapVO;

	public class GameUtil
	{
		public function GameUtil()
		{
		}
		
		public static function isMapDataEqual(a:MapVO, b:MapVO):Boolean
		{
			if(a.name == b.name && 
			   a.level == b.level && 
			   a.width == b.width && 
			   a.height == b.height)
			{
				var w:int = a.width;
				var h:int = a.height;
				for (var i:int = 0; i < w; i++) 
				{
					for (var j:int = 0; j < h; j++) 
					{
						if(a.getItem(i,j) != b.getItem(i, j))
							return false;
					}
				}		
				
				return true;
			}
			
			return false;
		}
		
		
	}
}