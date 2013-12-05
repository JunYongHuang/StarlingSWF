package lzm.starling.swf.tool.utils
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	import lzm.starling.swf.tool.Starup;

	/**
	 * 
	 * @author zmliu
	 * 
	 */
	public class ImageUtil
	{
		
		/**
		 * 获取图片bitmapdata
		 * */
		public static function getBitmapdata(clazz:Class,scale:Number):BitmapData{
			var mc:MovieClip = new clazz();
			mc.scaleX = mc.scaleY = scale;
			
			Starup.tempContent.addChild(mc);
			
			var rect:Rectangle = mc.getBounds(Starup.tempContent);
			rect.width = rect.width < 1 ? 1 : rect.width;
			rect.height = rect.height < 1 ? 1 : rect.height;
			mc.x = -rect.x;
			mc.y = -rect.y;
			
			var addWidth:Number = Math.abs((mc.x%1) + (rect.width%1));
			var addHeight:Number = Math.abs((mc.y%1) + (rect.height%1));
			
			addWidth = (addWidth%1) > 0 ? int(addWidth+1) : addWidth;
			addHeight = (addHeight%1) > 0 ? int(addHeight+1) : addHeight;
			
			rect.width += addWidth;
			rect.height += addHeight;
			
			var bitmapdata:BitmapData = new BitmapData(rect.width,rect.height,true,0);
			bitmapdata.draw(Starup.tempContent);
			
			Starup.tempContent.removeChild(mc);
			
			return bitmapdata;
		}
		
		/**
		 * 获取图片信息
		 * */
		public static function getImageInfo(clazz:Class):Array{
			var mc:MovieClip = new clazz();
			
			Starup.tempContent.addChild(mc);
			
			var rect:Rectangle = mc.getBounds(Starup.tempContent);
			
			Starup.tempContent.removeChild(mc);
			
			return [Util.formatNumber(-rect.x),Util.formatNumber(-rect.y)];
		}
		
	}
}