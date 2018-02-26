<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){ 
		var tenantId = $('#tenantId').text();
		var cpCd = $('#cpCd').text();
		
		$('#listButton').click(function(event){  
			location.href = "/selListCompetition";
		});
		$('#upButton').click(function(event){
			location.href = "/upCompetition?tenantId="+tenantId+"&cpCd="+cpCd;
		});
		$('#delButton').click(function(event){
			var result = confirm('대회정보를 삭제 하시겠습니까?'); 
			
			if(result) { 
				var frm = $("#frm"); 
				frm.action="/delCompetition";
				frm.method="Post";
				frm.submit();  
			}else{
				return;
			}
		});
	});
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/selCompetition">서비스관리</a></li>
			<li class="breadcrumb-item active">대회관리</li>
		</ul>
	</div>
</div>
	  <section class="forms">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">대회상세</h1>
          </header>
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display" >대회정보상세</h2>
                </div>
                <div class="card-body">
                <%-- <form action="/selCompetition" method="post" id="detailFrm">
                	<input type="hidden" name="page" value="${competitionModel.page}" />
                	<input type="hidden" id="hiddenTenantId" name="tenantId"/>
                	<input type="hidden" id="hiddenCpCd" name="cpCd"/>
                </form> --%>
                <form action="delCompetition" method="post" id="frm">
                <input type="hidden" name="page" value="${competitionModel.page}" />
                <input type="hidden" name="tenantId" value="${competition.tenantId}"/>
                <input type="hidden" name="cpCd" value="${competition.cpCd}"/>
                  <table class="table" id="selListCompetitionTable">
                    <tbody>
                    	<tr><td>테넌트ID</td><td id="tenantId">${competition.tenantId}</td></tr>
                    	<tr><td>계약명</td><td>${competition.contNm}</td></tr>
                    	<tr><td>대회 코드</td><td id="cpCd">${competition.cpCd}</td></tr>
                    	<tr><td>대회명</td><td>${competition.cpNm}</td></tr>
                    	<tr><td>대회 기간</td><td>${competition.cpStartDt} ~ ${competition.cpEndDt}</td></tr>
                    	<tr><td>대회 장소</td><td>${competition.cpPlaceNm}</td></tr>
                    	<tr><td>대회 규모</td><td>${competition.cpScaleCd}</td></tr>
                    	<tr><td>대회 유형</td><td>${competition.cpTypeCd}</td></tr>
                    	<tr><td>예상 이용자수</td><td>${competition.expectUserNum}</td></tr>
                    </tbody>
                  </table>
                  
                  <table class="table">
                  	<thead>
                      <tr>
                        <th>이미지명</th>
                        <th>파일 경로</th>
                        <th>이미지 종류</th>
                        <th>이미지 순서</th>
                        <th>등록 일자</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${competitionImageList}" var="list" varStatus="parent">
                      <tr>
                        <td>${list.imgFileNm}</td>
                        <td>${list.filePathNm}</td>
                        <td>${list.imgFgCd}</td>
                        <td>${list.imgSeq}</td>
                        <td>${list.adDate}</td>
                      </tr>
                      </c:forEach>  
                    </tbody>
                  </table>
                  <div class="form-group">
					<div class="col-sm-4 offset-sm-2">
						<input type="button" id="delButton" class="btn btn-secondary" value="삭제" />
						<input type="button" id="listButton" class="btn btn-primary" value="목록" />
						<input type="button" id="upButton" class="btn btn-primary" value="수정" />
					</div>
				  </div>
              	  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>