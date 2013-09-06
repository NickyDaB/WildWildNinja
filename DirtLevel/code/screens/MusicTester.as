package code.screens {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import code.Document;
	import code.PartOne;
	import code.PartTwo;
	import code.Sneaky;
	
	
	public class MusicTester extends Screen {
		
		//Sound to hold file
		var sdn:Sound;
		var soundChannel:SoundChannel;
		
		//fields
		var songCounter:int;
		var pausePosition:int;
		var previousSong:int;
		var paused:Boolean;
		var playing:Boolean;
		
		//Sound Array
		var sndArray:Array;
		
		//Songs for Array
		var partOne:Sound = new PartOne();
		var partTwo:Sound = new PartTwo();
		var sneaky:Sound = new Sneaky();
		
		public function MusicTester(doc:Document) {
			// constructor code
			super(doc);
			songCounter = 0;
			paused = false;
			playing = false;
			sndArray = new Array();
			
			sndArray.push(partOne);
			sndArray.push(partTwo);
			sndArray.push(sneaky);
			
		}
		
		public override function bringIn()
		{			  
			  super.bringIn();
			  playBtn.addEventListener(MouseEvent.CLICK, playMusic);
			  stopBtn.addEventListener(MouseEvent.CLICK, pauseMusic);
			  nextBtn.addEventListener(MouseEvent.CLICK, changeMusicForward);
			  previousBtn.addEventListener(MouseEvent.CLICK, changeMusicBackwards);
			  
		}
		
		private function changeMusicForward(e:MouseEvent) {
			
			soundChannel.stop();
			
			previousSong = songCounter;
			if(songCounter <= 1) songCounter++;
			
			if(previousSong != songCounter) {
				soundChannel = sndArray[songCounter].play();
				playing = true;
			}
			
		}
		
		private function changeMusicBackwards(e:MouseEvent) {
			
			soundChannel.stop();
			
			previousSong = songCounter;
			if(songCounter >= 1) songCounter--;
			
			if(previousSong != songCounter) {
				soundChannel = sndArray[songCounter].play();
				playing = true;
			}
		}
		
		private function pauseMusic(e:MouseEvent) {
			
			if(soundChannel != null) {
				pausePosition = soundChannel.position;
				soundChannel.stop();
				paused = true;
				playing = false;
			}
		}
		
		private function playMusic(e:MouseEvent) {
			if(paused == true) { 
				paused = false;
				soundChannel = sndArray[songCounter].play(pausePosition);
				playing = true;
			}else if(playing == false) {
				
				soundChannel = sndArray[songCounter].play();
				playing = true;
				
			}
			
			
		}
		
		public override function cleanUp()
		{
			  playBtn.removeEventListener(MouseEvent.CLICK, playMusic);
			  stopBtn.removeEventListener(MouseEvent.CLICK, pauseMusic);
			  nextBtn.removeEventListener(MouseEvent.CLICK, changeMusicForward);
			  previousBtn.removeEventListener(MouseEvent.CLICK, changeMusicBackwards);
			  super.cleanUp();
		}

	}
	
}
