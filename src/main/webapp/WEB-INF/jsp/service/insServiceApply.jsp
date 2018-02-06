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
 	
	$('#repColorCd').colorpicker({
        color: '#AA3399',
        format: 'hex'
    });
	
    // 추가 버튼 클릭시
    $("#addRowBtn").click(function(){
	 var serviceTbl = $("#serviceTbl tr:eq(1)").clone(); //1행 복사
	 var serviceDetailTbl = $("#serviceDetailTbl tr:eq(1)").clone();
	
	
     $("#serviceTbl").append(serviceTbl);
     $("#serviceDetailTbl").append(serviceDetailTbl);
    });
    
 	// 삭제버튼 클릭시
    $("#delRowBtn").click(function(){  
		var rows= $('#serviceTbl > tbody:last > tr').length;

		if(rows>1){
	   		$('#serviceTbl > tbody:last > tr:last').remove();
	   	    $('#serviceDetailTbl > tbody:last > tr:last').remove();
		}
    
    });
 	
 	//서비스 선택
 	//$('select[name=serviceSel]').each(function(index){
 		
 		$('select[name=serviceSel]').change(function(){
 			var html="";
 			var serviceId = this.value;

 			$.ajax({
	 			type : 'POST',
	 			url : '/selServicebySytem',
	 			//파리미터 변수 이름 : 값
	 			data : {
	 				serviceId : serviceId
	 			},
	 			success : function(data){
	 				if(data.length>0){
	 					for(var i=0; i <data.length; i++){
	 						html += "<input type='checkbox' id='systemChkBox"+i+"' name='systemChkBox' value='"+data[i].cdId
	 						+"'/> <label for='systemChkBox"+i+"'>"+data[i].cdNm+"</label>";
	 					}	
						$('div[name=checkBoxArea]').append(html);
	 				}
	 			},
	 			error:function(){
	 				alert("에러");
	 			}
	 	});
 		});
 	//});
 	
 	$('#btnModal').click(function(){
 		var modalTbl = $('#serviceDetailTbl').clone();
 		
 		console.log(modalTbl);
 		
 		$("#hiddenTbl").append(modalTbl);
 	});

});
</script>

<script>

$(document).ready(function(){
	
	$('#btnPopup').click(function(event){
		var serviceId = $(this).parent().parent().children().eq(0).children().eq(0).val();
		var startDt = $(this).parent().parent().children().eq(1).children().eq(0).val();
		var endDt = $(this).parent().parent().children().eq(2).children().eq(0).val();
		
		
		$('#serviceNmHidden').val(serviceId);
		$('#startDtHidden').val(startDt);
		$('#endDtHidden').val(endDt);
			
		 $('input[name=serviceStartDtD]').datepicker("setDate",$('#startDtHidden').val());
		 $('input[name=serviceEndDtD]').datepicker("setDate",$('#endDtHidden').val());
	});
	
});


