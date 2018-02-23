<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	var flag = false;

	function fnDupl() {
		var userID = $('#id').val();
		
		if(userID==''){
			$('#duplResult').html('아이디를 입력해주세요');
			flag=false;
			return;
		}
		else{
			$.ajax({
				type : 'POST',
				url : '/userDuplCheck',
				//파리미터 변수 이름 : 값
				data : {
					userID : userID
				},
				success : function(result) {
					if (result == "0") {
						$('#duplResult').html('사용할 수 있는 아이디입니다.');
						flag = true;
					} else {
						$('#duplResult').html('이미 사용중인 아이디입니다.');
						flag = false;
					}
				}
			});
		}
		
		return flag;
	}
	
	function fnIdCheck(){
		flag=false;
	}
 
</script>

<script>
	$(function(){
	    $('#frm').validate({
	     rules: {
	       id : {required : true, maxlength:100},
	       upw :{required : true, minlength: 8, maxlength:100},
	       upwConfirm : {required : true, minlength: 8, equalTo:"#upw", maxlength:100},
	       uemail : {email: true, maxlength:100},
	       uname : {required:true, maxlength:100}
	     },
	     messages:{
	    	id:{required :"아이디를 입력해주세요"},
	    	upw:{required :"패스워드를 입력해주세요",
	    		minlength :"패스워드는 8자리 이상 입력해주세요"},
	    	upwConfirm:{
	    		required : "패스워드 확인을 입력해주세요",
	    		minlength :"패스워드는 8자리 이상 입력해주세요",
	    		equalTo:"패스워드가 일치하지 않습니다"
	    	},
	    	uemail:{
	    		email:"올바른 이메일 주소를 입력해주세요"
	    	},
	    	uname:{required:"이름을 입력해주세요"}
	     },
	     highlight: function(element) {
	       $(element).closest('.control-group').removeClass('success').addClass('error');
	     },
	     /* ,
	     success: function(element) {
	       element
	       .text('OK!').addClass('valid')
	       .closest('.control-group').removeClass('error').addClass('success');
	     } */
	     submitHandler: function(frm){
	    	
	    	 if (!flag) {
					alert('ID 중복확인을 해주세요');
					return;
			 }
	    	 else{
	    		 frm.submit();
	    	 }
	     }
	    });
	});
	
</script>


<div class="breadcrumb-holder">
	<div class="container-fluid">
		<ul class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">계정관리</a></li>
			<li class="breadcrumb-item active">사용자 계정 등록</li>
		</ul>
	</div>
</div>
<section class="forms">
	<div class="container-fluid">
		<header>
			<h1 class="h3 display">사용자 계정 등록</h1>
		</header>
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-header d-flex align-items-center">
						<h2 class="h5 display">사용자 정보 입력</h2>
					</div>
					<div class="card-body">
						<form class="form-horizontal" id="frm" name="frm" method="POST" action="/regUser">
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 관리자ID</label>
									<div class="col-md-6">
										<div class="row">
											<div style="width: 60%; padding: 0.375rem 0.75rem;">
												<input type="text" class="form-control form-control-sm" id="id" name="id" onchange="fnIdCheck();">
											</div>
											<div style="width: 30%; padding: 0.375rem 0.75rem;">
												<button type="button" id="btnDupl" onclick="fnDupl()" data-toggle="modal" data-target="#myModal" class="btn btn-primary">중복확인</button>
											</div>
										</div>
									</div>

								<!-- Modal -->
								<div id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
									<div role="document" class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 id="exampleModalLabel" class="modal-title">중복확인</h5>
												<button type="button" data-dismiss="modal" aria-label="Close" class="close">
													<span aria-hidden="true">×</span>
												</button>
											</div>
											<div class="modal-body">
												<h2>아이디 중복확인 결과</h2>
												<p id="duplResult"></p>
											</div>
											<div class="modal-footer">
												<!-- <input type="button" data-dismiss="modal" class="btn btn-secondary" value="닫기" />  -->
												<input type="button" data-dismiss="modal" class="btn btn-primary" value="확인" />
											</div>
										</div>
									</div>
								</div>
								<!-- Modal End-->

							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 비밀번호</label>
								<div class="col-md-5">
									<input type="password" class="form-control form-control-sm" id="upw" name="upw" placeholder="영문+숫자+특수문자 8자리 이상">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 비밀번호 확인</label>
								<div class="col-md-5">
									<input type="password" class="form-control form-control-sm" id="upwConfirm" name="upwConfirm" placeholder="영문+숫자+특수문자 8자리 이상">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 이름</label>
								<div class="col-md-5">
									<input type="text" class="form-control form-control-sm" id="uname" name="uname">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">이메일</label>
								<div class="col-md-5">
									<input type="input" id="uemail" name="uemail" placeholder="직접입력" class="form-control form-control-sm">
									<label class="error" for="uemail" generated="true" style="display:none; color: red;">error message</label>
								</div>
								
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">권한</label>
								<div class="col-md-5">
									<div class="row">
										<div class="col-md-4">
											<input id="radioRoleAdmin" type="radio" checked="" value="ADMIN" name="radioRole" class="form-control-custom radio-custom">
											<label for="radioRoleAdmin">관리자</label>
										</div>
										<div class="col-md-4">
											<input id="radioRoleBasic" type="radio" value="BASIC" name="radioRole" class="form-control-custom radio-custom">
											<label for="radioRoleBasic">일반사용자</label>
										</div>
									</div>
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<div class="col-sm-4 offset-sm-2">
									<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
									<button type="submit" id="btnRegister" class="btn btn-primary" >등록</button>
								</div>
							</div>
							<input type="hidden" name="num" value="1">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
