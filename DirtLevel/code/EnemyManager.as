﻿package code
{
	import code.screens.Game;
	
	public class EnemyManager {
		
		//720 x 480
		
		//Notes current level to denote what enemy loadout to spawn
		private var _currLvl:int;
		
		//Notes player location in level to handle spawning enemies at proper time
		private var _playerLocation:int;
		
		private var _enemyList:Array;
		private var _enemy:Enemy;
		
		private var _game:Game;
		
		
		//Accessors and Modifiers
		public function get enemyList() {return _enemyList;}
		//public function get Document() {return _game;}
		
		public function set currentLevel(level:int) {_currLvl = level;}
		//public function set playerLocation(locate:int) {_playerLocation = locate;} ---> Probably don't need but made it anyway
		
		

		public function EnemyManager(aGame:Game) {
			// constructor code
			
			_game = aGame;
			
			_enemyList = new Array;
			//413 = y 33 = x 
			_enemy = new PickAxeMan(500,385,this, aGame, 25, 1);
			//_enemy = new Enemy(500,385,this,aDoc,0);
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
			 _enemy = new Enemy(500,385,this, _game);
			 _enemyList.push(_enemy);
			 _game.entityLayer.addChild(_enemy);
			
		}
		
		public function changeBehavior():void {
			
			_enemyList[0].behaviorType += 1;
			
			if(_enemyList[0].behaviorType == 4)
			{
				_enemyList[0].behaviorType = 0;
			}
			
			trace(_enemyList[0].behaviorType);
		}
		
		public function update(playerX:int, playerY:int, dt:Number):void {
			_playerLocation = playerX;
			
			for(var i:int = 0; i < _enemyList.length; i++)
			{
				_enemyList[i].update(dt);
				
				for (var j:int = 0; j < _game.weaponList.length; j++) {
					if (_game.weaponList[j].x + _game.weaponList[j].width > _enemyList[i].x)
					{
						trace("OMG BULLET!");
						_enemyList[i].lowerHealth = _game.weaponList[j].damage;
						_game.entityLayer.removeChild(_game.weaponList[j]);
						_game.weaponList.splice(j, 1);
						
					}
				}
				
				if(_enemyList[i].health <= 0)
				{
					_game.entityLayer.removeChild(_enemyList[i]);
					_enemyList[i].destroy();
					_enemyList.splice(i,1);
				}
				
				
				
			}
			
		}

	}
	
}
