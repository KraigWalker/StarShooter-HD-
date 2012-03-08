package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.FlxState;
	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * @author kraigwalker
	 */
	public class splashState extends FlxState {
		public function splashState() {
			super();
			
			var shapes:Sprite = new Sprite();
			var gr:Graphics = shapes.graphics;
			
			gr.lineStyle();
			gr.beginFill(0xFFFFFF, 0.2);
			gr.drawRect(0, 0, 320, 240);
			
			
		}
	}
}
