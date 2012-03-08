package com.kraigwalker.StarShooter {

import com.adamatomic.flixel.FlxSprite;

	public class Background extends FlxSprite 
	{
		[Embed(source="assets/backOne.png")]private var BackOne:Class;
		
		public function Background()
		{
			super(BackOne);
			
			this.y = -720;
		}
		override public function update():void
		{
			if(this.y >= 0){
				this.y = -720;
			}
			super.update();
		}
	}
}