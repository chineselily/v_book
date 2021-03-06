package loadermanager
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	import utils.functionCache;

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
			if(_dic[key]==null) _dic[key] = new functionCache();
			
			var cache:functionCache = _dic[key];
			cache.cacheFun(fun,param);
			
			return this;
		}
		
		public function apply(key:String, addParam:Array=null):void
		{
			var cache:functionCache = _dic[key];
			
			if(cache!=null) cache.apply(addParam);
		}
	}
}