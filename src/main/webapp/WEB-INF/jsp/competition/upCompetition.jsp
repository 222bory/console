<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	

<script type="text/javascript">
	/* var flag = false; */
	
	$(document).ready(function(){
		$("#btnCancel").click(function(){
			location.href="/selListCompetition";
		});
		
		$('#btnUpdate').click(function(event){
			var result = confirm('대회정보를 수정 하시겠습니까?'); 
			
			if(result) { 
				alert("수정");
			}else{
				return;
			}

			//location.href = "/delCompetition?tenantId="+tenantId+"&cpCd="+cpCd;
		});
	});
 
	$(function () {
		$('#cp3').colorpicker({
	        color: '#AA3399',
	        format: 'hex'
	    });
		
		
			$('#cpStartDt').datepicker({
					"format" :'yyyy-mm-dd',
					"setDate": new Date(),
			        "autoclose": true,
			        "todayHighlight":true
				});
			$('#cpEndDt').datepicker({
				"format" :'yyyy-mm-dd',
				"setDate": new Date(),
		        "autoclose": true,
		        "todayHighlight":true
			});
				
				$("#cpStartDt").datepicker("setDate", new Date());
				$("#cpEndDt").datepicker("setDate", new Date());
	});
	

</script>

<div class="breadcrumb-holder"> 
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">계정관리</a></li>
			<li class="breadcrumb-item active">대회 정보 수정</li>
		</ul>
	</div>
</div>
<section class="forms">
	<div class="container-fluid">
		<header>
			<h1 class="h3 display">대회 정보 수정</h1>
		</header>
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-header d-flex align-items-center">
						<h2 class="h5 display">사용자 정보 수정</h2>
					</div>
					<div class="card-body">
						<form class="form-horizontal" id="frm" name="frm" method="POST" action="/upCompetition">
							<div class="form-group">
								<!-- <div class="card-header d-flex align-items-center">
				                    <div class="form-group">
				                        <select id="searchType" name="searchType" class="form-control">
				                          <option value="C">계약명</option>
				                          <option value="T">테넌트아이디</option>
				                        </select>
				                    </div>
				                    <div class="form-group">
				                      <input id="searchValue" type="text" placeholder="유형 선택 후 검색어 입력 -> 아래 고객계약 선택에서 확인" class="mx-sm-2 form-control form-control">
				                    </div>
				                </div> -->
								<label class="col-sm-2 form-control-label">* 고객 계약</label>
								<div class="form-group">
			                        <div class="col-sm-5 select">
			                          <select id="tenantId" name="tenantId" class="form-control" readonly="readonly">
			                            <option value="${competition.tenantId}">${competition.cpNm} [ tenant id : ${competition.tenantId} ]</option>
			                          </select>
			                        </div>
								</div>
								<div class="help-block with-errors"></div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 코드</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpCd" name="cpCd" value="${competition.cpCd}" readonly="readonly">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회명</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpNm" name="cpNm" value="${competition.cpNm}">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 기간</label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="cpStartDt" name="cpStartDt" value="${competition.cpStartDt}"> ~
								</div>
								<div class="col-md-2">
									<input type="text" class="form-control" id="cpEndDt" name="cpEndDt" value="${competition.cpEndDt}">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 장소</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpPlaceNm" name="cpPlaceNm" value="${competition.cpPlaceNm}">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 규모</label>
		                        <div class="col-sm-5 select">
		                          <select id="cpScaleCd" name="cpScaleCd" class="form-control">
		                          <c:forEach items="${cpScaleCdList}" var="list" varStatus="parent">
		                            <option value="${list.cdId}">${list.cdNm}</option>
		                          </c:forEach>
		                          </select>
		                        </div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 유형</label>
								<div class="col-sm-5 select">
		                          <select id="cpTypeCd" name="cpTypeCd" class="form-control">
		                          <c:forEach items="${cpTypeCdList}" var="list" varStatus="parent">
		                            <option value="${list.cdId}">${list.cdNm}</option>
		                          </c:forEach>  
		                          </select>
		                        </div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 예상 이용자수</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="expectUserNum" name="expectUserNum" value="${competition.expectUserNum}">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<div class="col-sm-4 offset-sm-2">
									<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
									<button type="submit" id="btnUpdate" class="btn btn-primary" >수정</button>
								</div>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
