package com.novabox.customTeam 
{
	import com.novabox.MASwithTwoNests.AgentType;
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	
	//*****************************************************************
	// TODO : Register here all new agent types (Bot and Messages)
	//*****************************************************************
	 
	public class CustomAgentType
	{
		
		public static const CUSTOM_BOT:AgentType = new AgentType(	CustomBot,		// Bot Class
																	1				// Bot ratio in team
																);			
																
			
	}

}