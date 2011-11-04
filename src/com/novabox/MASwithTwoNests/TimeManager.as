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
	public class TimeManager 
	{
		public static var timeManager:TimeManager = new TimeManager();

		protected var appTime:Number;
		protected var frameDeltaTime:Number;

		public function TimeManager() 
		{
			appTime = (new Date).getTime();
			frameDeltaTime = 0;
		
		}
	
		public function Update() : void
		{
			var currentTime:Number = (new Date).getTime();
			frameDeltaTime =   (currentTime - appTime);

			appTime += frameDeltaTime;		

		}
		
		public function GetFrameDeltaTime():Number
		{
			return frameDeltaTime;
		}
		
		public function GetApplicationTime() : Number
		{
			return appTime;
		}
	}
	
}