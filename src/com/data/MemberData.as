package com.data
{
	public class MemberData
	{
		private var _id:int;
		private var _votedTo:int;
		private var _immunity:Boolean;
		public var currentTribe:int;
				
		public function MemberData(id:int, votedTo:int, immunity:Boolean = false)
		{
			_id = id;
			_votedTo = votedTo;
			_immunity = immunity;
		}

		public function get id():int
		{
			return _id;
		}

		public function get votedTo():int
		{
			return _votedTo;
		}

		/*public function get immunity():Boolean
		{
			return _immunity;
		}*/


	}
}