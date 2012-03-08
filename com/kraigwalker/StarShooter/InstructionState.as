package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.FlxState;
	import com.adamatomic.flixel.FlxSprite;
	import com.adamatomic.flixel.FlxText;
	import com.adamatomic.flixel.FlxG;
	import com.adamatomic.flixel.FlxButton;

	/**
	 * @author kraigwalker
	 */
	public class InstructionState extends FlxState {
		
		[Embed(source="assets/back.mp3")] private var BackSnd:Class;
		[Embed(source="assets/cursor.png")] private var Cursor:Class;
		
		private var instructionsBack:FlxText = new FlxText(25, 1, 100, 10, "Back", 0xfffff);					//the string inside the "Back Button"
		private var instructionsBackBtn:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
		
		public function InstructionState() {
			super();
			FlxG.setCursor(Cursor);	
			var buttonPos:uint = FlxG.width/2 -54;		//define button x position (Middle of Screen)
			this.add(new FlxButton(buttonPos, 210, instructionsBackBtn, MenuFade, instructionsBackBtn, instructionsBack, instructionsBack)) as FlxButton;
			this.add(new FlxText(0, 40, FlxG.width, 80, "Your Mission Is To Destroy as Many", 0xffffff, null, 10, "center"));
			this.add(new FlxText(0, 60, FlxG.width, 80, "Aliens As You Can", 0xffffff, null, 10, "center"));
			this.add(new FlxText(0, 100, FlxG.width, 80, "CONTROLS", 0xffffff, null, 10, "center"));
			this.add(new FlxText(0, 120, FlxG.width, 80, "Use The Arrow Keys To Move Left & Right etc.", 0xffffff, null, 10, "center"));
			this.add(new FlxText(0, 140, FlxG.width, 80, "Press Space Bar or C To Fire", 0xffffff, null, 10, "center"));
			this.add(new FlxText(0, 160, FlxG.width, 80, "Can You Survive All 10 Rounds?", 0xffffff, null, 10, "center"));
		}
		override public function update():void{	
			super.update();
		}
		private function onFade():void{
			FlxG.switchState(Level1);
		}
		private function MenuFade():void{
			FlxG.flash(0xffffff, 0.75);
			FlxG.fade(0xff000000, 1, onMenuFade);
			FlxG.play(BackSnd);
		}
		private function onMenuFade():void{
			FlxG.switchState(MenuState);
		}
	}
}
