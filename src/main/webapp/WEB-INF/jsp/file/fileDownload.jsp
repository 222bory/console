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
						if( data.result == '1' ){
							alert("'"+data.fileDir+"' 경로로 파일 다운로드가 완료되었습니다");
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
	 
 	 $('#btnScriptExecute').click(function(event){
 		 var form = $('#fileForm')[0];
 		 var formData = new FormData(form);
 		 var file = $("#scriptFile")[0].files[0];

 		 if(file != null){
 			formData.append("scriptFile", file);
 			/* 		 var scriptFile = $('#scriptFile').file;
 					 var scriptFilePath = $('#scriptFile').val().split('\\').pop(); */

 					 $.ajax({
 							type : "POST",
 							url  : "/executeQuery", 
 							processData: false,
 			                contentType: false,
 							data : formData,
 							success : function(data, status) {
 								try{
 									 if( data.result == '1'){
 										alert("스크립트 실행이 완료되었습니다");
 									} else {
 										alert("스크립트 실행 중 문제가 발생하였습니다 \n message: "+ data);
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
 			
 			 }
	 	 else{
	 		 alert("파일을 선택해주세요");
	 	 }
	 }); 
	});
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item">시스템관리</li>
			<li class="breadcrumb-item active"><a href="fileDownload">데이터다운로드</a></li>
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
                  <h2 class="h5 display" >스크립트 다운로드/실행</h2>
                </div>
                <div class="card-body">
                
                
                <div class="row">
	                <label class="col-sm-2 form-control-label">테넌트 ID</label>
	                <div class="col-md-4">
	                <select id='tenantId' class='form-control'> 
	 	         		<c:forEach items="${tenantList}" var="list" >
							<option value="${list}">${list}</option> 
						</c:forEach>	
					</select> 	
					</div>
					<div class="col-md-2">
						<input type="button" value="스크립트다운로드" id="btnScriptDownload" class="btn btn-primary"/> 
					</div>
                </div>
                
                <div class="line"></div>
                
                <form id="fileForm"  method="POST" enctype="multipart/form-data" action="">
                 <div class="row">
                 	<label class="col-sm-2 form-control-label">스크립트 실행</label>
                 	<div class="col-md-4">
                    	<input type="file" id="scriptFile" class="form-control form-control-sm"/>
					</div>
					<div class="col-md-2">
						<input type="button" value="스크립트실행" id="btnScriptExecute" class="btn btn-primary"/> 
					</div>
                </div>
                </form>
                
                </div>
              </div>
            </div>

        </div>
      </section>