package popwindowmanager
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import event.LoadingEvent;
	
	import loadermanager.LoaderFactory;
	import loadermanager.LoaderFactoryLibrary;
	import loadermanager.LoaderItemInfo;
	
	import mediator.AppDispatcher;
	
	import view.PopWindow;
	
	import vtrace.traceManager;
	
	public class PopWindowManager
	{
		private static var _instance:PopWindowManager;
		private static const POPWINDOWGROUP:String = "popwindow_group";
		
		private var _dPopInfo:Dictionary;
		private var _openList:Array;
		private var _waitList:Array;
		private var _container:Sprite;
		private var _dispathcer:AppDispatcher;
		
		public function PopWindowManager(_interal:PopWindowManagerInteral)
		{
			_dPopInfo = new Dictionary();
			_openList = new Array();
			_waitList = new Array();
			_dispathcer = AppDispatcher.Instance;
		}
		
		public static function Instance():PopWindowManager
		{
			if(_instance==null) _instance = new PopWindowManager(new PopWindowManagerInteral());
			
			return _instance;
		}
		
		public function registPop(id:String, popWin:Class, layer:int, popType:int, aniType:int):PopWindowData
		{
			_dPopInfo[id] = new PopWindowData(id,popWin,layer,aniType,popType);
			return _dPopInfo[id];
		}
		
		public function getPopInfo(id:String):PopWindowData
		{
			return _dPopInfo[id];
		}
		
		public function Open(id:String, aOpenParam:Array=null, winObj:Object=null):PopWindow
		{
			var info:PopWindowData = _dPopInfo[id];
			if(info==null)
			{//没有注册信息
				traceManager.Instance().TraceOut("PopWindowManager_have not Regist_"+id,traceManager.CLIENT);
				return null;
			}
			var bcrash:Boolean = PopWindowCompOpenCrash.crash(info,_openList);
			if(bcrash)
			{//现在不能打开
				_waitList.push(id);
				return info.win;
			}
			
			if(_waitList.indexOf(id)!=-1) _waitList.splice(_waitList.indexOf(id),1);
			info = PopWindowCompOpenCrash.popData(info);
			_openList.push(info);
			
			if(info.resPath!=null && info.resPath!=""
			&& LoaderFactoryLibrary.Instance().getAppliactionLib(info.resPath)==null)
			{//未加载资源
				//Open(ViewConst.Loading,[info.id]);
				_dispathcer.dispatchEvent(new LoadingEvent(LoadingEvent.OPEN,[id]));
				LoaderFactory.Instance().addGroup(POPWINDOWGROUP,info.resPath)
					                    .addCompleteFun(loadResComplete,info.id,aOpenParam,winObj)
										.addProgressFun(loadResProgress,info.id);
				return info.win;
			}
			
			OpenImp(info, aOpenParam, winObj);
			return info.win;
		}
		
		private function OpenImp(info:PopWindowData, aOpenParam:Array=null, winObj:Object=null):void
		{
			info.win.Open(aOpenParam);
			
			PopWindowCompAni.winOpenAni(info,info.container,winObj);
		}
		
		private function loadResComplete(info:LoaderItemInfo, id:String, aOpenParam:Array=null, winObj:Object=null):void
		{
			var winData:PopWindowData = getOpenInfo(id);
			winData.win.initial();
			_dispathcer.dispatchEvent(new LoadingEvent(LoadingEvent.CLOSE));
			OpenImp(winData, aOpenParam, winObj);
		}
		
		private function loadResProgress(byteLoaded:Number, byteTotal:Number, id:String):void
		{
			traceManager.Instance().TraceOut("PopWindowManager_load progress_loaded_total"+byteLoaded+" "+byteTotal,traceManager.CLIENT);
			_dispathcer.dispatchEvent(new LoadingEvent(LoadingEvent.UPDATE,[byteLoaded, byteTotal, id]));
		}
		
		private function getOpenInfo(id:String):PopWindowData
		{
			for each(var opened:PopWindowData in _openList)
			{
				if(opened.id == id) return opened;
			}
			return null;
		}
		
		public function Close(id:String, aCloseParam:Array=null):void
		{
			var info:PopWindowData = getOpenInfo(id);
			if(_openList.indexOf(info)==-1) return;
			_openList.splice(_openList.indexOf(info),1);
			
			info.win.Close(aCloseParam);
			_container.removeChild(info.win);
		}
	}
	
}
class PopWindowManagerInteral{}