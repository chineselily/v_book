package appconfig.app
{
	import mediator.LoadingMediator;
	
	import view.winLoading;

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