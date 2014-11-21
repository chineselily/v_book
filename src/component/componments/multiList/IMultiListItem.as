package component.componments.multiList
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	public interface IMultiListItem
	{
		function getBounds(targetCoordinateSpace:DisplayObject):Rectangle;
		function setSkin(mov:MovieClip):void;
		function update(object:Object):void;
		
		function set itemId(value:int):void;
		function get itemId():int;
		function set data(value:Object):void;
		function get data():Object;
		function get body():Object;
		
		function get x():Number;
		function get y():Number;
		function get width():Number;
		function get height():Number;
		function get visible():Boolean;
		
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set width(value:Number):void;
		function set height(value:Number):void;
		function set visible(value:Boolean):void;
	}
}