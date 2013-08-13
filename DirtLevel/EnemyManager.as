package  {
	
	public class EnemyManager {
		
		//720 x 480
		
		//Notes current level to denote what enemy loadout to spawn
		private var _currLvl:int;
		
		//Notes player location in level to handle spawning enemies at proper time
		private var _playerLocation:int;
		
		private var _enemyList:Array;
		private var _enemy:Enemy;
		
		private var _document:Document;
		
		
		//Accessors and Modifiers
		public function get enemyList() {return _enemyList;}
		//public function get Document() {return _document;}
		
		public function set currentLevel(level:int) {_currLvl = level;}
		//public function set playerLocation(locate:int) {_playerLocation = locate;} ---> Probably don't need but made it anyway
		
		

		public function EnemyManager(aDoc:Document) {
			// constructor code
			
			_document = aDoc;
			
			_enemyList = new Array;
			//413 = y 33 = x 
			_enemy = new Enemy(500,385,this, aDoc);
			_enemyList.push(_enemy);
			
			
			
			_currLvl = 1;
			_playerLocation = 0;
			
		}
		
		public function scrollEnemy(xShift:Number, yShift:Number):void {
			
			for( var i:int = 0; i < _enemyList.length; i++) {
				
				//Add moving for x and y, and patrol point
				_enemyList[i].position.x += xShift;
				_enemyList[i].position.y += yShift;
				_enemyList[i].patrolPoint += xShift;
			}
			
		}
		
		public function spawnEnemy():void {
			 _enemy = new Enemy(500,385,this, _document);
			 _enemyList.push(_enemy);
			 _document.addChild(_enemy);
			
		}
		
		public function changeBehavior():void {
			
			_enemyList[0].behaviorType += 1;
			
			if(_enemyList[0].behaviorType == 6)
			{
				_enemyList[0].behaviorType = 1;
			}
			
			trace(_enemyList[0].behaviorType);
		}
		
		public function update(playerX:int, playerY:int, dt:Number):void {
			_playerLocation = playerX;
			
			for(var i:int = 0; i < _enemyList.length; i++)
			{
				_enemyList[i].update(dt);
				
				for (var j:int = 0; j < _document.weaponList.length; j++) {
					if (_document.weaponList[j].x + _document.weaponList[j].width > _enemyList[i].x)
					{
						trace("OMG BULLET!");
						_enemyList[i].lowerHealth = _document.weaponList[j].damage;
						_document.bulletLayer.removeChild(_document.weaponList[j]);
						_document.weaponList.splice(j, 1);
						
					}
				}
				
				if(_enemyList[i].health <= 0)
				{
					_document.removeChild(_enemyList[i]);
					_enemyList[i].destroy();
					_enemyList.splice(i,1);
				}
				
				
				
			}
			
		}

	}
	
}