//로드되지 않은 태그에 대해서 change 이벤트 
$(document).on("change","input[name=systemChkBox]", function(e){
	var html="";
	var chkId = $(this).val();
	var chkNm = $(this).next().text();
	var serviceId = $('#serviceNmHidden').val();
	var id = $(this).attr('id');
	var name = $(this).attr('name');
	

	if($(this).is(':checked')){
		html += "<tr id='checkTr"+id+"'>";
		html += "<td id='dtlServiceId' style='display:none;'>" + serviceId +"</td>";
		html += "<td id='dtlSystemId' style='display:none;'>" + chkId +"</td>";
		html += "<td id='dtlServiceNm'>" + serviceId + "</td>";
		html += "<td id='dtlSystemNm'>" + chkNm + "</td>";
		html += "<td> <input name='serviceStartDtD' type='text' class='form-control-sm'/> </td>";
		html += "<td> <input name='serviceEndDtD' type='text' class='form-control-sm'/> </td>";
		html += "<td> <input name='serviceUrlAddrD' type='text' class='form-control-sm'/> </td>";
		html += "</tr>"; 

		$('tbody[name=tbodySystemList]').append(html); 
	}
	else{
	 	$('#checkTr'+id).remove();
	}
	
	
	 //하위서비스 달력 세팅
    $('input[name=serviceStartDtD]').each(function(){
    	$(this).datepicker({
			"format" :'yyyy-mm-dd',
	        "autoclose": true,
	        "todayHighlight":true
		});
    	$(this).datepicker("setDate",$('#startDtHidden').val());
    });
	 
	//하위서비스 달력 세팅
    $('input[name=serviceEndDtD]').each(function(){
    	$(this).datepicker({
    		"format" :'yyyy-mm-dd',
	        "autoclose": true,
	        "todayHighlight":true
		});
    	$(this).datepicker("setDate",$('#endDtHidden').val());
    });
});

	
	function fnGoPopup(){
/* 		$('input[name=systemChkBox]:checked').each(function(index){
			chkIdList += $(this).val() + ',';
			chkNmList += $(this).text() + ',';
		});
		
		slitData = chkIdList.split(",");*/
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
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>테스트랩<br>사용여부</th>
	                        <th>테스트이벤트<br>사용여부</th>
	                        <th>대표URL</th>
	                        <th>하위서비스 선택</th>
	                      </tr>
	                    </thead>
						<tbody>
	                      <tr>
	                        <td>
	                        	<!-- <div class="col-sm-5 select"> -->
		                        	<select id="serviceSel" name="serviceSel" class="form select">
		                        			<option value="0">선택</option>
			                        	<c:forEach items="${serviceList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	<!-- </div> -->
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
	                      	<td> <input id="btnPopup" class="btnPopup" name="btnPopup" type="button" value="클릭"  data-toggle="modal" data-target="#serviceModal"> </td>
	                      </tr>
	                    </tbody>
					</table>
					
						<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-secondary"/>
	                	<input type="button" name="delRowBtn" id="delRowBtn" value="삭제" class="btn btn-secondary"/>
				  	</div>
                 </div>
                 
             <div class="line"></div>
             
             

    	<div class="col-md-15" id="hiddenTbl">
				<!-- 	<table id="serviceDetailTbl" name="serviceDetailTbl" class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>하위서비스명</th>
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>하위서비스 URL</th>
	                      </tr>
	                    </thead>
						<tbody>
						<tr>
						<td id='dtlServiceId' style='display:none;'></td>
						<td id='dtlSystemId' style='display:none;'></td>
						<td id='dtlServiceNm'></td>
						<td id='dtlSystemNm'></td>
						<td> <input name='serviceStartDtD2' type='text' class='form-control-sm'/> </td>
						<td> <input name='serviceEndDtD2' type='text' class='form-control-sm'/> </td>
						<td> <input name='serviceUrlAddrD2' type='text' class='form-control-sm'/> </td>
						</tr>
							
	                    </tbody>
					</table> -->
		</div>
         
               <div class="line"></div>   
              
              <div class="form-group">
				<div class="row">
					<label class="col-sm-2 form-control-label">서비스별 설정</label>
				</div>
                <div class="col-md-8">
					<table id="serviceOptionTbl" name="serviceOptionTbl" class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>설정구분</th>
	                        <th>선택</th>
	                      </tr>
	                    </thead>
						<tbody>
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
				
				
				
				<!-- Modal Start -->
				<div id="serviceModal" name="serviceModal" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
				<div role="document" class="modal-dialog modal-lg">
					
					<div class="modal-content">
					<div class="modal-header">
						<h5 id="exampleModalLabel" class="modal-title">하위서비스 선택</h5>
						<button type="button" data-dismiss="modal" aria-label="Close" class="close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
						<div class="modal-body">
						<p type="hidden" id="serviceNmHidden" name="serviceNmHidden" value=""></p>
					  	<p type="hidden" id="startDtHidden" name="startDtHidden" value=""></p>
					  	<p type="hidden" id="endDtHidden" name="endDtHidden" value=""></p>
					  	
						<div name="checkBoxArea"></div>
						<div class="line"></div>
						<div class="col-md-15">
						<table id="serviceDetailTbl" name="serviceDetailTbl" class="table">
							<thead>
			                     <tr>
			                       <th>서비스명</th>
			                       <th>하위서비스명</th>
			                       <th>시작일자</th>
			                       <th>종료일자</th>
			                       <th>하위서비스 URL</th>
			                     </tr>
			                   </thead>
							<tbody name="tbodySystemList"></tbody>
						</table>
					  	</div>
					  	</div>
					<div class="modal-footer">
					 <input type="button" data-dismiss="modal" class="btn btn-secondary" value="닫기" />
					 <input type="button" data-dismiss="modal" id="btnModal" class="btn btn-primary" value="선택" />
					</div>
		           </div>
		           </div>
		         </div>
		        <!-- Modal End -->  
				
				
				</div>
			</div>
		</div>
		</div>	
	</div>
		

	</div>
</section>