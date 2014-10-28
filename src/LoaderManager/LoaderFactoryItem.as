package loadermanager
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import utils.functionCache;

	public class LoaderFactoryItem
	{
		private var _funCache:LoaderFactoryFunctionCache;
		
		private var _loaditem:LoadingItem;
		
		public function LoaderFactoryItem(_bLoader:BulkLoader, sPath:String)
		{
			_funCache = new LoaderFactoryFunctionCache();
			
			var obj:Object = {id:sPath, context:new LoaderContext(false,new ApplicationDomain())};		
			_loaditem = _bLoader.add(sPath,obj);
			_loaditem.addEventListener(Event.COMPLETE,complete);
			_loaditem.addEventListener(ProgressEvent.PROGRESS, progress);
			_loaditem.addEventListener(ErrorEvent.ERROR, error);
		}
		
		private function complete(evt:Event):void
		{
			var info:LoaderItemInfo = new LoaderItemInfo(_loaditem.id,_loaditem.content);
			LoaderFactoryLibrary.Instance().addAppliactionLib(_loaditem.id,info);
			_funCache.apply(LoaderFactoryFunctionCache.COMPLETE,[info]);
			removeListener(_loaditem);
		}
		
		private function progress(evt:ProgressEvent):void
		{
			_funCache.apply(LoaderFactoryFunctionCache.PROGRESS,[evt.bytesLoaded,evt.bytesTotal]);
		}
		
		private function error(evt:ErrorEvent):void
		{
			_funCache.apply(LoaderFactoryFunctionCache.ERROR);
			removeListener(_loaditem);
		}
		
		
		public function addCompleteFun(fun:Function,...params):LoaderFactoryItem
		{
			if(_loaditem.status == LoadingItem.STATUS_FINISHED)
			{
				functionCache.sapply(fun,params,[LoaderFactoryLibrary.Instance().getAppliactionLib(_loaditem.id)]);
			}
			else
				_funCache.cacheFun(LoaderFactoryFunctionCache.COMPLETE,fun,params);
			return this;
		}
		
		public function addProgressFun(fun:Function,...params):LoaderFactoryItem
		{
			_funCache.cacheFun(LoaderFactoryFunctionCache.PROGRESS,fun,params);
			return this;
		}
		
		public function addErrorFun(fun:Function, ...params):LoaderFactoryItem
		{
			if(_loaditem.status == LoadingItem.STATUS_ERROR)
				functionCache.sapply(fun,params);
			else
				_funCache.cacheFun(LoaderFactoryFunctionCache.ERROR,fun,params);
			return this;
		}
		
		private function removeListener(loaditem:LoadingItem):void
		{
			if(loaditem==null) return;
			loaditem.removeEventListener(Event.COMPLETE,complete);
			loaditem.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaditem.removeEventListener(ErrorEvent.ERROR, error);
		}
	}
}