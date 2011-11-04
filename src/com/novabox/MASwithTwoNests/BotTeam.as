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
	
	public class BotTeam
	{
		private var teamId:String;
		
		private var botTypes:Array;
		
		private var color:int;
		
		public function BotTeam(_teamId:String, _color:int, _botTypes:Array) 
		{
			teamId = _teamId;
			
			botTypes = _botTypes;
			color = _color;
		}
		
		public function GetId() : String
		{
			return teamId;
		}
		
		public function Initialize(_botCount:int) : void
		{
			var teamHome:BotHome = new BotHome(teamId, color + 0x222222);

			teamHome.x = Math.random() * World.WORLD_WIDTH;
			teamHome.y = Math.random() * World.WORLD_HEIGHT;
			
			
			teamHome.SetTargetPoint(new Point(		teamHome.x,
													teamHome.y));
																
													
			for (var i:int = 0; i < botTypes.length; i++)
			{
				var botType:AgentType = (botTypes[i] as AgentType);
				var botTypeCount:int = botType.GetRatio() * _botCount;
				var botClass:Class = botType.GetClass();
				
				Main.world.AddAgent(teamHome);
				
				for (var j:int = 0; j < botTypeCount; j++)
				{	
					var bot:Bot = new botClass(botType);
					bot.initialize(teamId, color, World.BOT_RADIUS, World.BOT_SPEED, World.BOT_DIRECTION_CHANGE_DELAY, World.BOT_PERCEPTION_RADIUS);
					
					if (World.BOT_START_FROM_HOME)
					{
						bot.x = teamHome.GetTargetPoint().x;
						bot.y = teamHome.GetTargetPoint().y;
					}
					else
					{
						bot.x = Math.random() * World.WORLD_WIDTH;
						bot.y = Math.random() * World.WORLD_HEIGHT;
					}
					Main.world.AddAgent(bot);
					
				}
				
				

			}
		}
		
		
		
	}

}