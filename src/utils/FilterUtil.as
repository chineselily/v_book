package utils
{
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	/**
	 * ...
	 * @author ...
	 */
	public class FilterUtil
	{
		//变灰
		public static function applyblack(child:DisplayObject):void {      
            var matrix:Array = new Array();
            matrix = matrix.concat([0.3086,0.6094,0.082,0,0]); // red
            matrix = matrix.concat([0.3086,0.6094,0.082,0,0]); // green
            matrix = matrix.concat([0.3086,0.6094,0.082,0,0]); // blue
            matrix = matrix.concat([0,0,0,1,0]); // alpha

            applyFilter(child, matrix);
        }

		/**
		 * 模糊滤镜
		 */
		public static function applyBlur(num:Number):Array
		{
			var blurX:Number = num;
			var blurY:Number = num;
			var quality:Number=BitmapFilterQuality.HIGH;
			var _blurFilter:BlurFilter = new BlurFilter(blurX, blurY, quality);
			var filters:Array = new Array();
			filters.push(_blurFilter);
			return filters;
		}		
		
        public static function applyRed(child:DisplayObject):void {
           
            var matrix:Array = new Array();
            matrix = matrix.concat([1, 1, 1, 1, 1]); // red
            matrix = matrix.concat([0, 0, 0, 0, 0]); // green
            matrix = matrix.concat([0, 0, 0, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 0.5, 0]); // alpha
            applyFilter(child, matrix);
        }

        public static function applyGreen(child:DisplayObject):void {
            var matrix:Array = new Array();
            matrix = matrix.concat([0, 0, 0, 0, 0]); // red
            matrix = matrix.concat([0, 1, 0, 0, 0]); // green
            matrix = matrix.concat([0, 0, 0, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 0.5, 0]); // alpha

            applyFilter(child, matrix);
        }

        public static function applyBlue(child:DisplayObject):void {
            var matrix:Array = new Array();
            matrix = matrix.concat([0, 0, 0, 0, 0]); // red
            matrix = matrix.concat([0, 0, 0, 0, 0]); // green
            matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha

            applyFilter(child, matrix);
        }

        public static function applyFilter(child:DisplayObject, matrix:Array):void {
            var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
            var filters:Array = new Array();
            filters.push(filter);
            child.filters = filters;
        }
				
		/** 
		 * 鼠标经过楼体的滤镜效果
		 * @param 
		 */
		public static function setGlowFilter(child:DisplayObject):void {
				var color:Number=0xFFFFFF;
				var alpha:Number=1;
				var blurX:Number=4;
				var blurY:Number=4;
				var strength:Number=6;
				var inner:Boolean=false;
				var knockout:Boolean=false;
				var quality:Number=BitmapFilterQuality.HIGH;
				var _glowFilter:GlowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
				
				var filters:Array = new Array();
				filters.push(_glowFilter);
				child.filters = filters;
		}
		
		/** 
		 * 鼠标移出墙纸的滤镜效果
		 * @param 
		 */
		public static function getGlowFilter(color:Number):GlowFilter
		{
			var _glowFilter:GlowFilter = null;
			var alpha:Number = 1;
			var blurX:Number = 2;
			var blurY:Number = 2;
			var strength:Number = 40;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			_glowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
			
			return _glowFilter;
		}
	}

}