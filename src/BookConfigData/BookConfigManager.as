package BookConfigData
{
	import flash.utils.Dictionary;

	public class BookConfigManager
	{
		private static var _instance:BookConfigManager;
		private var _dBookRes:Dictionary;
		
		public function BookConfigManager(_interal:BookDataManagerinteral)
		{
			_dBookRes = new Dictionary();	
		}
		
		public static function Instance():BookConfigManager
		{
			if(_instance==null) _instance = new BookConfigManager(new BookDataManagerinteral());
			
			return _instance;
		}
		
		public function parseBookResConfig(xmllist:XMLList):void
		{
			var book:BookResConfigData
			for each(var xml:XML in xmllist)
			{
				book = new BookResConfigData();
				book.parsexml(xml);
				_dBookRes[book.id] = book;
			}
		}
		
/*		private function addBook(book:BookResConfigData):void
		{
			if(book==null) return;
			var arr:Array = _arrBookResConfiglist[book.page];
			arr ==null? new Array():arr;
			arr.push(book);
		}
		
		private function sortBookList(arrBook:Array):void
		{
			if(arrBook==null || arrBook.length<2) return;
			
			arrBook.sort("index",Array.NUMERIC);
		}*/
	}
}
class BookDataManagerinteral{}