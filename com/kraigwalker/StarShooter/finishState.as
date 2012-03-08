package com.kraigwalker.StarShooter {
	
	import com.adamatomic.flixel.*;
	import flash.text.TextFormatAlign;
	import com.kraigwalker.StarShooter.Level1;

	/**
	 * @author kraigwalker
	 */
	public class finishState extends FlxState {
		[Embed(source="assets/cursor.png")]private var Cursor:Class;
		public function finishState() {
			super();
			
			FlxG.setCursor(Cursor);
			
			var buttonPos:uint = FlxG.width/2 -54;
			
			var lucky:FlxText = new FlxText(0, 100, 320, 200, "Dammit! You Beat My Game!", 0xffffff, null, 10, TextFormatAlign.CENTER);
			
			this.add(lucky);
			
			var playAgain:FlxText = new FlxText(25, 1, 100, 10, "Play Again", 0xfffff);
			var playBtn:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
			var mainBtnBack:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
			var mainMenu:FlxText = new FlxText(25, 1, 100, 10, "Main Menu", 0xfffff);
			
			this.add(new FlxButton(buttonPos, 150, playBtn, playAgainHandler, playBtn, playAgain, playAgain)) as FlxButton;
			this.add(new FlxButton(buttonPos, 150, mainBtnBack, mainMenuHandler, mainBtnBack, mainMenu, mainMenu)) as FlxButton;
		}

		private function playAgainHandler(score:int) : void 
		{
			score = 0;
			FlxG.switchState(Level1);
		}
		private function mainMenuHandler() : void 
		{
			FlxG.score = 0;
			FlxG.switchState(MenuState);
		}
	}
}