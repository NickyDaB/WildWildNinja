package code
{
	import code.screens.Game;
	
	public class MovementVehicle extends PhysicsObject
	{
		protected var _maxSpeed: Number = 150;
		protected var _maxForce: Number = 500;
		protected var _mass: Number = 1.0;
		protected var _radius:Number = 0;
		
		public function MovementVehicle(aGame:Game, aX:Number = 0, aY:Number = 0, aSpeed:Number = 0) {
			
			super(aGame,aX,aY);
			//initialize velocity to zero so that movement only comes from applied force
			_velocity = new Vector2();
			
		}
		
		//Accessors and Mutators
		public function set maxSpeed(s:Number)		{_maxSpeed = s;	}
		public function set maxForce(f:Number)		{_maxForce = f;	}
		public function get maxSpeed( )		{ return _maxSpeed;	}
		public function get maxForce( )		{ return _maxForce; }
		public function get right( )		{ return fwd.perpRight( ); }
		
		
		public function get radius():Number {
			
			if ((_radius == 0))
			{
				//save rotation, then erase so you can calculate proper radius without interference of rotated height and width
				var rot:Number = rotation;
				rotation = 0;
				_radius = Math.sqrt(((width * width) + height * height)) / 2;
				rotation = rot;
			}
			return _radius;
		}
		
		public function get mass()			{ return _mass;		}
		
		override public function update(dt:Number): void
		{
			//call calcSteeringForce (override  in subclass) to get steering force
			var steeringForce:Vector2 = new Vector2();
			steeringForce = calcSteeringForce( ); 
			
			// clamp steering force to max force
			clampSteeringForce(steeringForce);
	
			// calculate acceleration: force/mass
			var acceleration:Vector2 = Vector2.divide(steeringForce, _mass);
			// add acceleration for time step to velocity
			_velocity.plusEquals(Vector2.multiply(acceleration, dt));
			//_velocity = _velocity.plusEquals(acceleration.timesEquals(dt));
			// update speed to reflect new velocity
			_speed = _velocity.magnitude( );
			// update fwd to reflect new velocity 
			fwd = _velocity;
			// clamp speed and velocity to max speed
			if (_speed > _maxSpeed)
			{
				_speed = _maxSpeed;
				_velocity = Vector2.multiply(fwd, _speed);
			}
			// call move with velocity adjusted for time step
			move( Vector2.multiply(_velocity, dt));
		}
		
				
		protected function calcSteeringForce( ):Vector2
		{
			var steeringForce : Vector2 = new Vector2( );
			
			// override this function in subclasses by adding steering forces
			// using syntax like below (assuming target is a position vector)
			
			// steeringForce.plusEquals(seek(target));
			
			// multiple steering forces can be added to produce complex behavior
			
			return steeringForce;
		}

			
		private function clampSteeringForce(force: Vector2 ): void
		{
			var mag:Number = force.magnitude();
			if(mag > _maxForce)
			{
				force.divideEquals(mag);
				force.timesEquals(_maxForce);
			}
		}
		
			
		protected function seek(targPos : Vector2) : Vector2
		{
			// set desVel equal desired velocity
			var desVel:Vector2 = Vector2.subtract(targPos, position);
			
			
			// scale desired velocity to max speed
			desVel.normalize( );
			desVel.timesEquals(_maxSpeed);
			// subtract current velocity from desired velocity
			// to get steering force
			var steeringForce:Vector2 = Vector2.subtract(desVel, _velocity);
			//return steering force
			steeringForce.y = 0;
			return steeringForce;
		}
		
		//dir: true = left, false = right
		protected function step(dir:Boolean):Vector2 {
			
			var targPos:Vector2;
			
			if(dir)targPos = new Vector2(position.x - 1, position.y);
			else targPos = new Vector2(position.x + 1, position.y);
			
			var desVel:Vector2 = Vector2.subtract(targPos,position);
			desVel.normalize();
			desVel.timesEquals(_maxSpeed/10);
			
			var steeringForce:Vector2 = Vector2.subtract(desVel, _velocity);
			
			return steeringForce;
		}
		
		protected function flee(targPos : Vector2) : Vector2
		{
			// set desVel equal desired velocity
			var desVel:Vector2 = Vector2.subtract(position, targPos);

			// scale desired velocity to max speed
			desVel.normalize( );
			desVel.timesEquals(_maxSpeed);

			// subtract current velocity from desired velocity
			// to get steering force
			var steeringForce:Vector2 = Vector2.subtract(desVel, _velocity);
			//return steering force
			return steeringForce;
		}
		

		protected function avoid(obstaclePos:Vector2, 
								 obstacleRadius:Number, 
								 safeDistance:Number): Vector2 
		{
		var desVel: Vector2; //desired velocity
            var steeringForce:Vector2;
            
            var vectorToObstacleCenter:Vector2 = Vector2.subtract(obstaclePos, position);
            var distance: Number = vectorToObstacleCenter.magnitude();
            
            //if vectorToCenter - obstacleRadius longer than safe return zero vector
            if (((distance - obstacleRadius) - radius) > safeDistance)
            {
                return new Vector2();
            }
            
            // if object behind me return zero vector
            if ( vectorToObstacleCenter.dot (fwd) < 0)
            {
                return new Vector2();
            }
            
            var rightDotVTOC:Number = vectorToObstacleCenter.dot(right);
            
            // if sum of radii < dot of vectorToCenter with right return zero vector
            if ((obstacleRadius + radius) < Math.abs(rightDotVTOC))
            {
                return new Vector2();
            }
            
            //desired velocity is to right or left depending on 
            // sign of  dot of vectorToCenter with right 
            
            if ( rightDotVTOC > 0)
            {
                desVel = Vector2.multiply(right, -maxSpeed);
            }
            else
            {
                desVel = Vector2.multiply(right, maxSpeed);
            }        

            //subtract current velocity from desired velocity to get steering force
            steeringForce= Vector2.subtract(desVel, _velocity);
            
            //option: increase magnitude when obstacle is close
            steeringForce.timesEquals(safeDistance / Math.max(0.01, distance - obstacleRadius - radius));
            
            return steeringForce;
			//Math.max(0.01, distance - obstacleRadius - radius)
		}
		
		
		
		protected function stayInBounds():Vector2
		{
			var steeringForce : Vector2 = new Vector2( );
			
			if(position.x > 1000)
			{
				steeringForce = flee(new Vector2(1100,position.y));
			}
			
			if(position.x < 0)
			{
				steeringForce = flee(new Vector2(-100, position.y));
			}
			
			if(position.y > 800)
			{
				steeringForce = flee(new Vector2(position.x, 900));
			}
			
			if(position.y < 0)
			{
				steeringForce = flee(new Vector2(position.x, -100));
			}
			
			
			if(position.y > 800 || position.y < 0 || position.x > 1000 || position.x < 0)
			{
				steeringForce = seek(new Vector2(500,400));
			}
			
			steeringForce = Vector2.multiply(steeringForce, 5);			
			return steeringForce;
		}
		
		/*protected function fullSteamAhead ():Vector2
		{
			// Accelerate to maxSpeed
			var steeringForce = Vector2.subtract(Vector2.multiply(fwd, maxSpeed), velocity);
			return steeringForce;
			
		}
		*/
		
	
	}

}