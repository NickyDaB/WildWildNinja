package 
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class GameObject extends MovieClip
	{
		public var obeyGravity:Boolean = true;
		protected var friction:Number = 1;
		public function GameObject(iXpos:Number, iYpos:Number) {
			x = iXpos;
			y = iYpos;
		}
		
		public function update() {
			if (obeyGravity == true)
			{
				if (y < stage.stageHeight-(this.height/2)-32)
				{
					y = y + 8;
				}
			}
		}
		
		
	}
	
}