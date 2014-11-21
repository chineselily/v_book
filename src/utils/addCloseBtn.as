package utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import component.button;
	
	import loadermanager.LoaderFactoryLibrary;

	public class addCloseBtn
	{
		public function addCloseBtn()
		{
		}
		
		public static function addClose(con:DisplayObjectContainer, clickCall:Function, offset:Point=null,align:String=alignTool.TOP_RIGHT):void
		{
			var mc:MovieClip = LoaderFactoryLibrary.Instance().getMovieClip("close_mc");
			var point:Point = alignTool.alignDisplayobjects(con,mc,align);
			mc.x=point.x + (offset==null?0:offset.x);
			mc.y=point.y + (offset==null?0:offset.y);
			con.addChild(mc);
			var btn:button = new button(mc);
			btn.addEventListener(MouseEvent.CLICK, onclick);
			
			function onclick(event:MouseEvent):void
			{
				if(clickCall!=null)
					clickCall();
			}
		}
	}
}