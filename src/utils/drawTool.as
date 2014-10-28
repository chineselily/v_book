package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class drawTool
	{
		public function drawTool()
		{
		}
		
		public static function draw(source:DisplayObject,scale:Number=1,transparent:Boolean=true,fillColor=0x00000000):Bitmap
		{
			var bitmap:Bitmap = new Bitmap();
			if(source==null) return bitmap;
			
			var rect:Rectangle = source.getBounds(source);
			if(rect.width<1 ) rect.width=1;
			if(rect.height<1) rect.height=1;
			
			var bitmapData:BitmapData = new BitmapData(Math.ceil(rect.width*scale),Math.ceil(rect.height*scale),transparent,fillColor);
			bitmapData.draw(source,new Matrix(scale,0,0,scale,rect.x,rect.y));
			bitmap.bitmapData = bitmapData;
			bitmap.x = rect.x;
			bitmap.y = rect.y;
			bitmap = clearWhiteArea(bitmap);
			return bitmap;
		}
		
		private static function clearWhiteArea(source:Bitmap):Bitmap
		{
			var bitmapData:BitmapData;
			var sourceData:BitmapData = source.bitmapData;
			var rect:Rectangle = sourceData.getColorBoundsRect(0xff000000,0x00000000,false);
			if(rect!=null && !rect.isEmpty() && (rect.width!=source.width || rect.height!=source.height))
			{
				bitmapData = new BitmapData(rect.width,rect.height,true,0x0);
				bitmapData.copyPixels(sourceData,rect,new Point(0,0));
				sourceData.dispose();
				source.x += rect.x;
				source.y += rect.y;
				source.bitmapData = bitmapData;
			}
			return source;
		}
	}
}