<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<script>
$(function () {
	$('#cp3').colorpicker({
        color: '#AA3399',
        format: 'hex'
    });
	
	
		$('#cal3').datepicker({
				"format" :'yyyy-mm-dd',
				"setDate": new Date(),
		        "autoclose": true,
		        "todayHighlight":true
			});
			
			$("#cal3").datepicker("setDate", new Date());
});
</script>


<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">test</a></li>
			<li class="breadcrumb-item active">test</li>
		</ul>
	</div>
</div>

<section class="charts">
	<div class="container-fluid">
	<header>
		<h1 class="h3 display">Sample Code</h1>
	</header>
		
	<div class="row">
		<div class="col-lg-8">
			<div class="card">
				<div class="card-header d-flex align-items-center">
					<h2 class="h5 display">sample</h2>
				</div>
				<div class="card-body">
				
				<form class="form-horizontal" id="frm" name="frm">
					<table class="table table-hover">
						<thead>
	                      <tr>
	                        <th>no</th>
	                        <th>color</th>
	                        <th>가입일자</th>
	                      </tr>
	                    </thead>
						<tbody>
	                      <tr>
	                        <th scope="row">#</th>
	                        <td><div id="cp3" class="input-group colorpicker-component">
							    <input type="text" value="#00AABB" class="form-control" />
							    <span class="input-group-addon"><i></i></span>
								</div></td>
	                        <td>
	                        <input id="cal3" type="text" class="form-control" />
	                       
								<!--<span class="input-group-addon">
			                    	<i class="glyphicon glyphicon-calendar"></i>
			                    </span>  
			                    <a href="#">
						          <span class="glyphicon glyphicon-calendar"></span>
						        </a>-->
	                     
	                       	</td>
	                      </tr>
	                    </tbody>
					</table>
				</form>
				</div>
			</div>
		</div>
	</div>	
	</div>
</section>





