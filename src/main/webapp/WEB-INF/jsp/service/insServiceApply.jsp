<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="css/custom.css"> 
<script src="vendor/jquery/jquery.bpopup.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
		
 	// 달력 세팅
    $('input[name=serviceStartDt]').each(function(){
    	$(this).datepicker({
    		"format" :'yyyy-mm-dd',
            "autoclose": true,
            "todayHighlight":true
    	});
    	$(this).datepicker("setDate", new Date());
    });
    
 	// 달력 세팅
    $('input[name=serviceEndDt]').each(function(){
 	
	 	$(this).datepicker({
			"format" :'yyyy-mm-dd',
	        "autoclose": true,
	        "todayHighlight":true
		});
	 	$(this).datepicker("setDate", new Date());
    });
 	
	$('div[name=repColorCd]').colorpicker({
        color: '#AA3399',
        format: 'hex'
    });
	
    // 서비스 추가 버튼 클릭시
    $("#addRowBtn").click(function(){  
     	var html ="";
	    var originSelectItem = $('tbody[name=serviceTbody]:last > tr:last > td:eq(0) > select').clone();
	    var newSelectItem = "";
	    
	    html += "<tr>"; 
    	html += "<td> </td>";
		html += "<td> <select name='systemSel' class='form select'> <option value='0'>서비스선택</option> </select> </td>";
		html += "<td> <input name='serviceStartDt' type='text' class='form-control' /> </td>";
		html += "<td> <input name='serviceEndDt' type='text' class='form-control' /> </td>";
		html += "<td> <div class='row'> <input name='testLabUseYn' type='checkbox' value='Y' checked='checked' class='form-control-custom'>";
		html += "<label for ='testLabUseYn'></label> <input name='testLabRemarkDesc' type='text' class='form-control' placeholder='비고(용도)'/></div></td>";
		html += "<td> <div class='row'> <input name='testEventAddYn' type='checkbox' value='Y' checked='checked' class='form-control-custom'>";
		html += "<label for ='testEventAddYn'></label> <input name='testEventRemarkDesc' type='text' class='form-control' placeholder='비고(용도)'/></div></td>";
		html += "<td> <input name='serviceUrlAddr' type='text' class='form-control' placeholder=''/> </td>";
		html += "</tr>"; 

		$('tbody[name=serviceTbody]').append(html); 
		$('tbody[name=serviceTbody]:last > tr:last > td:eq(0)').html(originSelectItem); 
	 
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
		var rows= $('#serviceTbl > tbody:last > tr').length;

		if(rows>1){
	   		$('#serviceTbl > tbody:last > tr:last').remove();
		}
    });
 	
});
</script>

