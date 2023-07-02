package com.data
{
	import com.fxpn.util.Debugging;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class DataRepository extends EventDispatcher
	{
		private static var instance:DataRepository;
		
		private var episodes:Array;
		public var membersDict:Dictionary;
		public var tribesDict:Dictionary;
		
		public static const MALE:Boolean = true;
		public static const FEMALE:Boolean = false;
		
		public function DataRepository(singletonEnforcer:SingletonEnforcer)
		{
			super();
			membersDict = new Dictionary();
			membersDict[1] = {name: "אתי", sex: FEMALE, webSite: 500247, fb: "https://www.facebook.com/pages/ty-hlywwh/190210371002528?ref=ts"};
			membersDict[2] = {name: "יאנה", sex: FEMALE, webSite: 500246, fb: "https://www.facebook.com/pages/ynh-qlmn/175162042516043?ref=ts"};
			membersDict[3] = {name: "מוראל", sex: FEMALE, webSite: 500248, fb: "https://www.facebook.com/pages/mwrl-bn-hmw/191528904202683?ref=ts"};
			membersDict[4] = {name: "יולה", sex: FEMALE, webSite: 500249, fb: "https://www.facebook.com/pages/ywlh-qrbyz/194041997290574?ref=ts"};
			membersDict[5] = {name: "עפרי", sex: FEMALE, webSite: 500250, fb: "https://www.facebook.com/pages/pry-yryb/129800200423866?ref=ts"};
			membersDict[6] = {name: "יונתן", sex: MALE, webSite: 500251, fb: "https://www.facebook.com/pages/ywntn-sml/146053882120733?ref=ts"};
			membersDict[7] = {name: "אביב", sex: MALE, webSite: 500252, fb: "https://www.facebook.com/pages/byb-bsys/188934937804789?ref=ts"};
			membersDict[8] = {name: "בן", sex: MALE, webSite: 500255, fb: "https://www.facebook.com/pages/bn-mlk/174361392608311?ref=ts"};
			membersDict[9] = {name: "רועי", sex: MALE, webSite: 500254, fb: "https://www.facebook.com/pages/rwy-lwlw/184295541609064?sk=wall"};
			membersDict[10] = {name: "גיורא", sex: MALE, webSite: 500253, fb: "https://www.facebook.com/pages/gywr-rwtmn/140533986010424?ref=ts"};
			membersDict[11] = {name: "אירית", sex: FEMALE, webSite: 500257, fb: "https://www.facebook.com/pages/yryt-rhmym-bsys/152695168118327?ref=ts"};
			membersDict[12] = {name: "לירון", sex: MALE, webSite: 500261, fb: "https://www.facebook.com/pages/lyrwn-strws/180042365371398?ref=ts"};
			membersDict[13] = {name: "גב", sex: MALE, webSite: 500258, fb: "https://www.facebook.com/pages/gb-psty/162809467105185?ref=ts"};
			membersDict[14] = {name: "שונית", sex: FEMALE, webSite: 500265, fb: "https://www.facebook.com/pages/swnyt-prgy/196223887072290?ref=ts"};
			membersDict[15] = {name: "אוהד", sex: MALE, webSite: 500256, fb: "https://www.facebook.com/pages/whd-lwn/183624928340999?ref=ts"};
			membersDict[16] = {name: "נטלי", sex: FEMALE, webSite: 500262, fb: "https://www.facebook.com/pages/ntly-bn-ry/193228420695880?ref=ts"};
			membersDict[17] = {name: "פנינית", sex: FEMALE, webSite: 500264, fb: "https://www.facebook.com/pages/pnynyt-rwznbrg/182602111778833?ref=ts"};
			membersDict[18] = {name: "יגאל", sex: MALE, webSite: 500259, fb: "https://www.facebook.com/pages/ygl-bn-bnymyn/166556206724889?ref=ts"};
			membersDict[19] = {name: "יניב", sex: MALE, webSite: 500260, fb: "https://www.facebook.com/pages/ynyb-rwhn/201086283235296?ref=ts"};
			membersDict[20] = {name: "נטלי כ", sex: FEMALE, webSite: 500263, fb: "https://www.facebook.com/pages/ntly-kbsh/135108769889636?ref=ts"};
									
			tribesDict = new Dictionary();
			tribesDict[1] = "באנאו";
			tribesDict[2] = "מריקודו";
			tribesDict[3] = "מלאיה";
			
			episodes = [];
		}
		
		
		public static function getInstance():DataRepository
		{
			if (instance == null)
			{
				instance = new DataRepository(new SingletonEnforcer());
			}
			return instance;
		}
		
		public function loadData(dataURL:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onDataReady);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onDataError);
			loader.load(new URLRequest(dataURL));
		}
		
		private function onDataReady(event:Event):void
		{
			parseData(new XML(event.target.data));
			dispatchEvent(event);
		}
		
		public function parseData(data:XML):void
		{
			episodes = [];
			for each (var episode:XML in data.episode)
			{
				var episodeData:EpisodeData = new EpisodeData(episode.@order,episode.@date);
				for each (var tribe:XML in episode.tribe)
				{
					var tribeData:TribeData = new TribeData(parseInt(tribe.@id),tribe.@active == "true" ? true : false,parseInt(tribe.@vetoFrom),parseInt(tribe.@vetoTo),parseInt(tribe.@statue), parseInt(tribe.@necklace), parseInt(tribe.@outcasted));
					for each (var member:XML in tribe.member)
					{
						//if (member.@active == "true")
						//{
							var memberData:MemberData = new MemberData(parseInt(member.@id),parseInt(member.@votedTo),member.@immunity == "true" ? true : false);
							memberData.currentTribe = tribeData.id;							
							tribeData.members.push(memberData);
							episodeData.members.push(memberData);
						//}
					}
					episodeData.addTribe(tribeData);
				}
				episodes.push(episodeData);
			}
			episodes.sortOn("order",Array.DESCENDING | Array.NUMERIC);
		}
		
		private function onDataError(event:IOErrorEvent):void
		{
			Debugging.alert("שגיאה בטעינת המידע");
			episodes.sortOn("totalMember",Array.DESCENDING);
		}
		
		public function addEpisode(episodeData:EpisodeData):void
		{
			episodes.push(episodeData);
		}
		
		public function get totalEpisodes():int
		{
			return episodes.length;
		}
		
		public function getCurrentEpisode():EpisodeData
		{
			return episodes[0];
		}
		
		/*public function getEpisodeByOrder(order:int):EpisodeData
		{
			for (var i:int; i < episodes.length; i++)
			{
				if (episodes[i].order == order) break;
			}
			return episodes[i];
		}*/
		
		public function getEpisodeByIndex(index:int):EpisodeData
		{
			return episodes[index];
		}
	}	
}
class SingletonEnforcer{}