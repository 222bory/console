<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#btnCancel").click(function(){
			location.href="/selListCompetition";
		});
		
		$("#searchValue").keyup(function(){
			$.getJSON('searchCompetition', {"searchType" : $('#searchType').val(), "searchValue" : $('#searchValue').val()}, function(data){
				var html;
				$("#tenantId option").remove();
				
				var obj = $("#searchValue").offset();
				
				$(data).each(function(entryIndex, entry){
					$('#tenantId').append('<option value="'+entry.tenantId+'">'+entry.contNm+' [ tenant id : '+entry.tenantId+' ]</option>');
				});
				
			});
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
		
		$("#btnRegister").click(function(){
			var selectTag = $('select[name=imgFgCd]');
			var hiddenTag = $('input[name=imgSeq]');
			
			var len = selectTag.length;
			
			var msSeq = 0 ;
			var emSeq = 0 ;
			
			for(i = 0 ; i < len ; i ++){
				if(selectTag[i].value == 'MS'){
					$('input[name=imgSeq]:eq('+i+')').val(msSeq);
					msSeq += 1;
				}
				if(selectTag[i].value == 'EM'){
					$('input[name=imgSeq]:eq('+i+')').val(emSeq);
					emSeq += 1;
				}
			}
			
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
			<li class="breadcrumb-item"><a href="index.html">서비스관리</a></li>
			<li class="breadcrumb-item active">대회 정보 등록</li>
		</ul>
	</div>
</div>
<section class="forms">
	<div class="container-fluid">
		<header>
			<h1 class="h3 display">대회 정보 등록</h1>
		</header>
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-header d-flex align-items-center">
						<h2 class="h5 display">사용자 정보 입력</h2>
					</div>
					<div class="card-body">
						<form class="form-horizontal" id="frm" name="frm" method="POST" action="/insCompetition" enctype="multipart/form-data">
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 계약 선택</label>
								<div class="card-header d-flex align-items-center">
				                    <div class="form-group">
				                        <select id="searchType" name="searchType" class="form-control form-control-sm">
				                          <option value="C">계약명</option>
				                          <option value="T">테넌트아이디</option>
				                        </select>
				                    </div>
				                    <div class="form-group col-md-3">
				                      <input id="searchValue" type="text" placeholder="유형 선택 후 검색어 입력 -> 아래 고객계약 선택에서 확인" class="mx-sm-5 form-control form-control form-control-sm">
				                    </div>
				                </div>
				            </div>    
							<label class="col-sm-2 form-control-label">* 고객계약 선택</label>
							<div class="form-group">
			                    <div class="col-sm-5 select">
			                       <select id="tenantId" name="tenantId" class="form-control form-control-sm">
			                       <c:forEach items="${contractList}" var="list" varStatus="parent">
			                         <option value="${list.tenantId}">${list.contNm} [ tenant id : ${list.tenantId} ]</option>
			                       </c:forEach>
			                       </select>
			                     </div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 코드</label>
								<div class="col-md-5">
									<input type="text" class="form-control form-control-sm" id="cpCd" name="cpCd">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회명</label>
								<div class="col-md-5">
									<input type="text" class="form-control form-control-sm" id="cpNm" name="cpNm">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
							<label class="col-sm-3 form-control-label">* 대회 기간</label>
							<div class="card-header d-flex align-items-center">
								<div class="form-group">
									<input type="text" class="form-control form-control-sm" id="cpStartDt" name="cpStartDt">
								</div>
								<div class="form-group">
								&nbsp;~&nbsp;
								</div>
								<div class="form-group">
									<input type="text" class="form-control form-control-sm" id="cpEndDt" name="cpEndDt">
								</div>
							</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회 장소</label>
								<div class="col-md-5">
									<input type="text" class="form-control form-control-sm" id="cpPlaceNm" name="cpPlaceNm">
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
									<input type="text" class="form-control form-control-sm" id="expectUserNum" name="expectUserNum" value="0">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 파일 업로드</label>
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
							<div class="form-group">
								<div class="col-sm-4 offset-sm-2">
									<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
									<button type="submit" id="btnRegister" class="btn btn-primary" >등록</button>
								</div>
							</div>
						</form>
						<!-- <form action="/upCompetitionImage" method="post" enctype="multipart/form-data">
						   <div class="form-group">
								<label class="col-sm-2 form-control-label">* 파일 업로드</label>
								<div class="col-md-5">
									<input multiple="multiple"  type="file" id="fileName" name="fileName[]" class="form-control form-control-sm"/>
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<div class="col-sm-4 offset-sm-2">
									<button type="submit" id="btnRegister" class="btn btn-primary" >이미지 등록</button>
								</div>
							</div>
						</form> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
