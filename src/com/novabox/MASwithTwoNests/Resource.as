package com.novabox.MASwithTwoNests 
{
	import flash.geom.Point;
	
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class Resource extends Agent
	{
		private var life:Number;
		private var moveDelay:Number;
		private var updateTime:Number;
		private var direction:Point;
		private var speed:Number;
		
		public function Resource() 
		{
			super(AgentType.AGENT_RESOURCE);
			life = 0;
		}
		
		public function Initialize(_life:Number, _moveDelay:Number, _speed:Number) : void
		{
			moveDelay = _moveDelay;
			speed = _speed;
			updateTime = 0;
			
			var startLife:Number = _life;
			
			if (World.RESOURCE_RANDOM_START_LIFE)
			{
				startLife = startLife * Math.random() + World.RESOURCE_UPDATE_VALUE;
			}
			
			SetLife(startLife);
			ChangeDirection();
			DrawSprite();
		}
		
		public function SetLife(_life:Number) : void
		{
			life = _life;
			if (life < 0)
			{
				life = 0;
			}
		}
		
		public function GetLife() : Number
		{
			return life;
		}
		
		public function DecreaseLife() : void
		{
			SetLife(life - World.RESOURCE_UPDATE_VALUE);			
		}
		
		public function IncreaseLife() : void
		{
			SetLife(life + World.RESOURCE_UPDATE_VALUE);			
		}
		
		override public function Update() : void
		{
			updateTime += TimeManager.timeManager.GetFrameDeltaTime();
			if ((updateTime > moveDelay) || (Main.world.IsOut(targetPoint)))
			{
				ChangeDirection();
				updateTime = 0;
			}
			targetPoint.x = targetPoint.x + direction.x * speed * TimeManager.timeManager.GetFrameDeltaTime()/1000;
			targetPoint.y = targetPoint.y + direction.y * speed * TimeManager.timeManager.GetFrameDeltaTime() / 1000;;
			
			DrawSprite();
		}
		
		protected function ChangeDirection() : void
		{
			direction = new Point(Math.random(), Math.random());
			
			if (Math.random() > 0.5)
			{
				direction.x = direction.x * -1;
			}
			if (Math.random() > 0.5)
			{
				direction.y = direction.y * -1;
			}			
			direction.normalize(1);
		}
		
		protected function DrawSprite() : void
		{
			this.graphics.clear();
			if (life > 0)
			{
				this.graphics.beginFill(0xCCCCCC, 1);
					this.graphics.drawCircle(0, 0, World.RESOURCE_LIFE_RADIUS_COEFF * life);
				this.graphics.endFill();
			}
		}
	}
	
}