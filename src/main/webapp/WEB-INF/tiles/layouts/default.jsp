<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%-- <!DOCTYPE html>
<html>

<head>
	<tiles:insertAttribute name="header" />
</head>
<body>
	<div class="container-fluid">
		<div class="row-menu"><tiles:insertAttribute name="menu" /></div>
		<div class="row-content"><tiles:insertAttribute name="body" /></div>
		<tiles:insertAttribute name="footer" />
	</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%> --%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SICC GSP CONSOLE</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">

    <!-- Bootstrap CSS-->
<!--     <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css"> -->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css">
     <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap-colorpicker.min.css"> 
     <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap-datepicker3.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom icon font-->
    <link rel="stylesheet" href="css/fontastic.css">
    <!-- Google fonts - Roboto -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
    <!-- jQuery Circle-->
    <link rel="stylesheet" href="css/grasp_mobile_progress_circle-1.0.0.min.css">
    <!-- Custom Scrollbar-->
    <link rel="stylesheet" href="vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="favicon.png">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->

     <!-- Javascript files-->
    <!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script> -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/jquery/moment.js"></script>
    <script src="vendor/bootstrap/js/bootstrap-colorpicker.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap-datepicker.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <!-- <script src="js/charts-home.js"></script> -->
    <script src="js/front.js"></script>
    <!-- Google Analytics: change UA-XXXXX-X to be your site's ID.-->
    <!---->
    <script>
      (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
      function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
      e=o.createElement(i);r=o.getElementsByTagName(i)[0];
      e.src='//www.google-analytics.com/analytics.js';
      r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
      ga('create','UA-XXXXX-X');ga('send','pageview');
    </script>


  </head>
  <body>
    <!-- Side Navbar -->
    <nav class="side-navbar">
      <div class="side-navbar-wrapper">
        <div class="sidenav-header d-flex align-items-center justify-content-center">
          <div class="sidenav-header-inner text-center">
          	<img src="img/logo.png" alt="person" class="img-fluid rounded-circle">
            <h2 class="h5 text-uppercase">GSP</h2><span class="text-uppercase">CONSOLE</span>
          </div>
          <div class="sidenav-header-logo"><a href="#" class="brand-small text-center"> <strong>B</strong><strong class="text-primary">D</strong></a></div>
        </div>
        <!-- <div class="main-menu">
          <ul id="side-main-menu" class="side-menu list-unstyled">                  
            <li class="active"><a href="index.html"> <i class="icon-home"></i><span>Home</span></a></li>
            <li> <a href="forms.html"><i class="icon-form"></i><span>Forms</span></a></li>
            <li> <a href="charts.html"><i class="icon-presentation"></i><span>Charts</span></a></li>
            <li> <a href="tables.html"> <i class="icon-grid"> </i><span>Tables  </span></a></li>
            <li> <a href="login.html"> <i class="icon-interface-windows"></i><span>Login page                        </span></a></li>
            <li> <a href="#"> <i class="icon-mail"></i><span>Demo</span>
                <div class="badge badge-warning">6 New</div></a></li>
          </ul>
        </div> -->
        
        <sec:authorize access="isAuthenticated()">
        <div class="admin-menu">
          <ul id="side-admin-menu" class="side-menu list-unstyled"> 
			<li sec:authorize="isAuthenticated()"> <a href="#pages-nav-list1" data-toggle="collapse" aria-expanded="false"><i class="icon-interface-windows"></i><span>서비스 관리</span>
                <div class="arrow pull-right"><i class="fa fa-angle-down"></i></div></a>
              <ul id="pages-nav-list1" class="collapse list-unstyled">
                <li> <a href="/insContractForm">계약 등록</a></li>
                <li> <a href="/selListContract">계약 관리</a></li>
                <li> <a href="/insCompetition">대회 등록</a></li>
                <li> <a href="/selListCompetition">대회 관리</a></li>
                <li> <a href="/insServiceApply">서비스 신청</a></li>
                <li> <a href="/selListServiceApply">서비스신청 관리</a></li>
              </ul>
            </li>
            
 <!--            <li> <a href="#pages-nav-list2" data-toggle="collapse" aria-expanded="false"><i class="icon-interface-windows"></i><span>테넌트 관리</span>
                <div class="arrow pull-right"><i class="fa fa-angle-down"></i></div></a>
              <ul id="pages-nav-list2" class="collapse list-unstyled">
                <li> <a href="#">Page 1</a></li>
                <li> <a href="#">Page 2</a></li>
                <li> <a href="#">Page 3</a></li>
                <li> <a href="#">Page 4</a></li>
              </ul>
            </li>
            
            <li> <a href="#pages-nav-list3" data-toggle="collapse" aria-expanded="false"><i class="icon-interface-windows"></i><span>클라우드 관리</span>
                <div class="arrow pull-right"><i class="fa fa-angle-down"></i></div></a>
              <ul id="pages-nav-list3" class="collapse list-unstyled">
                <li> <a href="#">Page 1</a></li>
                <li> <a href="#">Page 2</a></li>
                <li> <a href="#">Page 3</a></li>
                <li> <a href="#">Page 4</a></li> 
              </ul>
            </li>
            
            <li> <a href="#pages-nav-list4" data-toggle="collapse" aria-expanded="false"><i class="icon-interface-windows"></i><span>모듈 관리</span>
                <div class="arrow pull-right"><i class="fa fa-angle-down"></i></div></a>
              <ul id="pages-nav-list4" class="collapse list-unstyled">
                <li> <a href="#">Page 1</a></li>
                <li> <a href="#">Page 2</a></li>
                <li> <a href="#">Page 3</a></li>
                <li> <a href="#">Page 4</a></li>
              </ul>
            </li> -->
           
            <li> <a href="#pages-nav-list5" data-toggle="collapse" aria-expanded="false"><i class="icon-interface-windows"></i><span>시스템 관리</span>
                <div class="arrow pull-right"><i class="fa fa-angle-down"></i></div></a>
              <ul id="pages-nav-list5" class="collapse list-unstyled">
                <li> <a href="/insCodeForm">코드 등록</a></li>
                <li> <a href="/selListCode">코드 관리</a></li>
                <li> <a href="/insMonitorForm">모니터링 등록</a></li> 
                <li> <a href="/selListMonitor">모니터링 조회</a></li> 
              </ul>
            </li>
            
            <li> <a href="#pages-nav-list6" data-toggle="collapse" aria-expanded="false"><i class="icon-interface-windows"></i><span>계정 관리</span>
                <div class="arrow pull-right"><i class="fa fa-angle-down"></i></div></a>
              <ul id="pages-nav-list6" class="collapse list-unstyled">
                <li> <a href="/insAdmin">사용자계정 등록</a></li>
                <li> <a href="/selectListAdmin">사용자계정 관리</a></li>
              </ul>
            </li>
            <!-- <li> <a href="#"> <i class="icon-screen"> </i><span>Demo</span></a></li>
            <li> <a href="#"> <i class="icon-flask"> </i><span>Demo</span>
                <div class="badge badge-info">Special</div></a></li>
            <li> <a href=""> <i class="icon-flask"> </i><span>Demo</span></a></li>
            <li> <a href=""> <i class="icon-picture"> </i><span>Demo</span></a></li> -->
          </ul>
        </div>
        </sec:authorize>
        <!-- here is tag properties for security function -->
       <%--  principal : <sec:authentication property="principal"/>
			principal.username : <sec:authentication property="principal.username"/>
			principal.password : <sec:authentication property="principal.password"/>
			principal.email : <sec:authentication property="principal.email"/>
			principal.enabled : <sec:authentication property="principal.enabled"/>
			principal.accountNonExpired : <sec:authentication property="principal.accountNonExpired"/> --%>
        
      </div>
    </nav>
    <div class="page home-page">
      <!-- navbar-->
      <header class="header">
        <nav class="navbar">
          <div class="container-fluid">
            <div class="navbar-holder d-flex align-items-center justify-content-between">
              <div class="navbar-header"><a id="toggle-btn" href="#" class="menu-btn"><i class="icon-bars"> </i></a><a href="#" class="navbar-brand">
                  <div class="brand-text d-none d-md-inline-block"><span>SICC </span><strong class="text-primary"> GSP CONSOLE</strong></div></a></div>
              <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                
                <li class="nav-item">
                	<a href="#" class="nav-link logout">
                	<sec:authorize access="isAuthenticated()"><sec:authentication property="principal.username"/> 님 로그인 중</sec:authorize>
                	</a></li>
                
                <!-- <li class="nav-item dropdown"> <a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-bell"></i><span class="badge badge-warning">12</span></a>
                  <ul aria-labelledby="notifications" class="dropdown-menu">
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification d-flex justify-content-between">
                          <div class="notification-content"><i class="fa fa-envelope"></i>You have 6 new messages </div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification d-flex justify-content-between">
                          <div class="notification-content"><i class="fa fa-twitter"></i>You have 2 followers</div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification d-flex justify-content-between">
                          <div class="notification-content"><i class="fa fa-upload"></i>Server Rebooted</div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification d-flex justify-content-between">
                          <div class="notification-content"><i class="fa fa-twitter"></i>You have 2 followers</div>
                          <div class="notification-time"><small>10 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item all-notifications text-center"> <strong> <i class="fa fa-bell"></i>view all notifications                                            </strong></a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a id="messages" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-envelope"></i><span class="badge badge-info">10</span></a>
                  <ul aria-labelledby="notifications" class="dropdown-menu">
                    <li><a rel="nofollow" href="#" class="dropdown-item d-flex"> 
                        <div class="msg-profile"> <img src="img/avatar-1.jpg" alt="..." class="img-fluid rounded-circle"></div>
                        <div class="msg-body">
                          <h3 class="h5">Jason Doe</h3><span>sent you a direct message</span><small>3 days ago at 7:58 pm - 10.06.2014</small>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item d-flex"> 
                        <div class="msg-profile"> <img src="img/avatar-2.jpg" alt="..." class="img-fluid rounded-circle"></div>
                        <div class="msg-body">
                          <h3 class="h5">Frank Williams</h3><span>sent you a direct message</span><small>3 days ago at 7:58 pm - 10.06.2014</small>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item d-flex"> 
                        <div class="msg-profile"> <img src="img/avatar-3.jpg" alt="..." class="img-fluid rounded-circle"></div>
                        <div class="msg-body">
                          <h3 class="h5">Ashley Wood</h3><span>sent you a direct message</span><small>3 days ago at 7:58 pm - 10.06.2014</small>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item all-notifications text-center"> <strong> <i class="fa fa-envelope"></i>Read all messages    </strong></a></li>
                  </ul>
                </li> -->
                <li class="nav-item"><a href="/login" class="nav-link logout">Logout<i class="fa fa-sign-out"></i></a></li>
              </ul>
            </div>
          </div>
        </nav>
      </header>
      <!-- Counts Section -->
      
      
      
      <tiles:insertAttribute name="body" />
      
      
      
      
      <footer class="main-footer">
        <div class="container-fluid">
          <div class="row">
            <div class="col-sm-6">
              <p>SICC &copy; 2018-2019</p>
            </div>
            <div class="col-sm-6 text-right">
              <p>SICC <a href="/index" class="external">GSP CONSOLE</a></p>
              <!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions. Thank you for understanding :)-->
            </div>
          </div>
        </div>
      </footer>
    </div>

  </body>
</html>