<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">

$(document).ready(function(){


	$("#btnCancel").click(function(){
		location.href="/selListServiceApply";
	});
	
	//검색어 입력
	$("#searchValue").keyup(function(){
		$.getJSON('searchCompetitionService', 
				{"searchType" : $('#searchType').val(), "searchValue" : $('#searchValue').val()}, function(data){
			var html;
			$("#competition option").remove();
			
			var obj = $("#searchValue").offset();
			
			$(data).each(function(entryIndex, entry){
				$('#competition').append('<option value="'+entry.tenantId+'.'+entry.cpCd+'">'+entry.cpNm+' [ tenant id : '+entry.tenantId+' 대회코드 : '+entry.cpCd+' ]</option>');
			});
			
		});
	});
	
    // 서비스 추가 버튼 클릭시
    $("#addRowBtn").click(function(){
    	
    	if($('tbody[name=serviceTbody] > tr').length == 0){
    		
    		alert("사용하실 서비스를 선택해주세요");
    	
    		return;
    	}

    	addServiceTbl('btn');
    	
    	// 달력 초기화
	    $('input[name=serviceStartDt]').datepicker({
	    		"format" :'yyyy-mm-dd',
	            "autoclose": true,
	            "todayHighlight":true
	    });
 	
	 	// 달력 초기화
	    $('input[name=serviceEndDt]').datepicker({
	    		"format" :'yyyy-mm-dd',
	            "autoclose": true,
	            "todayHighlight":true
	    });

    });
    
			
 	// 서비스 삭제버튼 클릭시
    $("#delRowBtn").click(function(){  
		//var rows= $('#serviceTbl > tbody:last > tr').length;
		//$('#serviceTbl > tbody:last > tr:last').remove();
    	delServiceTbl('', 'btn');
    });
 	
 	
 	//등록 
	$("#btnRegister").on("click", function(e){
		//테넌트 ID, 대회코드 setting
		var competitionStr = $("#competition").val().split('.');
		var tenantId = competitionStr[0];
		var cpCd = competitionStr[1];

		$("#tenantId").val(tenantId);	
		$("#cpCd").val(cpCd);
		console.log($("#frm").serializeArray());
		
		if($("input[name=serviceUrlAddr]").length == 1 && $("input[name=serviceUrlAddr]").val()==''){
			$("input[name=serviceUrlAddr]").val(' ');
		}
		if($("input[name=testLabRemarkDesc]").length == 1 && $("input[name=testLabRemarkDesc]").val()==''){
			$("input[name=testLabRemarkDesc]").val(' ');
		}
		if($("input[name=testEventRemarkDesc]").length == 1 && $("input[name=testEventRemarkDesc]").val()==''){
			$("input[name=testEventRemarkDesc]").val(' ');
		}
		
		//disabled 설정 해제
		$("select[name=serviceCd]").removeAttr("disabled");
		$("select[name=systemCd]").removeAttr("disabled");
		
		$("input[name=testLabCheck]:checked").each(function(){
			$(this).next().val('Y');
		});
		$("input[name=testLabCheck]").not(":checked").each(function(){
			$(this).next().val('N');
		});
		$("input[name=testEventCheck]:checked").each(function(){
			$(this).next().val('Y');
		});
		$("input[name=testEventCheck]").not(":checked").each(function(){
			$(this).next().val('N');
		});
		
		$.ajax({
			type : "POST",
			url  : "/insServiceApply", 
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
 	

});
</script>

<!-- dynamic object event binding -->
<script>
	//상위서비스 변경 이벤트
 	$(document).on("change","select[name='serviceCd']",function(){
 		var html="";
		var serviceId = this.value;
	 	var serviceCd = $(this);
	 	var systemCd = serviceCd.parent().next().children();

	 	//하위서비스 clear
	 	systemCd.find('option').remove();
	 	//하위서비스 첫행
	 	//systemCd.append("<option value='default'>대표서비스</option>");

		$.ajax({
			type : 'POST',
			url : '/selServicebySytem',
			//파리미터 변수 이름 : 값
			data : {
				serviceId : serviceId
			},
			cache:true,
			success : function(data){
				
				if(data.length>0){
					for(var i=0; i <data.length; i++){
						systemCd.append("<option value='"+data[i].cdId+"'>"+data[i].cdNm+"</option>");
					}	
				} 
			},
			error:function(){
				alert('서비스에 문제가 발생되었습니다. 관리자에게 문의 하시기 바랍니다.');
			}
		});
		
		
		
		
	});
 	
	//체크박스 서비스 선택
	$(document).on("change","input[name='serviceChkBox']",function(){
		//상위서비스 사용 체크시
		if($(this).is(":checked")){
			var servicdCd="";
			var systemCd="";
			
			//$("#addRowBtn").click();
			addServiceTbl('chk');
			setDatepicker();
			
			servicdCd = $('tbody[name=serviceTbody]:last > tr:last > td:eq(0) >select');
			systemCd = $('tbody[name=serviceTbody]:last > tr:last > td:eq(1) >select');
			
			servicdCd.val($(this).val());
			servicdCd.attr('disabled','disabled');
			
		 	systemCd.find('option').remove();
		 	systemCd.append("<option value='default'>대표서비스</option>");
		 	systemCd.attr('disabled','disabled');
		 	
		 	addOptionTbl($(this).val()); //서비스별 설정 row 추가
		 	
		}
		//상위서비스 체크 해제
		else{
			/* var rowNum = $('tbody[name=serviceTbody] tr').length;
			
			for( i=0; i< rowNum; i++){
				var removeRow = $('tbody[name=serviceTbody] > tr:eq('+i+')');
				
				if(removeRow.find('td:eq(1) select').val() == 'default'){
					if( removeRow.find('td:eq(0) select').val() == $(this).val()){
						
						removeRow.remove();
					}
				}
			} */
			var checkService = $(this).val();
			
			delServiceTbl(checkService, 'chk'); //서비스 상세정보 입력 row 삭제
			
			delOptionTbl(checkService); //서비스별 설정 row 삭제
		}
	});
 	
</script>

<script>
function redirectList(){
	$("#frm").attr("action", "/selListServiceApply");

	$("#frm").submit();
}

/* function checkValid(){

	$('select[name=serviceCd]').each(function(){
		
	});
	
	
	
}  */


function addServiceTbl(flag){
	var html ="";
    html += "<tr>"; 
	html += "<td> <select name='serviceCd' class='form-control form-control-sm'> <option value='0'>선택</option>"+
			 " <c:forEach items='${serviceList}' var='list'> "+
			 " <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select> </td>";
	html += "<td> <select name='systemCd' class='form-control form-control-sm'> <option value='0'>서비스선택</option> </select> </td>";
	html += "<td> <input name='serviceStartDt' type='text' class='form-control form-control-sm'/> </td>";
	html += "<td> <input name='serviceEndDt' type='text' class='form-control form-control-sm' /> </td>";
	html += "<td> <input name='serviceUrlAddr' type='text' class='form-control form-control-sm'/> </td>";
	
	if(flag == 'chk'){ //체크박스로 서비스 선택 및 추가
		html += "<td > <input name='testLabCheck' type='checkbox' class='form-check-input'>";
		html +=	"<input type='hidden' name='testLabUseYn' value='N'/>";
		html += "<input name='testLabRemarkDesc' type='text' class='form-control form-control-sm' placeholder='비고(용도)' /> </td>";
		html += "<td><input name='testEventCheck' type='checkbox' class='form-check-input'>";
		html += "<input type='hidden' name='testEventAddYn' value='N'/>";
		html += "<input name='testEventRemarkDesc' type='text' class='form-control form-control-sm' placeholder='비고(용도)'/></td>";
	}
	else if(flag == 'btn'){ //추가 버튼 클릭으로 하위서비스 추가
		html += "<td><input name='testLabRemarkDesc' type='text' class='form-control form-control-sm' readonly='true'/> <input type='hidden' name='testLabUseYn' value='N'/></td>";
		html += "<td><input name='testEventRemarkDesc' type='text' class='form-control form-control-sm' readonly='true'/> <input type='hidden' name='testEventAddYn' value='N'/></td>";
	}

	html += "</tr>"; 

	$('tbody[name=serviceTbody]').append(html); 
	
}


function addOptionTbl(serviceCd){
 	var html ="";

	    html += "<tr>"; 
	    html += "<td>"+serviceCd+"</td>";
	    html += "<input type='hidden' name='serviceCdD' value='"+serviceCd+"'/>";
 		html += "<td style='width:20%'> <div class='col-md-12'> <div name='colorGroup' class='input-group colorpicker-component'>"+
 				"<input name='repColorValue' type='text' class='form-control form-control-sm' />"+
 				"<span class='input-group-addon'><i></i></span></div></div></td>";
 		html += "<td> <select name='fstLangCd' class='form-control form-control-sm'> <option value='0'>사용안함</option>" +
 			 	" <c:forEach items='${languageList}' var='list'> "+
 				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></td>";
		html += "<td><select name='scndLangCd' class='form-control form-control-sm'> <option value='0'>사용안함</option>" +
			 	" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></td>";
		html += "<td> <select name='thrdLangCd' class='form-control form-control-sm'> <option value='0'>사용안함</option>" +
		 		" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></td>";
		html += "<td> <select name='fothLangCd' class='form-control form-control-sm'> <option value='0'>사용안함</option>" +
		 		" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></td>";
		html += "<td> <select name='fithLangCd' class='form-control form-control-sm'> <option value='0'>사용안함</option>" +
		 		" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></td>";		
		html += "</tr>"; 

		$('tbody[name=configTbody]').append(html); 

	   //colorpicker 초기화
		$('div[name=colorGroup]').each(function(){
			$(this).colorpicker({
		        color: '#AA3399',
		        format: 'hex'
			});
		});
}

function delServiceTbl(checkService , flag){
	var rowNum = $('tbody[name=serviceTbody] tr').length;
	var removeRow ="";

	for( i=0; i< rowNum; i++){
		removeRow = $('tbody[name=serviceTbody] > tr:eq('+i+')');
			
		if(flag=='chk'){//체크해제
			if(removeRow.find('td:eq(1) select').val() == 'default'){
				if( removeRow.find('td:eq(0) select').val() == checkService){
					removeRow.remove();
				}
			}
		}
	}
	
	for( i=rowNum-1; i>=0; i--){
		if(flag=='btn'){//삭제버튼
			removeRow = removeRow = $('tbody[name=serviceTbody] > tr:eq('+i+')');
			if(removeRow.find('td:eq(1) select').val() != 'default'){ 
					removeRow.remove();
					return;
			}
		}
	}
	
}

function delOptionTbl(checkService){
	var rowNum = $('#configTable > tbody > tr').length;
	
	for( i=0; i< rowNum; i++){
		var removeRow = $('tbody[name=configTbody] > tr:eq('+i+')');
		
		if( removeRow.find('td:eq(0)').text() == checkService){
			removeRow.remove();
		}
	}
}

function setDatepicker(){
	
	// 달력 초기화
    $('input[name=serviceStartDt]').datepicker({
    		"format" :'yyyy-mm-dd',
            "autoclose": true,
            "todayHighlight":true
    });
    //$('input[name=serviceStartDt]').datepicker("setDate", new Date());
 	
 	// 달력 초기화
    $('input[name=serviceEndDt]').datepicker({
    		"format" :'yyyy-mm-dd',
            "autoclose": true,
            "todayHighlight":true
    });
   // $('input[name=serviceEndDt]').datepicker("setDate", new Date());
	
}
</script>

 <div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/selListServiceApply">서비스관리</a></li>
			<li class="breadcrumb-item active">서비스신청</li>
		</ul>
	</div>
</div>

<section class="forms">
	<div class="container-fluid">
	<header>
		<h1 class="h3 display">서비스신청</h1>
	</header>


<form class="form-horizontal" id="frm" name="frm" method="POST">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-header d-flex align-items-center">
				<h2 class="h5 display">서비스 정보 입력</h2>
			</div>
			<div class="card-body">
				 <div class="row">
				 <label class="col-sm-2 form-control-label">* 대회선택</label>
				 <div class="form-group">
	                 <select id="searchType" name="searchType" class="form-control form-control-sm">
	                   <option value="C">대회코드</option>
	                   <option value="N">대회명</option>
	                 </select>
                 </div>
                 
                 <div class="form-group col-sm-2">
                 <input id="searchValue" type="text" placeholder="유형 선택 후 검색어 입력" class="form-control form-control-sm">
                 </div>
                 <div class="form-group col-sm-6">
					 <select id="competition" name="competition" class="form-control form-control-sm">
	                    <c:forEach items="${competitionList}" var="list" varStatus="parent">
	                      <option value="${list.tenantId}.${list.cpCd}">${list.cpNm} [ tenant id : ${list.tenantId}, 대회코드 : ${list.cpCd} ]</option>
	                    </c:forEach>
	                  </select>
                 </div>
                 </div>
                 
                 <input type="hidden" id="tenantId" name="tenantId" value=""/>
                 <input type="hidden" id="cpCd" name="cpCd" value=""/>
             
             <div class="line"></div>
             
			<div class="row">
				<label class="col-sm-2 form-control-label">* 서비스선택</label>
				<div class="form-group col-sm-8">
                   	<c:forEach items="${serviceList}" var="list" varStatus="status">
                   		<input type="checkbox" id="serviceChkBox+${status.index}" name="serviceChkBox" value="${list.cdId}" class="form-control-custom">
                   		<label for="serviceChkBox+${status.index}">${list.cdNm}</label>
                   	</c:forEach>
				</div>	
			</div>

		</div>
		</div>
	</div>
	
	<div class="col-lg-12">
		<div class="form-group">
           <div class="card">
                <div class="card-header d-flex align-items-center">
					<h2 class="h5 display">서비스별 설정</h2>
				</div>
             <div class="card-body">	
				<!-- <label class="col-sm-4 form-control-label">서비스별 설정</label> -->
					<table  id="configTable" name="configTable" class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>컬러선택</th>
	                        <th>1차언어</th>
	                        <th>2차언어</th>
	                        <th>3차언어</th>
	                        <th>4차언어</th>
	                        <th>5차언어</th>
	                      </tr>
	                    </thead>
						<tbody name="configTbody"></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="col-lg-12">
		<div class="form-group">
              <div class="card">
              	<div class="card-header d-flex align-items-center">
					<h2 class="h5 display">서비스별 상세정보 입력</h2>
				</div>
                <div class="card-body">	

					<div style="float:right;">
						<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-primary"/>
	                	<input type="button" name="delRowBtn" id="delRowBtn" value="삭제" class="btn btn-primary"/>
                	</div>
					<table id="serviceTbl" name="serviceTbl" class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>하위서비스</th>
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>서비스URL</th>
	                        <th>테스트랩 사용여부</th>
	                        <th>테스트이벤트 사용여부</th>
	                      </tr>
	                    </thead>
						<tbody name="serviceTbody"></tbody>
					</table>
				</div>
              </div>
           </div>
      
        
		
		<div class="form-group">
			<div class="col-sm-4 offset-sm-2">
				<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
				<input type="button" id="btnRegister" class="btn btn-primary" value="등록"></input>
			</div>
		</div>		
		
	</div>
	
</form>
</div>

</section>