<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>

<script type="text/javascript">
$(function () {
	
	if("${modalFlag}"=="popshow"){
		$("#myModal").modal('show');
	}
	
	$("table tr").click(function(){
        tr = $(this);
        var td = tr.children();
		var custId = td.eq(1).text();
        var custNm = td.eq(2).text();
        var repFaxNo = td.eq(3).text();
        var repTelNo = td.eq(4).text();
        var corpAdNo = td.eq(5).text();
        
        
        $("input[name=custId]").val(custId);
	 	$("input[name=custNm]").val(custNm);
	 	$("input[name=repFaxNo]").val(repFaxNo);
	 	$("input[name=repTelNo]").val(repTelNo);
	 	$("input[name=corpAdNo]").val(corpAdNo);
	 	
		$("#myModal").modal('hide');
    });
	
	$("#btnCancel").on("click", function(e){
		$("#frm").attr("action", "/selListContract");
		$("#frm").submit();
	});


	$("#btnUpdate").on("click", function(e){
		
		var r = confirm("정말 수정 하시겠습니까?");
		
		if (r == true) {
			$("input[name=custId]").attr('disabled', false);
			$("input[name=tenantId]").attr('disabled', false);
			
			$.ajax({
				type : "POST",
				url  : "/upContract", 
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
	
	$('#cp3').colorpicker({
        color: '#AA3399',
        format: 'hex'
    });
	
	
		$('#validStartDt').datepicker({
				"format" :'yyyy-mm-dd',
				"setDate": new Date(),
		        "autoclose": true,
		        "todayHighlight":true
			});
		$('#validEndDt').datepicker({
			"format" :'yyyy-mm-dd',
			"setDate": new Date(),
	        "autoclose": true,
	        "todayHighlight":true
		});
			
			$("#validStartDt").datepicker("validStartDt", new Date());
			$("#validEndDt").datepicker("validEndDt", new Date());
});
	
function redirectList(){
	$("#frm").attr("action", "/selListContract");
	$("input[name=page]").val("1");
	$("#frm").submit();
}

function goPage(page) {
	$("input[name=page]").val(page);
	submit();
}

function submit(){
	$("#frm1").submit();
	
	
}
</script>


<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">서비스관리</a></li>
			<li class="breadcrumb-item active">계약 수정</li>
		</ul>
	</div>
</div>
<section class="forms">
	<form class="form-horizontal" id="frm" name="frm" method="POST" action="">
	<div class="container-fluid">
		<header>
			<h1 class="h3 display">계약 수정</h1>
		</header>
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-header d-flex align-items-center">
						<h2 class="h5 display">고객 정보 수정</h2>
					</div>
					<div class="card-body">
						
							<div class="form-group row has-success">
		                      <label class="col-sm-2 form-control-label">* 고객ID</label>
		                      <div class="col-md-3">
		                        <input type="text" class="form-control" id="custId" name="custId" value="${cem.custId}" disabled>
		                      </div>
		                      
		                      <div class="form-group">
		                      	<button type="button" data-toggle="modal" data-target="#myModal" class="btn btn-primary">검색</button>
			                      <!-- <input type="button" value="검색" class="mx-sm-3 btn btn-primary"> -->
			                    </div>
			                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                  <label class="col-sm-2 form-control-label">* 고객명</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="custNm" name="custNm" value="${cem.custNm}">
		                      </div>  
		                    </div>
							

								<!-- Modal -->
								<!-- <div id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
									<div role="document" class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 id="exampleModalLabel" class="modal-title">중복확인</h5>
												<button type="button" data-dismiss="modal" aria-label="Close" class="close">
													<span aria-hidden="true">×</span>
												</button>
											</div>
											<div class="modal-body">
												<h2>아이디 중복확인 결과</h2>
												<p id="duplResult"></p>
											</div>
											<div class="modal-footer">
												<input type="button" data-dismiss="modal" class="btn btn-secondary" value="닫기" /> 
												<input type="button" data-dismiss="modal" class="btn btn-primary" value="확인" />
											</div>
										</div>
									</div>
								</div> -->
								<!-- Modal End-->

							
		                    <div class="line"></div>
		                    <div class="form-group row has-success">
		                      <label class="col-sm-2 form-control-label">* 대표팩스번호</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="repFaxNo" name="repFaxNo" value="${cem.repFaxNo}">
		                      </div>
		                      <label class="col-sm-2 form-control-label">* 대표전화번호</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="repTelNo" name="repTelNo" value="${cem.repTelNo}">
		                      </div>
		                    </div>
		                   
		            		<div class="line"></div>
							<div class="form-group row has-success">
		                      <label class="col-sm-2 form-control-label">* 법인등록번호</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="corpAdNo" name="corpAdNo" value="${cem.corpAdNo}">
		                      </div>
		                      <label class="col-sm-2 form-control-label">* 담당자명</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="mgrNm" name="mgrNm" value="${cem.mgrNm}">
		                      </div>
		                    </div>
		                    
							<div class="line"></div>
							<div class="form-group row has-success">
		                      <label class="col-sm-2 form-control-label">* 담당자이메일주소</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="mgrEmailAddr" name="mgrEmailAddr" value="${cem.mgrEmailAddr}">
		                      </div>
		                        <label class="col-sm-2 form-control-label">* 담당자전화번호</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="mgrTelNo" name="mgrTelNo" value="${cem.mgrTelNo}">
		                      </div>
		                    </div>
		                    
							
							
		         	</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-header d-flex align-items-center">
						<h2 class="h5 display">계약 정보 수정</h2>
					</div>
					<div class="card-body">
							<div class="form-group row has-success">
		                      <label class="col-sm-2 form-control-label">테넌트ID</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="tenantId" name="tenantId" value="${cem.tenantId}" disabled>
		                      </div>
		                      <label class="col-sm-2 form-control-label">* 계약명</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="contNm" name="contNm" value="${cem.contNm}">
		                      </div>
		                    </div>
		                  
		                    <div class="line"></div>
							<div class="form-group row has-success">
		                      <label class="col-sm-2 form-control-label">* 유효시작일자</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="validStartDt" name="validStartDt" value="${cem.validStartDt}">
		                      </div>
		                      <label class="col-sm-2 form-control-label">* 유효종료일자</label>
		                      <div class="col-md-4">
		                        <input type="text" class="form-control" id="validEndDt" name="validEndDt" value="${cem.validEndDt}">
		                      </div>
		                    </div>
		                   
							<div class="line"></div>
		                    <div class="form-group row has-success">
								<label class="col-sm-2 form-control-label">* 계약상태</label>
		                        <div class="col-sm-4 select">
		                          <select id="contStatCd" name="contStatCd" class="form-control">
		                          <c:forEach items="${contStatCdList}" var="list" varStatus="parent">
		                            <option value="${list.cdId}" ${list.cdNm == cem.contStatCd ? 'selected="selected"' : '' }>${list.cdNm}</option>
		                            
		                          </c:forEach> 
		                          </select>
		                        </div>
		                        <label class="col-sm-2 form-control-label">* 네트워크구분</label>
		                        <div class="col-sm-4 select">
		                          <select id="networkFgCd" name="networkFgCd" class="form-control">
		                          <c:forEach items="${networkFgCdList}" var="list" varStatus="parent">
		                            <option value="${list.cdId}" ${list.cdNm == cem.networkFgCd ? 'selected="selected"' : '' }>${list.cdNm}</option>
		                          </c:forEach> 
		                          </select>
		                        </div>
							</div>
		                    
							<div class="line"></div>
							<div class="form-group row has-success">
								<label class="col-sm-2 form-control-label">* 비밀번호난이도</label>
		                        <div class="col-sm-4 select">
		                          <select id="passwordLodCd" name="passwordLodCd" class="form-control">
		                          <c:forEach items="${passwordLodCdList}" var="list" varStatus="parent">
		                            <option value="${list.cdId}" ${list.cdNm == cem.passwordLodCd ? 'selected="selected"' : '' }>${list.cdNm}</option>
		                          </c:forEach> 
		                          </select>
		                        </div>
		                        <label class="col-sm-2 form-control-label">* 비밀번호갱신주기</label>
		                        <div class="col-sm-4 select">
		                          <select id="passwordRnwlCyclCd" name="passwordRnwlCyclCd" class="form-control">
		                          <c:forEach items="${rnwlCyclCd}" var="list" varStatus="parent">
		                            <option value="${list.cdId}" ${list.cdNm == cem.passwordRnwlCyclCd ? 'selected="selected"' : '' }>${list.cdNm}</option>
		                          </c:forEach> 
		                          </select>
		                        </div>
							</div>
							<div class="line"></div>
							<div class="form-group row has-success">
		                      <label class="col-sm-2 form-control-label">* 비밀번호최소길이</label>
		                      <div class="col-sm-10">
		                        <div>
		                          <input id="passwordMinLen1" type="radio" ${8 == cem.passwordMinLen ? 'checked="checked"' : '' } value="8" name="passwordMinLen">
		                          <label for="passwordMinLen1">8자리</label>
		                          <input id="passwordMinLen2" type="radio" ${10 == cem.passwordMinLen ? 'checked="checked"' : '' } value="10" name="passwordMinLen">
		                          <label for="passwordMinLen2">10자리</label>
		                          <input id="passwordMinLen2" type="radio" ${12 == cem.passwordMinLen ? 'checked="checked"' : '' } value="12" name="passwordMinLen">
		                          <label for="passwordMinLen2">12자리</label>
		                          <input id="passwordMinLen2" type="radio" ${16 == cem.passwordMinLen ? 'checked="checked"' : '' }value="16" name="passwordMinLen">
		                          <label for="passwordMinLen2">16자리</label>
		                        </div>
		                       
		                      </div>
		                    </div>
		                   
		                   <div class="line"></div>
							
						   <div class="form-group row">
		                      <label class="col-sm-2 form-control-label">* 비밀번호사용제한여부</label>
		                      <div class="col-sm-10">
		                        <div>
		                          <input id="passwordUseLmtYn1" type="radio" ${'Y' == cem.passwordUseLmtYn ? 'checked="checked"' : '' } value="Y" name="passwordUseLmtYn">
		                          <label for="optionsRadios1">사용</label>
		                          <input id="passwordUseLmtYn2" type="radio" ${'N' == cem.passwordUseLmtYn ? 'checked="checked"' : '' } value="N" name="passwordUseLmtYn">
		                          <label for="optionsRadios2">미사용</label>
		                        </div>
		                       
		                      </div>
		                    </div>	
							
							<div class="line"></div>
							
							<div class="form-group row">
		                      <label class="col-sm-2 form-control-label">* 비밀번호일시정지여부</label>
		                      <div class="col-sm-10">
		                        <div>
		                          <input id="passwordPoseYn1" type="radio" ${'Y' == cem.passwordPoseYn ? 'checked="checked"' : '' } value="Y" name="passwordPoseYn">
		                          <label for="optionsRadios1">사용</label>
		                          <input id="passwordPoseYn2" type="radio" ${'N' == cem.passwordPoseYn ? 'checked="checked"' : '' }value="N" name="passwordPoseYn">
		                          <label for="optionsRadios2">미사용</label>
		                        </div>
		                     
		                      </div>
		                    </div>
		                    
							<div class="line"></div> 
							<div class="form-group">
								<div class="col-sm-4 offset-sm-2">
									<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
									<button type="button" id="btnUpdate" class="btn btn-primary" >수정</button>
								</div>
							</div>
							
						
					</div>
				</div>
			</div>
		</div>
	</div>
	</form>
	
	<!-- Modal-->
    <div id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
      <div role="document" class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 id="exampleModalLabel" class="modal-title">고객ID 조회</h5>
            <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
          </div>
          <div class="modal-body">
               <form action="" method="post" id="frm1">
                <input type="hidden" name="page" value="${ContractExtModel.page}" />
                <input type="hidden" name="modalFlag" value="Y" />
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>고객ID</th>
                        <th>고객명</th>
                        <th>팩스번호</th>
                        <th>전화번호</th>
                        <th>법인번호</th>
                     <!--    <th>담당자명</th>
                        <th>담당자이메일</th>
                        <th>담당자전화번호</th> -->
                      </tr>
                    </thead>
                    <tbody>
                    <c:set var="no" value="${pagination.totalRow - (pagination.currentPage - 1) * pagination.rowPerPage }"/>
					<c:set var="countNo" value="0"/>
                    <c:forEach items="${list}" var="list" varStatus="parent">
                      <tr id="javaScript:dataSet">
                        <th scope="row">${no - countNo}</th>
                        <td>${list.custId}</td>
                        <td>${list.custNm}</td>
                        <td>${list.repFaxNo}</td>
                        <td>${list.repTelNo}</td>
                        <td>${list.corpAdNo}</td>
                       <%--  <td>${list.mgrNm}</td>
                        <td>${list.mgrEmailAddr}</td>
                        <td>${list.mgrTelNo}</td> --%>
                        
                      </tr>
                    <c:set var="countNo" value="${countNo+1 }" />
                    </c:forEach>  
                    </tbody>
                  </table>
              	  </form>
                  <!-- //Pagenate -->
				 	<div class="pagination">
					  <ul>
					  	<c:import url="/WEB-INF/jsp/paging/paging.jsp"></c:import>
					  </ul>
					</div>
            
            
          </div>
          <!-- <div class="modal-footer">
            <button type="button" data-dismiss="modal" class="btn btn-secondary">Close</button>
            <button type="button" id="regTest" class="btn btn-primary">Save changes</button>
          </div> -->
        </div>
      </div>
    </div>
    
</section>
