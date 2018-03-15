package com.sicc.console.common;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ExportDataToFile {


  public String getQueryDataString(Connection con, String selQuery[], String tables[], String tenantId) {

  	PreparedStatement psmt;
  	List<String> insertQueryList = new ArrayList<String>();
  	String result = "";
  	
	  try {
			for(int j = 0 ; j < selQuery.length ; j++) {
			
				//System.out.println("sql --> "+selQuery[j]);
				psmt = con.prepareStatement(selQuery[j]);
				psmt.execute();
				
				ResultSet rs = psmt.getResultSet();
				ResultSetMetaData rsmd = rs.getMetaData();

				Map<String, Object> map = new HashMap<String, Object>();
				
				while(rs.next()) {
					
					int cCount = rsmd.getColumnCount();
					
					for(int i = 1 ; i <= cCount ; i ++) {
						if(rsmd.getColumnType(i) == 12) {
							map.put(rsmd.getColumnName(i), rs.getString(i));
						}else if(rsmd.getColumnType(i) == 4) {
							map.put(rsmd.getColumnName(i), rs.getInt(i));
						}else if(rsmd.getColumnType(i) ==93) {
							map.put(rsmd.getColumnName(i), rs.getTimestamp(i));
						}
						
					}
				 	 //System.out.println("table ::: "+tables[j]);
				     String query = getInsertQueryString(map, tables[j]);
				     insertQueryList.add(query);
				     //System.out.println(query);
				}
			}

			result = exportFile(insertQueryList, tenantId);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	  
	  	return result;
  }

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
  
  public String exportFile(List<String> insertQueryList, String tenantId) {

  	String fileName = "C:/exportTemp/["+tenantId+"]InsertQuery.sql";
  	String path = "C:/exportTemp/";
  	
  		File file = new File(path);
  	
		if(!file.exists()) {
  			file.mkdirs();
  		}
  	
  	BufferedWriter writer = null;

  	try {
  		writer = new BufferedWriter( new FileWriter(fileName));

	    	for(String m : insertQueryList) {
	    		writer.write(m);
	    		writer.newLine();
	    	}
	    	writer.close();
  	}
  	catch(IOException io) {
  		io.printStackTrace();
  	}
	  
	  return "1";
  }
  
  
  public List<String> fileReader(InputStream scriptFileStream) throws IOException {
	  List<String> insertQueryList = new ArrayList<String>();
	  
	  try {
		  
		BufferedReader br = new BufferedReader(new InputStreamReader(scriptFileStream,"UTF8"));
		
		while(true){
			String str = br.readLine();
			
			if(str==null) break;
			
			insertQueryList.add(str);
		}
		
		br.close();
	  
	  } catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  
	  return insertQueryList;
  }
  
  
  
}
