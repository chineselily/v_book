package appconfig.window
{
	import flash.utils.Dictionary;

	public class windowCache
	{
		private static var _instance:windowCache;
		private var _dCache:Dictionary
		public function windowCache(interal:windowCacheInteral)
		{
			_dCache = new Dictionary();
		}
		public static function get Instance():windowCache
		{
			if(_instance==null) _instance = new windowCache(new windowCacheInteral());
			return _instance;
		}
		public function cache(list:XMLList):void
		{
			
		}
		public function windowPath(id:String):String
		{
			var info:windowInfo = _dCache[id];
			if(info!=null) return info.path;
			return null;
		}
		
	}
}
class windowCacheInteral{}
class windowInfo
{
	public var id:String;
	public var path:String; 
	public function windowInfo()
	{
		
	}
}