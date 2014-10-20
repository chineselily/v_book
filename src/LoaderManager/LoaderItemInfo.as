package LoaderManager
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;

	public class LoaderItemInfo
	{
		private var _content:*;
		private var _key:String;
		public function LoaderItemInfo(key:String, content:*)
		{
			_key = key;
			_content = content;
		}
		
		public function getClass(name:String):Class
		{	
			if(_content!=null && (_content is DisplayObject))
			{
				var loadinfo:LoaderInfo = (_content as DisplayObject).loaderInfo;
				if(loadinfo.applicationDomain.hasDefinition(name)) 
					return loadinfo.applicationDomain.getDefinition(name) as Class;
			}
			return null;
		}
		
		public function getXML():XML
		{
			if(_content!=null && _content is XML)
				return XML(_content);
			return null;
		}
		
		public function getBitmap():Bitmap
		{
			if(_content!=null && _content is Bitmap)
				return Bitmap(_content);
			return null;
		}
		
		public function getMovieclip(name:String):MovieClip
		{
			var cls:Class = getClass(name);
			if(cls!=null) return new cls();
			
			return null;
		}
		
		public function getDisplayobject():DisplayObject
		{
			if(_content!=null && _content is DisplayObject)
				return _content as DisplayObject;
			return null;
		}
	}
}