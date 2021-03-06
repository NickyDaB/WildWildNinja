﻿package code
{
	import code.screens.Game;
	
	public class Enemy extends MovementVehicle{
		
		private var _health:int;
		private var _healthTotal:int;
		protected var _healthBar:HealthBar;
		private var _healthBarMaxWidth:Number;
		
		private var _enemyManager:EnemyManager;
		
		//Behaviors
		private var _type:Number; 
		// 0 - Base Behavior
		// 1 - Idle
		// 2 - Charge
		// 3 - Patrol/Charge
		// 4 - Shoot -- Idle
		// 5 - Shoot -- Patrol
		
		//Patrolling Variables
		protected var _patrolPoint:Number; // Inital Spawn point to determine area of patrol
		protected var _patrolDistance:Number // Distance the enemy will walk while patrolling
		protected var _lookDirection:Boolean; // True for left, False for Right
		
		//ShooterManager Placeholder to allow for bullet attacks

		//Accessors and modifers
		public function set lowerHealth(minus:int) {
			
			_health -= minus;
			var _widthPercent:Number = _health/_healthTotal;
			_healthBar.Green_bar.width = _healthBarMaxWidth * _widthPercent;
			
		}
		
		public function set behaviorType(action:Number) {_type = action}
		public function set patrolPoint(moveDistance:Number) {_patrolPoint = moveDistance}
		
		public function get health() {return _health;}
		public function get behaviorType() {return _type;}
		public function get patrolPoint() {return _patrolPoint;}


		public function Enemy(xPlace:int, yPlace:int, enemMan:EnemyManager, aGame:Game, patrol:Number = 25, beha:Number = 0) {
			
			super(aGame,xPlace, yPlace);
			
			
			_enemyManager = enemMan;
			
			x = xPlace;
			y = yPlace;
			
			_game = aGame;
			
			
			
			_health = 50;
			_healthTotal = 50;
			//trace(xPlace, yPlace);
			
			// --------------------- Behavoirs ----------------------
			
			_type = 0;
			_patrolPoint = xPlace;
			_patrolDistance = patrol;
			_lookDirection = false;
			
			// -------------------------------------------------------
			
			
			// Health Bar
			_healthBar = new HealthBar(xPlace , yPlace - height + 48, health);
			_healthBarMaxWidth = _healthBar.Green_bar.width;
			_game.entityLayer.addChild(_healthBar);
			
		}
		
		override protected function calcSteeringForce():Vector2 {
			var steeringForce:Vector2 = new Vector2();
			
			_healthBar.x = this.position.x;
			_healthBar.y = this.position.y - height + 48;
			
			
			//Base
			if(_type == 0){
				_velocity = new Vector2();
				return steeringForce;
				
			}
			 
			//idle
			if(_type == 1) {
				_velocity = new Vector2();
				return steeringForce;
			}
			
			//Charge
			if(_type == 2){
				
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
			
			//Patrol -- Charge
			if(_type == 3)
			{
				
				//trace(_lookDirection);
				//Left
				if(_lookDirection){
					if(((_game.player.x > (x - 250)) && (_game.player.x <= x )) &&
						((_game.player.y >= (y - 20)) && (_game.player.y < (y + 20)))){ // if player is infront of enemy's sight within 150 pixels
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
						((_game.player.y > y - 20) && (_game.player.y < y + 20))){ // if player is infront of enemy's sight within 150 pixels
						
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
				//trace(_lookDirection);
				
			
			//Shoot -- Idle
			if(_type == 4)
			{
				
				_velocity = new Vector2();
				
				if(((_game.player.x > x - 250) && (_game.player.x < x + 250)) &&
					((_game.player.y > y - 20) && (_game.player.y < y + 20))) {
					
					if(_game.player.x < x && _lookDirection == false ) {
						_lookDirection = true;
						scaleX *= -1;
					}
					
					if (_game.player.x > x && _lookDirection == true) {
						_lookDirection = false;
						scaleX *= -1;
					}
						
							//shoot at player's position
							trace("Bang! BANG! BANG! BANG! BANG!");
				}
				
				return steeringForce;
			}
			
			//Shoot - Patrol
			if(_type == 5) {
				
				//trace(_lookDirection);
				//Left
				if(_lookDirection){
					if(((_game.player.x > (x - 250)) && (_game.player.x <= x )) &&
						((_game.player.y >= (y - 20)) && (_game.player.y < (y + 20)))){ // if player is infront of enemy's sight within 150 pixels
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
					if(((_game.player.x < (x + 250)) && (_game.player.x >= x)) && 
						((_game.player.y > y - 20) && (_game.player.y < y + 20))){ // if player is infront of enemy's sight within 150 pixels
						
							trace("Immmmmmaaaa Shooootingggg");
							_velocity = new Vector2();
							//trace("found");
					}
					else {
						
						if(x >= (_patrolPoint + (_patrolDistance * 3))) {scaleX *= -1; _lookDirection = true;}
						return patrol();
						
					}
				}
			}
			
			
			//draws line to show direction and speed (Based on velocity)
			//_game.drawLine(position.x,position.y, (position.x + velocity.x), (position.y + velocity.y));
			
			// ------------------------------------------- NEEDS COLLISION
			
			
			return steeringForce;

		}
		
		public function patrol():Vector2 {
			
			var steeringForce:Vector2 = new Vector2();
			
			
			if ((x < (_patrolPoint + (_patrolDistance * 3))) && (_lookDirection == false)) {
								steeringForce.plusEquals(seek(new Vector2(_patrolPoint + (_patrolDistance * 3), y)));
								return steeringForce;
								//trace("patrol");
							}
			else if (x >= (_patrolPoint - (_patrolDistance * 3))) {
								steeringForce.plusEquals(seek(new Vector2(_patrolPoint - (_patrolDistance * 3), y)));
								return steeringForce;
								//_lookDirection = true;
								//trace("patrol");
							}
			
							
			return steeringForce;				
							
		}

		public function destroy():void{
			
			_game.entityLayer.removeChild(_healthBar);
			
		}

	}
}
	

