package com.novabox.MASwithTwoNests 
{
	import com.novabox.expertSystem.ExpertSystem;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * Cognitive Multi-Agent System Example
	 * Part 2 : Two distinct termite nests
	 * (Termites collecting wood)
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class Agent extends Sprite
	{
		
		protected var targetPoint:Point;

		protected var type:AgentType;
				
		protected var dead:Boolean;
		
		public function Agent(_type:AgentType) 
		{
			targetPoint = new Point();
			type = _type;
			dead = false;
		}
		
		public function GetType() : AgentType
		{
			return type;
		}
		
		public function Update() : void
		{
			
		}
		
		public function GetTargetPoint() : Point
		{
			return targetPoint;
		}
		
		public function SetTargetPoint(_point:Point) : void
		{
			targetPoint.x = _point.x;
			targetPoint.y = _point.y;
		}
		
		public function IsDead() : Boolean
		{
			return dead;
		}
	}
	
}