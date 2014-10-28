package popwindowmanager
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	
	import appconfig.app.ProjectStage;
	
	import utils.aniTool;
	import utils.drawTool;

	public class PopWindowCompAni
	{
		public function PopWindowCompAni()
		{
		}
		public static function winOpenAni(winData:PopWindowData, container:DisplayObjectContainer,winObj:Object=null):void
		{
			if(winData==null) return;
			var x:Number = winObj==null?0:winObj[x];
			var y:Number = winObj==null?0:winObj[y];
			winData.win.x=x; winData.win.y=y;
			
			if(winData.aniType == PopWindowConst.ANI_TYPE_NONE) return;
			var bitmap:Bitmap = drawTool.draw(winData.win);
			bitmap.scaleX=bitmap.scaleY=0.1;
			container.addChild(bitmap);
			winData.win.visible=false;
			var toObj:Object;
			if(winData.aniType == PopWindowConst.ANI_TYPE_CENTER)
			{
				bitmap.x = ProjectStage.WIDTH/2; bitmap.y = ProjectStage.HEIGHT/2;
				toObj = {x:winData.win.x,y:winData.win.y,scaleX:1,scaleY:1, onComplete:aniComplete, onCompleteParams:[winData, bitmap, container]};
				utils.aniTool.Instance().to(bitmap,1,toObj);
			}
			else if(winData.aniType == PopWindowConst.ANI_TYPE_LEFTTOP)
			{
				bitmap.x+=x;
				bitmap.y+=y;
				toObj={scaleX:1,scaleY:1,onComplete:aniComplete, onCompleteParams:[winData, bitmap, container]};
				utils.aniTool.Instance().to(bitmap,1,toObj);
			}
		}
		
		private static function aniComplete(winData:PopWindowData,bitmap:Bitmap, container:DisplayObjectContainer):void
		{
			winData.win.visible=true;
			container.removeChild(bitmap);
			bitmap.bitmapData.dispose();
			bitmap=null;
		}
	}
}