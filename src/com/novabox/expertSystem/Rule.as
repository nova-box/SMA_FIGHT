package com.novabox.expertSystem 
{
	import adobe.utils.ProductManager;
	import flash.display.GradientType;
	/**
	 * Expert System 
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class Rule
	{
		
		private var premises:Array;
		private var goal:Fact;
		
		public function Rule(_goal:Fact, _premises:Array) 
		{
			goal = _goal;
			premises = _premises;
		}
		
		public function GetPremises() : Array
		{
			return premises;
		}
		
		public function GetGoal() : Fact
		{
			return goal;
		}
		
	}

}