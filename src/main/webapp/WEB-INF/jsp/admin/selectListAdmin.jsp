<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	
 
	function goPage(page) {
		$("input[name=page]").val(page);
		submit();
	}
	
	function submit(){
		
		$("#frm").submit();  
		
	}
	
	
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/selectListAdmin">계정관리</a></li>
			<li class="breadcrumb-item active">사용자 계정 관리</li>
		</ul>
	</div>
</div>

<section class="charts">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">사용자계정관리</h1>
          </header>
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">사용자계정목록</h2>
                </div>
                <div class="card-body">
                <form action="" method="post" id="frm">
                <input type="hidden" name="page" value="${adminModel.page}" />
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>ID</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>권한</th>
                        <th>가입일자</th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:set var="no" value="${pagination.totalRow - (pagination.currentPage - 1) * pagination.rowPerPage }"/>
					<c:set var="countNo" value="0"/>
                    <c:forEach items="${list}" var="list" varStatus="parent">
                      <tr>
                        <th scope="row">${no - countNo}</th>
                        <td>${list.adminId}</td>
                        <td>${list.adminNm}</td>
                        <td>${list.emailAddr}</td>
                        <td>${list.adminPrivCd}</td>
                        <td>${list.adDate}</td>
                        
                      </tr>
                    <c:set var="countNo" value="${countNo+1 }" />
                    </c:forEach>  
                    </tbody>
                  </table>
              	  </form>
                  <!-- //Pagenate -->
<%-- 				  <div class="pgwrap">
					<div class="pg_num">
					<c:import url="/WEB-INF/jsp/paging/paging.jsp">
					</c:import>
					</div>
				  </div> --%>
				 	<div class="pagination">
					  <ul>
					  	<c:import url="/WEB-INF/jsp/paging/paging.jsp"></c:import>
					  </ul>
					</div>
				  
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>