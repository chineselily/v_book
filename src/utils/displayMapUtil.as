package utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	import avmplus.getQualifiedSuperclassName;

	public class displayMapUtil
	{
		public function displayMapUtil()
		{
		}
		
		public static function mapDisplay(dis:DisplayObjectContainer, cls:Object):void
		{
			var dic:Dictionary = new Dictionary();
			getContainerChildrenListD(dis,dic);
			var describexml:XML = describeType(cls);
			var describelist:XMLList = describexml.variable;
			for each(var xml:XML in describelist)
			{
				var name:String = xml.@name;
				var type:String = xml.@type;
				if(dic[name] && (getQualifiedClassName(dic[name])==type || getQualifiedSuperclassName(dic[name])==type))
					cls[name]=dic[name];
			}
		}
		
		public static function getContainerChildrenListD(con:DisplayObjectContainer, dic:Dictionary, type:Class=null):void
		{
			for(var i:int=0;i<con.numChildren;i+=1)
			{
				var obj:DisplayObject = con.getChildAt(i);
				if(obj is DisplayObjectContainer)
				{
					if((type!=null && obj is type) || type==null)
						dic[obj.name]=obj;
					getContainerChildrenListD(obj as DisplayObjectContainer, dic, type);
				}
				else if(type!=null && (obj is type))
					dic[obj.name]=obj;
				else if(type==null)
					dic[obj.name]=obj;
			}
		}
		
		public static function getContainerChildrenList(con:DisplayObjectContainer, type:Class=null):Array
		{
			var arr:Array=[];
			for(var i:int=0;i<con.numChildren;i+=1)
			{
				var obj:DisplayObject = con.getChildAt(i);
				if(obj is DisplayObjectContainer)
				{
					if((type!=null && obj is type) || type==null)
						arr.push(obj);
					arr = arr.concat(getContainerChildrenList(obj as DisplayObjectContainer, type));
				}
				else if(type!=null && obj is type)
					arr.push(obj);
				else if(type==null)
					arr.push(obj);
			}
			return arr;
		}
	}
}