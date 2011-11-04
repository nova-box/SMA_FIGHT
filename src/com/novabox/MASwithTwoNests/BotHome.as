package com.novabox.MASwithTwoNests 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class BotHome extends Agent
	{

		private var teamId:String;
		private var resourceCount:int;
		private var color:int;
		
		private var countText:TextField;
		
		public function BotHome(_teamId:String, _color:int) 
		{
			super(AgentType.AGENT_BOT_HOME);
			resourceCount = 0;
			teamId = _teamId;
			color = _color;
			
			countText = new TextField();
			countText.autoSize = TextFieldAutoSize.CENTER;			
			addChild(countText);
		}
		
		public function GetTeamId() : String
		{
			return teamId;
		}
		
		override public function Update() : void
		{
			DrawSprite();
		}
		
		protected function DrawSprite() : void
		{
			var homeRadius:Number = World.HOME_RADIUS;
			if (World.HOME_GETTING_BIGGER)
			{
				homeRadius = resourceCount * 1 + World.HOME_RADIUS;
			}
			
			
			this.graphics.clear();
			this.graphics.beginFill(color, 0.5);
				this.graphics.drawCircle(0, 0, homeRadius);
			this.graphics.endFill();
		
			countText.text = resourceCount.toString();
			countText.x = -countText.textWidth/2;
			countText.y = -countText.textHeight/2;
		}		
		
		public function AddResource() : void
		{
			resourceCount++;
		}
		
	}

}