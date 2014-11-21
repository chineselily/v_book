package component.componments.multiList
{
	import flash.events.MouseEvent;

	public class SelectableMultiList extends MultiList
	{
		public function SelectableMultiList(clazz:Class, skinClazz:*, row:int, col:int, rowSpace:int, colSpace:int, direction:String=Direction.HORIZONTAL, bUseMask:Boolean=true)
		{
			super(clazz, skinClazz, row, col, rowSpace, colSpace, direction, bUseMask);
		}
		
		/**
		 *开启或关闭单元格可选状态 需要设置子单元格的mouseChildren = false;
		 * @param enable
		 * 
		 */		
		public function selectEnable(enable:Boolean):void
		{
			if(enable==true)
			{
				mContainer.addEventListener(MouseEvent.CLICK, onMouseHandler);
			}else{
				mContainer.removeEventListener(MouseEvent.CLICK, onMouseHandler);
			}
		}
		
		override protected function onGotoIndexComplete(func:Function):void
		{
			super.onGotoIndexComplete(func);
			if(_selectedData==null)
				return;
			var items:Array;
			var item:IListItem;
			for each(items in mList)
			{
				for each(item in items)
				{
					if(item.data==_selectedData && item.bSelectable==true && item.selected==false)
					{
						item.selected = true;
						break;
					}
				}
			}
		}
		
		override protected function gotoIndex(value:int, callBackFun:Function):void
		{
			super.gotoIndex(value, callBackFun);
			if(_selected!=null)
			{
				_selected.selected = false;
			}
		}
		
		private var _selected:IListItem;
		private var _selectedData:Object;
		
		public function rollSelectEnable(enable:Boolean):void
		{
			if(enable==true)
			{
				mContainer.addEventListener(MouseEvent.ROLL_OVER, onMouseHandler);
			}else{
				mContainer.removeEventListener(MouseEvent.ROLL_OVER, onMouseHandler);
			}
		}
		
		public function set selectIndex(index:int):void
		{
			setSelectIndex([index, false]);
		}
		
		public function setSelectIndex(aList:Array):void
		{
			var value:int = aList[0];
			var isClick:Boolean = aList[1];
			var items:Array;
			var item:IListItem;
			for each(items in mList)
			{
				for each(item in items)
				{
					if(item.itemId==value && item.bSelectable==true && item.selected==false)
					{
						_selected = item;
						dispatchEvent(new MultiListEvent(MultiListEvent.SELECTED, item));
						_selected.selected = true;
						_selectedData = _selected.data;						
					}else if(item.itemId!=value && item.selected==true)
					{
						item.selected = false;
					}
					
					//if (isClick && item is ExpressOrderFormGrid) ExpressOrderFormGrid(item).isHaveClick = true;  //移上不可选择。
				}
			}
		}
		
		protected function onMouseHandler(e:MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.ROLL_OVER:
				{
					trace(e);
					break;
				}
				case MouseEvent.CLICK:
				{
					var target:IListItem = e.target as IListItem;
					if(target!=null)
					{
						var items:Array;
						var item:IListItem;
						for each(items in mList)
						{
							for each(item in items)
							{
								if(item==target && item.bSelectable==true && item.selected==false)
								{
									_selected = item;
									dispatchEvent(new MultiListEvent(MultiListEvent.SELECTED, item));
									_selected.selected = true;
									_selectedData = _selected.data;
								}else if(item!=target && item.selected==true && target.bSelectable==true){
									item.selected = false;
								}
							}
						}
					}
					break;
				}
			}
		}
		
	}
}