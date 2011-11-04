package com.novabox.MASwithTwoNests 
{
	
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
		
		public function Resource() 
		{
			super(AgentType.AGENT_RESOURCE);
			life = 0;
		}
		
		public function Initialize(_life:Number) : void
		{
			var startLife:Number = _life;
			
			if (World.RESOURCE_RANDOM_START_LIFE)
			{
				startLife = startLife * Math.random() + World.RESOURCE_UPDATE_VALUE;
			}
			
			SetLife(startLife);
			
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
			DrawSprite();
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