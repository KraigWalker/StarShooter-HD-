package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source="assets/ship.png")]private var Img:Class;
		[Embed(source="assets/gibs.png")]private var ImgGibs:Class;
		[Embed(source="assets/asplode.mp3")]private var SndExplode:Class;
		[Embed(source="assets/menu_hit_2.mp3")]private var SndExplode2:Class;
		[Embed(source="assets/hurt.mp3")]private var SndHurt:Class;
		
		private var _bullets:FlxArray;
		private var _curBullet:uint;
		private var _bulletVel:int;
		private var _gibs:FlxEmitter;
		
		public function Player(X:int,Y:int, Bullets:FlxArray)
		{
			super(Img, X, Y, true, true);

			var runSpeed:uint = 80;
			drag.x = runSpeed * 8;
			drag.y = runSpeed * 8;
			acceleration.y = 0;
			maxVelocity.x = runSpeed;
			maxVelocity.y = runSpeed;

			addAnimation("idle", [0, 1, 2, 3], 12);
			addAnimation("left", [5]);
			addAnimation("right", [4]);
			
			//bullet stuff
			_bullets = Bullets;
			_curBullet = 0;
			_bulletVel = 360;
			
			_gibs = FlxG.state.add(new FlxEmitter(0,0,0,0,null,-1.5,-150,150,-200,0,-720,720,400,0,ImgGibs,60,true)) as FlxEmitter;
		}
		
		override public function update():void
		{
			acceleration.x = 0;
			acceleration.y = 0;
			
			if(FlxG.kLeft)
			{
				acceleration.x -= drag.x;
			}
			else if(FlxG.kRight)
			{
				acceleration.x += drag.x;
			}
			else if(FlxG.kUp)
			{
				acceleration.y -= drag.y;
			}
			else if(FlxG.kDown)
			{
				acceleration.y += drag.y;
			}
			if(velocity.x < 0)
			{
				play("left");
			}
			else if(velocity.x > 0)
			{
				play("right");
			}
			else
			{
				play("idle");
			}
			super.update();
			
			if(flickering())
			{
				if(FlxG.justPressed(FlxG.B))
				return;							//make sure the player can't shoot while invulnerable
			}
			
			if(FlxG.justPressed(FlxG.B))
			{
				var bXVel:int = 0;
				var bYVel:int = 0;
				var bX:int = x;
				var bY:int = y;
				
				bY -= _bullets[_curBullet].height - 4;
				bYVel = -_bulletVel;
				
				_bullets[_curBullet].shoot(bX,bY,bXVel,bYVel);
				
				if(++_curBullet >= _bullets.length)
					_curBullet = 0;
			}
		}
		override public function hurt(Damage:Number):void
		{
			Damage = 0;
			if(flickering())
				return;
			FlxG.play(SndHurt);
			flicker(1.3);			
			super.hurt(Damage);
		}
		
		override public function kill():void
		{
			if(dead)
				return;
			FlxG.play(SndExplode);
			FlxG.play(SndExplode2);
			super.kill();
			flicker(-1);
			exists = true;
			visible = false;
			FlxG.quake(0.005,0.35);
			FlxG.flash(0xffd8eba2,0.35);
			_gibs.x = x + width/2;
			_gibs.y = y + height/2;
			_gibs.reset();
		}
	}
}
