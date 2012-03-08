package com.kraigwalker.StarShooter {

	import com.adamatomic.flixel.FlxState;
	import com.adamatomic.flixel.FlxG;
	import com.adamatomic.flixel.FlxText;
	import com.adamatomic.flixel.FlxSprite;
	import com.adamatomic.flixel.FlxButton;
	import com.kraigwalker.StarShooter.Background;	
	public class MenuState extends FlxState
	{
		[Embed(source="assets/menu_hit.mp3")] private var SndHit:Class;
		[Embed(source="assets/cursor.png")] private var Cursor:Class;
		[Embed(source="assets/forward.mp3")] private var InstructionHit:Class;
		[Embed(source="assets/about.mp3")] private var AboutHit:Class;
		[Embed(source="assets/stage.mp3")] private var SuperStager:Class;
		
		private var back:Background;
		
		private var menuPlayGame:FlxText = new FlxText(25, 1, 100, 10, "Begin Game", 0xfffff);
		private var menuPlayBtn:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
		
		private var menuInstructions:FlxText = new FlxText(25, 1, 100, 10, "Instructions", 0xfffff);
		private var menuInstructionsBtn:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
		
		private var menuAbout:FlxText = new FlxText(25, 1, 100, 10, "About", 0xfffff);
		private var menuAboutBtn:FlxSprite = new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff3a5c39);
		
		public function MenuState()
		{
			super();
			var buttonPos:uint = FlxG.width/2 -54;		//define button x position (Middle of Screen)
			FlxG.setMusic(SuperStager)
			back = new Background();
			this.add(back);							//add the background to the scene
			FlxG.setCursor(Cursor);					//set the custom cursor
			//Display Title & Buttons
			this.add(new FlxText(0, 40, FlxG.width, 80, "StarBlaster HD", 0xffffff, null, 20, "center"));
			this.add(new FlxButton(buttonPos, 150, menuPlayBtn, PlayFade, menuPlayBtn, menuPlayGame, menuPlayGame)) as FlxButton;
			this.add(new FlxButton(buttonPos, 180, menuInstructionsBtn, InstructionsFade, menuInstructionsBtn, menuInstructions, menuInstructions)) as FlxButton;
			this.add(new FlxButton(buttonPos, 210, menuAboutBtn, AboutFade, menuAboutBtn, menuAbout, menuAbout)) as FlxButton;
		}
		
		override public function update():void
		{
			back.y += 2;		//move background along
			
			super.update();
		}
		private function PlayFade():void
		{
				FlxG.stopMusic();
				FlxG.flash(0xffffff, 0.75);
				FlxG.fade(0xff000000, 1, onPlayFade);
				FlxG.play(SndHit);
		}
				private function InstructionsFade():void
		{
				FlxG.fade(0xff000000, 1, onInstructionsFade);
				FlxG.play(InstructionHit);
		}
		private function AboutFade():void
		{
				FlxG.fade(0xff000000, 1, onAboutFade);
				FlxG.play(AboutHit);
		}
		private function onInstructionsFade():void
		{
			FlxG.switchState(InstructionState);
		}
		private function onAboutFade():void
		{
			FlxG.switchState(AboutState);
		}
		private function onPlayFade():void
		{
			FlxG.switchState(Level1);
		}
	}
}