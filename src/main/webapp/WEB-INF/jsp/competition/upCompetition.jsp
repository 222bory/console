<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	/* var flag = false;

	function fn_dupl() {
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
	
	function fn_idCheck(){
		flag=false;
	} */
 
</script>

<script>
	/* $(function(){
	    $('#frm').validate({
	     rules: {
	       id : {required : true},
	       upw :{required : true},
	       upwConfirm : {required : true, equalTo:"#upw"},
	       uemail : {email: true},
	       uname : {required:true}
	     },
	     messages:{
	    	id:{required :"아이디를 입력해주세요"},
	    	upw:{required :"패스워드를 입력해주세요"},
	    	upwConfirm:{
	    		required : "패스워드 확인을 입력해주세요",
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
	     } 
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
	}); */
	
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
						<h2 class="h5 display">사용자 정보 입력</h2>
					</div>
					<div class="card-body">
						<form class="form-horizontal" id="frm" name="frm" method="POST" action="/upCompetition">
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* Tenant ID</label>
								<div class="help-block with-errors"></div>
							<div class="col-md-6">
								<div class="row">
									<div style="width: 70%; padding: 0.375rem 0.75rem;">
										<input type="text" class="form-control" id="tenantId" name="tenantId">
									</div>
									
								</div>
							</div>

								<!-- Modal -->
								<!-- <div id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
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
												<input type="button" data-dismiss="modal" class="btn btn-secondary" value="닫기" /> 
												<input type="button" data-dismiss="modal" class="btn btn-primary" value="확인" />
											</div>
										</div>
									</div>
								</div> -->
								<!-- Modal End-->

							</div>
							<div class="line"></div>
							<!-- <div class="form-group">
								<label class="col-sm-2 form-control-label">* 비밀번호</label>
								<div class="col-md-5">
									<input type="password" class="form-control" id="upw" name="upw" placeholder="영문+숫자+특수문자 10자리 이상">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 비밀번호 확인</label>
								<div class="col-md-5">
									<input type="password" class="form-control" id="upwConfirm" name="upwConfirm" placeholder="영문+숫자+특수문자 10자리 이상">
								</div>
							</div>
							<div class="line"></div> -->
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회코드</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpCd" name="cpCd">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회명</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpNm" name="cpNm">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회시작일자</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpStartDt" name="cpStartDt">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회종료일자</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpEndDt" name="cpEndDt">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회장소명</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpPlaceNm" name="cpPlaceNm">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회Scale코드</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpScaleCd" name="cpScaleCd">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 대회유형코드</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="cpTypeCd" name="cpTypeCd">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<label class="col-sm-2 form-control-label">* 예상사용자수</label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="expectUserNum" name="expectUserNum">
								</div>
							</div>
							<div class="line"></div>
							<div class="form-group">
								<div class="col-sm-4 offset-sm-2">
									<input type="button" id="btnCancel" class="btn btn-secondary" value="취소" />
									<button type="submit" id="btnRegister" class="btn btn-primary" >수정</button>
								</div>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
