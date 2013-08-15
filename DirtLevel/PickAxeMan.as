package  {
	
	public class PickAxeMan extends Enemy{
		
		private var lookDirection:Boolean;

		public function PickAxeMan(xPlace:int, yPlace:int, enemMan:EnemyManager, aDoc:Document, patrol:Number = 25, beha:Number = 3) {
			// constructor code
			super(xPlace, yPlace, enemMan, aDoc, patrol, beha);
			_lookDirection = true;
		}
		
		//Patrol Area, then charge if sees Player
		override protected function calcSteeringForce():Vector2 {
			
			_healthBar.x = this.position.x;
			_healthBar.y = this.position.y - height + 48;
			
			var steeringForce:Vector2 = new Vector2();
			
			//trace(_lookDirection);
				//Left
				if(_lookDirection){
					if(((_document.player.x > (x - 250)) && (_document.player.x <= x )) &&
						((_document.player.y >= (y - 40)) && (_document.player.y < (y + 40)))){ // if player is infront of enemy's sight within 150 pixels
						 // if player is within vertical sightline of enemy
						steeringForce.plusEquals(seek(_document.player._position));
						return steeringForce;
					}
					else {
						
							if(x < (_patrolPoint - (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = false;}
							return patrol();
					}
				}
				//right
				else {
					if(((_document.player.x < (x + 250)) && (_document.player.x >= x)) && 
						((_document.player.y > y - 40) && (_document.player.y < y + 40))){ // if player is infront of enemy's sight within 150 pixels
						
							steeringForce.plusEquals(seek(_document.player._position));
							return steeringForce;
							//trace("found");
					}
					else {
						
						if(x >= (_patrolPoint + (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = true;}
						return patrol();
						
					}
				}
				
				return steeringForce;
				
		}

	}
	
}
