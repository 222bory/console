<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">
var no = 0;

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
    	var addRowNum = $('tbody[name=serviceTbody] > tr').length;
    	
    	if(addRowNum == 0){
    		
    		alert("사용하실 서비스를 선택해주세요");
    	
    		return;
    	}

    	addServiceTbl('btn', no++);
    	
    	setDatepicker(addRowNum);
	
    });
    

 	//등록 
	$("#btnRegister").on("click", function(e){
		//테넌트 ID, 대회코드 setting
		var competitionStr = $("#competition").val().split('.');
		var tenantId = competitionStr[0];
		var cpCd = competitionStr[1];
		var flag = false;
		
		var serviceCount = $('tbody[name=serviceTbody] > tr').length;
		var configCount = $('tbody[name=configTbody] > tr').length;
		
		if(configCount==0 || serviceCount==0){
			alert("최소 한개 이상의 서비스를 선택해주세요");
			return;
		}
		
		//validation check
		flag = checkValid();

		if(flag){
			
		$("#tenantId").val(tenantId);	
		$("#cpCd").val(cpCd);
		
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
			$(this).next().next().val('Y');
		});
		$("input[name=testLabCheck]").not(":checked").each(function(){
			$(this).next().next().val('N');
		});
		$("input[name=testEventCheck]:checked").each(function(){
			$(this).next().next().val('Y');
		});
		$("input[name=testEventCheck]").not(":checked").each(function(){
			$(this).next().next().val('N');
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
					} else if(data.result == 'dupl'){
						alert("이미 서비스를 신청한 대회입니다");
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
		}
	});

});
</script>

<!-- dynamic object event binding -->
<script>

	//삭제
	$(document).on("click","input[name='delRowBtn']",function(){
		$(this).parent().parent().remove();
	});
	
	//상위서비스 변경 이벤트
 	$(document).on("change","select[name='serviceCd']",function(){
 		var html="";
		var serviceId = this.value;
	 	var serviceCd = $(this);
	 	var systemCd = serviceCd.parent().next().children();
		var serviceChk = false;

	 	$("input[name='serviceChkBox']").each(function(){	 		
	 		if(serviceCd.val() == $(this).val()){
				if(!$(this).is(":checked")){
	 				alert("서비스 선택을 먼저 체크해주세요!");
	 				serviceCd.val('0');
	 				serviceCd.focus();
	 				
	 				serviceChk = false;
	 			}
				else{ serviceChk = true; }
	 		} 
	 	});
	 	
	 	
	 	if(serviceChk){
		 	//하위서비스 clear
		 	systemCd.find('option').remove();
		 	
		 	//상위서비스(대표서비스)의 하위서비스를 Load
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
	 	}
	});
 	
	//체크박스 서비스 선택
	$(document).on("change","input[name='serviceChkBox']",function(){
		//상위서비스 사용 체크시
		if($(this).is(":checked")){
			var servicdCd="";
			var systemCd="";
			var addRowNum = $('tbody[name=serviceTbody] > tr').length;
			
			$("#configInfo").show();
			$("#serviceInfo").show();

			addServiceTbl('chk', no++);
			setDatepicker(addRowNum);
			
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
			var checkServiceNm = $(this).val();
			
			delServiceTbl(checkServiceNm, 'chk'); //서비스 상세정보 입력 row 삭제
			
			delOptionTbl(checkServiceNm); //서비스별 설정 row 삭제
		}
	});
 	
</script>

<script>
function redirectList(){
	$("#frm").attr("action", "/selListServiceApply");

	$("#frm").submit();
}

 function checkValid(){
	var flag = false;

	$('select[name=serviceCd]').each(function(){
		if($(this).val()=='0' || $(this).val()=='' || $(this).val()==null){
			flag = false;
			alert('서비스를 선택해주세요');
			$(this).focus();
			
			return false;
		}
		else{
			flag = true;
		}
	});
	
	if(flag){
		$('select[name=systemCd]').each(function(){
			if($(this).val()=='0' || $(this).val()=='' || $(this).val()==null){
				flag = false;
				alert('하위서비스를 선택해주세요');
				$(this).focus();
				
				return false;
			}
			else{
				flag = true;
			}
		});
	}
	
	if(flag){
		$('input[name=serviceStartDt]').each(function(){
			if( $(this).val()=='' || $(this).val()==null){
				flag = false;
				alert('시작일자를 선택해주세요');
				$(this).focus();
				
				return false;
			}
			else{
				flag = true;
			}
		});
	}
	
	if(flag){
		$('input[name=serviceStartDt]').each(function(){
			if( $(this).val()=='' || $(this).val()==null){
				flag = false;
				alert('종료일자를 선택해주세요');
				$(this).focus();
				
				return false;
			}
			else{
				flag = true;
			}
		});
	}
	
	if(flag){
		$('input[name=serviceUrlAddr]').each(function(){
			if( $(this).val()=='' || $(this).val()==null){
				flag = false;
				alert('서비스URL을 입력해주세요');
				$(this).focus();
				
				return false;
			}
			else{
				flag = true;
			}
		});
	}
	
	if(flag){
		$('input[name=repColorValue]').each(function(){

			if( $(this).val()=='' || $(this).val()==null){
				flag = false;
				alert('컬러를 선택해주세요');
				$(this).focus();
				
				return false;
			}
			else{
				flag = true;
			}
		});
	}
	
	if(flag){
		$('select[name=fstLangCd]').each(function(){
			if( $(this).val()=='0'){
				flag = false;
				alert('최소 하나 이상의 언어를 선택해주세요');
				$(this).focus();
				
				return false;
			}
			else{
				flag = true;
			}
		});
	}
	
	//하위서비스 중복 체크
	if(flag){
		flag = !duplCheck();	
	}

	return flag;
} 

 
function dateCheck(){
	var dateChk = false;
	
	
	
	return dateChk;
}

