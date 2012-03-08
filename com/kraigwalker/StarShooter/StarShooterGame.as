package com.kraigwalker.StarShooter
{
	import com.kraigwalker.StarShooter.MenuState;
	import com.adamatomic.flixel.FlxGame;
	
	[SWF(width="640", height="480", backgroundColor="0x000000")];

	public class StarShooterGame extends FlxGame 
	{
		public function StarShooterGame()
		{
			super(320, 240, MenuState, 2, 0xff000000, false);
			
			help("Nothing", "Fire", "Nothing");
		}
	}
}
