package com.novabox.MASwithTwoNests 
{
	import com.novabox.MASwithTwoNests.AgentFacts;
	import com.novabox.expertSystem.ExpertSystem;
	import com.novabox.expertSystem.Fact;
	import com.novabox.expertSystem.Rule;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.1
	 */
	public class Bot extends Agent
	{
		//Sprite
		protected var botSprite:Sprite;

		//Bot properties
		protected var radius:Number;
		protected var speed:Number;
		protected var directionChangeDelay:Number;
		protected var direction:Point;
		protected var perceptionRadius:Number;
		
		protected var teamId:String;
		protected var color:int;
		

		//Decision paramaters
		protected var expertSystem:ExpertSystem;

		protected var hasResource:Boolean;
		protected var seenResource:Resource;
		protected var takenResource:Resource;
		protected var reachedResource:Resource;
		protected var lastReachedResource:Resource;
		protected var updateTime:Number;

		protected var home:BotHome;
		protected var homePosition:Point;
				
		public function Bot(_type:AgentType) 
		{
			super(_type);
			
			radius = 0;
			speed = 0;
			directionChangeDelay = 0;
			direction = null;
			
			hasResource = false;
			
			expertSystem = null;
			
			updateTime = 0;
			
			reachedResource = null;
			lastReachedResource = null;
			takenResource = null;
			
			seenResource = null;
			
			home = null;
			homePosition = null;
		}
		
		public function initialize(_teamId:String, _color:int, _radius:Number, _speed:Number, _directionChangeDelay:Number, _perceptionRadius:Number) : void
		{		
			teamId = _teamId;
			color = _color;
			
			speed = _speed;
			radius = _radius;
			direction = new Point();
		
			updateTime = 0;
		
			perceptionRadius = _perceptionRadius;
			directionChangeDelay = _directionChangeDelay;
			
			InitExpertSystem();
			InitSprites();
			DrawSprite();
		
			addEventListener(AgentCollideEvent.AGENT_COLLIDE, onAgentCollide);

			hasResource = false;
			
			ChangeDirection();
			
			reachedResource = null;
			lastReachedResource = null;
			takenResource = null;
			seenResource = null;
			
			home = null;
		}
		
		
		public function GetTeamId() : String
		{
			return teamId;
		}
		
		protected function InitExpertSystem() : void
		{
			expertSystem = new ExpertSystem();
			
			expertSystem.AddRule(new Rule(AgentFacts.GO_TO_RESOURCE, 	new Array(	AgentFacts.NO_RESOURCE,
																					AgentFacts.SEE_RESOURCE, AgentFacts.CHANGE_DIRECTION_TIME)));

			expertSystem.AddRule(new Rule(AgentFacts.TAKE_RESOURCE, 	new Array(	AgentFacts.NO_RESOURCE,
																					AgentFacts.REACHED_RESOURCE)));

			expertSystem.AddRule(new Rule(AgentFacts.GO_HOME, 			new Array(	AgentFacts.GOT_RESOURCE,
																					AgentFacts.SEEING_HOME)));
			
																					
			expertSystem.AddRule(new Rule(AgentFacts.GO_TO_RESOURCE, 	new Array(	AgentFacts.GOT_RESOURCE,
																					AgentFacts.SEE_RESOURCE,
																					AgentFacts.BIGGER_RESOURCE,
																					AgentFacts.NOT_SEEING_HOME, AgentFacts.CHANGE_DIRECTION_TIME)));

			expertSystem.AddRule(new Rule(AgentFacts.CHANGE_DIRECTION, 	new Array(	AgentFacts.GOT_RESOURCE,
																					AgentFacts.SEE_RESOURCE,
																					AgentFacts.SMALLER_RESOURCE, AgentFacts.CHANGE_DIRECTION_TIME)));

			expertSystem.AddRule(new Rule(AgentFacts.PUT_DOWN_RESOURCE, new Array(	AgentFacts.GOT_RESOURCE,
																					AgentFacts.REACHED_RESOURCE)));
	
			
			expertSystem.AddRule(new Rule(AgentFacts.PUT_DOWN_RESOURCE,	new Array(	AgentFacts.AT_HOME,
																					AgentFacts.GOT_RESOURCE )));

			expertSystem.AddRule(new Rule(AgentFacts.CHANGE_DIRECTION, 	new Array(	AgentFacts.NOTHING_SEEN,
																					AgentFacts.CHANGE_DIRECTION_TIME )));
																				
			expertSystem.AddRule(new Rule(AgentFacts.CHANGE_DIRECTION, 	new Array(	AgentFacts.TAKE_RESOURCE )));

			expertSystem.AddRule(new Rule(AgentFacts.CHANGE_DIRECTION, 	new Array(	AgentFacts.PUT_DOWN_RESOURCE )));

	}
				
		public function	InitSprites() : void
		{
			this.graphics.beginFill(0XAAAAAA, 0);
				this.graphics.drawCircle(0, 0, perceptionRadius);
			this.graphics.endFill();
			
			
			botSprite = new Sprite();
			addChild(botSprite);
			
			
		}
		
		protected function DrawSprite() : void
		{
			var botColor:int = color;
			
			if (hasResource)
			{
				botColor =  color + 0x555555; //0X228822;
			}
			
			botSprite.graphics.clear();
			botSprite.graphics.beginFill(botColor, 1);
				botSprite.graphics.drawCircle(0, 0, radius);
			botSprite.graphics.endFill();
		}

		override public function Update() : void
		{
			UpdateFacts();
			Infer();
			Act();		
			
			DrawSprite();
			Move();

			reachedResource = null;
			home = null;
		}

		protected function UpdateFacts() : void
		{
			//***************************************
			//Checking if the bot has got a resource
			//***************************************
			if (hasResource)
			{
				expertSystem.SetFactValue(AgentFacts.GOT_RESOURCE, true);
			}
			else
			{
				expertSystem.SetFactValue(AgentFacts.NO_RESOURCE, true);				
			}
			
			//***************************************
			//Checking if it's changing direction time
			//***************************************
			updateTime += TimeManager.timeManager.GetFrameDeltaTime();
			if (updateTime > directionChangeDelay)
			{
				expertSystem.SetFactValue(AgentFacts.CHANGE_DIRECTION_TIME, true);
				updateTime = 0;
			}
			
			
			//***************************************
			//Checking if a resource is seen
			//***************************************
			if (seenResource != null) 
			{
				expertSystem.SetFactValue(AgentFacts.SEE_RESOURCE, true);

				if (takenResource != null)
				{		
					//***************************************
					//Checking resource size
					//***************************************
					if (seenResource.GetLife() > takenResource.GetLife())
					{
						expertSystem.SetFactValue(AgentFacts.BIGGER_RESOURCE, true);							
					}
					else
					{
						expertSystem.SetFactValue(AgentFacts.SMALLER_RESOURCE, true);							
					}
				}
			}
			else
			{
				expertSystem.SetFactValue(AgentFacts.NOTHING_SEEN, true);				
			}
			
			//***************************************
			// Checking if a resource is reached
			//***************************************
			if (reachedResource != null)
			{
				expertSystem.SetFactValue(AgentFacts.REACHED_RESOURCE, true);
			}

			//***************************************
			// Checking if home is reached
			//***************************************
			if (home != null)
			{
				if (IsCollided(home))
				{
					expertSystem.SetFactValue(AgentFacts.AT_HOME, true);
				}
				else
				{
					expertSystem.SetFactValue(AgentFacts.SEEING_HOME, true);
				}
			}
			else
			{
				expertSystem.SetFactValue(AgentFacts.NOT_SEEING_HOME, true);
			}
		}
		
		public function IsCollided(_agent:Agent) : Boolean
		{
			return botSprite.hitTestObject(_agent);
		}
		
		public function IsPercieved(_agent:Agent) : Boolean
		{
			return this.hitTestObject(_agent);
		}
		
		public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (IsCollided(collidedAgent))
			{
				//Bot collision
				
				if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
				{
					reachedResource = (collidedAgent as Resource);
				}
			}
			else
			{
				//Perception
				
				if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
				{
					//The last reached resource can't be seen
					if ((collidedAgent != lastReachedResource) || (lastReachedResource == null))
					{
						seenResource = (collidedAgent as Resource);
					}
				}				
				
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME)
				{
					var botHome:BotHome = (collidedAgent as BotHome);
					if (botHome.GetTeamId() == teamId)
					{
						home = botHome;
						if (homePosition == null)
						{
							homePosition = new Point(home.GetTargetPoint().x, home.GetTargetPoint().y);
						}
					}
				}
		}

		protected function Infer() : void
		{
			expertSystem.Infer();
		}
		
		protected function Act() : void
		{
			var inferedFacts:Array = expertSystem.GetInferedFacts();
			
			for (var i:int = 0; i < inferedFacts.length; i++)
			{
				var fact:Fact = (inferedFacts[i] as Fact);
				
				switch(fact)
				{
					case AgentFacts.CHANGE_DIRECTION:
					ChangeDirection();
					break;
					
					case AgentFacts.GO_TO_RESOURCE:
					GoToResource();
					break;
					
					case AgentFacts.GO_HOME:
					GoHome();
					break;
					
					case AgentFacts.TAKE_RESOURCE:
					TakeResource();
					break;
					
					case AgentFacts.PUT_DOWN_RESOURCE:
					PutDownResource();
					break;
					
				}
				
				
			}
			
			expertSystem.ResetFacts();
		}
			
		public function Move() : void
		{
			var elapsedTime:Number = TimeManager.timeManager.GetFrameDeltaTime();
			
			var botSpeed:Number = speed;
			if (hasResource)
			{
				botSpeed *= World.BOT_WITH_RESOURCE_SPEED_COEFF;
			}
			
			 targetPoint.x = x + direction.x * botSpeed * elapsedTime / 1000 ;
			 targetPoint.y = y + direction.y * botSpeed * elapsedTime / 1000;			
		}
		
		public function GoToResource() : void
		{
			if (seenResource != null)
			{
				direction = seenResource.GetCurrentPoint().subtract(targetPoint);
			
				direction.normalize(1);
				
				seenResource = null;
			}
		}
		
		public function GoHome() : void
		{
			if (homePosition != null)
			{
				direction = homePosition.subtract(targetPoint);
			
				direction.normalize(1);
			}
		}

		public function TakeResource() : void
		{
			if (reachedResource != null)
			{
				reachedResource.DecreaseLife();
				hasResource = true;
				takenResource = reachedResource;
				
				lastReachedResource = reachedResource;
				
				reachedResource = null;
			}
			seenResource = null;
		}

		public function PutDownResource() : void
		{
			if (home != null)
			{
				home.AddResource();
				home = null;
			}
			else if (reachedResource != null)
			{
				reachedResource.IncreaseLife();
	
				lastReachedResource = reachedResource;
				
				reachedResource = null;
				takenResource = null;
			}

			hasResource = false;
			seenResource = null;
		}
		
		public function GetDirection() : Point
		{
			return direction;
		}
		
		public function SetDirection(_direction:Point) : void
		{
			direction = new Point(_direction.x, _direction.y);
		}
		
		public function ChangeDirection() : void
		{
				direction.x = Math.random();
				direction.y = Math.random();
			
				if (Math.random() < 0.5)
				{
					direction.x *= -1;
				}
				if (Math.random() < 0.5)
				{
					direction.y *= -1;				
				}
			
				direction.normalize(1);
				
				seenResource = null;
				
		}
		
		public function HasResource() : Boolean
		{
			return hasResource;
		}
		
		public function SetResource(_value:Boolean) : void
		{
			hasResource = _value;
		}
		
		public function StealResource(_bot:Bot) : void
		{
			_bot.SetResource(false);
			SetResource(true);
		}
		
		public function DropResource() : void
		{
			if (hasResource)
			{
				var resource:Resource = new Resource();
				resource.Initialize(World.RESOURCE_UPDATE_VALUE, World.RESOURCE_MOVE_DELAY, World.RESOURCE_MOVE_SPEED);
				Drop(resource);
			}
		}
		
		public function Drop(_agent:Agent) : void
		{
			_agent.SetTargetPoint(new Point(targetPoint.x, targetPoint.y));
			Main.world.AddAgent(_agent);
		}
		
		public function GetHomePosition() : Point
		{
			return homePosition;
		}
	}
	
}