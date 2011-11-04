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
	public class AgentType 
	{	
		public static const AGENT_BOT:AgentType = new AgentType(Bot, 1);
		public static const AGENT_BOT_HOME:AgentType = new AgentType();

		public static const AGENT_RESOURCE:AgentType = new AgentType();
	
		//**********************************************************************
		// Type properties and methods
		//**********************************************************************
		private var ratio:Number;
		private var agentClass:Class;
		
		public function AgentType(_class:Class = null,_ratio:Number = -1)
		{
			ratio = _ratio;
			agentClass = _class;
		}
		
		public function GetRatio() : Number
		{
			return ratio;
		}
		
		public function GetClass() : Class
		{
			return agentClass;
		}
	}
	
	
}