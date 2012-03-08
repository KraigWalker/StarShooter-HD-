package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.FlxSprite;

	/**
	 * @author kraigwalker
	 */
	public class HealthMonitor extends FlxSprite {
		[Embed(source="assets/lives.png")]private var Health:Class;
		
		public static var dead:Boolean = false;
		
		public function HealthMonitor(X:int = 0, Y:int = 0) {
			super(Health, X, Y, true, false);
			
			this.addAnimation("full", [0]);
			this.addAnimation("threeQuarters", [1]);
			this.addAnimation("half", [2]);
			this.addAnimation("quarter", [3]);
			this.addAnimation("empty", [4]);
		}
		
		public function updateHealth():void
		{
			if(this._curFrame == 0)
			{
				this.play("threeQuarters");
				this._curFrame = 1;
			}
			if(this._curFrame == 1)
			{
				this.play("half");
				this._curFrame = 2;
			}
			if(this._curFrame == 2)
			{
				this.play("quarter");
				this._curFrame = 3;
			}
			if(this._curFrame == 3)
			{
				this.play("empty");
				dead = true;
			}
		}
		
		//may delete this
		public function resetHealth():void
		{
			this.play("full");
			this._curFrame = 0;
			dead = false;
		}
	}
}
