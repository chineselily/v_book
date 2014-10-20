package LoaderManager
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	import utils.FunctionCache;

	public class LoaderFactoryFunctionCache
	{
		public static const COMPLETE:String = Event.COMPLETE;
		public static const PROGRESS:String = ProgressEvent.PROGRESS;
		public static const ERROR:String = ErrorEvent.ERROR;
		
		private var _dic:Dictionary;
		public function LoaderFactoryFunctionCache()
		{
			_dic = new Dictionary();
		}
		
		public function cacheFun(key:String, fun:Function, param:Array):LoaderFactoryFunctionCache
		{
			if(_dic[key]==null) _dic[key] = new FunctionCache();
			
			var cache:FunctionCache = _dic[key];
			cache.cacheFun(fun,param);
			
			return this;
		}
		
		public function concatLoadInfo(key:String, info:LoaderItemInfo):void
		{
			var cache:FunctionCache = _dic[key];
			if(cache==null) return;
			
			var arrFun:Array = cache.getArrFun();
			if(arrFun==null) return;
			
			for(var i:int=0;i<arrFun.length;i+=1)
			{
				var arrParam:Array = cache.getFunArrParam(arrFun[i]);
				if(arrParam!=null) arrParam.unshift(info);
			}
		}
		
		public function apply(key:String):void
		{
			var cache:FunctionCache = _dic[key];
			
			if(cache!=null) cache.apply();
		}
		
		public function getCache(key:String):FunctionCache
		{
			var cache:FunctionCache = _dic[key];
			return cache;
		}
	}
}