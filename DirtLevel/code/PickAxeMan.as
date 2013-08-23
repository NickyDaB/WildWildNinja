package code
{
	import code.screens.Game;
	
	public class PickAxeMan extends Enemy{
		
		private var lookDirection:Boolean;
		
		private var _type:Number;

		public function PickAxeMan(xPlace:int, yPlace:int, enemMan:EnemyManager, aGame:Game, 
			patrol:Number = 25, beha:Number = 0) {
			// constructor code
			super(xPlace, yPlace, enemMan, aGame, patrol, beha);
			_lookDirection = true;
				
			_type = beha;
		
		}
		
		override public function set behaviorType(action:Number) {_type = action}
		
		override public function get behaviorType() {return _type;}
		
		//Patrol Area, then charge if sees Player
		override protected function calcSteeringForce():Vector2 {
			
			_healthBar.x = this.position.x;
			_healthBar.y = this.position.y - height + 48;
			
			var steeringForce:Vector2 = new Vector2();
			
			//Base: Patrol / Chase Down the Player / Swing PickAxe?
			if(_type == 0) {

			//trace(_lookDirection);
				//Left
				if(_lookDirection){
					if(((_game.player.x > (x - 250)) && (_game.player.x <= x )) &&
						((_game.player.y >= (y - 40)) && (_game.player.y < (y + 40)))){ // if player is infront of enemy's 
																								//sight within 150 pixels
						 // if player is within vertical sightline of enemy
						steeringForce.plusEquals(seek(_game.player._position));
						return steeringForce;
					}
					else {
						
							if(x < (_patrolPoint - (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = false;}
							return patrol();
					}
				}
				//right
				else {
					if(((_game.player.x < (x + 250)) && (_game.player.x >= x)) && 

						((_game.player.y > y - 40) && (_game.player.y < y + 40))){ // if player is infront of enemy's sight
																						   //within 150 pixels
						
							steeringForce.plusEquals(seek(_game.player._position));
							return steeringForce;
							//trace("found");
						}
						else {
							
							if(x >= (_patrolPoint + (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = true;}
							return patrol();
							
						}
					}

				}
						
			//Idle
			if(_type == 1) {
				_velocity = new Vector2();
				return steeringForce;
			}
			
			//Straight Charge
			if(_type == 2) {
				
				if(_game.player.x < x && _lookDirection == false ) {
						_lookDirection = true;
						scaleX *= -1;
					}
						
				if (_game.player.x >= x && _lookDirection == true) {
						_lookDirection = false;
						scaleX *= -1;
					}
				
				steeringForce.plusEquals(seek(_game.player._position));
					
			}
			

				return steeringForce;
				
		}

	}
	
}
