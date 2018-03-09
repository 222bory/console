package com.sicc.console.common;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class ExportDataToFile {
	
	 /* public static void main(String[] args) {
          Map map = new HashMap();

          map.put("1", "123");

          map.put("2","456");

          String query = getInsertQueryString(map, "abc");

          System.out.println(query);

  }*/

  public static String getInsertQueryString(Map<String, Object> result, String tableName) {

          StringBuffer sql = new StringBuffer();

          sql.append("INSERT INTO " + tableName + "(");
         

          Set<String> keys = result.keySet();

          StringBuffer columns = new StringBuffer();

          StringBuffer values = new StringBuffer();

          for (String key : keys) {

                 Object value = result.get(key);

                 if(value instanceof String){

                         columns.append(key + ", ");

                         values.append("'" + value.toString() + "', ");

                 }else if(value instanceof Number){

                         columns.append(key + ", ");

                         values.append(value.toString() + ", ");

                 }else if(value instanceof Date) {
                	 
	                	 columns.append(key + ", ");
	
	                     values.append("clock_timestamp(), ");
                 }

          }

          String columnStr = columns.substring(0, (columns.length() - ", ".length()));

          String valueStr = values.substring(0, (values.length() - ", ".length()));

         

          sql.append(columnStr + ") VALUES (" + valueStr + ");");

         

          return sql.toString();

  }
	
}
