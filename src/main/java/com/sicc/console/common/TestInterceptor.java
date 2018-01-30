package com.sicc.console.common;

import java.sql.Connection;
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
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.CommonDao;
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
		
		
		if(param instanceof Member){
			for(int i = 0 ; i < pmList.size() ; i ++) {
				String key = pmList.get(i).getProperty();
				System.out.println("interceptor test ::::::::::: "+ key);
				System.out.println("interceptor test :::::::::::::::   "+((Member) param).getAdminId());
				
			}
		}	
			
		Member m = (Member)param;
		
		Statement st = (Statement) (invocation.getArgs())[0];
		Connection con = st.getConnection();
		
		String histSql = "insert into conadminh (admin_id, admin_nm, admin_priv_cd, email_addr, password, crt_id, crt_ip, ad_date, udt_id, udt_ip, udt_date)" + 
				"    	values ('"+m.getAdminId()+"', '"+m.getAdminNm()+"', '"+m.getAdminPrivCd()+"', '"+m.getEmailAddr()+"', '"+m.getPassword()+"', 'ADMIN', null, current_timestamp, 'ADMIN', null, current_timestamp)";
		Statement st2 = con.prepareStatement(histSql);
		handler.update(st2);
		
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
