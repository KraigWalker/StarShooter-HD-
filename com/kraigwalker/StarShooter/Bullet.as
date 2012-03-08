package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.FlxG;
	import com.adamatomic.flixel.FlxSprite;

	public class Bullet extends FlxSprite 
	{
		[Embed(source="assets/bullet.png")]private var ImgBullet:Class;
		[Embed(source="assets/jump.mp3")]private var SndHit:Class;
		[Embed(source="assets/shoot.mp3")]private var SndShoot:Class;
		
		public function Bullet()
		{
			super(ImgBullet, 0, 0, false);
			
			width = 6;
			height = 6;
			
			exists = false;
		}
		
		override public function update():void
		{
			(dead && finished) ? exists = false : super.update();
		}
		override public function hurt(Damage:Number):void
		{
			Damage = 0;
			if(dead){
				return;
			}
			velocity.x = 0;
			velocity.y = 0;
			
			if(onScreen()){
				FlxG.play(SndHit);
			}
			dead = true;
			exists = false;
		}
		public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):void
		{
			FlxG.play(SndShoot);
			this.x = X;
			this.y = Y;
			
			velocity.x = VelocityX;
			velocity.y = VelocityY;
			
			dead = false;
			exists = true;
			visible = true;
		}
	}
}
