package com.kraigwalker.StarShooter {
	
	import com.adamatomic.flixel.*;
	import flash.text.TextFormatAlign;

	/**
	 * @author kraigwalker
	 */
	public class deadState extends FlxState {
		[Embed(source="assets/cursor.png")]private var Cursor:Class;
		[Embed(source="assets/gameover.mp3")] private var GameoverSnd:Class;
		public function deadState() {
			super();
			
			FlxG.setCursor(Cursor);
			FlxG.play(GameoverSnd);
			var buttonPos:uint = FlxG.width/2 -54;
			
			var unlucky:FlxText = new FlxText(0, 100, 320, 200, "Unlucky Sucka!!", 0xffffff, null, 10, TextFormatAlign.CENTER);
			var unlucky2:FlxText = new FlxText(0, 120, 320, 200, "In Space: No one can hear you Scream!", 0xffffff, null, 10, TextFormatAlign.CENTER);
			
			this.add(unlucky);
			this.add(unlucky2);
			
			var playAgain:FlxText = new FlxText(25, 1, 100, 10, "Play Again", 0xfffff);
			var playBtn:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
			var mainBtnBack:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
			var mainMenu:FlxText = new FlxText(25, 1, 100, 10, "Main Menu", 0xfffff);
			
			this.add(new FlxButton(buttonPos, 150, playBtn, playAgainHandler, playBtn, playAgain, playAgain)) as FlxButton;
		
			this.add(new FlxButton(buttonPos, 180, mainBtnBack, mainMenuHandler, mainBtnBack, mainMenu, mainMenu)) as FlxButton;
		}

		private function playAgainHandler() : void 
		{
			FlxG.switchState(Level1);
		}
		private function mainMenuHandler() : void 
		{
			FlxG.switchState(MenuState);
		}
	}
}
