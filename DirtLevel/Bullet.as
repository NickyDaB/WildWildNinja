package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class Bullet extends GameObject
	{
		
		public var damage:Number = 0;
		public var bulletSpeed:Number = 0;
		private var directionOfFire:Boolean;
		
		public function Bullet(xPos:Number, yPos:Number, iDamage:Number, iBulletSpeed:Number, direct:Boolean = true) 
		{
			super(xPos, yPos);
			damage = iDamage;
			bulletSpeed = iBulletSpeed;
			directionOfFire = direct;
		}
		
		override public function update():void
		{
			if(directionOfFire) {x += bulletSpeed;}
			else if (directionOfFire == false) {x -= bulletSpeed;}
		}
		
	}

}