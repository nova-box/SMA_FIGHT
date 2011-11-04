package com.novabox.MASwithTwoNests 
{
	import com.novabox.expertSystem.Fact;
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class AgentFacts
	{
		public static const NOTHING_SEEN:Fact			= new Fact("Nothing seen");
		public static const SEE_RESOURCE:Fact			= new Fact("Resource seen");
		public static const REACHED_RESOURCE:Fact		= new Fact("Resource reached");
		public static const GOT_RESOURCE:Fact 			= new Fact("Got resource" );
		public static const NO_RESOURCE:Fact 			= new Fact("Got no resource" );
		public static const BIGGER_RESOURCE:Fact 		= new Fact("Resource is bigger" );
		public static const SMALLER_RESOURCE:Fact 		= new Fact("Resource is smaller" );
		public static const CHANGE_DIRECTION_TIME:Fact	= new Fact("Time to change direction");
		
		public static const SEEING_HOME:Fact			= new Fact("Seeing home");
		public static const NOT_SEEING_HOME:Fact		= new Fact("Not seeing home");
		public static const GO_HOME:Fact				= new Fact("Go home");
		public static const AT_HOME:Fact				= new Fact("At home");

		public static const CHANGE_DIRECTION:Fact		= new Fact("Changing direction");
		public static const GO_TO_RESOURCE:Fact			= new Fact("Going to resource");
		public static const TAKE_RESOURCE:Fact 			= new Fact("Taking Resource." );
		public static const PUT_DOWN_RESOURCE:Fact 		= new Fact("Putting down Resource." );
	}

}