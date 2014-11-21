package appconfig.book
{
	import flash.utils.Dictionary;

	public class bookConfigCache
	{
		private static var _dBookConfig:Dictionary = new Dictionary();
		private static var _arrBookId:Array=[];
		public function bookConfigCache()
		{
		}
		
		public static function parseBookResConfig(xml:XML):void
		{
			var book:bookConfig
			for each(var xmlelem:XML in xml.book.info)
			{
				book = new bookConfig();
				book.parsexml(xmlelem);
				_dBookConfig[book.id] = book;
				_arrBookId.push(book.id);
			}
		}
		
		public static function get arrBookId():Array
		{
			return _arrBookId;
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
	public var width:int;
	public var height:int;
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
		width = xml.@width;
		height = xml.@height;
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