function duplCheck(){
	var duplChk = false;
	var tbody = $('#serviceTbl > tbody');
	var tableRow = $('#serviceTbl > tbody > tr');
	var tableLength = tableRow.length;

	for(i=0; i< tableLength; i++){
		var serviceNm = tbody.find('tr:eq('+i+') > td:eq(0) > select').val();
		var systemNm = tbody.find('tr:eq('+i+') > td:eq(1) > select').val();
		var serviceSystemNm1 = serviceNm+'.'+systemNm;

		if(duplChk){
			break;
		}
		
		if(systemNm != 'default'){
			for( j=0 ; j < tableLength ; j++){
				var serviceNm2 = tbody.find('tr:eq('+j+') > td:eq(0) > select').val();
				var systemNm2 = tbody.find('tr:eq('+j+') > td:eq(1) > select').val();
				var serviceSystemNm2 = serviceNm2+'.'+systemNm2;

				if(systemNm2 != 'default'){
					if(i != j){
						if(serviceSystemNm1 == serviceSystemNm2){
							alert('중복된 서비스가 있습니다. 다시 확인해주세요.');
							duplChk = true;
							break;
						}
					}
					
				}
				
			}	
		}
		
	}

	return duplChk;
}

//서비스별 상세정보 입력 테이블 추가
function addServiceTbl(flag, no){
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
		html += "<td > <div class='row'> <input name='testLabCheck' id='testLabCheck"+no+"' type='checkbox' class='form-control-custom'>";
		html += "<label for='testLabCheck"+no+"'/>";
		html +=	"<input type='hidden' name='testLabUseYn' value='N'/>";
		html += "<input name='testLabRemarkDesc' type='text' class='form-control form-control-sm col-md-9' placeholder='비고(용도)' /> </div></td>";
		html += "<td> <div class='row'> <input name='testEventCheck' id='testEventCheck"+no+"' type='checkbox' class='form-control-custom'>";
		html += "<label for='testEventCheck"+no+"'/>";
		html += "<input type='hidden' name='testEventAddYn' value='N'/>";
		html += "<input name='testEventRemarkDesc' type='text' class='form-control form-control-sm col-md-9' placeholder='비고(용도)'/></div></td>";
		html += "<td></td>";
	}
	else if(flag == 'btn'){ //추가 버튼 클릭으로 하위서비스 추가
		html += "<td><input name='testLabRemarkDesc' type='text' class='form-control form-control-sm' readonly='true'/> <input type='hidden' name='testLabUseYn' value='N'/></td>";
		html += "<td><input name='testEventRemarkDesc' type='text' class='form-control form-control-sm' readonly='true'/> <input type='hidden' name='testEventAddYn' value='N'/></td>";
	
		html += "<td><input type='button' name='delRowBtn' value='삭제' class='btn btn-primary'/></td>";
	}

	html += "</tr>"; 

	$('tbody[name=serviceTbody]').append(html); 
	
}

//서비스별 설정 테이블 추가
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
		        color: '#000000',
		        format: 'hex'
			});
		});
}

function delServiceTbl(checkServiceNm , flag){
	$('#serviceTbl > tbody > tr').each(function(i,e){
		if( $(this).find('td:eq(1) select').val() == 'default'){
		if( $(this).find('td:eq(0) select').val() == checkServiceNm){
			$(this).remove();
		}
		}
	});
}

function delOptionTbl(checkServiceNm){
	$('#configTbl > tbody > tr').each(function(i,e){
		if( $(this).find('td:eq(0)').text() == checkServiceNm){
			$(this).remove();
		}
	});
}

function setDatepicker(addRowNum){
	var rowNum = addRowNum;
	var startDt =  $($('input[name=serviceStartDt]').get(rowNum));
	var endDt = $($('input[name=serviceEndDt]').get(rowNum));
	
	// 달력 초기화
    startDt.datepicker({
    		"format" :'yyyy-mm-dd',
            "todayHighlight":true,
            "autoclose": true
    });
	
    startDt.datepicker("setDate",new Date());
/* 	startDt.datepicker("option","onClose", function(selectedDate){
		endDt.datepicker("option", "minDate", selectedDate);
	}); */
	
 	// 달력 초기화
    endDt.datepicker({
    		"format" :'yyyy-mm-dd',
            "autoclose": true,
            "todayHighlight":true
    });
 	
    endDt.datepicker("setDate",new Date());
/*     endDt.datepicker("option","onClose", function(selectedDate){
    	startDt.datepicker("option", "maxDate", selectedDate);
	}); */
	
}
</script>

 <div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item">서비스관리</li>
			<li class="breadcrumb-item active"><a href="insServiceApplyForm">서비스신청</a></li>
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
           <div class="card" id="configInfo" style="display:none;">
                <div class="card-header d-flex align-items-center">
					<h2 class="h5 display">서비스별 설정</h2>
				</div>
             <div class="card-body" >	
					<table id="configTbl" name="configTbl" class="table" >
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
              <div class="card" id="serviceInfo" style="display:none;">
              	<div class="card-header d-flex align-items-center">
					<h2 class="h5 display">서비스별 상세정보 입력</h2>
				</div>
               		<div class="card-body" >	
               		<div style="float:right">
						<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-primary"/>
                	</div>
					<table id="serviceTbl" name="serviceTbl" class="table" >
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th style="width:15%">하위서비스</th>
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>서비스URL</th>
	                        <th>테스트랩 사용여부</th>
	                        <th>테스트이벤트 사용여부</th>
	                        <th></th>
	                      </tr>
	                    </thead>
						<tbody name="serviceTbody"></tbody>
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