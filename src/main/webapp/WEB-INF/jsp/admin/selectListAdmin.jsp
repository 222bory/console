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
	
	
	//계정 삭제
	$(document).on("click","input[name='delRowBtn']",function(){
		var delId = $(this).parent().parent().find('td:eq(0)').text();
		
		console.log(delId);
			
 		$.ajax({
			type : "POST",
			url  : "/delAdmin", 
			dataType : "json",
			data : {"delId":delId},
			success : function(data, status) {
				try{
					if( data.result == '1'){
						alert("삭제 성공!");
						goPage(1);
					} else {
						alert("RETURN CODE : "+ data.result+' , '+"등록 실패!");
					}
				}catch(e) {	
					alert('서비스에 문제가 발생되었습니다. 관리자에게 문의 하시기 바랍니다.');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				if(XMLHttpRequest.status == '901'){
					sessionTimeOut();			
				} else {
					alert('서비스에 문제가 발생되었습니다. 관리자에게 문의 하시기 바랍니다.');
				}
				return;
			}
		}); 
		
	});
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item">계정관리</li>
			<li class="breadcrumb-item active"><a href="/selectListAdmin">사용자계정관리</a></li>
		</ul>
	</div>
</div>

<section class="forms">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">사용자계정관리</h1>
          </header>

            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">사용자계정목록</h2>
                </div>
                <div class="card-body">
                <form action="" method="post" id="frm">
                <input type="hidden" name="page" value="${adminModel.page}" />
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>ID</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>권한</th>
                        <th>가입일자</th>
                        <th></th>
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
                        <td><input type="button" name="delRowBtn" value="삭제" class="btn btn-primary"/></td>
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
      </section>