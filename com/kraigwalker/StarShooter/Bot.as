package com.kraigwalker.StarShooter {
	import com.adamatomic.flixel.*;
	
	import flash.geom.Point;

	public class Bot extends FlxSprite
	{
		[Embed(source="assets/bot.png")]private var ImgBot:Class;
		[Embed(source="assets/gibs.png")]private var ImgGibs:Class;
		[Embed(source="assets/asplode.mp3")]private var SndExplode:Class;
		[Embed(source="assets/hit.mp3")]private var SndHit:Class;
		
		private var _gibs:FlxEmitter;
		private var player:Player;
		private var bullets:FlxArray;
		private var currentBullet:uint = 0;
		private var _shotClock:Number;
		
		public function Bot(xPos:int,yPos:int,Bullets:FlxArray,ThePlayer:Player)
		{
			super(ImgBot,xPos,yPos,true);
			player = ThePlayer;
			bullets = Bullets;
			
			width = 12;
			height = 12;
			maxAngular = 120;
			angularDrag = 400;
			maxThrust = 100;
			drag.x = 40;
			drag.y = 40;
			
			addAnimation("idle", [0]);
			addAnimation("dead", [1, 2, 3, 4, 5], 15, false);

			_gibs = FlxG.state.add(new FlxEmitter(0,0,0,0,null,-1.5,-150,150,-200,0,-720,720,400,0,ImgGibs,20,true)) as FlxEmitter;

			reset(x,y);
		}		
		override public function update():void
		{
			if(dead)
			{
				if(finished) exists = false;
				else
					super.update();
				return;
			}
			
			var dx:Number = x-player.x;
			var dy:Number = y-player.y;
			
			var da:Number = FlxG.getAngle(dx,dy);
			
			if(da < 0)
				da += 360;
			var ac:Number = angle;
			if(ac < 0)
				ac += 360;
			if(da < angle)
				angularAcceleration = -angularDrag;
			else if(da > angle)
				angularAcceleration = angularDrag;
			else
				angularAcceleration = 0;

			thrust = 50;

			if(onScreen())
			{
				var os:Number = _shotClock;
				_shotClock += FlxG.elapsed;
				if((os < 4.0) && (_shotClock >= 4.0))
				{
					_shotClock = 0;
					shoot();
				}
				else if((os < 3.5) && (_shotClock >= 3.5))
					shoot();
				else if((os < 3.0) && (_shotClock >= 3.0))
					shoot();
			}			
			super.update();
		}
		
		override public function hurt(Damage:Number):void
		{
			FlxG.play(SndHit);
			flicker(0.2);
			FlxG.score += 10;
			super.hurt(Damage);
		}
		
		override public function kill():void
		{
			if(dead)
				return;
			FlxG.play(SndExplode);
			super.kill();
			exists = true;
			flicker(-1);
			play("dead");
			_gibs.x = x + width/2;
			_gibs.y = y + height/2;
			_gibs.reset();
			FlxG.score += 200;
		}		
		public function reset(X:Number, Y:Number):void
		{
			exists = true;
			dead = false;
			visible = true;
			active = true;
			x = X;
			y = Y;
			thrust = 0;
			velocity.x = 0;
			velocity.y = 0;
			angle = Math.random()*360 - 180;
			health = 2;
			_shotClock = 0;
			play("idle");
		}
		
		private function shoot():void
		{
			var ba:Point = FlxG.rotatePoint(-120,0,0,0,angle);
			bullets[currentBullet].shoot(x+width/2-2,y+height/2-2,ba.x,ba.y);
			if(++currentBullet >= bullets.length) currentBullet = 0;
		}
	}
}
