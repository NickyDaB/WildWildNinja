package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Nick Buonarota
	 */
	public class Document extends Sprite
	{
		//Layers - Handles proper depth of all art on screen
		public var landscapeLayer:Sprite; //Clouds, Mountains
		public var backgroundLayer:Sprite; //Open space for other details
		public var midgroundLayer:Sprite; // Building Fronts
		public var detailLayer:Sprite; // Non-entities (Lamp Posts, non-interactable art)
		public var platformLayer:Sprite; // Interactable Art (Boxes, Barrels)
		public var entityLayer:Sprite; // Player, enemies, bullets
		public var foregroundLayer:Sprite; // Deatils infront of everything else (Flowers, Dust Clouds)
		
		//Lists for Layers - Gives us access to the data to move art on screen
		public var landscapeList:Array;
		public var landscapeShift:Number = .10; 
		
		public var backgroundList:Array;
		public var backgroundShift:Number = .25; 		
		
		public var midgroundList:Array;
		public var midgroundShift:Number = .5;
		
		public var detailList:Array;
		public var detailShift:Number = .75; 		
		
		public var platformList:Array; //Holds all Platforms and interactable objects
		public var platformShift:Number = .75;
		
		public var entityList:Array;		
		
		public var foregroundList:Array;
		public var foregroundShift:Number = 1.25;
		
		
		//MASTER VARIABLES
		public var gameObjectList:Array;
		public var _environmentList:Array; //Holds references to Art Assests and non interacatable objects
		public var temp:Number;
		public var weaponList:Array;
		public var enemyWeaponList:Array;
		
		
		//Game Objects
		public var testBlock:GameObject;
		public var testBlock32:Cube32;
		public var tempBlock32:Cube32;
		public var platTestBlock32:Cube32;
		public var player:Player;
		public var playerPos:Vector2;
		public var playerGunTest:characterStick;
		public var weapon:Weapon;
		//public var plat:Platform;
		
		/*
		//Michelle TEST
		public var gravity:int = 15;
		public var friction:int = 10;
		public var collision:Boolean = false;
		public var leftSlide:Boolean = false;
		public var rightSlide:Boolean = false;*/
		
		//AI Handler
		public var enemManager:EnemyManager;
		
		//AI Movement Timings
		private var _lastTime: Number;
		private var _curTime: Number;
		private var _dt: Number;
		
		public function Document() 
		{
			begin();
		}
		
		public function begin()
		{
			_lastTime = getTimer( );
			
			//create layers
			landscapeLayer =  new Sprite(); //Clouds, Mountains
			backgroundLayer =  new Sprite(); //Open space for other details
			midgroundLayer = new Sprite(); // Building Fronts
			detailLayer = new Sprite(); // Non-entities (Lamp Posts, non-interactable art)
			platformLayer = new Sprite(); // Interactable Art (Boxes, Barrels)
			entityLayer = new Sprite(); // Player, enemies, bullets
			foregroundLayer = new Sprite(); // Deatils infront of everything else (Flowers, Dust Clouds)
			
			//add layers as children
			
			
			addChild(landscapeLayer);
			addChild(backgroundLayer);
			addChild(midgroundLayer);
			addChild(detailLayer);
			addChild(platformLayer);
			addChild(entityLayer);
			addChild(foregroundLayer);
			
			//game Objects
			gameObjectList = new Array();
			weaponList = new Array();
			enemyWeaponList = new Array();
			_environmentList = new Array();
			
			landscapeList = new Array();
			backgroundList = new Array();
			midgroundList = new Array();
			detailList = new Array();
			platformList = new Array();
			entityList = new Array();
			foregroundList = new Array();
			
			//floorFiller();
			//EXAMPLE FORMAT:
			// X = new X();
			// push it onto the gameObjectList
			// child it to the appropriate layer
			//testBlock = new GameObject(350, 0);
			//gameObjectList.push(testBlock);
			//addChild(testBlock);
			player = new Player(60, 350, this);
			player.scaleX = .75;
			player.scaleY = .75;
			playerPos = new Vector2(60,375);
			//gameObjectList.push(player);
			entityLayer.addChild(player);
			/*playerGunTest = new characterStick(stage.stageWidth/2, stage.stageHeight/2, 30.5, 20);
			gameObjectList.push(playerGunTest);
			addChild(playerGunTest);*/
			weapon = new Weapon(player, this);
			gameObjectList.push(weapon);
			entityLayer.addChild(weapon);
			
			
			//addPlatform(283, 256, 270, 20);
			letsMakeALevel();
			
			/*platTestBlock32 = new Cube32(200, 200);
			gameObjectList.push(platTestBlock32);
			platformList.push(platTestBlock32);
			platformLayer.addChild(platTestBlock32);*/
			
			//Enemy Manager
			enemManager = new EnemyManager(this);
			entityLayer.addChild(enemManager.enemyList[0]);
			
			//Parllax Test
			var cube1:Cube32 = new Cube32(stage.stageWidth/2,16); //Landscape
			var cube2:Cube32 = new Cube32(stage.stageWidth/2,32); // Background
			var cube3:Cube32 = new Cube32(stage.stageWidth/2,48); // Midground
			var cube4:Cube32 = new Cube32(stage.stageWidth/2,64); // Detail
			var cube5:Cube32 = new Cube32(stage.stageWidth/2,80); // Foreground
			
			landscapeLayer.addChild(cube1);
			backgroundLayer.addChild(cube2);
			midgroundLayer.addChild(cube3);			
			detailLayer.addChild(cube4);
			foregroundLayer.addChild(cube5);
			
			landscapeList.push(cube1);
			backgroundList.push(cube2);
			midgroundList.push(cube3);			
			detailList.push(cube4);
			foregroundList.push(cube5);
			
			//Event Listeners
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, platformerInputPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, platformerInputRelease);
		}
		
		public function platformerInputPress(event:KeyboardEvent):void {
			//trace("you pressed key: " + event.keyCode);
			if (event.keyCode == 68 || event.keyCode == 39)
			{
				player.setXSpeed("RIGHT");

			}
			if (event.keyCode == 65 || event.keyCode == 37)
			{
				player.setXSpeed("LEFT");
			
			}
			if (event.keyCode == 32 || event.keyCode == 87 || event.keyCode == 38)
			{
				player.setYSpeed();
				//trace("jump");
			}
			if(event.keyCode == 83) {
				//this.y -= 5;
				
			}
			if (event.keyCode == 81)
			{
				weapon.changeWeapon();
			}
			//y
			if (event.keyCode == 89)
			{
				weapon.shoot();
				//enemManager.enemyList[0].lowerHealth = 5;
			}
			//u
			if (event.keyCode == 85)
			{
				enemManager.spawnEnemy();
			}
			if(event.keyCode == 67) // C button, changes behavoirs
			{
				enemManager.changeBehavior();
			}
		}
		
		public function platformerInputRelease(event:KeyboardEvent):void {
			//trace("you released key: " + event.keyCode);
			if (event.keyCode == 68 || event.keyCode == 39)
			{
				player.setXSpeed("STAND");
				
			}
			if (event.keyCode == 65 || event.keyCode == 37)
			{
				player.setXSpeed("STAND");
				
			}
			if (event.keyCode == 32 || event.keyCode == 87 || event.keyCode == 38)
			{
				player.setYSpeed();
			}else {
				player.setXSpeed("STAND");
			}
		}
		
		public function update(e:Event)
		{
			
			for (var j:int = 0; j < gameObjectList.length; j++)
			{
				gameObjectList[j].update();
			}
			
			player.update();
			//move player in Y direction
			
			//AI Timing for Movement
			_curTime = getTimer( );
			_dt = (_curTime - _lastTime)/1000;
			_lastTime = _curTime;
			graphics.clear();
			
			enemManager.update(player.x,player.y, _dt);
			//END Alex Stuff
			
			
		}
		
		public function addPlatform(xLoc:Number, yLoc:Number, w:Number, h:Number): void
		{
			var plat:Platform = new Platform();
			plat.x = xLoc;
			plat.y = yLoc;
			plat.width = w;
			plat.height = h;
			platformLayer.addChild(plat)
			platformList.push(plat);
		}
		
		public function scrollGame(xShift:Number, yShift:Number):void {
			var i:int = 0;			
			
			
			////for(var i:int = 0; i < _environmentList.length; i++) {
			//	
			//		_environmentList[i].x += xShift;
			//		_environmentList[i].y += yShift;
			//}
			
			for(i = 0; i < landscapeList.length; i++) {
					
					landscapeList[i].x += xShift * landscapeShift;
					landscapeList[i].y += yShift;
				
			}
			
			for(i = 0; i < backgroundList.length; i++) {
					
					backgroundList[i].x += xShift * backgroundShift;
					backgroundList[i].y += yShift;
				
			}
			
			for(i = 0; i < midgroundList.length; i++) {
					
					midgroundList[i].x += xShift * midgroundShift;
					midgroundList[i].y += yShift;
				
			}
			
			for(i = 0; i < detailList.length; i++) {
					
					detailList[i].x += xShift * detailShift;
					detailList[i].y += yShift;
				
			}
			
			for(i = 0; i < platformList.length; i++) {
					
					platformList[i].x += xShift * platformShift;
					platformList[i].y = platformList[i].y + yShift;
				
			}
			
			
			for(i = 0; i < foregroundList.length; i++) {
					
					foregroundList[i].x += xShift * foregroundShift;
					foregroundList[i].y += yShift;
				
			}
			
			for(i = 0; i < enemyWeaponList.length; i++)
			{
				enemyWeaponList[i].x += xShift;
				enemyWeaponList[i].y += yShift;
			}
			
			enemManager.scrollEnemy(xShift, yShift);
			
		}
		
		public function letsMakeALevel():void {
			
			// addPlatform(X Location, Y Location, width Height);
			//addPlatform(525, 150, 150, 20);
			//addPlatform(190, 260, 270, 20);
			addPlatform(-6000, 455, 14000, 70);
			
			//house
			addPlatform(240, 199, 480, 25);
			addPlatform(240, -57, 480, 25);
			addPlatform(240, -57, 25, 256);
			addPlatform(240, 199, 25, 128);
			addPlatform(720, -57, 25, 384);
			
			//Wall-Roof/Box
			addPlatform(1200, -57, 25, 528);
			addPlatform(944, 199, 256, 256);
			addPlatform(1200, -57, 528, 25);
			addPlatform(1728, -57, 25, 528);
			
			//Extra
			//addPlatform(1728, -57, 256, 16);
			
			//Roof
			addPlatform(1984, -57, 25, 528);
			addPlatform(1984, -57, 528, 25);
			addPlatform(2512, -57, 25, 528);
			
			//Extra
			//addPlatform(2512, -57, 256, 16);
			
			//Roof
			addPlatform(2768, -57, 25, 528);
			addPlatform(2768, -57, 320, 25);
			addPlatform(3216, -57, 64, 25);
			addPlatform(3280, -57, 25, 528);
			
			
			//Corridor
			addPlatform(3536, -57, 64, 25);
			addPlatform(3654, -57, 2240, 25);
			addPlatform(3536, -57, 25, 256);
			addPlatform(3536, 199, 2368, 25);
			
			
			
			
		}
		
	}

}