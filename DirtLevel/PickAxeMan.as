package  {
	
	public class PickAxeMan extends Enemy{
		
		private var lookDirection:Boolean;
<<<<<<< HEAD

		public function PickAxeMan(xPlace:int, yPlace:int, enemMan:EnemyManager, aDoc:Document, patrol:Number = 25, beha:Number = 3) {
			// constructor code
			super(xPlace, yPlace, enemMan, aDoc, patrol, beha);
			_lookDirection = true;
		}
		
=======
		
		private var _type:Number;

		public function PickAxeMan(xPlace:int, yPlace:int, enemMan:EnemyManager, aDoc:Document, 
			patrol:Number = 25, beha:Number = 0) {
			// constructor code
			super(xPlace, yPlace, enemMan, aDoc, patrol, beha);
			_lookDirection = true;
				
			_type = beha;
		
		}
		
		override public function set behaviorType(action:Number) {_type = action}
		
		override public function get behaviorType() {return _type;}
		
>>>>>>> origin/Alex
		//Patrol Area, then charge if sees Player
		override protected function calcSteeringForce():Vector2 {
			
			_healthBar.x = this.position.x;
			_healthBar.y = this.position.y - height + 48;
			
			var steeringForce:Vector2 = new Vector2();
			
<<<<<<< HEAD
=======
			//Base: Patrol / Chase Down the Player / Swing PickAxe?
			if(_type == 0) {
>>>>>>> origin/Alex
			//trace(_lookDirection);
				//Left
				if(_lookDirection){
					if(((_document.player.x > (x - 250)) && (_document.player.x <= x )) &&
<<<<<<< HEAD
						((_document.player.y >= (y - 40)) && (_document.player.y < (y + 40)))){ // if player is infront of enemy's sight within 150 pixels
=======
						((_document.player.y >= (y - 40)) && (_document.player.y < (y + 40)))){ // if player is infront of enemy's 
																								//sight within 150 pixels
>>>>>>> origin/Alex
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
<<<<<<< HEAD
						((_document.player.y > y - 40) && (_document.player.y < y + 40))){ // if player is infront of enemy's sight within 150 pixels
=======
						((_document.player.y > y - 40) && (_document.player.y < y + 40))){ // if player is infront of enemy's sight
																						   //within 150 pixels
>>>>>>> origin/Alex
						
							steeringForce.plusEquals(seek(_document.player._position));
							return steeringForce;
							//trace("found");
					}
					else {
						
						if(x >= (_patrolPoint + (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = true;}
						return patrol();
						
					}
				}
<<<<<<< HEAD
				
=======
			}
			
			//Idle
			if(_type == 1) {
				_velocity = new Vector2();
				return steeringForce;
			}
			
			//Straight Charge
			if(_type == 2) {
				
				if(_document.player.x < x && _lookDirection == false ) {
						_lookDirection = true;
						scaleX *= -1;
					}
						
				if (_document.player.x >= x && _lookDirection == true) {
						_lookDirection = false;
						scaleX *= -1;
					}
				
				steeringForce.plusEquals(seek(_document.player._position));
					
			}
			
>>>>>>> origin/Alex
				return steeringForce;
				
		}

	}
	
}
