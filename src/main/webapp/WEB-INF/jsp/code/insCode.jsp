<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">

$(document).ready(function(){

	$("#btnCancel").click(function(){
		location.href="/selListServiceApply";
	});
	
    // 서비스 추가 버튼 클릭시
    $("#addRowBtn").click(function(){
    	addServiceTbl('btn');
    });
    
    
 	//등록 
	$("#btnRegister").on("click", function(e){
		
		
		if($("#cdGroupId").val() == ''){
			alert("코드그룹ID를 입력해 주세요!");
			$("input[name=cdGroupId]").focus();
			return;
		} 
		
		if($("#cdGroupNm").val() == ''){
			alert("코드그룹명을 입력해 주세요!");
			$("input[name=cdGroupNm]").focus();
			return;
		} 
				

		$.each($('input[name=cdId]'),function(){
			if($.trim($(this).val()) == "") {
				exit = true;
				alert("코드를 입력해주세요!");
				$(this).focus();
				return false;
				}
			    exit = false;
		});
		if(exit){return;} 
		
		$.each($('input[name=cdNm]'),function(){
			if($.trim($(this).val()) == "") {
				exit = true;
				alert("코드명을 입력해주세요!");
				$(this).focus();
				return false;
				}
			    exit = false;
		});
		if(exit){return;} 
		 
		
		
		/* $.each($('input[name=cdNm]'),function(){
			if($.trim($(this).val()) == "") {
				exit2 = true;
				alert("코드명를 입력해주세요!");
				$(this).focus();
				return false;
				}
		});
		if(exit2){ return false;}  */ 
		
		$.ajax({
			type : "POST",
			url  : "/insCode", 
			dataType : "json",
			data : $("#frm").serializeArray(),
			success : function(data, status) {
				try{
					if( data.result == '1'){
						alert("등록 성공!");
						redirectList();
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
					//console.log(XMLHttpRequest.code + ":" + textStatus + ":" + errorThrown);
					alert('서비스에 문제가 발생되었습니다. 관리자에게 문의 하시기 바랍니다.');
				}
				return;
			}
		});
	});
 	
	//삭제
	$(document).on("click","input[name='delRowBtn']",function(){
		$(this).parent().parent().remove();
	});
	
});

function redirectList(){
	$("#frm").attr("action", "/selListCode");

	$("#frm").submit();
}


function addServiceTbl(flag){
	var no = Number($(".no").last().text());
    num = no+1;
    
	var html ="";
    html += "<tr>"; 
    html += "<th scope='row' class='no'>"+num+"</th>";
	html += "<td><input name='cdId' type='text' class='form-control form-control-sm' /> </td>";
	html += "<td><input name='cdNm' type='text' class='form-control form-control-sm' /> </td>";
	html += "<td><input type='button' name='delRowBtn' value='삭제' class='btn btn-primary'/></td>";
	html += "</tr>"; 

	$('tbody[name=serviceTbody]').append(html); 
	
}
</script>



 <div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item">시스템관리</li>
			<li class="breadcrumb-item active"><a href="insCodeForm">코드등록</a></li>
		</ul>
	</div>
</div>

<section class="forms">
	<div class="container-fluid">
	<header>
		<h1 class="h3 display">코드등록</h1>
	</header>


<form class="form-horizontal" id="frm" name="frm" method="POST">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-header d-flex align-items-center">
				<h2 class="h5 display">코드그룹 입력</h2>
			</div>
			<div class="card-body">
				 <div class="row">
				 <label class="col-sm-2 form-control-label">* 코드그룹 아이디</label>
			         <div class="form-group col-sm-8">
	                 <input id="cdGroupId" name='cdGroupId' type="text"  class="form-control form-control-sm">
	                 </div>
                 </div>
                 
                 <input type="hidden" id="tenantId" name="tenantId" value=""/>
                 <input type="hidden" id="cpCd" name="cpCd" value=""/>
             
             <div class="line"></div>
             
			<div class="row">
				<label class="col-sm-2 form-control-label">* 코드그룹명</label>
				<div class="form-group col-sm-8">
	                 <input id="cdGroupNm" name='cdGroupNm' type="text"  class="form-control form-control-sm">
	            </div>
			</div>

		</div>
		</div>
	</div>
	
	<div class="col-lg-12">
		<div class="form-group">
              <div class="card">
              	<div class="card-header d-flex align-items-center">
					<h2 class="h5 display">코드 정보 입력</h2>
				</div>
               		<div class="card-body">	
               		<div style="float:right">
						<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-primary"/>
                	</div>
					<table id="serviceTbl" name="serviceTbl" class="table">
						<thead>
	                      <tr>
	                        <th>#</th>
	                        <th>코드</th>
	                        <th>코드명</th>
	                        <th></th>
	                      </tr>
	                    </thead>
						<tbody name="serviceTbody">
						 <tr> 
						    <th scope="row" class="no">1</th>
							<td><input name='cdId' type='text' class='form-control form-control-sm' /> </td>
							<td><input name='cdNm' type='text' class='form-control form-control-sm' /> </td>
							
						</tr>
						</tbody>
					</table>
					
			<div class="line"></div>
			<div class="btn-center">
				<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
				<input type="button" id="btnRegister" class="btn btn-primary" value="등록" />
			</div>
				</div>
              </div>
           </div>


	</div>
	
</form>
</div>

</section>