<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
$(function () {

	$("#btnHystrix").on("click", function(e){
		
		alert($("#btnHystrix").val());
	});
	

	$(".tenantId").click(function(){
		id = $(this);
	    var td = id.children();
	    var tempTenantId = td.eq(1).val();
	    $("input[name=tenantId]").val(tempTenantId);
	    $("#frm").attr("action", "/selMonitorView");
	    submit();
	});

$("button").click(function () {
	var value = $(this).val();
	window.open(value,'모니터링','width=840, height=620, scrollbars=no');
	});

});
	
	function goPage(page) {
		$("input[name=page]").val(page);
		submit();
	}
	
	function submit(){
		
		$("#frm").submit();  
		
	}
	
	
</script>

<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/selListContract">시스템관리</a></li> 
			<li class="breadcrumb-item active">모니터링 목록</li>
		</ul>
	</div>
</div>

<section class="charts">
	 
        <div class="container-fluid">
       <!--  <form id="frm" action="" method="post" class=""> -->
          <header> 
            <h1 class="h3">모니터링 목록</h1>
          </header>
          <div class="row">
          <c:choose>
			<c:when test="${fn:length(list) >0 }">
	          <c:forEach items="${list}" var="list" varStatus="parent">
		           <div class="col-lg-12">
		              <div class="card">
		                
		                
		                <div class="card-header d-flex align-items-center">
		                  <div class="tenantId">
		                  	<h2 class="h5 display">[${list.tenantId}]${list.contNm}</h2>
		                  	<input type="hidden" id="tempTenantId" name="tempTenantId" value="${list.tenantId}" />
		                  </div>
		                </div>
		                
		                
		                
		                <div class="card-body">
		                  <form class="form-inline">
		                    <div class="form-group">
		                      <button type="button"  value="${list.url1}" class="mx-sm-5 btn btn-secondary">hystrix : [${list.url1}]</button>
		                    </div>
		                    <div class="form-group">
		                      <button type="button"  value="${list.url2}" class="mx-sm-5 btn btn-primary">zipkin : [${list.url2}]</button>
		                    </div>
		                  
		                  </form>
		                </div>
		              </div>
		            </div>
		   
	          	</c:forEach>
		 		 </c:when>
				<c:otherwise>
					<div class="col-lg-12">
		              <div class="card">
		                  <div class="card-body">
		                  <form class="form-inline">
		                    조회된 목록이 없습니다.
		                  </form>
		                </div>
		              </div>
		            </div>
				</c:otherwise>
			</c:choose>
          </div>
         <!--  </form> -->
        </div>
        
        <form id="frm" class="form-inline">
        	<input type="hidden" id="tenantId" name="tenantId" value="" />
        </form> 
      </section>