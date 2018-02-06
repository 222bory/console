<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	
 
	/* function goPage(page) {
		$("input[name=page]").val(page);
		submit();
	}
	function submit(){
		$("#frm").submit();  
	} */
	
	$(document).ready(function(){
		$('#listButton').click(function(event){
			
			$("#hiddenTenantId").val($("#tenantId").text());
			
			alert($("#tenantId").text());
			alert($("#hiddenTenantId").val());
			$("#frm").action = "/selListCompetition";
			$("#frm").submit();  
		});
		$('#upButton').click(function(event){
			$("#frm").action = "/upCompetition";
			$("#frm").submit();  
		});
		$('#delButton').click(function(event){
			$("#frm").action = "/delCompetition";
			$("#frm").submit();  
		});
	});
/* 	$("#selListCompetitionTable tr").click(function() {
		alert("test");
        var str = ""
        var tdArr = new Array();

        var tr = $(this);
        var td = tr.children();

        td.each(function(i){
            tdArr.push(td.eq(i).text());
        });

        var tenantId = td.eq(0).text();
		alert(tenantId);
	}); */
	
	/* $(document).ready(function(){
		$('#selListCompetitionTable tr').click(function(event){
			if(event.target.nodeName.toLowerCase() == 'td') {
				$('#hiddenTenantId').val($(this).children().eq(1).text());
				alert("test :: "+ $('#hiddenTenantId').val());
				$("#detailFrm").submit();
				//var checkbox = $(this).find('td:first-child :checkbox');
				//checkbox.attr('checked', !checkbox.is(':checked'));
			}
		});
	}); */
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/selCompetition">대회관리</a></li>
			<li class="breadcrumb-item active">대회관리</li>
		</ul>
	</div>
</div>

	  <section class="charts">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">대회관리</h1>
          </header>
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display" >대회상세</h2>
                </div>
                <div class="card-body">
                <form action="/selCompetition" method="post" id="detailFrm">
                	<%-- <input type="hidden" name="page" value="${competitionModel.page}" /> --%>
                	<input type="hidden" id="hiddenTenantId" name="hiddenTenantId"/>
                </form>
                
                <form action="" method="post" id="frm">
                <input type="hidden" name="page" value="${competitionModel.page}" />
                  <table class="table" id="selListCompetitionTable">
                    <tbody>
                    	<tr><td>테넌트ID</td><td id="tenantId">${competition.tenantId}</td></tr>
                    	<tr><td>계약명</td><td>${competition.contNm}</td></tr>
                    	<tr><td>대회 코드</td><td>${competition.cpCd}</td></tr>
                    	<tr><td>대회명</td><td>${competition.cpNm}</td></tr>
                    	<tr><td>대회 기간</td><td>${competition.cpStartDt} ~ ${competition.cpEndDt}</td></tr>
                    	<tr><td>대회 장소</td><td>${competition.cpPlaceNm}</td></tr>
                    	<tr><td>대회 규모</td><td>${competition.cpScaleCd}</td></tr>
                    	<tr><td>대회 유형</td><td>${competition.cpTypeCd}</td></tr>
                    	<tr><td>예상 이용자수</td><td>${competition.expectUserNum}</td></tr>
                    </tbody>
                  </table>
                  
                  <div class="form-group">
					<div class="col-sm-4 offset-sm-2">
						<input type="button" id="listButton" class="btn btn-primary" value="목록" />
						<input type="button" id="upButton" class="btn btn-primary" value="수정" />
						<input type="button" id="delButton" class="btn btn-primary" value="삭제" />
					</div>
				  </div>
              	  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>