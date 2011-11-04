package com.novabox.expertSystem 
{
	/**
	 * Expert System 
	 * 
	 * @author Ophir / Nova-box
	 * @version 1.0
	 */
	public class Fact
	{
		private var label:String;

		public function Fact(_label:String) 
		{
			label = _label;
		}
		
		public function GetLabel() : String
		{
			return label;
		}		
	}

}