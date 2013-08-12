package  
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class Gun extends GameObject
	{
		//attributes
		public var gunName:String;
		public var damage:Number;
		public var clipSize:Number;
		
		public var bulletList:Array;
		private static const BULLET_AGE:Number = 24;
		
		public var tempBullet:Bullet;
		
		//currently unused attributes
		public var currentAmmo:Number;
		public var maxAmmo:Number;
		public var maxSpareMags:Number;
		public var barrelXpos:Number;
		public var barrelYpos:Number;
		
		public function Gun(holderOfGun:characterStick){
			super(holderOfGun.x + holderOfGun.handX, holderOfGun.y + holderOfGun.handY);
			obeyGravity = false;
			
			bulletList = new Array();
			
			damage = 0;
			gunName = "Nothing";
			clipSize = 0;
			
			trace("gunName: " + gunName );
			trace("damage: " + damage );
			trace("clipSize: " + clipSize );
		}
		
		public function changeWeapon() {
			this.nextFrame();
			trace("gunName: " + gunName );
			trace("damage: " + damage );
			trace("clipSize: " + clipSize );
			currentAmmo = clipSize;
		}
		
		public function shoot()
		{
			/*
			 * create new bullet object at the pos of gun barrel
			 * with the appropriate parameters
			 * 
			 * tempBullet = new Bullet(barrelXpos, barrelYpos, damage);
			 * gameObjectList.push(tempBullet);
			 * bulletList.push(tempBullet);
			 * bulletLayer.addChild(tempBullet);
			 * currentAmmo--;
			 */
			 if(bulletList.length < clipSize)
			 {
			 	tempBullet = new Bullet(barrelXpos, barrelYpos, damage);
				 bulletList.push(tempBullet);
			 	addChild(tempBullet);
				currentAmmo--;
			 } 
			 
		}
		
		public override function update()
		{
			
			for (var i:int = 0; i < bulletList.length; i++)
			{
				bulletList[i].update();
				trace("bulletList[i].x: " + bulletList[i].x);
				if(bulletList[i].age > BULLET_AGE)
				{	
					removeChild(bulletList[i]);
					bulletList.splice(i,1);
				}
				if(bulletList[i].x > stage.stageWidth)
				{	
					removeChild(bulletList[i]);
					bulletList.splice(i,1);
				}
			}
			
			
		}
		
		
	}

}