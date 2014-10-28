package view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedSuperclassName;
	
	import appconfig.app.ProjectStage;
	
	import loadermanager.LoaderFactoryLibrary;
	import loadermanager.LoaderItemInfo;
	
	import popwindowmanager.PopWindowData;
	
	public class PopWindow extends Sprite
	{
		private var _popData:PopWindowData;
		private var _mask:Shape;
		protected var _loadLibrary:LoaderFactoryLibrary;
		protected var _loadInfo:LoaderItemInfo;
		protected var _skin:DisplayObjectContainer;
		
		public function PopWindow()
		{
			super();
			_mask = null;
			_skin = null;
		}
		
		public function set popData(data:PopWindowData):void
		{
			_popData = data;
		}
		public function get popData():PopWindowData
		{
			return _popData;
		}
		
		public function initial():void
		{
			if(_skin==null);
			{
				var clazz:String = getQualifiedSuperclassName(this);
				var arr:Array = clazz.split("::");
				var skinName:String = arr[arr.length-1]+"_mc";
				
				_loadInfo = _loadLibrary.getAppliactionLib(_popData.resPath);
				if(_loadInfo!=null) setSkin(_loadInfo.getMovieclip(skinName));
				
				
				initialData();//重载
			}
		}
		
		protected function initialData():void
		{
			
		}
		
		protected function setSkin(res:MovieClip):void
		{
			_skin=res;
			this.addChild(_skin);
		}
		
		public function Open(params:Array):void
		{
			
		}
		
		public function Close(params:Array):void
		{
			
		}
		
		public function createMask():void
		{
			if(_mask==null) _mask = new Shape();
			
			var rect:Rectangle = stageRect;
			_mask.graphics.clear();
			_mask.graphics.beginFill(0,0.5);
			_mask.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
			_mask.graphics.endFill();
			
			this.addChildAt(_mask,0);
		}
		
		private function get stageRect():Rectangle
		{
			return new Rectangle(ProjectStage.x,ProjectStage.y,ProjectStage.width,ProjectStage.height);
		}
	}
}