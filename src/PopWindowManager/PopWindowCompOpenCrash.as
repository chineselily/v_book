package popwindowmanager
{
	public class PopWindowCompOpenCrash
	{
		public function PopWindowCompOpenCrash()
		{
		}
		public static function crash(winData:PopWindowData, arrOpen:Array):Boolean
		{
			if(winData==null) return true;
			
			var opened:PopWindowData;
			if(winData.popType == PopWindowConst.POP_NOTSAMEWIN)
			{
				for each(opened in arrOpen)
				{
					if(opened.winClazz == winData.winClazz) return true;
				}
			}
			else if(winData.popType == PopWindowConst.POP_NOTLAYER)
			{
				for each(opened in arrOpen)
				{
					if(opened.layer == winData.layer) return true;
				}
			}
			else if(winData.popType == PopWindowConst.POP_ALL)
			{
				if(arrOpen.length>0) return true;
			}	
			return false;
		}
		public static function popData(winData:PopWindowData):PopWindowData
		{
			if(winData.popType == PopWindowConst.POP_NONE) return winData.clone();
			
			return winData;
		}
	}
}