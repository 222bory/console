<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sicc.console.enums.CommonEnums" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<c:set var="useCd" value="<%=CommonEnums.USE_CD.getCode()%>"/>
<c:set var="useValue" value="<%=CommonEnums.USE_CD.getValue()%>"/>
<c:set var="NUseCd" value="<%=CommonEnums.NUSE_CD.getCode()%>"/>
<c:set var="NUseValue" value="<%=CommonEnums.NUSE_CD.getValue()%>"/>

<script type="text/javascript">

$(document).ready(function(){

	$("#btnList").on("click", function(e){
		//location.href="/selListServiceApply";
		$("#frm").attr("action", "/selListServiceApply");
		$("#frm").submit();
	});
	
	$("#btnModify").on("click", function(e){
		//location.href="/selListServiceApply";
		$("#frm").attr("action", "/upServiceApply");
		$("#frm").submit();
	});
	
	$("#btnDelete").on("click", function(e){
		var r = confirm("서비스정보를 삭제 하시겠습니까?");
		
		if (r == true) {
			$.ajax({
				type : "POST",
				url  : "/delServiceApply", 
				dataType : "json",
				data : $("#frm").serialize(),
				success : function(data, status) {
					try{
						if( data.result == '1'){
							alert("삭제 성공!");
							redirectList();
						} else {
							//alert(makeMessage(INSERT_FAIL, '<br>' + 'RETURN CODE : ' + data.result + '<br>' + 'RETURN MESSAGE : ' + data.message));
							alert("RETURN CODE : "+ data.result+' , '+"삭제 실패!");
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

	$('div[name=colorGroup]').each(function(){
		$(this).colorpicker({
	        format: 'hex'
		});
	});

});

function redirectList(){
	$("#frm").attr("action", "/selListServiceApply");
	$("input[name=page]").val("1");
	$("#frm").submit();
}
</script>


 <div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/userList">서비스관리</a></li>
			<li class="breadcrumb-item">서비스신청</li>
			<li class="breadcrumb-item active">서비스신청 상세</li>
		</ul>
	</div>
</div>

<section class="forms">
	<div class="container-fluid">
	<header>
		<h1 class="h3 display">서비스신청 상세</h1>
	</header>
	<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
			<form class="form-horizontal" id="frm" name="frm" method="POST">
				<input type="hidden" name="page" value="${serviceModel.page}" />
				<input type="hidden" id="tenantId" name="tenantId" value="${competition.tenantId}"/>
				<input type="hidden" id="cpCd" name="cpCd" value="${competition.cpCd}"/>
				
				<div class="form-group">
					<div class="row">
						<label class="col-sm-2 form-control-label">테넌트ID</label>
						<p>${competition.tenantId}</p>
					</div>
				</div>
				
				<div class="line"></div>
				
				<div class="form-group">
					<div class="row">
						<label class="col-sm-2 form-control-label">대회정보</label>
						<p>[ 대회코드 : ${competition.cpCd} ] ${competition.cpNm}</p>
					</div>
				</div>
				
				<div class="line"></div>
				
				
				<div class="form-group">
				<label class="col-sm-2 form-control-label">서비스별 설정</label>

				<table class="table" id="configTable">
					<thead>
                      <tr>
                        <th>서비스명</th>
                        <th>컬러</th>
                        <th>1차언어</th>
                        <th>2차언어</th>
                        <th>3차언어</th>
                        <th>4차언어</th>
                        <th>5차언어</th>
                      </tr>
					</thead>
					
					<tbody name='configTbody'>
						<c:forEach items="${selServiceApply}" var ="list">
							<tr>
								<td>
								<c:forEach items="${serviceList}" var="svc">
									<c:if test="${list.serviceCd == svc.cdId}">
										${svc.cdNm}
									</c:if> 
								</c:forEach>
								</td>
								<td style='width:20%'>
									<div name='colorGroup' class='input-group' >
									<input name='repColorValue' type='text' class='form-control form-control-sm' readonly='true' value="${list.repColorValue}" />
									 <span class='input-group-addon'><i></i></span> 
									</div>
								</td>
								<td>
								<c:forEach items="${languageList}" var="lang">
									<c:if test="${list.fstLangCd == lang.cdId}">
										${lang.cdNm}
									</c:if> 
								</c:forEach>
								</td>
								<td> 
								<c:forEach items="${languageList}" var="lang">
									<c:if test="${list.scndLangCd == lang.cdId}">
										${lang.cdNm}
									</c:if> 
								</c:forEach>
								</td>
								<td>
								<c:forEach items="${languageList}" var="lang">
									<c:if test="${list.thrdLangCd == lang.cdId}">
										${lang.cdNm}
									</c:if> 
								</c:forEach>
								</td>
								<td>
								<c:forEach items="${languageList}" var="lang">
									<c:if test="${list.fothLangCd == lang.cdId}">
										${lang.cdNm}
									</c:if> 
								</c:forEach>
								</td>
								<td>
								<c:forEach items="${languageList}" var="lang">
									<c:if test="${list.fithLangCd == lang.cdId}">
										${lang.cdNm}
									</c:if> 
								</c:forEach>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				
				<div class="line"></div>
				
				<div class="form-group">
					<label class="col-sm-4 form-control-label">서비스별 상세정보 </label>
					<table  class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>하위서비스</th>
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>서비스URL</th>
	                        <th>테스트랩<br>사용여부</th>
	                        <th>테스트이벤트<br>사용여부</th>
	                      </tr>
	                    </thead>
						<tbody name="serviceTbody">
							<c:forEach items="${selServiceApply}" var ="list">
								<tr>
									<td> 
									<c:forEach items="${serviceList}" var="svc">
										<c:if test="${list.serviceCd == svc.cdId}">
											${svc.cdNm}
										</c:if> 
									</c:forEach>
									</td>
									<input type="hidden" name="serviceCd" value="${list.serviceCd}"/>
									<td> 대표서비스 </td>
									<td> ${list.serviceStartDt} </td>
									<td> ${list.serviceEndDt} </td>
									<td> ${list.serviceUrlAddr} </td>
									<td>
										<c:choose>
											<c:when test="${list.testLabUseYn == useCd}">
												${useValue}
												<c:if test="${list.testLabRemarkDesc!=''}">
													/ ${list.testLabRemarkDesc}
												</c:if>
											</c:when>
											<c:otherwise>
												${NUseValue} 
											</c:otherwise>
										</c:choose>
									</td>
									<td> 
										<c:choose>
											<c:when test="${list.testEventAddYn == useCd}">
												${useValue} 
												<c:if test="${list.testEventRemarkDesc!=''}">
													/ ${list.testEventRemarkDesc} 
												</c:if>
											</c:when>
											<c:otherwise>
												${NUseValue} 
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
							<c:forEach items="${selServiceApplyDetail}" var ="list">
							<tr>
								<td> 
									<c:forEach items="${serviceList}" var="svc">
										<c:if test="${list.serviceCd == svc.cdId}">
											${svc.cdNm}
										</c:if> 
									</c:forEach>
								</td>
								<input type="hidden" name="serviceCdd" value="${list.serviceCd}"/>
								<input type="hidden" name="systemCd" value="${list.systemCd}"/>
								<td> ${list.systemNm} </td>
								<td> ${list.serviceStartDt} </td>
								<td> ${list.serviceEndDt} </td>
								<td> ${list.serviceUrlAddr} </td>
								<td> </td>
								<td> </td>
							</tr>
							</c:forEach> 
	                    </tbody>
					</table>
                 </div>

 
	  			<div class="line"></div>
				<div class="form-group">
					<div class="col-sm-4 offset-sm-2">
						<input type="button" id="btnDelete" class="btn btn-secondary" value="삭제"/>
						<input type="button" id="btnList" class="btn btn-primary" value="목록"/>
						<input type="button" id="btnModify" class="btn btn-primary" value="수정"/>

					</div>
				</div>
				</form>
	
			
			</div>
		</div>
		</div>	
	</div>
</div>
</section>