package  
{
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class Weapon extends GameObject
	{
		//attributes
		public var weaponName:String;
		public var damage:Number;
		public var clipSize:Number;
		public var barrelXpos:Number;
		public var barrelYpos:Number;
		
		//currently unused attributes
		public var currentAmmo:Number;
		public var maxAmmo:Number;
		public var maxSpareMags:Number;
		
		//stupid shit to get it to work
		public var _holderOfTheWeapon;
		public var tempBullet:Bullet;
		public var doc:Document;
		public var tempHandX:Number;
		public var tempHandY:Number;
		
		/*
		 * NOTE: Weeze says eventually all weapon animations will include arms.
		 * So when we get those animations into the program, we will probably 
		 * change how the weapon draws in relative locations. 
		 * 
		 * IE: right now I have these variables called holderOfWeapon & holderOfWeapon.handX et et
		 * 
		 * For now leave it as is.
		 * 
		 */
		
		public function Weapon(holderOfWeapon, iDoc:Document){
			super(holderOfWeapon.x + holderOfWeapon.handX, holderOfWeapon.y + holderOfWeapon.handY);
			obeyGravity = false;
			
			_holderOfTheWeapon = holderOfWeapon;
			
			doc = iDoc;
			
			barrelXpos = holderOfWeapon.handX;
			barrelYpos = holderOfWeapon.handY;
			
			tempHandX = holderOfWeapon.handX;
			tempHandY = holderOfWeapon.handY;
			
			damage = 0;
			weaponName = "Nothing";
			clipSize = 0;
			
			trace("weaponName: " + weaponName );
			trace("damage: " + damage );
			trace("clipSize: " + clipSize );
		}
		
		public function changeWeapon() {
			this.nextFrame();
			trace("weaponName: " + weaponName );
			trace("damage: " + damage );
			trace("clipSize: " + clipSize );
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
			//trace("_holderOfTheWeapon.x: " + _holderOfTheWeapon.x);
			//trace("_holderOfTheWeapon.y: " +_holderOfTheWeapon.y);
			//trace("barrelXpos: " + barrelXpos);
			//trace("_holderOfTheWeapon.x+tempHandX+barrelXpos: " + (_holderOfTheWeapon.x+tempHandX+barrelXpos));
			/*trace("_holderOfTheWeapon.x: " + _holderOfTheWeapon.x);
			trace("_holderOfTheWeapon.y: " +_holderOfTheWeapon.y);
			trace("barrelYpos: " + barrelYpos);
			trace("_holderOfTheWeapon.y+tempHandY+barrelYpos: " + (_holderOfTheWeapon.y+tempHandY+barrelYpos));*/
			if (this.currentFrame == 1){
				trace("no weapon - punch?");
			}else if (this.currentFrame == 2) {
				trace("sword slash");
			}else{
				tempBullet = new Bullet(_holderOfTheWeapon.x + tempHandX + barrelXpos, _holderOfTheWeapon.y + tempHandY + barrelYpos, damage, 10);
				doc.gameObjectList.push(tempBullet);
				doc.weaponList.push(tempBullet);
				doc.entityLayer.addChild(tempBullet);
			}
		}
		
		public function enemyShoot(direction:Boolean)
		{
			
			
			tempBullet = new Bullet(_holderOfTheWeapon.x ,_holderOfTheWeapon.y, damage, 10, direction);
			doc.gameObjectList.push(tempBullet);
			doc.enemyWeaponList.push(tempBullet);
			doc.entityLayer.addChild(tempBullet);
			
		}
		
		override public function update():void
		{
			x = _holderOfTheWeapon.x + _holderOfTheWeapon.width;
			y = _holderOfTheWeapon.y + _holderOfTheWeapon.height / 2;
		}
		
		
		
	}

}