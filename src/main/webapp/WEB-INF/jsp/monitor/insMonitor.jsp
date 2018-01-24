<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
function fn_submit(){
	var f = document.frm;
	f.action="/monitor/insertUrl";
	f.submit();
	
}

function fn_dupl(){
	
	flag=true;
	
	return flag;
}
</script>

<section class="forms">
        <div class="breadcrumb-holder">
        <div class="container-fluid">
          <ul class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">tenent</li>
            <li class="breadcrumb-item active">url</li>
          </ul>
        </div>
      	</div>
        <div class="container-fluid">
          <header> 
            <h1 class="h3 display">Forms</h1>
          </header>
          <div class="row">
      
            
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">Monitoring URL</h2>
                </div>
                
                    
                
                <div class="card-body">
                  <form action="/insMonitor" method="post" class="form-horizontal">
                  
                  
                    <div class="form-group row">
                      <label class="col-sm-2 form-control-label">하이스트릭스</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="hystricx">
                      </div>
                    </div>
                    <div class="line"></div>
                    <div class="form-group row">
                      <label class="col-sm-2 form-control-label">zipkin</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="zipkin"><span class="help-block-none">A block of help text that breaks onto a new line and may extend beyond one line.</span>
                      </div>
                    </div>
                    <div class="line"></div>
                    
                    <div class="form-group row">
                      <div class="col-sm-4 offset-sm-2">
                        <button type="submit" class="btn btn-secondary">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>