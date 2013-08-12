package  {
	
	import flash.display.MovieClip;
	
	
	public class HealthBar extends MovieClip {
		
		private var _healthTotal:int;
		private var _widthPercent:Number;
		private var _currHealth:int;
		
		
		public function HealthBar(locatX:int, locatY:int, total:int) {
			// constructor code
			
			x = locatX;
			y = locatY;
			
			_healthTotal = total;
			_widthPercent = 1;
			_currHealth = total;
		}
		
//		public function update(charHealth:int):void{
//			
//			_currHealth = charHealth;
//			
//			_widthPercent = _currHealth/_healthTotal;
//			
//			Green_bar.width = Green_bar.width * _widthPercent;
//			trace(Green_bar.width)
//			
//			
//		}
	}
	
}
