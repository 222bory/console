package com.sicc.console.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;

import com.sicc.console.model.CompetitionModel;
import com.sicc.console.model.ContractModel;
import com.sicc.console.model.Member;
import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceModel; 

@Intercepts({
		@Signature(type=StatementHandler.class, method="update", args= {Statement.class}),
		//@Signature(type=StatementHandler.class, method="query", args= {Statement.class, ResultHandler.class})
})
public class CUDInterceptor implements Interceptor{
	
	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		StatementHandler handler = (StatementHandler) invocation.getTarget();
		BoundSql bs = handler.getBoundSql();
		
		//String sql = bs.getSql();
		
		Object param = handler.getParameterHandler().getParameterObject();
		
		List<ParameterMapping> pmList = bs.getParameterMappings();
		
		PreparedStatement psmt = null;
		
		if(param instanceof Member){
			for(int i = 0 ; i < pmList.size() ; i ++) {
				String key = pmList.get(i).getProperty();
				System.out.println("interceptor test ::::::::::: "+ key);
				
			}
		}else if(param instanceof ContractModel) {
			Statement st = (Statement) (invocation.getArgs())[0];
			Connection con = st.getConnection();
			String orginSql = "select tenant_id, cust_id, cont_nm, valid_start_dt, valid_end_dt, cont_stat_cd, network_fg_cd, password_lod_cd, password_min_len, password_rnwl_cycl_cd, password_use_lmt_yn, password_pose_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date from concustcontm where tenant_id = '"+((ContractModel) param).getTenantId()+"'" ;
			
			psmt = con.prepareStatement(orginSql);
			psmt.execute();
			ResultSet rs = psmt.getResultSet();
			
			String histSql = "";
			if(rs.next()) {
				histSql = "INSERT INTO concustcontm_log(tenant_id, cust_id, cont_nm, valid_start_dt, valid_end_dt, cont_stat_cd, network_fg_cd, password_lod_cd, password_min_len, password_rnwl_cycl_cd, password_use_lmt_yn, password_pose_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date) values('"+rs.getString("tenant_id")+"', '"+rs.getString("cust_id")+"', '"+rs.getString("cont_nm")+"', '"+rs.getString("valid_start_dt")+"', '"+rs.getString("valid_end_dt")+"', '"+rs.getString("cont_stat_cd")+"', '"+rs.getString("network_fg_cd")+"', '"+rs.getString("password_lod_cd")+"', "+rs.getInt("password_min_len")+", '"+rs.getString("password_rnwl_cycl_cd")+"', '"+rs.getString("password_use_lmt_yn")+"', '"+rs.getString("password_pose_yn")+"', '"+rs.getString("crt_id")+"', '"+rs.getString("crt_ip")+"', current_timestamp, '"+rs.getString("udt_id")+"', '"+rs.getString("udt_ip")+"', current_timestamp)";
				
				psmt = con.prepareStatement(histSql);
				psmt.execute();
			}
		}else if(param instanceof CompetitionModel) {
			Statement st = (Statement) (invocation.getArgs())[0];
			Connection con = st.getConnection();
			String orginSql = "select tenant_id, cp_cd, cp_nm, cp_start_dt, cp_end_dt, cp_place_nm, cp_scale_cd, cp_type_cd, expect_user_num, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date from concpm where tenant_id = '"+((CompetitionModel) param).getTenantId()+"'" ;
			
			psmt = con.prepareStatement(orginSql);
			psmt.execute();
			ResultSet rs = psmt.getResultSet();
			
			String histSql = "";
			if(rs.next()) {
				histSql = "INSERT INTO concpm_log(tenant_id, cp_cd, cp_nm, cp_start_dt, cp_end_dt, cp_place_nm, cp_scale_cd, cp_type_cd, expect_user_num, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date) values('"+rs.getString("tenant_id")+"', '"+rs.getString("cp_cd")+"', '"+rs.getString("cp_nm")+"', '"+rs.getString("cp_start_dt")+"', '"+rs.getString("cp_end_dt")+"', '"+rs.getString("cp_place_nm")+"', '"+rs.getString("cp_scale_cd")+"', '"+rs.getString("cp_type_cd")+"', "+rs.getInt("expect_user_num")+", '"+rs.getString("crt_id")+"', '"+rs.getString("crt_ip")+"', current_timestamp, '"+rs.getString("udt_id")+"', '"+rs.getString("udt_ip")+"', current_timestamp)";
				
				psmt = con.prepareStatement(histSql);
				psmt.execute();
			}
		}
		if(psmt != null) {
			psmt.close();
		}
		
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties properties) {
		
	}
	
}
