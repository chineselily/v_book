package component.componments.multiList
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import utils.displayMapUtil;
	
	
	public class MultiListItem extends Sprite implements IMultiListItem
	{
		protected var _itemId:int = -1;
		protected var _data:Object;
		protected var skin:MovieClip;
		public function MultiListItem()
		{
			
			super();
		}
		
		public function setSkin(mov:MovieClip):void
		{
			skin = mov;
			this.addChild(skin);
			displayMapUtil.mapDisplay(skin,this);
		}
		
		public function set itemId(value:int):void
		{
			_itemId = value;
		}
		
		public function get itemId():int
		{
			return _itemId;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			if(_data)
			{
				this.visible = true;
				initlize();
			}else{
				this.visible = false;
			}
		}
		
		public function get data():Object
		{
			
			return _data;
		}
		
		public function initlize():void
		{
			
		}
		
		public function get body():Object
		{
			
			return this;
		}
		
		public function update(object:Object):void
		{
			
		}
	}
}