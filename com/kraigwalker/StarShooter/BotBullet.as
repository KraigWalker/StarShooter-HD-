package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.FlxG;
	import com.adamatomic.flixel.FlxSprite;

	public class BotBullet extends FlxSprite 
	{
		[Embed(source="assets/bot_bullet.png")]private var ImgBotBullet:Class;
		[Embed(source="assets/jump.mp3")]private var SndHit:Class;
		[Embed(source="assets/shoot.mp3")]private var SndShoot:Class;
		
		public function BotBullet()
		{
			super(ImgBotBullet, 0, 0, true);
			
			addAnimation("idle", [0]);
			addAnimation("poof", [1, 2, 3, 4], 15, false);			
			exists = false;
		}
		
		override public function update():void
		{
			(dead && finished) ? exists = false : super.update();	//remove from memory once destroyed
		}
		override public function hurt(Damage:Number):void
		{
			Damage = 0;
			if(dead){
				return;
			}
			velocity.x = 0;			//stop the sprite from moving on contact
			velocity.y = 0;
			
			if(onScreen()){
				FlxG.play(SndHit);
			}
			dead = true;
			exists = false;
			play("poof");
		}
		public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):void
		{
			FlxG.play(SndShoot);
			this.x = X;
			this.y = Y;
			
			velocity.x = VelocityX;
			velocity.y = VelocityY;
			
			play("idle");
			
			dead = false;
			exists = true;
			visible = true;
		}
	}
}
