package  {
	
	import flash.events.Event;
	
	public class Bottle extends GameObject{

		public var damage:Number;
		
		private var angle:Number;
		private var vX:Number;
		private var vY:Number;
		private var speed:Number;
		private var gravity:Number; 
		
		public function Bottle(xPlace:int, yPlace:int) {
			// constructor code
			super(xPlace, yPlace);
			
			vX = 30;
			vY = 2;
			angle = 30;
			gravity = .5;
			speed = 25;
			
			damage = 15;
		}
		
		public function throwBottle():void {
			
			
			var radians:Number = ((angle * 180)/Math.PI);
			
			vX = (speed * Math.cos(radians));
			vY = ((speed * Math.sin(radians)) + gravity);
			
			addEventListener(Event.ENTER_FRAME, trajectory);
		}
		
		public function trajectory(e:Event):void {
			
			vY += gravity;
			
			
			this.x += vX; 
			this.y += vY/3;
			
		}
		
		public function hit():void {
			removeEventListener(Event.ENTER_FRAME, trajectory);
		}

	}
	
}
