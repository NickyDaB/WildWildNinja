package  {
	
	public class BottleThrower extends Enemy{
		
		
		//Variables
		private var lookDirection:Boolean;
		
		private var bottle:Bottle;
		
		private var thrown:Boolean;
		
		public function BottleThrower(xPlace:int, yPlace:int, enemMan:EnemyManager, aDoc:Document, patrol:Number = 25, beha:Number = 3) {
			super(xPlace, yPlace, enemMan, aDoc, patrol, beha);
			
			this.position.x = xPlace;
			this.position.y = yPlace;
			
			lookDirection = false;
			
			thrown = false;
			
			//Add Bottle 
			bottle = new Bottle((this.x + 10),(this.y + 20));
			
			_document.enemyWeaponList.push(bottle);
			_document.foregroundLayer.addChild(bottle);
			
		}
		
		override protected function calcSteeringForce():Vector2 {
			//trace(_lookDirection);
				
			_healthBar.x = this.position.x;
			_healthBar.y = this.position.y - height + 48;
			
			
			var steeringForce:Vector2 = new Vector2();
				
				//Left
				if(_lookDirection){
					
					if(thrown == false) {
						bottle.x = this.position.x - 12;
						bottle.y = this.position.y + 18;
					}					
						
					if(((_document.player.x > (x - 250)) && (_document.player.x <= x )) &&
						((_document.player.y >= (y - 20)) && (_document.player.y < (y + 20)))){ // if player is infront of enemy's sight within 150 pixels
						 // if player is within vertical sightline of enemy
						trace("Immmmmmaaaa Shooootingggg");
						_velocity = new Vector2();
					}
					else {
						
							if(x < (_patrolPoint - (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = false;}
							return patrol();
					}
				}
				//right
				else {
					
					if(thrown == false) {
						bottle.x = this.position.x + 32;
						bottle.y = this.position.y + 18;
					}					
						
					if(((_document.player.x < (x + 250)) && (_document.player.x >= x)) && 
						((_document.player.y > y - 20) && (_document.player.y < y + 20))){ // if player is infront of enemy's sight within 150 pixels
						
							trace("Immmmmmaaaa Shooootingggg");
							_velocity = new Vector2();
							//trace("found");
					}
					else {
						
						if(x >= (_patrolPoint + (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = true;}
						return patrol();
						
					}
				}
				
				return	steeringForce;			
				
			}
		

	}
	
}
