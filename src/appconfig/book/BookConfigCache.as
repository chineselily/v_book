package appconfig.book
{
	import flash.utils.Dictionary;

	public class BookConfigCache
	{
		private static var _dBookConfig:Dictionary = new Dictionary();
		public function BookConfigCache()
		{
		}
		
		public static function parseBookResConfig(xmllist:XMLList):void
		{
			var book:bookConfig
			for each(var xml:XML in xmllist)
			{
				book = new bookConfig();
				book.parsexml(xml);
				_dBookConfig[book.id] = book;
			}
		}
		
		public static function pngPath(id:String):String
		{
			var book:bookConfig = _dBookConfig[id];
			if(book) return book.ppath;
			return "no_book";
		}
		
		public static function bookPath(id:String):String
		{
			var book:bookConfig = _dBookConfig[id];
			if(book) return book.bpath;
			return "no_book";
		}
	}
}
import appconfig.app.ProjectConst;

class bookConfig
{
	public var id:String;
	public var page:int;
	public var index:int;
	private var _bpath:String;
	private var _ppath:String;
	
	public function bookConfig()
	{
		id="no name";
	}
	public function parsexml(xml:XML):void
	{
		id = xml.@id;
		page = xml.@page;
		index = xml.@index;
		_bpath = xml.@bpath;
		_ppath = xml.@ppath;
	}
	
	public function get bpath():String
	{
		return ProjectConst.bookswf_path+_bpath;
	}
	
	public function get ppath():String
	{
		return ProjectConst.bookpng_path+_ppath;
	}
}