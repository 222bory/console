<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

	$(document).ready(function(){

	 $('#btnScriptDownload').click(function(event){
		 var tenantId = $('#tenantId').val();
		 
		 $.ajax({
				type : "POST",
				url  : "/exportQuery", 
				dataType : "json",
				data : {"tenantId": tenantId },
				success : function(data, status) {
					try{
						 if( data == '1'){
							alert("다운로드가 완료되었습니다");
						} else {
							alert("다운로드 중 문제가 발생하였습니다");
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
	 
	 $('#btnDataDownload').click(function(event){
		 var tenantId = $('#tenantId').val();
		 
		 $.ajax({
				type : "POST",
				url  : "/exportData", 
				dataType : "json",
				data : {"tenantId": tenantId },
				success : function(data, status) {
					try{
						 if( data == '1'){
							alert("다운로드가 완료되었습니다");
						} else {
							alert("다운로드 중 문제가 발생하였습니다");
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
	 
	});
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="">시스템관리</a></li>
			<li class="breadcrumb-item active">데이터 다운로드</li>
		</ul>
	</div>
</div>

	  <section class="forms">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">데이터 다운로드</h1>
          </header>

            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display" >테넌트ID 선택</h2>
                </div>
                <div class="card-body">
                <div class="row">
	                <label class="col-sm-2 form-control-label">* 테넌트ID</label>
	                <select id='tenantId' class='form-control form-control-sm col-md-4'> 
	 	         		<c:forEach items="${tenantList}" var="list" >
							<option value="${list}">${list}</option> 
						</c:forEach>	
					</select> 	
					<div class="col-md-2">
					<input type="button" value="스크립트다운로드" id="btnScriptDownload" class="btn btn-primary"/> 
					</div>
					<div class="col-md-2">
					<input type="button" value="데이터다운로드" id="btnDataDownload" class="btn btn-primary"/> 
					</div>
                </div>
                </div>
              </div>
            </div>

        </div>
      </section>