<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	
 
	function goPage(page) {
		$("input[name=page]").val(page);
		submit();
	}
	function submit(){
		$("#frm").submit();  
	}
	
	
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
	
	$(document).ready(function(){
		$('#selListCompetitionTable tr').click(function(event){
			if(event.target.nodeName.toLowerCase() == 'td') {
				var tenantId = $(this).children().eq(1).text();
				var cpCd = $(this).children().eq(3).text();
				location.href='/selCompetition?tenantId='+tenantId+'&cpCd='+cpCd;
				//$('#hiddenTenantId').val($(this).children().eq(1).text());
				//$("#detailFrm").submit();
				//var checkbox = $(this).find('td:first-child :checkbox');
				//checkbox.attr('checked', !checkbox.is(':checked'));
			}
		});
	});
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
                  <h2 class="h5 display" >대회목록</h2>
                </div>
                <div class="card-body">
                <form action="/selCompetition" method="post" id="detailFrm">
                	<input type="hidden" id="hiddenTenantId" name="hiddenTenantId" value="" />
                </form>
                
                <form action="" method="post" id="frm">
                <input type="hidden" name="page" value="${competitionModel.page}" />
                  <table class="table" id="selListCompetitionTable">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Tenant ID</th>
                        <th>계약명</th>
                        <th>대회코드</th>
                        <th>대회명</th>
                        <th>대회기간</th>
                        <th>대표자명</th>
                        <th>전화번호</th>
                        <th>등록일</th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:set var="no" value="${pagination.totalRow - (pagination.currentPage - 1) * pagination.rowPerPage }"/>
					<c:set var="countNo" value="0"/>
                    <c:forEach items="${competitionList}" var="list" varStatus="parent">
                      <tr>
                        <th scope="row">${no - countNo}</th>
                        <td>${list.tenantId}</td>
                        <td>${list.contNm}</td>
                        <td>${list.cpCd}</td>
                        <td>${list.cpNm}</td>
                        <td>${list.cpStartDt} ~ ${list.cpEndDt}</td>
                        <td>${list.mgrNm}</td>
                        <td>${list.mgrTelNo}</td>
                        <td>${list.adDate}</td>
                      </tr>
                    <c:set var="countNo" value="${countNo+1 }" />
                    </c:forEach>  
                    </tbody>
                  </table>
              	  </form>
				 	<div class="pagination">
					  <ul>
					  	<c:import url="/WEB-INF/jsp/paging/paging.jsp"></c:import>
					  </ul>
					</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>