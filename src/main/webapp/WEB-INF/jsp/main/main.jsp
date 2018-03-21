<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
$(function () {
	$("h2[class^='h5 display 1']").click(function(){
        $("#frm").attr("action", "/selListContract");
	 	submit();
    });
	
	$("h2[class^='h5 display 2']").click(function(){
        $("#frm").attr("action", "/selListCompetition");
	 	submit();
    });
	
	$("h2[class^='h5 display 3']").click(function(){
        $("#frm").attr("action", "/selListServiceApply");
	 	submit();
    });
	
	function submit(){
		
		$("#frm").submit();  
		
	};
});	
	
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/main">메인</a></li> 
		</ul>
	</div>
</div>

<section class="charts">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">메인페이지</h1>
          </header>
          <div class="row">
            <div class="col-lg-6">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display 1">계약목록  [더보기]</h2>
                </div>
                
                <div class="card-body">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>고객명</th>
                        <th>테넌트ID</th>
                        <th>계약명</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:set var="countNo" value="1"/>
						<c:choose>
						<c:when test="${fn:length(Contractlist) >0 }">
		                    <c:forEach items="${Contractlist}" var="list" varStatus="parent">
		                      <tr class="tr">
		                        <th scope="row">${countNo}</th>
		                        <td>${list.custNm}</td>
		                        <td>${list.tenantId}</td>
		                        <td>${list.contNm}</td>
		                      </tr>
		                    <c:set var="countNo" value="${countNo+1 }" />
		                    </c:forEach>  
		                </c:when>
						<c:otherwise>
							<tr>
		                        <td colspan="5"  class="tbl_listnodata" align='center'>조회된 목록이 없습니다.</td>
							</tr>
						</c:otherwise>
						</c:choose>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
			<div class="col-lg-6">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display 2">대회목록 [더보기]</h2>
                </div>
                <div class="card-body">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>테넌트ID</th>
                        <th>계약명</th>
                        <th>대회명</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:set var="countNo" value="1"/>
	                    <c:forEach items="${competitionList}" var="list" varStatus="parent">
	                      <tr>
	                        <th scope="row">${countNo}</th>
	                        <td>${list.tenantId}</td>
	                        <td>${list.contNm}</td>
	                        <td>${list.cpNm}</td>
	                      </tr>
	                    <c:set var="countNo" value="${countNo+1 }" />
                    </c:forEach>  
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display 3">서비스목록 [더보기]</h2>
                </div>
                <div class="card-body">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>테넌트ID</th>
                        <th>대회코드</th>
                        <th>대회명</th>
                        <th>신청서비스</th>
                        <th>대회기간</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:set var="countNo" value="1"/>
	                    <c:forEach items="${serviceList}" var="list" varStatus="parent">
	                      <tr>
	                        <th scope="row">${countNo}</th>
	                        <td>${list.tenantId}</td>
	                        <td>${list.cpCd}</td>
	                        <td>${list.cpNm}</td>
	                        <td>${list.serviceCd}</td>
	                        <c:set var="cpStartDt" value="${list.cpStartDt}"/>
							<c:set var="cpEndDt" value="${list.cpEndDt}"/>
	                        <td>${fn:substring(cpStartDt,0,4)}-${fn:substring(cpStartDt,4,6)}-${fn:substring(cpStartDt,6,8)} ~ ${fn:substring(cpEndDt,0,4)}-${fn:substring(cpEndDt,4,6)}-${fn:substring(cpEndDt,6,8)}</td>
	                      </tr>
	                    <c:set var="countNo" value="${countNo+1 }" />
	                    </c:forEach>  
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
      
          </div>
        </div>
      </section>
      
      <form id="frm"></form>