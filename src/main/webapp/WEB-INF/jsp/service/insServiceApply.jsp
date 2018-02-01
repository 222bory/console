<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">

$(document).ready(function(){

    // 추가 버튼 클릭시
    $("#addRowBtn").click(function(){
	 var newitem = $("#serviceGroupTbl tr:eq(1)").clone(); //1행 복사
	 
     $("#serviceGroupTbl").append(newitem);
    });
    
 	// 삭제버튼 클릭시
    $("#delRowBtn").click(function(){  
        $('#serviceGroupTbl > tbody:last > tr:last').remove();
    });


});

</script>
    
 <div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="/userList">서비스관리</a></li>
			<li class="breadcrumb-item active">서비스신청</li>
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
				<form class="form-horizontal" id="frm" name="frm">
				
				<div class="form-group">
				<label class="col-sm-2 form-control-label">* 대회선택</label>
				<div class="row">
					<div style="width: 60%; padding: 0.375rem 0.75rem;">
						<input type="text" class="form-control" id="cpNm" name="cpNm">
					</div>
					<div style="width: 30%; padding: 0.375rem 0.75rem;">
						<button type="button" id="searchCpBtn" class="btn btn-primary">검색</button>
					</div>
				</div>
				</div>
				<div class="line"></div>
				<div class="form-group">
					<div class="row">
						<label class="col-sm-2 form-control-label">* 서비스선택</label>
						<div class="">
						<input type="button" name="addRowBtn" id="addRowBtn" value="추가" class="btn btn-secondary"/>
	                	<input type="button" name="delRowBtn" id="delRowBtn" value="삭제" class="btn btn-secondary"/>
						</div>
					</div>
					<div class="col-md-15">
					<table id="serviceGroupTbl" class="table">
						<thead>
	                      <tr>
	                        <th>서비스명</th>
	                        <th>시작일자</th>
	                        <th>종료일자</th>
	                        <th>테스트랩<br>사용여부</th>
	                        <th>테스트이벤트<br>사용여부</th>
	                      </tr>
	                    </thead>
						<tbody>
	                      <tr>
	                        <td><div class="col-sm-10 select">
	                        	<select name="service" class="form-control">
	                        	<c:forEach items="${serviceList}" var="service" varStatus="parent">
	                        		<option>${service.name}</option>
	                        	</c:forEach>
	                        	</select>
	                        </div></td>
	                        <td>서비스1</td>
	                        <td>서비스1</td>
	                        <td><div id="cp3" class="input-group colorpicker-component">
							    <input type="text" value="#00AABB" class="form-control" />
							    <span class="input-group-addon"><i></i></span>
								</div>
							</td>
	                        <td>
	                        <input id="cal3" type="text" class="form-control" />
	                       	</td>
	                      </tr>
	                    </tbody>
					</table>
				  	</div>
                 </div>
                 
                 
                 
				</form>
				</div>
			</div>
		</div>
	</div>	
	</div>
</section>