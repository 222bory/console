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
	
$("#btnRegister").on("click", function(e){
		
		/* if(isEmpty($("input[name=titlNm]").val())){
			alert("제목을 입력해 주세요!");
			$("input[name=titlNm]").focus();
			return;
		} */

		
		$.ajax({
			type : "POST",
			url  : "/insMonitor", 
			dataType : "json",
			data : $("#frm").serialize(),
			success : function(data, status) {
				try{
					if( data.result == '1'){
						alert("등록 성공!");
						redirectList();
					} else {
						//alert(makeMessage(INSERT_FAIL, '<br>' + 'RETURN CODE : ' + data.result + '<br>' + 'RETURN MESSAGE : ' + data.message));
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
					//console.log(XMLHttpRequest.code + ":" + textStatus + ":" + errorThrown);
					alert('서비스에 문제가 있습니다. 관리자에게 문의 하세요.');
				}
				return;
			}
		});
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
            <li class="breadcrumb-item">모니터링 등록</li>
          </ul>
        </div>
      	</div>
        <div class="container-fluid">
          <header> 
            <h1 class="h3 display">모니터링 등록</h1>
          </header>
          <div class="row">
      
            
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">Monitoring URL</h2>
                </div>
                
                    
                
                <div class="card-body">
                  <form id="frm" action="" method="post" class="form-horizontal">
                  
                  	<div class="row">
						 <label class="col-sm-2 form-control-label">* 대회선택</label>
						 <div class="col-sm-2 select">
	                       <select id="searchType" name="searchType" class="form-control">
		                       <option value="C">대회코드</option>
			                   <option value="N">대회명</option>
	                       </select>
	                    </div>
	                    
	                    <div class="col-sm-3">
	                        <input type="text" id="searchValue" class="form-control" placeholder="유형 선택 후 검색어 입력">
	                    </div>
	                    
	                    <div class="col-sm-5 select">
	                       <select id="tenantId" name="tenantId" class="form-control">
	                       <c:forEach items="${contractList}" var="list" varStatus="parent">
	                         <option value="${list.tenantId}">${list.contNm} [ tenant id : ${list.tenantId} ]</option>
	                       </c:forEach>
	                       </select>
	                    </div>
                    </div>
                    <div class="line"></div>
                    <div class="form-group row">
                      <label class="col-sm-2 form-control-label">hystricx URL</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="montrnUrlAddr"><span class="help-block-none">예) http://www.hystricx.com</span>
                      </div>
                    </div>
                    <div class="line"></div>
                    <div class="form-group row">
                      <label class="col-sm-2 form-control-label">zipkin URL</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="montrnUrlAddr"><span class="help-block-none">예) http://www.zipkin.com</span>
                      </div>
                    </div>
                    <div class="line"></div>
                    
                    <div class="form-group row">
                      <div class="col-sm-4 offset-sm-2">
                        <button type="button" class="btn btn-secondary">취소</button>
                        <button type="button" id="btnRegister" class="btn btn-primary">등록</button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>