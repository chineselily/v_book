package component.componments.multiList
{
	/**
	 *显示方向和滚动方向不一致的multiList 
	 * @author Administrator
	 * 
	 */	
	public class difScrollmultiList extends MultiList
	{
		public function difScrollmultiList(clazz:Class, skinClazz:*, row:int, col:int, rowSpace:int, colSpace:int, direction:String=Direction.HORIZONTAL)
		{
			super(clazz, skinClazz, row, col, rowSpace, colSpace, direction);
		}
		/**
		 * 刷新显示对象中的元素
		 */
		protected override function make():void
		{
			mList = [];
			
			var len_1:int;
			var len_2:int;
			if(_direction == Direction.HORIZONTAL){
				len_1 = row;
				len_2 = col;
			}
			else
			{
				len_1 = col;
				len_2 = row;
			}
			
			var item:IListItem;
			for (var i:int = 0; i < len_1; i++)
			{
				if(mList[i] == null)
					mList[i] = [];
				for (var j:int = 0; j < len_2+1; j++)//在第二维中增加一排元素，用于滚动
				{
					item		= getNewItem();
					item.itemId	= -1;
					mList[i].push(item);
				}
			}
		}
		/**
		 * 执行滚动时的数据更新 
		 * @param isAll
		 * 
		 */		
		override public function fill(isAll:Boolean = false):void
		{
			var i:int, j:int, k:int, rowNum:int, len2:int, len:int=mList.length;
			var item:IListItem;
			var needList:Array	= [];
			var outList:Array	= [];
			var findneedList:Array = [];
			var isNeed:Boolean;
			if(isAll){
				for (i = 0; i < len; i++)
				{
					len2 = mList[i].length;
					for (j = 0; j < len2; j++)
					{
						item							= mList[i][j];
						rowNum = int((_currentPoint + (j * itemSize)) / itemSize);
						//与正常的正好相反
						if(_direction == Direction.VERTICAL)
							item.itemId						= rowNum * col + i;
						else
							item.itemId						= rowNum * row + i;
						itemdata = item;//设置数据
						itemxy = item;//设置x,y
					}
				}
			}
			else
			{
				len2 = mList[0].length;
				len = mList.length;
				//计算需要显示的列
				for (i = 0; i < len2; i++)
				{
					needList.push(Math.ceil((_currentPoint + (i* itemSize)) / itemSize));
				}
				//将现在显示的列数据更新 
				for (i = 0; i < len2; i++)
				{
					if(_direction == Direction.HORIZONTAL){
						rowNum		= int(mList[0][i].itemId / row);						
					}
					else
					{
						rowNum		= int(mList[0][i].itemId / col);
					}
					isNeed		= false;
					for (j = 0; j < needList.length; j++)
					{
						if (rowNum == needList[j])
						{
							isNeed	= true;
							needList.splice(j, 1);
							break;
						}
					}
					findneedList=null;
					findneedList=[];
					for(j=0;j<len;j++)
						findneedList.push(mList[j][i]);
					
					if (!isNeed)
					{
						outList.push(findneedList);
					}else
					{
						for(j=0;j<len;j++)
						{
							item = mList[j][i];
							itemxy = item;
						}
					}
				}
				//列表外的子项修正到显示区域内
				len	= outList.length;
				var temp:Array;
				var tlen:int;
				for (i = 0; i < len; i++)
				{
					temp 	= outList[i];
					rowNum 	= needList[i];
					for (j = 0, tlen = temp.length; j < tlen; j++)
					{
						item				= temp[j];
						
						if(_direction == Direction.HORIZONTAL){
							item.itemId			= rowNum * row + j;
						}
						else
						{
							item.itemId			= rowNum * col + j;
						}	
						itemdata = item;
						itemxy = item;
					}					
				}
			}
		}
		/**
		 * 计算item应该显示的数据 
		 * @param item
		 * 
		 */		
		private function set itemdata(item:IListItem):void
		{
			var itemId:int = item.itemId;
			var itemId1:int, i:int;
			if(_direction == Direction.VERTICAL)
			{
				itemId-=col;
				if(itemId<0)//备用滚动一行在mask外显示 
					item.data = _data[itemId];
				else
				{
					i = int(itemId/pageElemNum);
					itemId=i>0?itemId-i*pageElemNum:itemId;
					itemId1 = ((itemId%col)*row+(itemId/col));
					itemId = itemId1 + i*pageElemNum;
					item.data = _data[itemId];
				}
			}
			else
			{
				itemId-=row;
				if(itemId<0)//备用滚动一列在mask外显示 
					item.data = _data[itemId];
				else
				{
					i = int(itemId/pageElemNum);
					itemId=i>0?itemId-i*pageElemNum:itemId;
					itemId1 = ((itemId%row)*col+(itemId/row));
					itemId = itemId1 + i*pageElemNum;
					item.data = _data[itemId];
				}
			}
		}
		/**
		 * 计算X,Y值 
		 * @param item
		 * 
		 */		
		private function set itemxy(item:IListItem):void
		{
			var itemId:int = item.itemId;
			var _row:int, _col:int;
			if(_direction == Direction.VERTICAL)
			{
				_row = itemId%col; _col = itemId/col;
				item.y=_col*itemSize-_currentPoint-itemSize;
				item.x=_row*(itemInstance.height+rowSpace);
			}
			else
			{
				_row = itemId%row; _col = itemId/row;
				item.x=_col*itemSize-_currentPoint-itemSize;
				item.y=_row*(itemInstance.height+rowSpace);
			}
		}

		/**
		 * 单页的行或列数 
		 * @return 
		 * 
		 */		
		override public function get pageNum():int
		{
			if(_direction == Direction.HORIZONTAL)//和正常的正好相反
			{
				return col;
			}
			return row;
		}
		/**
		 * 总索引数 
		 * @return 
		 * 
		 */	
		override public function get totalIndex():int
		{
			var num:int=0;
			var len:int = data.length;//数据长度 
			var ipage:int = int(len/pageElemNum);//数据可以显示多少完整的页数
			len -= ipage*pageElemNum;//完整页数后剩余的数量
			if(_direction == Direction.HORIZONTAL)
			{
				num += ipage*col;//最后一页index
				num = len==0?num-col:num;
			}
			else if(_direction == Direction.VERTICAL)
			{
				num += ipage*row;
				num = len==0?num-row:num;
			}
			
			return num <0?0:num;
		}
		/**
		 * 行或列的间距 
		 * @return 
		 * 
		 */		
		override protected function get itemSize():int
		{
			if(_direction == Direction.VERTICAL)//和正常的正好相反
			{
				return itemInstance.height + rowSpace;
			}
			return itemInstance.width + colSpace;
		}
	}
}