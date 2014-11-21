package popwindowmanager
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import appconfig.app.ProjectStage;
	
	import utils.alignTool;
	import utils.aniTool;
	import utils.drawTool;

	public class PopWindowCompAni
	{
		public function PopWindowCompAni()
		{
		}
		public static function winOpenAni(dis:DisplayObject, container:DisplayObjectContainer,aniType:int,callback:Function=null):void
		{
			if(dis==null) return;
			var pointc:Point;
			
			if(aniType == PopWindowConst.ANI_TYPE_CENTER)
			{
				pointc = alignTool.alginRect(new Rectangle(0,0,ProjectStage.width,ProjectStage.height),dis,alignTool.MIDDLE);
			}
			else if(aniType == PopWindowConst.ANI_TYPE_LEFTTOP)
			{
				pointc = alignTool.alginRect(new Rectangle(0,0,ProjectStage.width,ProjectStage.height),dis,alignTool.TOP_LEFT);
			}
			else if(aniType == PopWindowConst.ANI_TYPE_BOTTOM)
			{
				pointc = alignTool.alginRect(new Rectangle(0,0,ProjectStage.WIDTH,ProjectStage.HEIGHT+ProjectStage.TOOLHEIGHT),dis,alignTool.BOTTOM);
			}
			if(pointc==null)
			{
				dis.visible=true;
				callback();
			}
			else
			{
				var bitmap:Bitmap = drawTool.draw(dis);
				container.addChild(bitmap);
				dis.visible=false;
				
				var endx:Number = pointc.x+bitmap.x;
				var endy:Number = pointc.y+bitmap.y;
				
				dis.x = pointc.x; dis.y=pointc.y;
				
				bitmap.x=endx+bitmap.width/2;bitmap.y=endy+bitmap.height/2;
				bitmap.scaleX=bitmap.scaleY=0.1;
				
				var toObj:Object = {x:endx,y:endy,scaleX:1,scaleY:1, onComplete:aniComplete, onCompleteParams:[dis, bitmap, container,callback]};
				utils.aniTool.to(bitmap,0.5,toObj);
			}
		}
		
		private static function aniComplete(dis:DisplayObject,bitmap:Bitmap, container:DisplayObjectContainer,callback:Function):void
		{
			dis.visible=true;
			container.removeChild(bitmap);
			bitmap.bitmapData.dispose();
			bitmap=null;
			if(callback!=null) 
				callback();
		}
	}
}