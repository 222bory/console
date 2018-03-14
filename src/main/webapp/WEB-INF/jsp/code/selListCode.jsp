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
		var cdGroupId = td.eq(1).text();
       
        $("input[name=cdGroupId]").val(cdGroupId);
	 	
	 	$("#frm").attr("action", "/selCodeView");
	 	submit();
    });
	
	$("#btnSearch").on("click", function(e){
		$("#frm").attr("action", "/selListCode");
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
			<li class="breadcrumb-item"><a href="/selListCode">시스템관리</a></li> 
			<li class="breadcrumb-item active">코드 목록</li>
		</ul>
	</div>
</div>

<section class="charts">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">코드 목록</h1>
          </header>
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">코드 목록</h2>
                </div>
                
                <form action="" method="post" id="frm">
	                <input type="hidden" name="page" value="${codeModel.page}" />
	                <input type="hidden" name="cdGroupId" value="" />
	                <div class="card-header d-flex">
	                	  
	                      <div class="col-md-2">
	                        <select id="serachGroup" name="serachGroup" class="form-control form-control-sm">
	                           <option value="cdGroupId">코드그룹아이디</option>
	                           <option value="cdGroupNm">코드그룹명</option>
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
                <%--          
               <div class="card-header d-flex align-items-center">
                   <form class="form-inline">
                    <div class="form-group">
                        <select name="account" class="form-control">
                          <option>option 1</option>
                          <option>option 2</option>
                          <option>option 3</option>
                          <option>option 4</option>
                        </select>
                    </div>
                    <div class="form-group">
                      <label for="inlineFormInputGroup" class="sr-only">Username</label>
                      <input id="inlineFormInputGroup" type="text" placeholder="Username" class="mx-sm-2 form-control form-control">
                    </div>
                    <div class="form-group">
                      <input type="button" value="검색" class="mx-sm-3 btn btn-primary">
                    </div>
                	</form>
                </div> --%>
         
                    
                <div class="line"></div>        
                
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>코드그룹아이디</th>
                        <th>코드그룹명</th>
                        <th>등록자</th>
                        <th>등록자IP</th>
                        <th>등록일자</th>
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
	                        <td>${list.cdGroupId}</td>
	                        <td>${list.cdGroupNm}</td>
	                        <td>${list.crtId}</td>
	                        <td>${list.crtIp}</td>
	                        <td><fmt:formatDate value='${list.adDate}' pattern='yyyy-MM-dd'/></td>
	                        
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