package loadermanager
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import utils.functionCache;

	public class LoaderFactory
	{
		private static var _instance:LoaderFactory;
		private static const DEFAULTGROUPNAME:String="defaultgroup";
		private static const DEFAULTPATHNAME:String = "defaultpath";
		
		private var _dicBloader:Dictionary;
		private var _dicFactoryItem:Dictionary;
		private var _dicCacheFun:Dictionary;
		
		public function LoaderFactory(_interal:loaderfactoryinteral)
		{
			_dicBloader = new Dictionary();
			_dicFactoryItem = new Dictionary();
			_dicCacheFun = new Dictionary();
		}
		
		public static function Instance():LoaderFactory
		{
			if(_instance==null) _instance = new LoaderFactory(new loaderfactoryinteral());
			
			return _instance;
		}
		
		public function addGroup(sGroup:String, sPath:String, obj:Object=null):LoaderFactoryItem
		{
			var _bloader:BulkLoader = _dicBloader[sGroup];
			
			if(_bloader==null) 
			{
				_bloader = _dicBloader[sGroup] = new BulkLoader(sGroup);
				_bloader.addEventListener(BulkProgressEvent.COMPLETE, onComplete);
				_bloader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
				_bloader.addEventListener("error", onError);
			}
			
			if(_dicFactoryItem[formKey(sGroup,sPath)]==null)
				_dicFactoryItem[formKey(sGroup,sPath)] = new LoaderFactoryItem(_bloader,sPath, obj);
			
			if(!_bloader.isRunning) _bloader.start();
			
			return _dicFactoryItem[formKey(sGroup,sPath)];
		}
		
		public function addGroupComplete(sGroup:String, fun:Function, ...params):LoaderFactory
		{
			var _bloader:BulkLoader = _dicBloader[sGroup];
			if(_bloader && _bloader.isFinished)
				functionCache.sapply(fun,params);
			else
				getFunCache(sGroup).cacheFun(LoaderFactoryFunctionCache.COMPLETE,fun,params);
			
			return this;
		}
		
		public function addGroupProgress(sGroup:String, fun:Function, ...params):LoaderFactory
		{
			getFunCache(sGroup).cacheFun(LoaderFactoryFunctionCache.PROGRESS,fun,params);
			
			return this;
		}
		
		public function addGroupError(sGroup:String, fun:Function, ...params):LoaderFactory
		{
			getFunCache(sGroup).cacheFun(LoaderFactoryFunctionCache.ERROR,fun,params);
			
			return this;
		}
		
		private function onComplete(evt:Event):void
		{
			var curTarget:BulkLoader = evt.currentTarget as BulkLoader;
			getFunCache(curTarget.name).apply(LoaderFactoryFunctionCache.COMPLETE);
			removeListener(curTarget);
		}
		
		private function onProgress(evt:ProgressEvent):void
		{
			var curTarget:BulkLoader = evt.currentTarget as BulkLoader;
			getFunCache(curTarget.name).apply(LoaderFactoryFunctionCache.PROGRESS);
		}
		
		private function onError(evt:flash.events.ErrorEvent):void
		{
			var curTarget:BulkLoader = evt.currentTarget as BulkLoader;
			getFunCache(curTarget.name).apply(LoaderFactoryFunctionCache.ERROR);
			removeListener(curTarget);
		}
		
		private function getFunCache(sGroup:String):LoaderFactoryFunctionCache
		{
			if(sGroup==null) sGroup = DEFAULTGROUPNAME;
			
			if(_dicCacheFun[sGroup]==null) _dicCacheFun[sGroup] = new LoaderFactoryFunctionCache();
			
			return _dicCacheFun[sGroup];
		}
		
		private function removeListener(loader:BulkLoader):void
		{
			if(loader==null) return;
			loader.removeEventListener(BulkProgressEvent.COMPLETE, onComplete);
			loader.removeEventListener(BulkProgressEvent.PROGRESS, onProgress);
			loader.removeEventListener("error", onError);
		}
		
		private function formKey(sGroup:String, sPath:String):String
		{
			if(sGroup==null) sGroup=DEFAULTGROUPNAME;
			if(sPath==null) sPath=DEFAULTPATHNAME;
			
			return sGroup+"_"+sPath;
		}
	}
}
class loaderfactoryinteral{}