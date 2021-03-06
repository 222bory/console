<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	

<script type="text/javascript">

	var maxMSImgSeq;
	var maxEMImgSeq;
	var maxFAImgSeq;
	
	<c:forEach items="${competitionImageMaxSeqList}" var="list" varStatus="parent">
		<c:if test="${list.imgfgcd == 'MS'}">  
			maxMSImgSeq = ${list.imgseq}; 	
			<c:set value="${list.imgseq}" var = "maxMSImgSeq"/>
	    </c:if>
	    <c:if test="${list.imgfgcd == 'EM'}">     
	    	maxEMImgSeq = ${list.imgseq};	
	    	<c:set value="${list.imgseq}" var = "maxEMImgSeq"/>
	    </c:if>
	    <c:if test="${list.imgfgcd == 'FA'}">     
    		maxFAImgSeq = ${list.imgseq};	
    	<c:set value="${list.imgseq}" var = "maxFAImgSeq"/>
    </c:if>
	</c:forEach>

	$(document).ready(function(){
		
		$('input[name=cancelDelImgBtn]').hide();
		
		$("#btnCancel").click(function(){
			location.href="/selListCompetition";
		});
		
		$("#addRowBtn").click(function(){
			var html ='<tr>'
						+	'<td>'
						+		'<div class="col-sm-5 select">'
					    +          '<select name="imgFgCd" class="form-control form-control-sm">'
					    +          '<c:forEach items="${imgFgCdList}" var="list" varStatus="parent">'
					    +            '<option value="${list.cdId}">${list.cdNm}</option>'
					    +          '</c:forEach>'
					    +          '</select>'
					    +		   '<input type="hidden" name="imgSeq" class="form-control form-control-sm"/>'	
					    +          '<input type="file" name="file" class="form-control form-control-sm"/>'
					    +        '</div>'
						+	'</td>'
						+'</tr>';
			$('tbody[name=serviceTbody]').append(html); 
	    });
		
		$('input[name=delImgBtn]').click(function(){
			var index = $('input[name=delImgBtn]').index(this);
			var obj = $('#imgTbody > tr:eq('+index+') > td:eq(0) > input:eq(0)');
			obj.val('Y');
			
			$('input[name=delImgBtn]:eq('+index+')').hide();
			$('input[name=cancelDelImgBtn]:eq('+index+')').show();
	    });
		
		$('input[name=cancelDelImgBtn]').click(function(){
			var index = $('input[name=cancelDelImgBtn]').index(this);
			var obj = $('#imgTbody > tr:eq('+index+') > td:eq(0) > input:eq(0)');
			obj.val('N');
			
			$('input[name=cancelDelImgBtn]:eq('+index+')').hide();
			$('input[name=delImgBtn]:eq('+index+')').show();
	    });
		
		$("#delRowBtn").click(function(){
			var rowNum = $('tbody[name=serviceTbody] tr').length;
			var removeRow ="";
			
			for( i=rowNum-1; i>=0; i--){
				removeRow = removeRow = $('tbody[name=serviceTbody] > tr:eq('+i+')');
				if(removeRow.find('td:eq(1) select').val() != 'default'){ 
						removeRow.remove();
						return;
				}
			}
	    });
		
		$("#btnUpdate").click(function(){
			var result = confirm('대회정보를 수정 하시겠습니까?'); 
			
			var selectTag = $('select[name=imgFgCd]');
			var hiddenTag = $('input[name=imgSeq]');
			
			var len = selectTag.length;
			
			if(maxMSImgSeq==null){
				maxMSImgSeq = 0;
			}
			if(maxEMImgSeq==null){
				maxEMImgSeq = 0;
			}
			if(maxFAImgSeq==null){
				maxFAImgSeq = 0;
			}
			
			var msSeq = maxMSImgSeq ;
			var emSeq = maxEMImgSeq ;
			var faSeq = maxFAImgSeq ;
			
			for(i = 0 ; i < len ; i ++){
				if(selectTag[i].value == 'MS'){
					$('input[name=imgSeq]:eq('+i+')').val(msSeq);
					msSeq += 1;
				}
				if(selectTag[i].value == 'EM'){
					$('input[name=imgSeq]:eq('+i+')').val(emSeq);
					emSeq += 1;
				}
				if(selectTag[i].value == 'FA'){
					$('input[name=imgSeq]:eq('+i+')').val(faSeq);
					faSeq += 1;
				}
			}
			
			if(result){
				if(validationCheck() == 1) { 
					alert("수정 되었습니다.");
					$('#frm').submit();
				}else{
					return;
				}
			}
			
	    });
		
		
	});
	
	$(function () {
		var cpStartDt = $('#cpStartDt').val().substring(0,4)+"-"+$('#cpStartDt').val().substring(4,6)+"-"+$('#cpStartDt').val().substring(6,8);
		var cpEndDt = $('#cpEndDt').val().substring(0,4)+"-"+$('#cpEndDt').val().substring(4,6)+"-"+$('#cpEndDt').val().substring(6,8);
		
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
			
		$("#cpStartDt").datepicker("setDate", cpStartDt);
		$("#cpEndDt").datepicker("setDate", cpEndDt);
	});
	
	function validationCheck(){
		
		var cpCdTag = $('input[name=cpCd]');
		var cpNmTag = $('input[name=cpNm]');
		var cpPlaceNmTag = $('input[name=cpPlaceNm]');
		var imgTag = $('input[name=file]');
		
		if(cpCdTag.val() ==''|| cpCdTag.val() == null){
			alert("대회코드를 입력 하십시오.");
			return;
		}
		
		if(cpNmTag.val() ==''|| cpNmTag.val() == null){
			alert("대회명을 입력 하십시오.");
			return;
		}
		
		if(cpPlaceNmTag.val() ==''|| cpPlaceNmTag.val() == null){
			alert("대회장소를 입력 하십시오.");
			return;
		}
		
		for(var i = 0 ; i < imgTag.length ; i ++){
			
			if(imgTag[i].value == '' || imgTag[i] == null){
				alert("file을 선택 하십시오.");
				return;
			}
		}
		
		return 1;
	}
	
