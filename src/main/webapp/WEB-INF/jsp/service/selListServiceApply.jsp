<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	
	$(document).ready(function(){
		
	 $('#selListServiceTable tr').click(function(event){
		 if(event.target.nodeName.toLowerCase() == 'td') {
			var tenantId = $(this).children().eq(1).text();
			var cpCd = $(this).children().eq(2).text();
			
		 	$("input[name=tenantId]").val(tenantId);
		 	$("input[name=cpCd]").val(cpCd);
			
		 	$("#frm").attr("action", "/selServiceApply");
		 	submit();
		 	
			//location.href='/selServiceApply?tenantId='+tenantId+'&cpCd='+cpCd;
			} 
		});
	});
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="">서비스관리</a></li>
			<li class="breadcrumb-item active">서비스신청 관리</li>
		</ul>
	</div>
</div>

	  <section class="forms">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">서비스신청 관리</h1>
          </header>
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display" >서비스신청 목록</h2>
                </div>
                <div class="card-body">
                <form action="" method="POST" id="detailFrm">
                	<input type="hidden" id="hiddenTenantId" name="hiddenTenantId" value="" />
                </form>
                
                <form action="" method="POST" id="frm">
                <input type="hidden" name="page" value="${serviceModel.page}" />
                <input type="hidden" name="tenantId" value="" />
                <input type="hidden" name="cpCd" value="" />
                  <table class="table" id="selListServiceTable">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Tenant ID</th>
                        <th>대회코드</th>
                        <th>대회명</th>
                        <th>대회기간</th>
                        <th>신청서비스</th>
                        <th>등록일</th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:set var="no" value="${pagination.totalRow - (pagination.currentPage - 1) * pagination.rowPerPage }"/>
					<c:set var="countNo" value="0"/>
                    <c:forEach items="${serviceList}" var="list" varStatus="parent">
                      <tr>
                        <th scope="row">${no - countNo}</th>
                        <td>${list.tenantId}</td>
                        <td>${list.cpCd}</td>
                        <td>${list.cpNm}</td>
                        <td>${list.cpStartDt} ~ ${list.cpEndDt}</td>
                        <td>${list.serviceCd}</td>
                        <td>${list.adDate}</td>
                      </tr>
                    <c:set var="countNo" value="${countNo+1 }" />
                    </c:forEach>  
                    </tbody>
                  </table>
              	  </form>
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