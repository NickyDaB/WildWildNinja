package code
{
	import flash.display.MovieClip;
	import code.screens.Game;
	
	public class PhysicsObject extends MovieClip
	{
		protected var _position : Vector2;
		protected var _fwd : Vector2;
		protected var _velocity : Vector2;
		protected var _speed : Number;
		protected var _game: Game;
		
		//constructor
		public function PhysicsObject(aGame:Game, anX:Number = 0, aY:Number = 0) {
			
			_game = aGame;
			x = anX;
			y = aY;
			_position = new Vector2(x, y);
			_speed = 0; //arbitrary value for convenience
			_fwd = new Vector2(1, 0);
			_velocity = Vector2.multiply(_fwd, _speed);
		
		}
		
		//******accessors and mutators -- getters and setters
		public function get position( )	: Vector2	{ return  _position;}
		public function get fwd( )		: Vector2	{ return _fwd;		}
		public function get speed( )	: Number	{ return _speed;	}
		public function get velocity()	:Vector2 	{ return _velocity;	}
		
		public function set position(pos : Vector2): void
		{
			_position.x = pos.x;
			_position.y = pos.y;
			x = pos.x;
			y = pos.y;
		}
		
		//when assigning a new value to fwd, the vector must be adjusted with a slight rotation
		public function set fwd(vec: Vector2): void
		{
			if (vec.x != 0 && vec.y != 0)
			{
				_fwd.x = vec.x;
				_fwd.y = vec.y;
				_fwd.normalize( );
				rotation = _fwd.angle;
			}
		}	

		public function set speed(amt:Number):void	{_speed = amt; }
		//******End Accessors and Mutators
		
		//---------- Main Body of Class --------------//
		
		public function update( dt : Number): void
		{
			// calculate velocity
			// call move to update position
			_velocity =Vector2.multiply(_fwd, _speed);
			move(Vector2.multiply(_velocity, dt));
		}
		
			public function turnRight(ang: Number): void
		{
			// change rotation
			// change forward vector to reflect new orientation
			rotation += ang;
			_fwd = Vector2.degToVector(rotation);
		}
		
		public function turnLeft(ang: Number): void
		{
			// change rotation
			// change forward vector to reflect new orientation
			rotation -= ang;
			_fwd = Vector2.degToVector(rotation);
		}
		
		
		public function move( moveVector:Vector2): void
		{
			// calculate new position by adding the moveVector to the old position
			// update MovieClip's coordinates 
			_position.plusEquals(moveVector); 
			x = _position.x;
			y = _position.y;
		}
		
		//-----------------INFO-----------------//
		
		override public function toString( ): String
		{
			
			return "x:" + x + ", y:" + y;;
		}
	
	}


}