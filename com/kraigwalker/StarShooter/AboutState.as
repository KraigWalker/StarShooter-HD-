package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.FlxState;
	import com.adamatomic.flixel.FlxText;
	import com.adamatomic.flixel.FlxSprite;
	import com.adamatomic.flixel.FlxButton;
	import com.adamatomic.flixel.FlxG;
	

	/**
	 * @author kraigwalker
	 */
	public class AboutState extends FlxState {
		
		[Embed(source="assets/aboutback.mp3")] private var AboutBackHit:Class;
		[Embed(source="assets/cursor.png")] private var Cursor:Class;
		
		private var aboutBack:FlxText = new FlxText(25, 1, 100, 10, "Back", 0xfffff);					//the string inside the "Back Button"
		private var aboutBackBtn:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
	
		
		public function AboutState() {
			super();
			FlxG.setCursor(Cursor);	
			var buttonPos:uint = FlxG.width/2 -54;		//define button x position (Middle of Screen)
			this.add(new FlxButton(buttonPos, 210, aboutBackBtn, AboutScreenFade, aboutBackBtn, aboutBack, aboutBack)) as FlxButton;
			this.add(new FlxText(0, 40, FlxG.width, 80, "StarShooter HD", 0xffffff, null, 20, "center"));
			this.add(new FlxText(0, 70, FlxG.width, 80, "Developed by Kraig Walker", 0xffffff, null, 10, "center"));
			this.add(new FlxText(0, 90, FlxG.width, 80, "At The University of Abertay Dundee", 0xffffff, null, 10, "center"));
			this.add(new FlxText(0, 110, FlxG.width, 80, "1000272@live.abertay.ac.uk", 0xffffff, null, 10, "center"));
		
		}
		private function AboutScreenFade():void{
			FlxG.flash(0xffffff, 0.75);
			FlxG.fade(0xff000000, 1, onAboutScreenFade);
			FlxG.play(AboutBackHit);
		}
		private function onAboutScreenFade():void{
			FlxG.switchState(MenuState);			//display main menu
		}
	}
}
