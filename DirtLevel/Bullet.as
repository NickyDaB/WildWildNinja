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
		
		public function Bullet(xPos:Number, yPos:Number, iDamage:Number, iBulletSpeed:Number) 
		{
			super(xPos, yPos);
			damage = iDamage;
			bulletSpeed = iBulletSpeed;
		}
		
		override public function update()
		{
			x += bulletSpeed;
		}
		
	}

}