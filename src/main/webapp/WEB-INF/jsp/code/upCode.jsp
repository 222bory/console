<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">

$(document).ready(function(){
	// 서비스 추가 버튼 클릭시
    $("#addRowBtn").click(function(){
    	addServiceTbl();
    });
	
    $("#btnCancel").on("click", function(e){
		$("#frm").attr("action", "/selListCode");
		$("#frm").submit();
	});
	
    $("#btnUpdate").on("click", function(e){
    	
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
		
		var r = confirm("정말 수정 하시겠습니까?");
		
		if (r == true) {
			$.ajax({
				type : "POST",
				url  : "/upCode", 
				dataType : "json",
				data : $("#frm").serialize(),
				success : function(data, status) {
					try{
						if( data.result == '1'){
							alert("수정 성공!");
							redirectList();
						} else {
							//alert(makeMessage(INSERT_FAIL, '<br>' + 'RETURN CODE : ' + data.result + '<br>' + 'RETURN MESSAGE : ' + data.message));
							alert("RETURN CODE : "+ data.result+' , '+"수정 실패!");
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
	
});

function redirectList(){
	$("#frm").attr("action", "/selListCode");

	$("#frm").submit();
}

function addServiceTbl(){
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

//삭제
$(document).on("click","input[name='delRowBtn']",function(){
	$(this).parent().parent().remove();
});
</script>



 <div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item">시스템관리</li>
			<li class="breadcrumb-item active"><a href="selListCode">코드관리</a></li>
			<li class="breadcrumb-item active">코드수정</li>
		</ul>
	</div>
</div>

<section class="forms">
	<div class="container-fluid">
	<header>
		<h1 class="h3 display">코드상세</h1>
	</header>


<form class="form-horizontal" id="frm" name="frm" method="POST">
<input type="hidden" name="page" value="${codeModel.page}" />
<input type="hidden" name="cdGroupId" value="${cdGroupId}" />
	<div class="col-lg-12">
		<div class="card">
			<div class="card-header d-flex align-items-center">
				<h2 class="h5 display">코드그룹 상세</h2>
			</div>
			<div class="card-body">
				 <div class="row">
				 <label class="col-sm-2 form-control-label">* 코드그룹 아이디</label>
			         <div class="form-group col-sm-8">
	                 ${cdGroupId}
	                 </div>
                 </div>
                 
             <div class="line"></div>
             
			<div class="row">
				<label class="col-sm-2 form-control-label">* 코드그룹명</label>
				<div class="form-group col-sm-8">
	                 ${cdGroupNm}
	            </div>
			</div>

		</div>
		</div>
	</div>
	
	<div class="col-lg-12">
		<div class="form-group">
              <div class="card">
              	<div class="card-header d-flex align-items-center">
					<h2 class="h5 display">코드 정보 상세</h2>
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
						<c:set var="countNo" value="1"/>
						
						  	<c:forEach items="${list}" var="list" varStatus="parent">
		                      <tr class="tr">
		                            <th scope="row" class="no">${countNo}</th>
			                        <td><input name='cdId' type='text' class='form-control form-control-sm' value='${list.cdId}' /> </td>
									<td><input name='cdNm' type='text' class='form-control form-control-sm' value='${list.cdNm}'/></td>
									<td><input type='button' name='delRowBtn' value='삭제' class='btn btn-primary'/></td>
			                  </tr>
			                   <c:set var="countNo" value="${countNo+1 }" />
			               </c:forEach>  
						</tbody>
					</table>
					
			<div class="line"></div>
			<div class="btn-center">
				<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
				<button type="button" id="btnUpdate" class="btn btn-primary" >수정</button>
			</div>
				</div>
              </div>
           </div>


	</div>
	
</form>
</div>

</section>