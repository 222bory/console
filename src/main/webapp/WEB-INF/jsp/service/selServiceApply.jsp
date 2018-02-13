<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">

$(document).ready(function(){

	$("#btnCancel").click(function(){
		location.href="/selListServiceApply";
	});
	


});
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
		<h1 class="h3 display">서비스신청</h1>
	</header>
	<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
			<form class="form-horizontal" id="frm" name="frm" method="POST">
				
				<div class="form-group">
					<div class="row">
						<label class="col-sm-2 form-control-label">테넌트ID</label>
						<p id="tenantId">${competition.tenantId}</p>
					</div>
				</div>
				
				<div class="line"></div>
				
				<div class="form-group">
					<div class="row">
						<label class="col-sm-2 form-control-label">대회정보</label>
						<p id="cpCd">[ 대회코드 : ${competition.cpCd} ] ${competition.cpNm}</p>
					</div>
				</div>
				
				<div class="line"></div>
				
				<div class="form-group">
					<div class="col-md-15">
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
									<td> ${list.serviceNm} </td>
									<td> 대표서비스 </td>
									<td> ${list.serviceStartDt} </td>
									<td> ${list.serviceEndDt} </td>
									<td> ${list.serviceUrlAddr} </td>
									<td> ${list.testLabUseYn} / ${list.testLabRemarkDesc}</td>
									<td> ${list.testEventAddYn} / ${list.testEventRemarkDesc}</td>
								</tr>
							</c:forEach>
							<c:forEach items="${selServiceApplyDetail}" var ="list">
							<tr>
								<td> ${list.serviceNm} </td>
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
									<td> ${list.serviceNm} </td>
									<td> ${list.repColorValue} </td>
									<td> ${list.fstLangNm} </td>
									<td> ${list.scndLangNm} </td>
									<td> ${list.thrdLangNm} </td>
									<td> ${list.fothLangNm} </td>
									<td> ${list.fithLangNm}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				  </div> 
				  
	  			<div class="line"></div>
				<div class="form-group">
					<div class="col-sm-4 offset-sm-2">
						<input type="button" id="btnCancel" class="btn btn-secondary" value="취소"/>
						<input type="button" id="btnRegister" class="btn btn-primary" value="등록"/>
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