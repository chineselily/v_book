package appconfig.app
{
	public class ProjectConst
	{
		//public static const serverPath:String="http://172.17.3.233/vbook/";//我的电脑上安装了apache,并且在安装目录下D:\Program Files\Apache Software Foundation\Apache2.2\htdocs放文件
		//public static const serverPath:String="d:/v_book/";//我的电脑上安装了apache,并且在安装目录下D:\Program Files\Apache Software Foundation\Apache2.2\htdocs放文件
		//这个会有沙箱冲突，导出的swf中的控件不能监听事件，所以不得以我就只有移动到debug目录下了。
		public static const serverPath:String="";
		public static const bookconfig_path:String=serverPath+"config/BookConfig.xml";
		public static const winconfig_path:String = serverPath+"config/winConfig.xml";
		public static const vedioconfig_path:String = serverPath+"config/vedioConfig.xml";
		public static const bookswf_path:String = serverPath+"swf/";
		public static const bookswfextend_path:String = serverPath+"swfextend/";
		public static const bookpng_path:String = serverPath+"png/";
		public static const vedio_path:String = serverPath+"vedio/";
		
		public static const icon_extend:String=".jpg";
		public static const book_extend:String=".swf";
		public static const vedio_extend:String=".flv";
		public function ProjectConst()
		{
			
		}
	}
}