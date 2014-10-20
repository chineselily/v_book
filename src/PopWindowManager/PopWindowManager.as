package PopWindowManager
{
	import flash.utils.Dictionary;
	
	import LoaderManager.LoaderFactory;
	import LoaderManager.LoaderFactoryLibrary;
	import LoaderManager.LoaderItemInfo;
	
	import Trace.TraceManager;
	
	public class PopWindowManager
	{
		private static var _instance:PopWindowManager;
		private static const POPWINDOWGROUP:String = "popwindow_group";
		
		private var _dPopInfo:Dictionary;
		private var _openList:Array;
		private var _waitList:Array;
		
		
		
		public function PopWindowManager(_interal:PopWindowManagerInteral)
		{
			_dPopInfo = new Dictionary();
			_openList = new Array();
			_waitList = new Array();
		}
		
		public static function Instance():PopWindowManager
		{
			if(_instance==null) _instance = new PopWindowManager(new PopWindowManagerInteral());
			
			return _instance;
		}
		
		public function registPop(id:String, popWin:PopWindow, sPath:String):PopWindowData
		{
			_dPopInfo[id] = new PopWindowData(id,popWin,sPath);
			return _dPopInfo[id];
		}
		
		public function getPopInfo(id:String):PopWindowData
		{
			return _dPopInfo[id];
		}
		
		public function Open(id:String, aOpenParam:Array=null, aniType:int=PopWindowAni.ANI_TYPE_CENTER):void
		{
			if(_openList.indexOf(id)!=-1)
			{
				if(id!=PopWindowConst.LOADING)
					TraceManager.Instance().TraceOut("PopWindowManager_have opened_"+id,TraceManager.CLIENT);
				return;
			}
			var info:PopWindowData = _dPopInfo[id];
			if(info==null)
			{
				TraceManager.Instance().TraceOut("PopWindowManager_have not Regist_"+id,TraceManager.CLIENT);
				return;
			}
			if(_openList.length>0)
			{
				_waitList.push(id);
				return;
			}
			if(info.resPath!=null && LoaderFactoryLibrary.Instance().getAppliactionLib(info.id)==null)
			{
				LoaderFactory.Instance().addGroup(POPWINDOWGROUP,info.resPath)
					                    .addCompleteFun(loadResComplete,id)
										.addProgressFun(loadResProgress,id);
				Open(PopWindowConst.LOADING);
			}
		}
		
		private function loadResComplete(info:LoaderItemInfo, id:String):void
		{
			
		}
		
		private function loadResProgress(byteLoaded:Number, byteTotal:Number, id:String):void
		{
			
		}
		
		public function Close(id:String, aCloseParam:Array=null):void
		{
			
		}
	}
	
}
class PopWindowManagerInteral{}