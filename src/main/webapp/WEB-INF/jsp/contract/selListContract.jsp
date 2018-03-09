<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
$(function () {
	$("table tr[class^='tr']").click(function(){
        tr = $(this);
        var td = tr.children();
		var custId = td.eq(1).text();
        var tenantId = td.eq(3).text();
        
        $("input[name=custId]").val(custId);
	 	$("input[name=tenantId]").val(tenantId);
	 	
	 	$("#frm").attr("action", "/selContractView");
	 	submit();
    });
	
	$("#btnSearch").on("click", function(e){
		$("#frm").attr("action", "/selListContract");
		$("#frm").submit();
	});
	
});
	
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
			<li class="breadcrumb-item"><a href="/selListContract">서비스관리</a></li> 
			<li class="breadcrumb-item active">계약 목록</li>
		</ul>
	</div>
</div>

<section class="charts">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">계약 목록</h1>
          </header>
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">계약 목록</h2>
                </div>
                
                <form action="" method="post" id="frm">
	                <input type="hidden" name="page" value="${contractExtModel.page}" />
	                <input type="hidden" name="custId" value="" />
	                <input type="hidden" name="tenantId" value="" />
	                <div class="card-header d-flex">
	                	  
	                      <div class="col-md-2">
	                        <select id="serachGroup" name="serachGroup" class="form-control form-control-sm">
	                           <option value="custNm">고객명</option>
	                           <option value="contNm">계약명</option>
	                         </select>
	                      </div>
	                      <div class="col-md-3">
	                        <input type="text" class="form-control form-control-sm" id="serachNm" name="serachNm">
	                      </div>
	                      <div class="col-md-1">
	                     	<input type="button" class="form-control form-control-sm" id="btnSearch" name="btnSearch" value="검색">
	                     </div> 
	                </div>
                </form>
                
                <div class="card-body">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>고객아이디</th>
                        <th>고객명</th>
                        <th>테넌트ID</th>
                        <th>계약명</th>
                        <th>가입일자</th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:set var="no" value="${pagination.totalRow - (pagination.currentPage - 1) * pagination.rowPerPage }"/>
					<c:set var="countNo" value="0"/>
					
					<c:choose>
					<c:when test="${fn:length(list) >0 }">
	                    <c:forEach items="${list}" var="list" varStatus="parent">
	                      <tr class="tr">
	                        <th scope="row">${no - countNo}</th>
	                        <td>${list.custId}</td>
	                        <td>${list.custNm}</td>
	                        <td>${list.tenantId}</td>
	                        <td>${list.contNm}</td>
	                        <td>${list.adDate}</td>
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
              	 
                  <!-- //Pagenate -->
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