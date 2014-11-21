package component.componments.multiList
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import component.componments.multiList.IListItem;
	
	import utils.displayMapUtil;
	
	
	/**
	 * 
	 * @author chenyonghua
	 * 
	 */		
	public class ListItem extends Sprite implements IListItem
	{
		protected var _itemId:int = -1;
		protected var _data:Object;
		protected var skin:MovieClip;
		public function ListItem()
		{			
			super();
		}
		
		public function setSkin(mov:MovieClip):void
		{
			skin = mov;
			this.addChild(skin);
			//ChgFontManager.ChgContainerFontToNormal(skin);
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
		
		public function setSkinClassName(skinClassName:String):void
		{
			
		}
		
		public function get bSelectable():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function get selected():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function set selected(value:Boolean):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function destruction():void
		{
			while(numChildren>0)
			{
				removeChildAt(0);
			}
			if(parent!=null)
			{
				parent.removeChild(this);
			}
		}
	}
}