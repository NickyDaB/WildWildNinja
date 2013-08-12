package  {
	
	public class Bullet extends GameObject{

		//public var xPosition:Number;
		//public var yPosition:Number;
		public var bulletDamage:Number;
		
		public var vX:Number;
		
		public var isFired:Boolean;
		public var age:Number;
		
		private static const BULLET_AGE:Number = 24;
		
		private static const BULLET_SPEED:Number = 5;

		public function Bullet(posX, posY, damage) {
			// constructor code
			
			super(posX, posY);
			super.obeyGravity = false;
			bulletDamage = damage;
			age = 0;
		}
		
		public override function update() {
			x += 20;
			age++;
		}

	}
	
}
