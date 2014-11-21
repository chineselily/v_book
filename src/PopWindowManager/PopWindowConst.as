package popwindowmanager
{
	public class PopWindowConst
	{
		/**
		 * 打开窗口动画相关 
		 */		
		public static const ANI_TYPE_NONE:int=1;//无动画
		public static const ANI_TYPE_CENTER:int=2;//从中间向两边放大
		public static const ANI_TYPE_LEFTTOP:int=3;//从左上角向下向右放大
		public static const ANI_TYPE_BOTTOM:int=4;//直接放在屏幕下方
		
		/**
		 *打开窗口是否掩码 
		 */		
		public static const MASK_YES:int=1;//遮挡屏幕掩码
		public static const MASK_NO:int=2;//不需要掩码
		
		/**
		 *打开窗口对齐方式 
		 */		
		public static const ALIGN_CENTER:int=1;//和屏幕中央对齐
		public static const ALIGN_XY:int=2;//没有对齐，设置XY
		
		/**
		 *打开窗口条件 
		 */		
		public static const POP_NONE:int=1;//无条件打开
		public static const POP_NOTSAMEWIN:int=2;//同层只要有一个相同的窗口就不打开
		public static const POP_NOTLAYER:int=3;//同层有窗口就不打开
		public static const POP_ALL:int=4;//只要有窗口就不打开
		
		public function PopWindowConst()
		{
		}
	}
}