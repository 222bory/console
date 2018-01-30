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
import org.apache.ibatis.session.ResultHandler;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.CommonDao;
import com.sicc.console.model.ConCustCont;
import com.sicc.console.model.Member;

@Intercepts({
		@Signature(type=StatementHandler.class, method="update", args= {Statement.class}),
		//@Signature(type=StatementHandler.class, method="query", args= {Statement.class, ResultHandler.class})
})
public class TestInterceptor implements Interceptor{
	
	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		StatementHandler handler = (StatementHandler) invocation.getTarget();
		BoundSql bs = handler.getBoundSql();
		
		String sql = bs.getSql();
		System.out.println("interceptor sql ::::::::: "+sql);
		
		Object param = handler.getParameterHandler().getParameterObject();
		
		List<ParameterMapping> pmList = bs.getParameterMappings();
		
		
		if(param instanceof ConCustCont){
			for(int i = 0 ; i < pmList.size() ; i ++) {
				String key = pmList.get(i).getProperty();
				System.out.println("interceptor test ::::::::::: "+ key);
				System.out.println("interceptor test :::::::::::::::   "+((Member) param).getAdminId());
				
			}
		}/*else if(param instanceof Member) {
			System.out.println("inter 진입!!!!!!!!!!!!!!!!1");
			Statement st = (Statement) (invocation.getArgs())[0];
			Connection con = st.getConnection();
			String orginSql = "select tenant_id, cust_id, cont_nm, valid_start_dt, valid_end_dt, cont_stat_cd, network_fg_cd, password_lod_cd, password_min_len, password_rnwl_cycl_cd, password_use_lmt_yn, password_pose_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date from concustcontm where tenant_id = '1'" ;
			
			System.out.println("inter 진입!!!!!!!!!!!!!!!!2");
			String histSql = "insert into conadminh (admin_id, admin_nm, admin_priv_cd, email_addr, password, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date)" + 
					"    	values ('"+m.getAdminId()+"', '"+m.getAdminNm()+"', '"+m.getAdminPrivCd()+"', '"+m.getEmailAddr()+"', '"+m.getPassword()+"', 'ADMIN', null, current_timestamp, 'ADMIN', null, current_timestamp)";
			PreparedStatement psmt = con.prepareStatement(orginSql);
			
			//handler.query(psmt, resultHandler);
			
			PreparedStatement psmtH;
			System.out.println("inter 진입!!!!!!!!!!!!!!!!3");
			//boolean a = psmt.execute();
			//System.out.println("쿼리 결과 "+a);
			System.out.println("쿼리 수행1~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			ResultSet rs = psmt.executeQuery(orginSql);
			//psmt.close();
			System.out.println("쿼리 수행2~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			
			String histSql = "";
			if(rs.next()) {
				histSql = "INSERT INTO concustcontm_log(tenant_id, cust_id, cont_nm, valid_start_dt, valid_end_dt, cont_stat_cd, network_fg_cd, password_lod_cd, password_min_len, password_rnwl_cycl_cd, password_use_lmt_yn, password_pose_yn, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date)"
						+"values('"+rs.getString("tenant_id")+"', '"+rs.getString("cust_id")+"', '"+rs.getString("cont_nm")+"', '"+rs.getString("valid_start_dt")+"', '"+rs.getString("valid_end_dt")+"', '"+rs.getString("cont_stat_cd")+"', '"+rs.getString("network_fg_cd")+"', '"+rs.getString("password_lod_cd")+"', "+rs.getInt("password_min_len")+", '"+rs.getString("password_rnwl_cycl_cd")+"', '"+rs.getString("password_use_lmt_yn")+"', '"+rs.getString("password_pose_yn")+"', '"+rs.getString("crt_id")+"', '"+rs.getString("crt_ip")+"', "+rs.getTime("ad_date")+", '"+rs.getString("udt_id")+"', '"+rs.getString("udt_ip")+"', "+rs.getTime("udt_date")+")";
				
				System.out.println("inter test ::: "+histSql);
				
				psmtH = con.prepareStatement(histSql);
				handler.update(psmtH);
			}
			
			//handler.update(st2);
		}*/
			
		/*Member m = (Member)param;
		
		Statement st = (Statement) (invocation.getArgs())[0];
		Connection con = st.getConnection();
		
		String histSql = "insert into conadminh (admin_id, admin_nm, admin_priv_cd, email_addr, password, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date)" + 
				"    	values ('"+m.getAdminId()+"', '"+m.getAdminNm()+"', '"+m.getAdminPrivCd()+"', '"+m.getEmailAddr()+"', '"+m.getPassword()+"', 'ADMIN', null, current_timestamp, 'ADMIN', null, current_timestamp)";
		Statement st2 = con.prepareStatement(histSql);
		handler.update(st2);*/
		
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object target) {
		// TODO Auto-generated method stub
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties properties) {
		// TODO Auto-generated method stub
		
	}
	
}
