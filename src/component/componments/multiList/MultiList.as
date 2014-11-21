package component.componments.multiList
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * QQ:563723791 
	 * @author Luke.Chen
	 * 多行列表滚动
	 * 支持动态行列
	 * 
	 * eg.  
	 * 	var list = new MultiList(MultiListDemoItem,classLibrary.getClass("PageItemUI"),3,5,10,10,Direction.HORIZONTAL);
	 */	
	public class MultiList extends Sprite
	{
		private var itemClazz:Class;
		private var skinClazz:Class;
		protected var row:int;
		protected var col:int;
		protected var rowSpace:int;
		protected var colSpace:int;
		protected var _direction:String;
		
		protected var mContainer:Sprite;
		protected var mList:Array;
		
		protected var _data:Array;
		protected var _currentPoint:Number = 0;
		private var _index:int;
		private var _mask:Sprite;
		protected var itemInstance:IListItem;
		private var _controller:MultiListController;
		
		/**
		 * 构造方法
		 * @param clazz     	单个item的类，必须得继承于MultiListItem.
		 * @param skinClazz		item所用到的皮肤的素材类，可以为null，类，或类名;
		 * @param row			行
		 * @param col			列
		 * @param rowSpace		行间距
		 * @param colSpace		列间距
		 * @param direction		方向：Direction.HORIZONTAL 或 Direction.VERTICAL
		 * @bUseMask 是否需要遮罩层
		 */		
		public function MultiList(clazz:Class,skinClazz:*, row:int, col:int, rowSpace:int,colSpace:int,direction:String = Direction.HORIZONTAL, bUseMask:Boolean=true)
		{
			this.itemClazz 		= clazz;	
			this.skinClazz 		= skinClazz is Class ? skinClazz : null;	
			this.row 			= row;	
			this.col 			= col;	
			this.rowSpace 		= rowSpace;	
			this.colSpace 		= colSpace;		
			this.direction		= direction;
			itemInstance		= new clazz();
			
			if(skinClazz is Class)
			{
				itemInstance.setSkin(new skinClazz());
			}else if(skinClazz is String)
			{
				itemInstance.setSkinClassName(skinClazz);
			}
			
			//容器
			mContainer			= new Sprite();
			this.addChild(mContainer);
			
			//遮罩层
			if(bUseMask==true)
			{
				_mask				= new Sprite();
				_mask.mouseChildren = _mask.mouseEnabled = false;
				this.addChild(_mask);
				mContainer.mask 	= _mask;
			}
			
			make();
			drawMask();
		}
		
		/**
		 * 更改行列和间距
		 * @param	row
		 * @param	col
		 * @param	rowSpace 0不改
		 * @param	colSpace 0不改
		 */
		public function exchangeColAndRow(row:int, col:int, rowSpace:int=0,colSpace:int=0):void 
		{
			this.row = row;	
			this.col = col;	
			if (rowSpace != 0) this.rowSpace = rowSpace;	
			if (colSpace != 0) this.colSpace = colSpace;
			
			drawMask();
		}
		
		private var _onScrollEnd:Function; 
		/**
		* 设置跳转控制器 
		 * @param skin
		 * @param onScrollEnd 翻页完成后的回调
		 * @return 
		 * 
		 */		
		public function setController(skin:DisplayObjectContainer, onScrollEnd:Function=null):MultiListController
		{
			_controller = new MultiListController(this,skin);
			_onScrollEnd = onScrollEnd;
			return _controller;
		}
		
		/**
		 * 绘制遮罩 
		 * @param drawX
		 * @param drawY
		 * @param drawWidth
		 * @param drawHeight
		 * 
		 */		
		public function drawMask(drawX:int =0, drawY:int=0, drawWidth:int =0, drawHeight:int=0):void
		{
			if(_mask==null)
				return;
			var rect:Rectangle = this.itemInstance.getBounds(itemInstance.body as DisplayObject);
			_mask.graphics.clear();
			_mask.graphics.beginFill(0, 0.5);
			var wt:Number = ((rect.width + this.colSpace) * this.col - this.colSpace);
			var ht:Number = ((rect.height + this.rowSpace) * this.row - this.rowSpace);
			_mask.graphics.drawRect(drawX + rect.x, drawY + rect.y, drawWidth ==0?wt:drawWidth, drawHeight == 0?ht:drawHeight);
			_mask.graphics.endFill();
		}
		
		/**
		 * 刷新显示对象中的元素
		 */
		protected function make():void
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
			for (var i:int = 0; i < len_1 + 1; i++)
			{
				if(mList[i] == null)
					mList[i] = [];
				for (var j:int = 0; j < len_2; j++)
				{
					item		= getNewItem();
					item.itemId	= -1;
					mList[i].push(item);
				}
			}
		}
		
		/**
		 * 获取新的子项
		 * @return
		 */
		protected function getNewItem():IListItem
		{
			var item:IListItem = mContainer.addChild(new itemClazz()) as IListItem;
			if(skinClazz != null)
			{
				item.setSkin(new skinClazz());
			}
			return item;
		}
		
		/**
		 * 设置滚动方向 
		 * @param value
		 * 
		 */		
		public function set direction(value:String):void
		{
			_direction = value;
		}

		/**
		 * 获取列表数据 
		 * @return 
		 * 
		 */		
		public function get data():Array
		{
			return _data;
		}
 
		/**
		 * 设置列表数据 
		 * @return 
		 * 
		 */
		public function set data(value:Array):void
		{
			_data 			= value;
			_currentPoint   = 0;
			_index		= 0;
			fill(true);
			if(_controller!=null) _controller.checkButtonStatus();
		}
		
		/**
		 * 执行滚动时的数据更新 
		 * @param isAll
		 * 
		 */		
		public function fill(isAll:Boolean = false):void
		{
			var i:int
			var j:int;
			var len:int			= mList.length;
			var item:IListItem;			
			var isNeed:Boolean;
			var needList:Array	= [];
			var outList:Array	= [];
			var rowNum:int = -1;
			if(isAll){
				for (i = 0; i < len; i++)
				{
					rowNum = int((_currentPoint + (i * itemSize)) / itemSize);
					for (j = 0; j < mList[i].length; j++)
					{
						item							= mList[i][j];
						if(_direction == Direction.HORIZONTAL){
							item.itemId						= rowNum * col + j;
							item.data						= _data[item.itemId-col];						
							item.x							= j * (itemInstance.width + colSpace);
							item.y							= (rowNum * itemSize)-_currentPoint - itemSize;
						}
						else
						{
							item.itemId						= rowNum * row + j;
							item.data						= _data[item.itemId-row];						
							item.x							= (rowNum * itemSize)-_currentPoint - itemSize;
							item.y							= j * (itemInstance.height + rowSpace);
						}
						//trace("itemid=",item.itemId," itemdata=",item.data," itemx=",item.x," itemy=",item.y);
					}
				}
			}
			else
			{
				for (i = 0; i < len; i++)
				{
					needList.push(Math.ceil((_currentPoint + (i* itemSize)) / itemSize));
				}
				//找到显示区域外的子项
				for (i = 0; i < len; i++)
				{
					if(_direction == Direction.HORIZONTAL){
						rowNum		= int(mList[i][0].itemId / col);						
					}
					else
					{
						rowNum		= int(mList[i][0].itemId / row);
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
					if (!isNeed)
					{
						outList.push(mList[i]);
					}else
					{
						for (var k:int = 0, llen:int = mList[i].length; k < llen; k++)
						{
							item 	= mList[i][k];
							
							if(_direction == Direction.HORIZONTAL){
								item.y	= (int(item.itemId / col) * itemSize) - _currentPoint - itemSize;						
							}
							else
							{
								item.x	= (int(item.itemId / row) * itemSize) - _currentPoint - itemSize;
							}
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
							item.itemId			= rowNum * col + j;
							item.data			= _data[item.itemId-col];
							item.y				= (int(item.itemId / col) * itemSize) - _currentPoint - itemSize;
						}
						else
						{
							item.itemId			= rowNum * row + j;
							item.data			= _data[item.itemId-row];
							item.x				= (int(item.itemId / row) * itemSize) - _currentPoint - itemSize;
						}					
					}					
				}
			}
		}
		
		/**
		 * 获取行列的索引 
		 * @return 
		 * 
		 */		
		public function get index():int
		{
			return _index;
		}
		
		/**
		 * 设置行列的索引 
		 * @return  
		 */	
		public function set index(value:int):void
		{
			gotoIndex(value,_onScrollEnd);
		}
		/**
		 * 设置滚动到某个数据 
		 * @param data
		 * @param callBackFun
		 */		
		public function gotoDataElem(searchField:String,filedValue:Object, callBackFun:Function):void
		{
			var tempdata:Object = searchItemData(searchField,filedValue);
			if(tempdata==null) return;//未找到
			
			var dataindex:int =	data.indexOf(tempdata);
			if(dataindex<0) return;//未找到
			
			var pageindex:int = int(dataindex/pageElemNum);//标签页
			pageindex*=pageNum;
			gotoIndex(pageindex,function callback():void
			{
				var listItem:IListItem = searchItem(searchField,filedValue);
				if(callBackFun!=null) callBackFun(listItem);
			});
			
			_controller.checkButtonStatus();
		}
		protected function gotoIndex(value:int, callBackFun:Function):void
		{
			if(value <=0)
			{
				value = 0;
			}
			else if(value >= totalIndex)
			{
				value = totalIndex;
			}
			if(Math.floor(_index - value) >= 5)
			{
				if(_index < value)
				{
					currentPoint = (value - 5) * itemSize;
				}
				else
				{
					currentPoint = (value + 5) * itemSize;
				}
			}
			_index = value;
			/*if(callBackFun!=null)
				TweenLite.to(this,.5,{currentPoint:index * itemSize,ease:Expo.easeOut, onComplete:onGotoIndexComplete});
			else
				TweenLite.to(this,.5,{currentPoint:index * itemSize,ease:Expo.easeOut});*/
			this.mouseChildren = this.mouseEnabled = false;
			if(_controller!=null)
				_controller.setButtonsEnable(false);
			TweenLite.to(this,.5,{currentPoint:index * itemSize,ease:Expo.easeOut, onComplete:onGotoIndexComplete, onCompleteParams:[callBackFun]});
		}
		
		protected function onGotoIndexComplete(func:Function):void
		{
			if(func is Function)
				func.apply(null, [int(index / pageNum)+1]);
			this.mouseChildren = this.mouseEnabled = true;
			if(_controller!=null)
				_controller.setButtonsEnable(true);
			if(_controller!=null) _controller.checkButtonStatus();
		}
		
		/**
		 * 获取列表位置 
		 * @return 
		 * 
		 */		
		public function get currentPoint():Number
		{
			return _currentPoint;
		}

		/**
		 * 设置列表位置 
		 * @return 
		 * 
		 */	
		public function set currentPoint(value:Number):void
		{
			_currentPoint = value;
			if(_currentPoint >= totalIndex * itemSize)
			{
				_currentPoint 	= totalIndex * itemSize;
			}else if(_currentPoint<=0){
				_currentPoint = 0;
			}
			fill();
		}
		
		/**
		 * 单页的行或列数 
		 * @return 
		 * 
		 */		
		public function get pageNum():int
		{
			if(_direction == Direction.HORIZONTAL)
			{
				return row;
			}
			return col;
		}
		/**
		 * 单页的元素总数 
		 * @return 
		 * 
		 */		
		public function get pageElemNum():int
		{
			return row*col;
		}
		
		/**
		 * 总索引数 
		 * @return 
		 * 
		 */		
		public function get totalIndex():int
		{
			var num:int;
			if(_direction == Direction.HORIZONTAL)
			{
				num = Math.ceil(data.length / col) - row;
			}
			else if(_direction == Direction.VERTICAL)
			{
				num = Math.ceil(data.length / row) - col;
			}
			
			return num <0?0:num;
		}
		
		/**
		 * 行或列的间距 
		 * @return 
		 * 
		 */		
		protected function get itemSize():int
		{
			if(_direction == Direction.HORIZONTAL)
			{
				return itemInstance.height + rowSpace;
			}
			return itemInstance.width + colSpace;
		}
		
		// --------------------------------------------------------
		// -------------------- 对数据的查询操作 --------------------
		// --------------------------------------------------------
		
		/**
		 * 查找ITEM
		 * @param searchField
		 * @param value
		 * @return 
		 * 
		 */		
		public function searchItem(searchField:String,filedValue:Object):IListItem{
			var item:IListItem;
			var len:int = this.mList.length;
			var i:int;
			for (i = 0; i < len;i++ ){
				for (var j:int = 0, lenj:int = mList[i].length; j < lenj; j++)
				{
					item                = this.mList[i][j];
					if(item.data && item.data[searchField] == filedValue){
						return item;
						break;
					}
				}
			}
			return null;
		}
		
		/**
		 * update single item 
		 * @param searchField
		 * @param filedValue
		 * @param value
		 * 
		 */		
		public function updateItem(searchField:String,filedValue:Object,value:Object):void{
			var item:IListItem = searchItem(searchField,filedValue);
			if(item){
				item.data = value;
			}
			updateItemData(searchField,filedValue,value);
		}
		
		/**
		 *  查找数据池里面的数据
		 * @param searchField
		 * @param filedValue
		 * @return 
		 * 
		 */		
		public function searchItemData(searchField:String,filedValue:Object):Object{
			var o:Object;
			var len:int = data.length;
			var i:int;
			for (i = 0; i < len;i++ ){
				o = this.data[i];
				if(o && o[searchField] == filedValue){
					return o;
					break;
				}
			}
			return null;
		}
		
		/**
		 * 执行所有ITEM的update方法 
		 * @param object
		 * 
		 */		
		public function updateItems(object:Object):void
		{
			var item:IListItem;
			var len:int = this.mList.length;
			var i:int;
			for (i = 0; i < len;i++ ){
				for (var j:int = 0, lenj:int = mList[i].length; j < lenj; j++)
				{
					item                = this.mList[i][j];
					if(item.data){
						item.update(object);
					}					
				}
			}
		}
		
		/**
		 * 只更新数据池里的数据 
		 * @param searchField
		 * @param filedValue
		 * @param value
		 * 
		 */		
		public function updateItemData(searchField:String,filedValue:Object,value:Object):void{
			var o:Object;
			var len:int = data.length;
			var i:int;
			for (i = 0; i < len;i++ ){
				o = this.data[i];
				if(o && o[searchField] == filedValue){
					data[i] = value;
					break;
				}
			}
		}
		/**
		 * 更新所有的数据某个字段 
		 * @param filedValue
		 * @param value
		 * 
		 */		
		public function updateAllDataField(filedValue:Object, value:Object):void
		{
			if(data==null) return;
			var o:Object;
			var len:int = data.length;
			var i:int;
			for (i = 0; i < len;i++ )
			{
				o = this.data[i];
				if(o && o.hasOwnProperty(filedValue)) o[filedValue] = value;
			}
				
		}
		/**
		 *销毁函数 
		 */		
		public function destruction():void
		{
			var items:Array;
			var item:IListItem;
			for each(items in mList)
			{
				for each(item in items)
					item.destruction();
			}
			if(mContainer!=null)
			{
				while(mContainer.numChildren>0)
				{
					mContainer.removeChildAt(0);
				}
			}
			while(numChildren>0)
			{
				removeChildAt(0);
			}
			if(parent!=null)
			{
				parent.removeChild(this);
			}
		}
		
		public function get itemContainer():Sprite
		{
			return mContainer;
		}
	}
}