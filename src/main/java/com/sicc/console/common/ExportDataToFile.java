package com.sicc.console.common;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
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


  public String getQueryDataString(Connection con, String selQuery[], String tables[], String tenantId, String fileDir) {

  	PreparedStatement psmt = null;
  	List<String> insertQueryList = new ArrayList<String>();
  	String result = "";
  	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	
	  try {
			for(int j = 0 ; j < selQuery.length ; j++) {
				psmt = con.prepareStatement(selQuery[j]);
				psmt.execute();
				
				 rs = psmt.getResultSet();
				 rsmd = rs.getMetaData();

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
				     String query = getInsertQueryString(map, tables[j]);
				     insertQueryList.add(query);
				}
			}

			result = exportFile(insertQueryList, tenantId , fileDir);
						
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	  	finally {
	  		if(psmt != null) try { psmt.close();} catch(SQLException e) {}
	  		if(rs != null) try { rs.close();} catch(SQLException e) {}
	  		if(con != null) try { con.close();} catch(SQLException e) {}
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
  
  public String exportFile(List<String> insertQueryList, String tenantId, String fileDir) {

  	String fileName = fileDir+"["+tenantId+"]InsertQuery.sql";
  	//String path = "C:/exportTemp/";
  	
  	File file = new File(fileDir);
  	
		if(!file.exists()) {
  			file.mkdirs();
  		}
  	
  	BufferedWriter bw = null;
  	FileWriter fw = null;

  	try {
  		fw = new FileWriter(fileName);
  		bw = new BufferedWriter(fw);

    	for(String m : insertQueryList) {
    		bw.write(m);
    		bw.newLine();
    	}
  	}
  	catch(IOException io) {
  		io.printStackTrace();
  	} finally{
		if(bw != null) try{bw.close();}catch(IOException e){}
		if(fw != null) try{fw.close();}catch(IOException e){}
	}
	  return "1";
  }
  
  
  public List<String> fileReader(InputStream scriptFileStream) throws IOException {
	  List<String> insertQueryList = new ArrayList<String>();
	  BufferedReader br = null;
	  InputStreamReader ir = null;
	  
	  try {
		ir = new InputStreamReader(scriptFileStream,"UTF8");
		br = new BufferedReader(ir);
		
		while(true){
			String str = br.readLine();
			
			if(str==null) break;
			
			insertQueryList.add(str);
		}

	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	} catch (FileNotFoundException e) {
		e.printStackTrace();
	}  finally{
		if(ir != null) try{ir.close();}catch(IOException e){}
		if(br != null) try{br.close();}catch(IOException e){}
	}

	  return insertQueryList;
  }
  
  
  
}
