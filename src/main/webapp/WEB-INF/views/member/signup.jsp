<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
.or{
  position: relative;
}
.or:before{
  content: '';
  height: 1px;
  background: linear-gradient(to right,silver,silver,rgba(255,255,255,0),rgba(255,255,255,0),silver,silver);
  position: absolute;
  left: 0;
  top: 50%;
  width: 100%;
  z-index: 0;
}
</style>

<div id="main_container">
	<section class="py-4">
	  <div class="container">
	    <div class="row d-flex align-items-center justify-content-center">
	      <div style="max-width:420px;">
	        <form action="#" class="bg-white border py-4 px-5" method="get">
	          <div class="text-center mb-3">
	            <i class="fab fa-bootstrap fa-5x text-secondary mb-2"></i>
	            <p class="text-muted fw-bold">
	              회원가입
	            </p>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" name="email" placeholder="Mobile Number or Email" required="" type="email" /><label>Mobile Number or Email</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" name="fullname" placeholder="Full Name" required="" type="text" /><label>Full Name</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" name="username" placeholder="Username" required="" type="text" /><label>Username</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" name="password" placeholder="Password" required="" type="password" /><label>Password</label>
	          </div>
	          <div class="mb-2">
	            <button class="btn btn-primary fw-bold w-100 bg-gradient" href="#" type="submit">Sign Up</button>
	          </div>
	        </form>
	        <div class="bg-white py-4 px-5 text-center border mt-4">
	          <p class="m-0">
	            계정이 존재하나요? <a href="/member/login">Log In</a>
	          </p>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
</div>

			
</body>

<script>
$(document).ready(function() {
	
});
</script>
</html>