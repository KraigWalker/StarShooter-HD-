package com.kraigwalker.StarShooter {
import flash.events.Event;
	import com.adamatomic.flixel.FlxArray;
	import com.adamatomic.flixel.FlxG;
	import com.adamatomic.flixel.FlxSprite;
	import com.adamatomic.flixel.FlxState;
	import com.adamatomic.flixel.FlxText;

	import flash.text.TextFormatAlign;

	public class Level1 extends FlxState 
	{
		[Embed(source="assets/blip.mp3")]private var Blip:Class;
		
		private var player:Player;
		private var bullets:FlxArray;
		private var back:Background;
		private var score:FlxText;
		private var health:FlxArray;
		private var enemies:FlxArray;
		private var botBullets:FlxArray;
		private var botAmount:int = 4;
		private var botCount:int;
		private var currentHealth:int = 4;
		
		private var victoryText:FlxText;
		private var currentBonus:Number;
		private var bonusAmount:Number = 50;
		private var bonus:FlxText;
		private var level:int = 1;
		private var isAdding:Boolean = false;
		private var bonusTimer:int;
		
		public function Level1()
		{
			super();
			FlxG.score = 0;
			back = new Background();
			this.add(back);
			
			score = new FlxText(10, 10, 100, 20, "Score: 0", 0xFFFFFF);
			this.add(score);
			
			health = new FlxArray();
			var h:int = 10;
			for(var l:int = 0; l < 5; ++l){
				var healthIcon:HealthMonitor = new HealthMonitor(h, 25);
				this.add(healthIcon);
				h += 12;
				health.add(healthIcon);
			}
			
			init();
		}
		private function init():void
		{
			bullets = new FlxArray();
			enemies = new FlxArray();
			botBullets = new FlxArray();			
			player = new Player(140, 160, bullets);
			
			botCount = botAmount;
			
			this.add(player);
			
			for(var i:int = 0; i < 80; ++i) {
				bullets.add(this.add(new Bullet()));
			}
			for(var j:int = 0; j < 80; ++j){
				botBullets.add(this.add(new BotBullet()));		
			}
			for(var k:int = 0; k < botAmount; ++k){
				enemies.add(this.add(new Bot(Math.random()*320, 0, botBullets, player)));
			}
		}
		override public function update():void
		{
			super.update();
			
			back.y += 2;
			
			FlxG.overlapArrays(bullets, enemies, enemiesHit);
			FlxG.overlapArray(enemies, player, bothHit);
			FlxG.overlapArray(botBullets, player, playerHit);
		}

		private function enemiesHit(bullet:FlxSprite, bot:FlxSprite):void
		{
			if(bullet != null){
				bullet.hurt(0);
			}
			bot.hurt(1);
			
			/**	as you can see those of you that noticed I have 
			*	amended my mistake in calling the 'score' 'String' 
			*	in the lines below - doh!
			*/
			
			score.setText("Score: " + String(FlxG.score));
			if(bot.dead){
				botCount -= 1;
				score.setText("Score: " + String(FlxG.score));
				if(botCount < 1){
					isAdding = true;
					victoryState();
				}
			}
		}

		private function bothHit(enemies:FlxSprite, player:FlxSprite):void
		{
			playerHit(null, player);
		}

		private function playerHit(bullet:FlxSprite, player:FlxSprite):void
		{
			if(!player.flickering()){
				if(bullet != null){
					bullet.hurt(0);
				}
				player.hurt(1);
				health[currentHealth].updateHealth();
				if(health[currentHealth].dead){
					currentHealth -= 1;
					if(currentHealth < 0){
						FlxG.switchState(deadState);
					}
				}
			}
		}

		private function victoryState():void
		{
			player.flickering();
			currentBonus = bonusAmount;
			victoryText = new FlxText(0, 100, 320, 50, "Level " + level + " complete", 0xFFFFFF, null, 8, TextFormatAlign.CENTER);
			
			this.add(victoryText);
			
			bonus = new FlxText(0, 150, 320, 50, "Bonus " + String(currentBonus), 0xFFFFFF, null, 8, TextFormatAlign.CENTER);
			this.add(bonus);
			
			this.addEventListener(Event.ENTER_FRAME, bonusCount);
		}

		private function bonusCount(e:Event):void
		{
			if(level == 10){
				FlxG.switchState(finishState);		//end the game at max num of levels.
			}
			if(isAdding){
				currentBonus -= 2;
				FlxG.play(Blip);
				bonus.setText("Bonus " + String(currentBonus));
				FlxG.score += 2;
				score.setText("String: " + String(FlxG.score));
			}
			
			player.y -= 8;
			
			if(player.y < 0){
				player.exists = false;
			}
			
			if(currentBonus <= 0){
				isAdding = false;
				bonus.setText("Bonus 0");
				bonusTimer += 1;
				if(bonusTimer > 20){
					this.removeEventListener(Event.ENTER_FRAME, bonusCount);
					botAmount += 4;
					bonusAmount += 10;
					bonusTimer = 0;
					level += 1;
					init();
					bonus.exists = false;
					victoryText.exists = false;
				}
			}	
		}
	}
}
