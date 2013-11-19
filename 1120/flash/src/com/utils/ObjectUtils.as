package com.utils
{
	public class ObjectUtils
	{
		// http://stackoverflow.com/questions/8295050/as3-best-way-to-traverse-find-deep-nested-objects
		public static function logDeep(object:*, level:uint = 0):String {
			var retval:String = "";
			for(var item:* in object) {
				if (typeof(object[item]) == "object") {
					retval += getTabs(level) + "[" + level + "]: " + item + " (" + typeof(object[item]) + ")\n";
					retval += logDeep(object[item], level + 1);
				} else {
					if (typeof(object[item]) != "string") retval += getTabs(level) + " - " +  item + " : " + object[item] + " (" + typeof(object[item]) + ")\n";
					else retval += getTabs(level) + " - " +  item + " : '" + object[item] + "' (" + typeof(object[item]) + ")\n";
				}
			}
			return retval;
		}
		
		public static function getTabs(level:uint = 0):String {
			var retval:String = "";
			while (level--) retval+= "\t"
			return retval;
		}
	}
}