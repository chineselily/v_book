package popwindowmanager
{
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
		
		private var _dPopInfo:Dictionary;
		private var _openList:Array;
		private var _waitList:Array;
		private var _waitDic:Dictionary;
		private var _dispathcer:AppDispatcher;
		
		public function PopWindowManager(_interal:PopWindowManagerInteral)
		{
			_dPopInfo = new Dictionary();
			_openList = new Array();
			_waitList = new Array();
			_waitDic = new Dictionary();
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
			if(bcrash && _waitList.indexOf(id)==-1)
			{//现在不能打开
				_waitList.push(id);
				_waitDic[id]={param:aOpenParam,winobj:winObj};
				return info.win;
			}
			
			if(_waitList.indexOf(id)!=-1)
			{
				_waitList.splice(_waitList.indexOf(id),1);
			}
			info = PopWindowCompOpenCrash.popData(info);
			_openList.push(info);
			
			/*if(info.resStatus==0 && !info.isNoRes && LoaderFactoryLibrary.Instance().getAppliactionLib(info.resPath)==null)
			{//未加载资源
				//Open(ViewConst.Loading,[info.id]);
				info.resStatus=1;
				_dispathcer.dispatchEvent(new LoadingEvent(LoadingEvent.OPEN,[id]));
				LoaderFactory.Instance().addGroup(POPWINDOWGROUP,info.resPath)
					                    .addCompleteFun(loadResComplete,info.id,aOpenParam,winObj)
										.addProgressFun(loadResProgress,info.id);
				return info.win;
			}
			else if(info.resStatus==0 && info.isNoRes)
			{
				initImp(id);
			}*/
			info.win.loadRes(loadResProgress,[info.id],loadResComplete,[info.id,aOpenParam,winObj],OpenImp,[info, aOpenParam, winObj]);
			//OpenImp(info, aOpenParam, winObj);
			return info.win;
		}
		
		private function OpenImp(info:PopWindowData, aOpenParam:Array=null, winObj:Object=null):void
		{
			info.win.Open(aOpenParam);
			
			var x:Number = winObj==null?0:winObj[x];
			var y:Number = winObj==null?0:winObj[y];
			info.win.x=x; info.win.y=y;
			info.win.visible=true;
			info.container.addChild(info.win);
	
			PopWindowCompAni.winOpenAni(info.win,info.container,info.aniType, callback);
			function callback():void
			{
				info.win.onOpenComplete(aOpenParam);
			}
		}
		//arrComplete中的内容顺序是：【id:String, aOpenParam:Array=null, winObj:Object=null】
		private function loadResComplete(info:LoaderItemInfo, arrComplete:Array):void
		{
			_dispathcer.dispatchEvent(new LoadingEvent(LoadingEvent.CLOSE));
			
			var winData:PopWindowData = getOpenInfo(arrComplete[0]);
			winData.win.initial();
			
			OpenImp(winData, arrComplete[1], arrComplete[2]);
		}

		private function loadResProgress(byteLoaded:Number, byteTotal:Number, id:String):void
		{
			//traceManager.Instance().TraceOut("PopWindowManager_load progress_loaded_total"+byteLoaded+" "+byteTotal,traceManager.CLIENT);
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
			var index:int = _openList.indexOf(info);
			if(index==-1) return;
			_openList.splice(_openList.indexOf(info),1);
			
			info.win.Close(aCloseParam);
			info.win.visible=false;
			info.container.removeChild(info.win);

		}
	}
	
}
class PopWindowManagerInteral{}