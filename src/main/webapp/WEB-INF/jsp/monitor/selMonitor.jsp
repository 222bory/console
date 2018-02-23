<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<script type="text/javascript">

$(document).ready(function(){
	$("#btnCancel").click(function(){
		location.href="/selListMonitor";
	});
	
	$("#searchValue").keyup(function(){
		$.getJSON('searchCompetition', {"searchType" : $('#searchType').val(), "searchValue" : $('#searchValue').val()}, function(data){
			var html;
			$("#tenantId option").remove();
			
			var obj = $("#searchValue").offset();
			
			$(data).each(function(entryIndex, entry){
				$('#tenantId').append('<option value="'+entry.tenantId+'">'+entry.contNm+' [ tenant id : '+entry.tenantId+' ]</option>');
			});
			
		});
	});
	
	$("#btnList").on("click", function(e){
		$("#frm").attr("action", "/selListMonitor");
		$("#frm").submit();
	});
	
	$("#btnModify").on("click", function(e){
		$("#frm").attr("action", "/upMonitorForm");
		$("#frm").submit();
	});
	
	$("#btnDelete").on("click", function(e){
		var r = confirm("정말 삭제 하시겠습니까?");
		
		if (r == true) {
			$.ajax({
				type : "POST",
				url  : "/delMonitor", 
				dataType : "json",
				data : $("#frm").serialize(),
				success : function(data, status) {
					try{
						if( data.result == '1'){
							alert("삭제 성공!");
							redirectList();
						} else {
							//alert(makeMessage(INSERT_FAIL, '<br>' + 'RETURN CODE : ' + data.result + '<br>' + 'RETURN MESSAGE : ' + data.message));
							alert("RETURN CODE : "+ data.result+' , '+"삭제 실패!");
						}
					}catch(e) {	
						alert('서비스에 문제가 발생되었습니다. 관리자에게 문의 하시기 바랍니다.');
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					if(XMLHttpRequest.status == '901'){
						sessionTimeOut();			
					} else {
						//console.log(XMLHttpRequest.code + ":" + textStatus + ":" + errorThrown);
						alert('서비스에 문제가 있습니다. 관리자에게 문의 하세요.');
					}
					return;
				}
			}); 
	    } else {
	        //취소 처리 
	    }
		
	});
	
	function redirectList(){
		$("#frm").attr("action", "/selListMonitor");
		$("#frm").submit();
	}
});


</script>

<section class="forms">
        <div class="breadcrumb-holder">
        <div class="container-fluid">
          <ul class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">시스템관리</a></li>
            <li class="breadcrumb-item">모니터링 상세</li>
          </ul>
        </div>
      	</div>
        <div class="container-fluid">
          <header> 
            <h1 class="h3 display">모니터링 상세</h1>
          </header>
          <div class="row">
      
            
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">Monitoring URL</h2>
                </div>
                
                    
                
                <div class="card-body">
                  <form id="frm" action="" method="post" class="form-horizontal">
                    <input type="hidden" id="tenantId" name="tenantId" value="${mm.tenantId}" />
                  	<div class="form-group row">
						 <label class="col-sm-2 form-control-label">* 대회선택</label>
						 <div class="col-sm-10">
                        [${mm.tenantId}] ${mm.contNm}
                      </div>
                    </div>
                    <div class="line"></div>
                    <div class="form-group row">
                      <label class="col-sm-2 form-control-label">hystricx URL</label>
                      <div class="col-sm-10">
                        ${mm.url1}
                      </div>
                    </div>
                    <div class="line"></div>
                    <div class="form-group row">
                      <label class="col-sm-2 form-control-label">zipkin URL</label>
                      <div class="col-sm-10">
                        ${mm.url2}
                      </div>
                    </div>
                    <div class="line"></div>
                    
                    <div class="form-group row">
                      <div class="col-sm-4 offset-sm-2">
                        <button type="button" id="btnDelete" class="btn btn-secondary" >삭제</button>
						<button type="button" id="btnModify" class="btn btn-primary" >수정</button>
						<button type="button" id="btnList" class="btn btn-primary" >목록</button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>