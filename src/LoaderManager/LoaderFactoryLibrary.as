package LoaderManager
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	import Trace.TraceManager;

	public class LoaderFactoryLibrary
	{
		private static var _instance:LoaderFactoryLibrary;
		
		private var _dicAppliactionLib:Dictionary;
		
		public function LoaderFactoryLibrary(_interal:LoaderFactoryLibrayInteral)
		{
			_dicAppliactionLib = new Dictionary();
		}
		
		public static function Instance():LoaderFactoryLibrary
		{
			if(_instance==null) _instance = new LoaderFactoryLibrary(new LoaderFactoryLibrayInteral());
			return _instance;
		}
		
		public function addAppliactionLib(domainName:String, itemInfo:LoaderItemInfo):void
		{
			if(_dicAppliactionLib[domainName]!=null)
			{
				TraceManager.Instance().TraceOut("loaderFactory_ApplicationDomain_already_exsit",TraceManager.CLIENT);
			}
			_dicAppliactionLib[domainName]=itemInfo;
		}
		
		public function getAppliactionLib(domainName:String):LoaderItemInfo
		{
			if(_dicAppliactionLib[domainName]!=null)
				return _dicAppliactionLib[domainName];
			return null;
		}
		
		public function getXML(name:String):XML
		{
			var iteminfo:LoaderItemInfo = _dicAppliactionLib[name];
			if(iteminfo!=null) return iteminfo.getXML();
			return null;
		}
		
		public function getBitmap(name:String):Bitmap
		{
			var iteminfo:LoaderItemInfo = _dicAppliactionLib[name];
			if(iteminfo!=null) return iteminfo.getBitmap();
			return null;
		}
		
		public function getMovieClip(name:String, domainName:String=null):MovieClip
		{
			var iteminfo:LoaderItemInfo;
			var mov:MovieClip = null;
			if(domainName==null)
			{
				for each(iteminfo in _dicAppliactionLib)
				{
					mov = iteminfo.getMovieclip(name);
					if(mov!=null) return mov;
				}
			}
			else
			{
				iteminfo = _dicAppliactionLib[domainName];
				if(iteminfo!=null) 
					mov = iteminfo.getMovieclip(name);
			}
			return mov;
		}
	}
}
class LoaderFactoryLibrayInteral{}