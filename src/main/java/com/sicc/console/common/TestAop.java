package com.sicc.admin.common;

/*import java.lang.reflect.Method;
import java.util.List;

import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.ParameterMap;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.session.SqlSession;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.sicc.admin.controller.IndexController;
import com.sicc.admin.enums.AdminEnums;
import com.sicc.admin.model.Member;
import com.sicc.admin.service.UserService;*/

//@Aspect

//@Component

public class TestAop{


	//private ApplicationContext applicationContext;
	
	//@Autowired
	//private SqlSessionTemplate sqlSessionTemplate;	

	//@Around("@annotation(com.sicc.admin.demo.common.WithHist) && @ annotation(target)")
    /*public Object customAnnoTest(ProceedingJoinPoint joinPoint, WithHist target) throws Throwable {
		
		IndexController m = (IndexController)applicationContext.getBean("indexController");
		
		System.out.println("aop111 test :::: " + target.sqlId());
		
		//AdminEnums.target.getValue();
		
		System.out.println("sql :::: "+sqlSessionTemplate.getConfiguration().getMappedStatement(target.sqlId()).getSqlSource().getBoundSql(target.sqlId()).getSql());
		
		ParameterMap map = sqlSessionTemplate.getConfiguration().getMappedStatement(target.sqlId()).getParameterMap();
		
		SqlSource s = sqlSessionTemplate.getConfiguration().getMappedStatement(target.sqlId()).getSqlSource();
		
		System.out.println("map test1 :::"+ map.toString());
		
		
		
		BoundSql b = sqlSessionTemplate.getConfiguration().getMappedStatement(target.sqlId()).getBoundSql(map);
		
		System.out.println("map test ::: "+b.getSql());
				
				
		List<ParameterMapping> parameterMappingList =
		sqlSessionTemplate.getConfiguration().getMappedStatement(target.sqlId()).getSqlSource().getBoundSql(target.sqlId()).getParameterMappings();
		
		System.out.println("parameter :: "+parameterMappingList.get(0).toString());
		
		Member member = sqlSessionTemplate.selectOne(target.sqlId(), "ransang");
		
		System.out.println("aop test222 ::: "+ member.getAdminNm());
		
		
		Object returnPoint = joinPoint.proceed();

		return returnPoint;

    }*/



   

}
