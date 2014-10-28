package utils
{
	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class alignTool
	{
		public static const TOP:String = StageAlign.TOP;//y轴顶对齐，x轴居中对齐
		public static const BOTTOM:String = StageAlign.BOTTOM;//y轴底对齐，x轴居中对齐
		public static const LEFT:String = StageAlign.LEFT;//y轴居中对齐，x轴左对齐
		public static const RIGHT:String = StageAlign.RIGHT;//y轴居中对齐，x轴右对齐
		public static const TOP_LEFT:String = StageAlign.TOP_LEFT;//y轴顶对齐，x轴左对齐
		public static const TOP_RIGHT:String = StageAlign.TOP_RIGHT;//y轴顶对齐，x轴右对齐
		public static const BOTTOM_LEFT:String = StageAlign.BOTTOM_LEFT;//y轴底对齐，x轴左对齐
		public static const BOTTOM_RIGHT:String = StageAlign.BOTTOM_RIGHT;//y轴底对齐，x轴右对齐
		public static const MIDDLE:String = "MIDDLE_MIDDLE";//y轴居中对齐，x轴居中对齐

		public function alignTool()
		{
		}
		
		public static function alignDisplayobjects(objStandard:DisplayObject, objChange:DisplayObject, align:String):Point
		{
			var point:Point = new Point();
			if(objStandard==null || objChange==null) return point;
			
			var rectS:Rectangle = objStandard.getBounds(objStandard);
			var rectC:Rectangle = objChange.getBounds(objChange);
			
			var x:Number = xValue(rectS.x,rectS.width,rectC.x,rectC.width,align,objStandard.scaleX,objChange.scaleY);
			var y:Number = yValue(rectS.y,rectS.height,rectC.y,rectC.height,align,objStandard.scaleY,objChange.scaleY);
			
			point.x=x; point.y=y;
			return point;
		}
		
		public static function alginRect(rectStandard:Rectangle, objChange:DisplayObject, align:String):Point
		{
			var point:Point = new Point();
			if(rectStandard==null || objChange==null) return point;
			
			var rectS:Rectangle = rectStandard;
			var rectC:Rectangle = objChange.getBounds(objChange);
			
			var x:Number = xValue(rectS.x,rectS.width,rectC.x,rectC.width,align,1,objChange.scaleY);
			var y:Number = yValue(rectS.y,rectS.height,rectC.y,rectC.height,align,1,objChange.scaleY);
			
			point.x=x; point.y=y;
			return point;
		}
		
		private static function xValue(xs:Number,ws:Number,xc:Number,wc:Number,align:String, ss:Number=1,cs:Number=1):Number
		{
			var aLeft:Array = [LEFT,TOP_LEFT,BOTTOM_LEFT];
			var aRight:Array = [RIGHT,TOP_RIGHT,BOTTOM_RIGHT];
			var aMid:Array = [TOP,BOTTOM,MIDDLE];
			
			if(aLeft.indexOf(align)!=-1) return pLeft(xs,ss)-pLeft(xc,cs);
			if(aMid.indexOf(align)!=-1) return pMid(xs,ws,ss)-pMid(xc,wc,cs);
			if(aRight.indexOf(align)!=-1) return pRight(xs,ws,ss)-pRight(xc,wc,cs);
			
			return 0;
		}
		
		private static function yValue(ys:Number,hs:Number,yc:Number,hc:Number,align:String, ss:Number=1,cs:Number=1):Number
		{
			var aTop:Array = [TOP,TOP_LEFT,TOP_RIGHT];
			var aBottom:Array = [BOTTOM,BOTTOM_LEFT,BOTTOM_RIGHT];
			var aMid:Array = [LEFT,RIGHT,MIDDLE];
			
			if(aTop.indexOf(align)!=-1) return pLeft(ys,ss)-pLeft(yc,cs);
			if(aMid.indexOf(align)!=-1) return pMid(ys,hs,ss)-pMid(yc,hc,cs);
			if(aBottom.indexOf(align)!=-1) return pRight(ys,hs,ss) - pRight(yc,hc,cs);
			
			return 0;
		}
		
		private static function pLeft(pLeft:Number, pscale:Number):Number
		{
			return pLeft*pscale;
		}
		
		private static function pMid(pLeft:Number, pWidth:Number, pscale:Number):Number
		{
			return (pWidth/2+pLeft)*pscale;
		}
		
		private static function pRight(pLeft:Number, pWidth:Number, pscale:Number):Number
		{
			return (pWidth+pLeft)*pscale;
		}
	}
}