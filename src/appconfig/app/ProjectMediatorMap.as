package appconfig.app
{
	import mediator.LoadingMediator;
	import mediator.ToolMediator;
	import mediator.bookIconMediator;
	import mediator.bookMediator;
	import mediator.vedioMediator;
	
	import view.winBook;
	import view.winBookIcon;
	import view.winLoading;
	import view.winTool;
	import view.winVedio;

	public class ProjectMediatorMap
	{
		private static var _instance:ProjectMediatorMap;	
		private var _arrMediator:Array;
		public function ProjectMediatorMap(_interal:ProjectMediatorMapInteral)
		{
			_arrMediator=[];
		}
		public static function Instance():ProjectMediatorMap
		{
			if(_instance==null) _instance = new ProjectMediatorMap(new ProjectMediatorMapInteral());
			return _instance;
		}
		public function Map():void
		{
			MapImp(winLoading, LoadingMediator);
			MapImp(winBookIcon, bookIconMediator);
			MapImp(winBook, bookMediator);
			MapImp(winTool, ToolMediator);
			MapImp(winVedio, vedioMediator);
		}
		
		private function MapImp(winClazz:Class, meditorClazz:Class):void
		{
			if(_arrMediator.indexOf(meditorClazz)!=-1) return;
			_arrMediator.push(meditorClazz);
			new meditorClazz();
		}
	}
}
class ProjectMediatorMapInteral{}