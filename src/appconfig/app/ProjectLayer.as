package appconfig.app
{
	import flash.display.Sprite;

	public class ProjectLayer
	{
		private static var _instance:ProjectLayer;
		public static const LAYER_START:int=0;
		public static const LAYER_BOOK:int=LAYER_START;
		public static const LAYER_TOOL:int=LAYER_START+1;
		public static const LAYER_DRAW:int=LAYER_START+2;
		public static const LAYER_NOTESHOW:int=LAYER_START+3;
		public static const LAYER_NOTEWRITE:int=LAYER_START+4;
		public static const LAYER_VEDIO:int=LAYER_START+5;
		public static const LAYER_LOADING:int=LAYER_START+6;
		public static const LAYER_END:int = LAYER_LOADING;
		
		private var _aLayers:Array;
		
		public function ProjectLayer(_interal:ProjectLayerInteral)
		{
		}
		public static function get Instance():ProjectLayer
		{
			if(_instance==null) _instance = new ProjectLayer(new ProjectLayerInteral());
			return _instance;
		}
		public function initLayer(container:Sprite):void
		{
			_aLayers = [];
			for(var i:int=LAYER_START;i<=LAYER_END;i+=1)
			{
				_aLayers.push(new Sprite());
				container.addChildAt(_aLayers[i],i);
			}
		}
		
		public function getLayer(layer:int):Sprite
		{
			if(layer>=_aLayers.length) return null;
			return _aLayers[layer];
		}
	}
}
class ProjectLayerInteral{}