<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<section class="charts">
        <div class="container-fluid">
          <header> 
            <h1 class="h3">User Information</h1>
          </header>
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h2 class="h5 display">List of user's access info</h2>
                </div>
                <div class="card-body">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>User Id</th>
                        <th>User Name</th>
                        <th>User Email</th>
                        <th>User Roles</th>
                      </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${memberList}" var="member" varStatus="parent">
	                   <tr>
	                     <th scope="row">${parent.count}</th>
	                     <td>${member.adminId}</td>
	                     <td>${member.adminNm}</td>
	                     <td>${member.emailAddr}</td>
	                     <td>${member.adminPrivCd}</td>
	                   </tr>
                    </c:forEach>  
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>