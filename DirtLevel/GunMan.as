package  {
	
	
	public class GunMan extends Enemy {
		
		private var lookDirection:Boolean;	
		
		private var gunWeapon:Weapon;
		public var handX:Number;
		public var handY:Number;
		
		public var clip:Number;		 
		
		private var _type:int;
		
		public function GunMan(xPlace:int, yPlace:int, enemMan:EnemyManager, aDoc:Document, patrol:Number = 25, beha:Number = 3) {
			// constructor code
			super(xPlace, yPlace, enemMan, aDoc, patrol, beha);
			_lookDirection = true;
			
			gunWeapon = new Weapon(this, _document);
			gunWeapon.x = this.position.x - 12;
			gunWeapon.y = this.position.y + 18;
			
			gunWeapon.changeWeapon();
			gunWeapon.changeWeapon();
			
			gunWeapon.scaleX *= -1;
			 
			_document.enemyWeaponList.push(gunWeapon);
			_document.foregroundLayer.addChild(gunWeapon);
			
			handX = this.position.x - 12;
			handY = this.position.y + 18;
			
			_type = beha;
			
		}
		
		override public function set behaviorType(action:Number) {_type = action}
		
		override public function get behaviorType() {return _type;}
		
		override protected function calcSteeringForce():Vector2 {
			//Shoot - Patrol
			
			_healthBar.x = this.position.x;
			_healthBar.y = this.position.y - height + 48;
			
			var steeringForce:Vector2 = new Vector2();
	
			if(_type == 0){
				
				//trace(_lookDirection);
				//Left
				if(_lookDirection){
					
					 
					gunWeapon.x = this.position.x - 12;
					gunWeapon.y = this.position.y + 18;
					 
					if(((_document.player.x > (x - 450)) && (_document.player.x <= x )) &&
						((_document.player.y >= (y - 40)) && (_document.player.y < (y + 40)))){ // if player is infront of enemy's sight within 150 pixels
						 // if player is within vertical sightline of enemy
						gunWeapon.enemyShoot(false);
						_velocity = new Vector2();
					}
					else {
						
							if(x < (_patrolPoint - (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = false; 
								gunWeapon.scaleX *= -1;}
							return patrol();
					}
				}
				//right
				else {
					
					
					 
					gunWeapon.x = this.position.x + 32;
					gunWeapon.y = this.position.y + 18;
					 
					if(((_document.player.x < (x + 450)) && (_document.player.x >= x)) && 
						((_document.player.y > y - 40) && (_document.player.y < y + 40))){ // if player is infront of enemy's sight within 150 pixels
						
							gunWeapon.enemyShoot(true);
							_velocity = new Vector2();
							//trace("found");
					}
					else {
						
						if(x >= (_patrolPoint + (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = true; 
							gunWeapon.scaleX *= -1;}						
						return patrol();
						
					}
				}
			}
			
			//idle
			if(_type == 1) {
				if(lookDirection) {
						gunWeapon.x = this.position.x - 12;
						gunWeapon.y = this.position.y + 18;
				}
				else {
						gunWeapon.x = this.position.x + 32;
						gunWeapon.y = this.position.y + 18;
				}
				 
				_velocity = new Vector2();
				return steeringForce;
			}
			
			//idle - shoot
			if(_type == 2) {
				
							//trace(_lookDirection);
				//Left
				if(_lookDirection){
					
					 
					gunWeapon.x = this.position.x - 12;
					gunWeapon.y = this.position.y + 18;
					 
					if(((_document.player.x > (x - 450)) && (_document.player.x <= x )) &&
						((_document.player.y >= (y - 40)) && (_document.player.y < (y + 40)))){ // if player is infront of enemy's sight within 150 pixels
						 // if player is within vertical sightline of enemy
						gunWeapon.enemyShoot(false);
						_velocity = new Vector2();
					}
					else {
						
						_velocity = new Vector2();
						return steeringForce;
					}
				}
				//right
				else {
					
					
					 
					gunWeapon.x = this.position.x + 32;
					gunWeapon.y = this.position.y + 18;
					 
					if(((_document.player.x < (x + 450)) && (_document.player.x >= x)) && 
						((_document.player.y > y - 40) && (_document.player.y < y + 40))){ // if player is infront of enemy's sight within 150 pixels
						
							gunWeapon.enemyShoot(true);
							_velocity = new Vector2();
							//trace("found");
					}
					else {
						
						_velocity = new Vector2();
						return steeringForce;
						
					}
				}
				
			}
			
				return steeringForce;
				
			}			
			
		
	}
	
}
