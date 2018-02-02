package com.sicc.console.common;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CommonUtil {
	public static String getCurrentDate(String fmt) {
        SimpleDateFormat sdf = new SimpleDateFormat(fmt);
        return sdf.format(new Date());
    }
	
	public static String getPaddingZero(String lengthValue , int value) {
		return String.format("%0"+lengthValue+"d", value); 
	}
	
	public static String concatString(String str1 , String str2) {
		StringBuffer sb = new StringBuffer();
		sb.append(str1).append(str2);
		return sb.toString(); 
	}
	
	public static String removeSpecificStr(String originStr, String specificStr) {
		return originStr.replaceAll(specificStr, "");
	}
}
