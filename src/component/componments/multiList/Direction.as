package component.componments.multiList
{
	public class Direction
	{
		public static const NORTH:int = 1;
		public static const EAST:int = 2;
		public static const SOUTH:int = 4;
		public static const WEST:int = 8;
		public static const NORTHEAST:int = 3;
		public static const SOUTHEAST:int = 6;
		public static const SOUTHWEST:int = 12;
		public static const NORTHWEST:int = 9;
		
		/**
		 * 9(NORTHWEST)		1(NORTH)	3(NORTHEAST)
		 * 8(WEST)			CENTER		2(EAST)
		 * 12(SOUTHWEST)	4(SOUTH)	6(SOUTHEAST)
		 */
		
		public static const TOP:String		  = "top";
		public static const BOTTOM:String     = "bottom";
		public static const LEFT:String 	  = "left";
		public static const RIGHT:String      = "right";
		public static const AUTO:String       = "auto";
		
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String   = "vertical";
	}
}