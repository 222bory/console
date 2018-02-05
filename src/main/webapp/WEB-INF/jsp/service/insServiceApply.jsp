<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">

$(document).ready(function(){
	
/*     fncRowReset = function(obj){
        $(obj).find(':input').each(function(){
              this.value = '';
              this.checked = '';
        });
  };
 */
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
 	
 	// 달력 세팅
    $('#serviceStartDt').datepicker({
		"format" :'yyyy-mm-dd',
        "autoclose": true,
        "todayHighlight":true
	});
	$("#serviceStartDt").datepicker("setDate", new Date());
 	
 	// 달력 세팅
    $('#serviceEndDt').datepicker({
		"format" :'yyyy-mm-dd',
        "autoclose": true,
        "todayHighlight":true
	});
    $("#serviceEndDt").datepicker("setDate", new Date());
    
   // 달력 세팅
    $('#serviceStartDtD').datepicker({
		"format" :'yyyy-mm-dd',
        "autoclose": true,
        "todayHighlight":true
	});
	$("#serviceStartDtD").datepicker("setDate", new Date());
	
	// 달력 세팅
    $('#serviceEndDtD').datepicker({
		"format" :'yyyy-mm-dd',
        "autoclose": true,
        "todayHighlight":true
	});
	$("#serviceEndDtD").datepicker("setDate", new Date());


	$('#repColorCd').colorpicker({
        color: '#AA3399',
        format: 'hex'
    });
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
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>테스트랩<br>사용여부</th>
	                        <th>테스트이벤트<br>사용여부</th>
	                        <th>대표URL</th>
	                      </tr>
	                    </thead>
						<tbody>
	                      <tr>
	                        <td>
	                        	<div class="col-sm-5 select">
		                        	<select name="serviceSel" class="form select">
			                        	<c:forEach items="${serviceList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
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
						<label class="col-sm-2 form-control-label">* 하위서비스 선택</label>
					</div>
					<div class="col-md-15">
					<table id="serviceDetailTbl" name="serviceDetailTbl" class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>하위서비스명</th>
	                        <th>사용여부</th>
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>하위서비스 URL</th>
	                      </tr>
	                    </thead>
						<tbody>
	                      <tr>
	                        <td>
	                        	<div class="col-sm-5 select">
		                        	<select name="serviceSelD" class="form select">
			                        	<c:forEach items="${serviceList}" var="list" varStatus="status">
			                        		<option value="${list.cdId}">${list.cdNm}</option>
			                        	</c:forEach>
		                        	</select> 
	                        	</div>
	                        </td>
	                        <td><input id="systemCd" name="systemCd" type="text" class="form-control-sm" readOnly=true/></td>
	                        <td>
	                        	 <div class="row">
		                          <input id="useYN" name="useYN" type="checkbox" value="Y" class="form-control-custom">
		                          <label for="useYN"></label>
		                    	 </div>
		                     </td>
	                        <td> <input id="serviceStartDtD" name="serviceStartDtD" type="text" class="form-control-sm" /> </td>
	                        <td> <input id="serviceEndDtD" name="serviceEndDtD" type="text" class="form-control-sm" /> </td>
	                        <td> <input id="serviceUrlAddrD" name="serviceUrlAddrD" type="text" class="form-control-sm" placeholder=""/> </td>
	                      </tr>
	                    </tbody>
					</table>
				  	</div>
                 </div>
              
              <div class="line"></div>   
              
              <div class="form-group">
				<div class="row">
					<label class="col-sm-2 form-control-label">서비스별 설정</label>
				</div>
                <div class="col-md-8">
					<table id="serviceDetailTbl" name="serviceDetailTbl" class="table">
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
		                        	<select name="serviceSel" class="form select">
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
					<input type="button" name="addTblBtn" id="addTblBtn" value="추가" class="btn btn-secondary"/>
	                	<input type="button" name="addTblBtn" id="addTblBtn" value="삭제" class="btn btn-secondary"/>
				  </div> 
                 
                 
				</form>
				</div>
			</div>
		</div>
	</div>	
	</div>
</section>