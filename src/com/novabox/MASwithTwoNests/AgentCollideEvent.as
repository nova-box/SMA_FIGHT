package com.novabox.MASwithTwoNests 
{
	import flash.events.Event;
	
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class AgentCollideEvent extends Event
	{
		public static var AGENT_COLLIDE:String = "Agent Collide";
		
		private var agent:Agent;
		
		public function AgentCollideEvent(_agent:Agent) 
		{
			super(AGENT_COLLIDE);
			
			agent = _agent;
			
		}
		
		public function GetAgent() : Agent
		{
			return agent;
		}
		
	}
	
}