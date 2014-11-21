package appconfig.window
{
	import flash.utils.Dictionary;
	
	import appconfig.app.ProjectConst;

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
		public function cache(xml:XML):void
		{
			var xmlelem:XML;
			var winInfo:windowInfo;
			for each(xmlelem in xml.first.info)
			{
				winInfo = new windowInfo(xmlelem);
				_dCache[winInfo.id]=winInfo;
			}
		}
		public function windowPath(id:String):String
		{
			var info:windowInfo = _dCache[id];
			if(info!=null) return ProjectConst.serverPath+info.path;
			return null;
		}
	}
}
class windowCacheInteral{}
class windowInfo
{
	public var id:String;
	public var path:String; 
	public function windowInfo(xml:XML)
	{
		id = xml.@id;
		path = xml.@path;
	}
}