<!-- dynamic object event binding -->
<script>

 	$(document).on("change","select[name='serviceSel']",function(){
 		var html="";
		var serviceId = this.value;
	 	var serviceSel = $(this);
	 	var systemSel = serviceSel.parent().next().children();

	 	//하위서비스 clear
	 	//systemSel.find('option').not("[value='']").remove();
	 	systemSel.find('option').remove();
	 	//하위서비스 첫행
	 	systemSel.append("<option value=''>대표서비스</option>");

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
						systemSel.append("<option value='"+data[i].cdId+"'>"+data[i].cdNm+"</option>");
					}	
				} 
			},
			error:function(){
				alert("에러");
			}
		});
	});
 	
 	
	 // 서비스별 설정 추가 버튼 클릭시
 	$(document).on("click","#addOptionTblBtn",function(){
 		//tbody 복제
 	   var originTbody = $('tbody[name=configTbody]:eq(0)').clone();
 	   $('#configTable').append(originTbody);	
 	   
 	   
 	   //colorpicker 초기화
		$('div[name=repColorCd]').each(function(){
			$(this).colorpicker({
		        color: '#AA3399',
		        format: 'hex'
			});
		});
 	});

	 // 서비스별 설정 삭제 버튼 클릭시
 	$(document).on("click","#delOptionTblBtn",function(){
 		var tbodyCount= $('#configTable > tbody').length;

		if(tbodyCount > 1){
	   		$('#configTable > tbody:last').remove();
		}
 		
 	});
	 
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
				<form class="form-horizontal" id="frm" name="frm">
				
				<div class="form-group">
				<label class="col-sm-2 form-control-label">* 대회선택</label>
				<div class="row">
					<div style="width: 60%; padding: 0.375rem 0.75rem;">
						<input type="hidden" id="tenantId" name="tenantId">
						<input type="text" class="form-control" id="cpNm" name="cpNm">
					</div>
					<div style="width: 30%; padding: 0.375rem 0.75rem;">
						<button type="button" id="searchCpBtn" class="btn btn-primary">검색</button>
					</div>
				</div>
				</div>
				<div class="line"></div>
				<div class="form-group">
					<div class="row">
						<label class="col-sm-2 form-control-label">* 서비스선택</label>
					</div>
					<div class="col-md-15">
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
	                      <tr>
	                        <td>
		                        	<select id="serviceSel" name="serviceSel" class="form select">
		                        			<option value="0">선택</option>
			                        	<c:forEach items="${serviceList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        </td>
	                        <td>
	                        	<select id="systemSel" name="systemSel" class="form select">
	                        			<option value="0">대표서비스</option>
		                        	
	                        	</select> 
	                        </td>
	                        <td> <input id="serviceStartDt" name="serviceStartDt" type="text" class="form-control" /> </td>
	                        <td> <input id="serviceEndDt" name="serviceEndDt" type="text" class="form-control" /> </td>
	                        
	                        <td>
								<div class="row">
		                          <input id="testLabUseYn" name="testLabUseYn" type="checkbox" value="Y" checked="checked" class="form-control-custom">
		                          <label for="testLabUseYn"></label>
		                          <input id="testLabRemarkDesc" name="testLabRemarkDesc" type="text" class="form-control" placeholder="비고(용도)"/>
		                        </div>
							</td>
	                        <td>
	                        <div class="row">
		                          <input id="testEventAddYn" name="testEventAddYn" type="checkbox" value="Y" checked="checked" class="form-control-custom">
		                          <label for="testEventAddYn"></label>
		                          <input id="testEventRemarkDesc" name="testEventRemarkDesc" type="text" class="form-control" placeholder="비고(용도)" />
		                     </div>
							</td>
							<td> <input id="serviceUrlAddr" name="serviceUrlAddr" type="text" class="form-control" placeholder=""/> </td>
	                      	<!-- <td> <input id="btnPopup" class="btnPopup" name="btnPopup" type="button" value="클릭"  data-toggle="modal" data-target="#serviceModal"> </td> -->
	                      </tr>
	                    </tbody>
					</table>
					
						<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-secondary"/>
	                	<input type="button" name="delRowBtn" id="delRowBtn" value="삭제" class="btn btn-secondary"/>
				  	</div>
                 </div>
                 
             <div class="line"></div>
             
              <div class="form-group">
				<div class="row">
					<label class="col-sm-2 form-control-label">서비스별 설정</label>
				</div>
                <div class="col-md-8">
					<table class="table" id="configTable">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>설정구분</th>
	                        <th>선택</th>
	                      </tr>
	                    </thead>
						<tbody name='configTbody'>
	                      <tr>
	                        <td rowspan="6">
	                        	<div class="col-sm-5 select">
		                        	<select name="serviceSel2" class="form select">
			                        	<c:forEach items="${serviceList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
	                        </td>
	                        <td>메인 컬러</td>
	                        <td>
	                        	<div id="repColorCd" name="repColorCd" class="input-group colorpicker-component">
							    <input type="text" value="#00AABB" class="form-control" />
							    <span class="input-group-addon"><i></i></span>
								</div>
							</td>
	                      </tr>
	                      
	                      <tr>
	                        <td>1차언어</td>
	                        <td>
	                        	<div class="col-sm-5 select">
		                        	<select name="selectLang1" class="form select">
		                        		<option value="0">사용안함</option>
			                        	<c:forEach items="${languageList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
							</td>
	                      </tr>
	                      
	                      <tr>
	                        <td>2차언어</td>
	                        <td>
	                        	<div class="col-sm-5 select">
		                        	<select name="selectLang2" class="form select">
		                        		<option value="0">사용안함</option>
			                        	<c:forEach items="${languageList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
							</td>
	                      </tr>
	                      
	                      <tr>
	                        <td>3차언어</td>
	                        <td>
	                        	<div class="col-sm-5 select">
		                        	<select name="selectLang3" class="form select">
		                        		<option value="0">사용안함</option>
			                        	<c:forEach items="${languageList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
							</td>
	                      </tr>
	                      
	                      <tr>
	                        <td>4차언어</td>
	                        <td>
	                        	<div class="col-sm-5 select">
		                        	<select name="selectLang4" class="form select">
		                        		<option value="0">사용안함</option>
			                        	<c:forEach items="${languageList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
							</td>
	                      </tr>
	                      
	                     <tr>
	                        <td>5차언어</td>
	                        <td>
	                        	<div class="col-sm-5 select">
		                        	<select name="selectLang5" class="form select">
		                        		<option value="0">사용안함</option>
			                        	<c:forEach items="${languageList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
							</td>
	                      </tr>
	                      
	                    </tbody>
					</table>
					<input type="button" name="addOptionTblBtn" id="addOptionTblBtn" value="추가" class="btn btn-secondary"/>
	                <input type="button" name="delOptionTblBtn" id="delOptionTblBtn" value="삭제" class="btn btn-secondary"/>
				  </div> 
				</form>
	
				</div>
			</div>
		</div>
		</div>	
	</div>
</div>
</section>