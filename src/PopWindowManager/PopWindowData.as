package PopWindowManager
{
	import flash.display.Shape;

	public class PopWindowData
	{
		private var _id:String;
		private var _winPath:String;
		private var _win:PopWindow;
		
		private var _mask:Shape;
		
		public function PopWindowData(id:String, win:PopWindow, path:String)
		{
			_id = id;
			_winPath = path;
			_win = win;
			
			_mask = new Shape();
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get resPath():String
		{
			return _winPath;
		}
		
		public function get popWin():PopWindow
		{
			return _win; 
		}
	}
}