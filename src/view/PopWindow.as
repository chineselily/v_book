package view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	import appconfig.app.ProjectStage;
	
	import loadermanager.LoaderFactory;
	import loadermanager.LoaderFactoryLibrary;
	import loadermanager.LoaderItemInfo;
	
	import popwindowmanager.PopWindowData;
	
	public class PopWindow extends Sprite
	{
		private var _popData:PopWindowData;
		private var _mask:Shape;
		protected var _resStatus:int;
		protected var _loadLibrary:LoaderFactoryLibrary;
		protected var _loadInfo:LoaderItemInfo;
		protected var _skin:DisplayObjectContainer;
		protected static const POPWINDOWGROUP:String = "popwindow_group";
		
		public function PopWindow()
		{
			super();
			_mask = null;
			_skin = null;
			_resStatus=0;
			_loadLibrary = LoaderFactoryLibrary.Instance();
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
				var clazz:String = getQualifiedClassName(this);
				var arr:Array = clazz.split("::");
				var skinName:String = arr[arr.length-1]+"_mc";
				
				_loadInfo = _popData.isNoRes?null:_loadLibrary.getAppliactionLib(_popData.resPath);
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
		
		public function onOpenComplete(params:Array):void
		{
			
		}
		
		public function Close(params:Array):void
		{
			
		}
		
		public function createMask(color:uint=0,alpha:Number=0.5):void
		{
			if(_mask==null) _mask = new Shape();
			
			var rect:Rectangle = stageRect;
			_mask.graphics.clear();
			_mask.graphics.beginFill(color,alpha);
			_mask.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
			_mask.graphics.endFill();
			
			this.addChildAt(_mask,0);
		}
		
		private function get stageRect():Rectangle
		{
			return new Rectangle(ProjectStage.x,ProjectStage.y,ProjectStage.width,ProjectStage.height+ProjectStage.TOOLHEIGHT);
		}
		
		public function loadRes(progressFun:Function, progressParam:Array, loadcompleteFun:Function, loadcompleteParam:Array, completeFun:Function, completeParam:Array):void
		{
			if(_popData.isNoRes)
			{
				callComplete();
				return;
			}
			
			if(_loadLibrary.getAppliactionLib(_popData.resPath)==null)
			{
				if(_resStatus!=1)
				{
					_resStatus=1;
					LoaderFactory.Instance().addGroup(POPWINDOWGROUP,_popData.resPath)
						.addProgressFun(progressFun, progressParam)
						.addCompleteFun(loadcompleteFun, loadcompleteParam);
				}
				else
					callComplete();
			}
			else
				callComplete();
			
			function callComplete():void
			{
				if(completeFun!=null)
					completeFun.apply(null,completeParam);
			}
		}
	}
}