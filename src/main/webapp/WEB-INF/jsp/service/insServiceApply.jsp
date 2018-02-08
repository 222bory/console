<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="css/custom.css"> 
<script type="text/javascript">

$(document).ready(function(){
	
	$('div[name=repColorCd]').colorpicker({
        color: '#AA3399',
        format: 'hex'
    });
	
    // 서비스 추가 버튼 클릭시
    $("#addRowBtn").click(function(){
     	var html ="";
	   // var originSelectItem = $('tbody[name=serviceTbody]:last > tr:last > td:eq(0) > select').clone();
	    var newSelectItem = "";
   
	    html += "<tr>"; 
    	html += "<td> <select name='serviceCd' class='form select'> <option value='0'>선택</option>"+
    			 " <c:forEach items='${serviceList}' var='list'> "+
    			 " <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select> </td>";
		html += "<td> <select name='systemCd' class='form select'> <option value='0'>서비스선택</option> </select> </td>";
		html += "<td> <input name='serviceStartDt' type='text' class='form-control' /> </td>";
		html += "<td> <input name='serviceEndDt' type='text' class='form-control' /> </td>";
		html += "<td> <div class='row'> <input name='testLabUseYn' type='checkbox' value='Y' checked='checked' >";
		html += "<label></label> <input name='testLabRemarkDesc' type='text' class='form-control' placeholder='비고(용도)'/></div></td>";
		html += "<td> <div class='row'> <input name='testEventAddYn' type='checkbox' value='Y' checked='checked' >";
		html += "<label></label> <input name='testEventRemarkDesc' type='text' class='form-control' placeholder='비고(용도)'/></div></td>";
		html += "<td> <input name='serviceUrlAddr' type='text' class='form-control' placeholder=''/> </td>";
		html += "</tr>"; 

		$('tbody[name=serviceTbody]').append(html); 
		//$('tbody[name=serviceTbody]:last > tr:last > td:eq(0)').html(originSelectItem); 

	 	// 달력 초기화
	    $('input[name=serviceStartDt]').datepicker({
	    		"format" :'yyyy-mm-dd',
	            "autoclose": true,
	            "todayHighlight":true
	    });
	    $('input[name=serviceStartDt]').datepicker("setDate", new Date());
	 	
	 	// 달력 초기화
	    $('input[name=serviceEndDt]').datepicker({
	    		"format" :'yyyy-mm-dd',
	            "autoclose": true,
	            "todayHighlight":true
	    });
	    $('input[name=serviceEndDt]').datepicker("setDate", new Date());
    });
    
			
 	// 서비스 삭제버튼 클릭시
    $("#delRowBtn").click(function(){  
		//var rows= $('#serviceTbl > tbody:last > tr').length;

	   		$('#serviceTbl > tbody:last > tr:last').remove();
		
    });
 	
 	
 	//등록 
	$("#btnRegister").on("click", function(e){
		$.ajax({
			type : "POST",
			url  : "/insServiceApply", 
			dataType : "json",
			data : $("#frm").serialize(),
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
					alert('서비스에 문제가 있습니다. 관리자에게 문의 하세요.');
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
				alert("에러");
			}
		});
	});
 	
	//체크박스 서비스 선택
	$(document).on("change","input[name='serviceChkBox']",function(){
		var rowNum = $('tbody[name=serviceTbody] tr').length;

		//상위서비스 사용 체크시
		if($(this).is(":checked")){
			var servicdCd="";
			var systemCd="";
			
			$("#addRowBtn").click();
			
			servicdCd = $('tbody[name=serviceTbody]:last > tr:last > td:eq(0) >select');
			systemCd = $('tbody[name=serviceTbody]:last > tr:last > td:eq(1) >select');
			
			servicdCd.val($(this).val());
			servicdCd.attr('disabled','disabled');
			
		 	systemCd.find('option').remove();
		 	systemCd.append("<option value='default'>대표서비스</option>");
		 	systemCd.attr('disabled','disabled');
		 	
		 	addOptionTbl($(this).val()); //서비스별 설정 row 추가
		 	
		}
		//상위서비스 미사용 체크시
		else{
			for( i=0; i< rowNum; i++){
				var removeRow = $('tbody[name=serviceTbody] > tr:eq('+i+')');
				
				if(removeRow.find('td:eq(1) select').val() == 'default'){
					if( removeRow.find('td:eq(0) select').val() == $(this).val()){
						
						removeRow.remove();
					}
				}
			}
			
			delOptionTbl($(this).val()); //서비스별 설정 row 삭제
		}
	});
 	
</script>

<script>
function redirectList(){
	$("#frm").attr("action", "/insServiceApply");
	
	//disabled 설정 해제
	$("select[name=serviceCd]").removeAttr("disabled");
	$("select[name=systemCd]").removeAttr("disabled");
	
/* 	  $("#form").submit( function(eventObj) {
	      $('<select />')
          .attr('name', "serviceCdD")
          .appendTo('#form');
	      return true;
	  }); */
	$("#frm").append('<td name="serviceCdD"/>');
	
	  
	//$("input[name=page]").val("1");
	$("#frm").submit();
}

function addOptionTbl(serviceCd){
 	var html ="";

	    html += "<tr>"; 
	    html += "<td name='serviceCdD'>"+serviceCd+"</td>";
 		html += "<td> <div name='repColorCd' class='input-group colorpicker-component'>"+
 				"<input type='text' value='#00AABB' class='form-control' />"+
 				"<span class='input-group-addon'><i></i></span></div></td>";
 		html += "<td> <div class='col-sm-5 select'> <select name='fstLangCd' class='form select'> <option value='0'>사용안함</option>" +
 			 	" <c:forEach items='${languageList}' var='list'> "+
 				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></div></td>";
		html += "<td> <div class='col-sm-5 select'> <select name='scndLangCd' class='form select'> <option value='0'>사용안함</option>" +
			 	" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></div></td>";
		html += "<td> <div class='col-sm-5 select'> <select name='thrdLangCd' class='form select'> <option value='0'>사용안함</option>" +
		 		" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></div></td>";
		html += "<td> <div class='col-sm-5 select'> <select name='fothLangCd' class='form select'> <option value='0'>사용안함</option>" +
		 		" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></div></td>";
		html += "<td> <div class='col-sm-5 select'> <select name='fithLangCd' class='form select'> <option value='0'>사용안함</option>" +
		 		" <c:forEach items='${languageList}' var='list'> "+
				" <option value='${list.cdId}'>${list.cdNm}</option></c:forEach> </select></div></td>";		
		html += "</tr>"; 

		$('tbody[name=configTbody]').append(html); 

		//var originTbody = $('tbody[name=configTbody]:eq(0)').clone();
	   // $('#configTable').append(originTbody);	
 		
	    
	   //colorpicker 초기화
		$('div[name=repColorCd]').each(function(){
			$(this).colorpicker({
		        color: '#AA3399',
		        format: 'hex'
			});
		});
}

function delOptionTbl(servicdCd){
	var rowNum = $('#configTable > tbody > tr').length;
	
	for( i=0; i< rowNum; i++){
		var removeRow = $('tbody[name=configTbody] > tr:eq('+i+')');
		
		if( removeRow.find('td:eq(0)').text() == servicdCd){
			removeRow.remove();
		}
	}
}
</script>

 <div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/userList">서비스관리</a></li>
			<li class="breadcrumb-item active">서비스신청</li>
		</ul>
	</div>
</div>

<section class="forms">
	<div class="container-fluid">
	
	<header>
		<h1 class="h3 display">서비스신청</h1>
	</header>
	
	<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
			<form class="form-horizontal" id="frm" name="frm" method="POST">
				
				<div class="form-group">
				<label class="col-sm-2 form-control-label">* 대회선택</label>
				<div class="row">
					<div style="width: 60%; padding: 0.375rem 0.75rem;">
						<input type="hidden" id="tenantId" name="tenantId" value="2018000000"/>
						<input type="hidden" id="cpCd" name="cpCd" value="PC20180101"/>
						<input type="text" class="form-control" id="cpNm" name="cpNm" value="평창동계올림픽1"/>
					</div>
					<div style="width: 30%; padding: 0.375rem 0.75rem;">
						<button type="button" id="searchCpBtn" class="btn btn-primary">검색</button>
					</div>
				</div>
				</div>
				<div class="line"></div>
				<div class="form-group">
					<label class="col-sm-2 form-control-label">* 서비스선택</label>
                       	<c:forEach items="${serviceList}" var="list" varStatus="status">
                       		<input type="checkbox" id="serviceChkBox+${status.index}" name="serviceChkBox" value="${list.cdId}" class="form-control-custom">
                       		<label for="serviceChkBox+${status.index}">${list.cdNm}</label>
                       	</c:forEach>

					<div class="line"></div>
					
					<div class="col-md-15">
					<label class="col-sm-2 form-control-label">* 서비스별 상세정보 입력</label>
					<br>
					<label class="col-sm-2 form-control-label">하위 서비스 추가/삭제</label>
					<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-secondary"/>
                	<input type="button" name="delRowBtn" id="delRowBtn" value="삭제" class="btn btn-secondary"/>
					<table id="serviceTbl" name="serviceTbl" class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>하위서비스</th>
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>테스트랩<br>사용여부</th>
	                        <th>테스트이벤트<br>사용여부</th>
	                        <th>서비스URL</th>
	                      </tr>
	                    </thead>
						<tbody name="serviceTbody">
	                    </tbody>
					</table>
				  	</div>
                 </div>
                 
             <div class="line"></div>
             
              <div class="form-group">
				<div class="row">
					<label class="col-sm-2 form-control-label">서비스별 설정</label>
				</div>
                <div class="col-md-15">
					<table class="table" id="configTable">
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
						<tbody name='configTbody'> </tbody>
					</table>

				  </div> 
				  
	  			<div class="line"></div>
				<div class="form-group">
					<div class="col-sm-4 offset-sm-2">
						<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
						<button type="submit" id="btnRegister" class="btn btn-primary" >등록</button>
					</div>
				</div>
				</form>
	
				</div>
			</div>
		</div>
		</div>	
	</div>
</div>
</section>