</script>

<div class="breadcrumb-holder"> 
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item">서비스관리</li>
			<li class="breadcrumb-item active"><a href="selListCompetition">대회관리</a></li>
			<li class="breadcrumb-item active">대회수정</li>
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
						<h2 class="h5 display">대회 정보 수정</h2>
					</div>
					<div class="card-body">
						<form class="form-horizontal" id="frm" name="frm" method="POST" action="/upCompetition" enctype="multipart/form-data">
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 고객 계약</label>
								<div class="form-group">
			                        <div class="col-sm-5 select">
			                          <select id="tenantId" name="tenantId" class="form-control form-control-sm" readonly="readonly">
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
									<input type="text" class="form-control form-control-sm" id="cpCd" name="cpCd" value="${competition.cpCd}" readonly="readonly">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회명</label>
								<div class="col-md-5">
									<input type="text" class="form-control form-control-sm" id="cpNm" name="cpNm" value="${competition.cpNm}">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 기간</label>
								<div class="card-header d-flex align-items-center">
								<div class="form-group">
									<input type="text" class="form-control form-control-sm" id="cpStartDt" name="cpStartDt" value="${competition.cpStartDt}">
								</div>
								<div class="form-group">
								&nbsp;~&nbsp;
								</div>
								<div class="form-group">
									<input type="text" class="form-control form-control-sm" id="cpEndDt" name="cpEndDt" value="${competition.cpEndDt}">
								</div>
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 장소</label>
								<div class="col-md-5">
									<input type="text" class="form-control form-control-sm" id="cpPlaceNm" name="cpPlaceNm" value="${competition.cpPlaceNm}">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 규모</label>
		                        <div class="col-sm-5 select">
		                          <select id="cpScaleCd" name="cpScaleCd" class="form-control form-control-sm">
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
		                          <select id="cpTypeCd" name="cpTypeCd" class="form-control form-control-sm">
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
									<input type="text" class="form-control form-control-sm" id="expectUserNum" name="expectUserNum" value="${competition.expectUserNum}">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 파일 업로드</label>
			                	
			                	<table class="table" id="selListCompetitionTable">
			                    <thead>
			                      <tr>
			                        <th>#</th>
			                        <th>Tenant ID</th>
			                        <th>대회코드</th>
			                        <th>이미지명</th>
			                        <th>이미지경로</th>
			                        <th>이미지유형</th>
			                        <th>이미지번호</th>
			                        <th>등록일</th>
			                        <th></th>
			                      </tr>
			                    </thead>
			                    <tbody id="imgTbody" name="imgTbody">
			                    <c:forEach items="${competitionImageList}" var="list" varStatus="parent">
			                      <tr>
			                        <th scope="row"></th>
			                        <td>${list.tenantId}<input type="hidden" name="delImgYn" value="N"/></td>
			                        <td>${list.cpCd}</td>
			                        <td>${list.imgFileNm}</td>
			                        <td>${list.filePathNm}</td>
			                        <td>${list.imgFgCd}<input type="hidden" name="delImgFgCd" value="${list.imgFgCd}"/></td>
			                        <td>${list.imgSeq}<input type="hidden" name="delImgSeq" value="${list.imgSeq}"/></td>
			                        <td>${list.adDate}</td>
			                        <td><input type="button" name="delImgBtn" id="delImgBtn" value="삭제" class="btn btn-primary"/>
			                        <input type="button" name="cancelDelImgBtn" id="cancelDelImgBtn" value="취소" class="btn btn-secondary"/></td>
			                      </tr>
			                    </c:forEach>  
			                    </tbody>
			                  </table>
			                	
			                	<div style="float:right;">
									<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-primary"/>
				                	<input type="button" name="delRowBtn" id="delRowBtn" value="삭제" class="btn btn-primary"/>
			                	</div>
			                	<table id="serviceTbl" name="serviceTbl" class="table">
									<tbody name="serviceTbody">
										<tr>
											<td>
												<div class="col-sm-5 select">
						                          <select name="imgFgCd" class="form-control form-control-sm">
						                          <c:forEach items="${imgFgCdList}" var="list" varStatus="parent">
						                            <option value="${list.cdId}">${list.cdNm}</option>
						                          </c:forEach>
						                          </select>
						                          <input type="hidden" name="imgSeq" class="form-control form-control-sm"/>
						                          <input type="file" name="file" class="form-control form-control-sm"/>
						                        </div>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- <div class="col-md-5">
									<input type="file" name="file" class="form-control form-control-sm"/>
									<input multiple="multiple"  type="file" id="file" name="file[]" class="form-control form-control-sm"/>
								</div> -->
							</div>
							<div class="line"></div>
							<div class="btn-center">
									<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
									<input type="button" id="btnUpdate" class="btn btn-primary" value="수정"/>
								
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
