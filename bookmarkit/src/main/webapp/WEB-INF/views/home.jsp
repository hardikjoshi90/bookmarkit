<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
</head>

<body>
<div id="wrapper"	>
 	<!-- <div class="navbar navbar-fixed-top navbar-inverse" role="navigation"> --> <!-- Navbar -->
 	<!--  	<div class="navbar-header">
 			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
 			<span class="sr-only">Toggle Navigation</span>
 			<span class="icon-bar"></span>
 			<span class="icon-bar"></span>
 			<span class="icon-bar"></span>
 			</button>
 			<a class="navbar-brand" href="#">Project Name</a>
 		</div>
 		<div class="navbar-collapse collapse">
 			<ul class="nav navbar-nav">
 				<li class="active"><a href="#">Home</a></li>
 				<li><a href="#">DoIt1</a></li>
 				<li><a data-toggle="modal" href="#myModal" >Contact Us</a></li>
 				<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li class="divider"></li>
            <li><a href="#">One more separated link</a></li>
          </ul>
          
        </li>
 			</ul>
 			<form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
      <form class="navbar-form navbar-right" role="search">
       
     <a href="http://localhost:8080/bookmarkit/login" class="btn btn-link">Sign In</a>
      </form>
 		</div>
 	</div>-->	<!-- navbar ends -->
 	
 	<div class="container">
 	 <!-- container -->
 	 
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    <form class="form-horizontal">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Contact Us:</h4>
      </div>
      <div class="modal-body">
        <div class="fomr-group">
        	<label class="col-lg-2 control-label" for="contact-name">Name:</label>
        	<div class="col-lg-10">
        		<input type="text" class="form-control" id="contact-name" placeholder="Full Name">
        	</div>
        </div>
         
        <div class="fomr-group">
        	<label class="col-lg-2 control-label" for="contact-name">Email:</label>
        	<div class="col-lg-10">
        		<input type="text" class="form-control" id="contact-email" placeholder="you@example.com">
        	</div>
        </div>
        
        <div class="fomr-group">
        	<label class="col-lg-2 control-label" for="contact-msg">Message:</label>
        	<div class="col-lg-10">
        		<textarea class="form-control" rows="8"></textarea>
        	</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
      </form>
    </div>
  </div>
</div>
 </div> <!-- container ends -->

 
 <div id="signup">
 <div id="btn-signin">
  <a href="http://localhost:8080/bookmarkit/login">Log In</a>
 
  </div>
 		<h1 class="form-signin-heading">bookmarkIt</h1>
        <h3 class="form-signin-heading">Create your own world.Share things you love.</h3>
 	<form class="form-signin" role="form" method="POST" action="/bookmarkit/signUp">
        
       	 <input type="email" class="form-control" name="email" placeholder="Email address" required autofocus>
         <input type="text" class="form-control" name="uname" placeholder="Username" required>
         <input type="text" class="form-control" name="fname" placeholder="First Name" required>
         <input type="text" class="form-control" name="lname" placeholder="Last Name" required>
        
         <input type="password" class="form-control" name="password" placeholder="Password" required>
         Gender:
         <input type="radio" name="gender" value="male">Male &nbsp;&nbsp;
		 <input type="radio" name="gender" value="female">Female
        
      
        <button class="btn btn-lg btn-primary btn-block btn-signup" type="submit">Sign up</button>
      </form>
   </div>   
   <div id="mac">
  	<img src="<c:url value="/resources/images/1.jpg" />" class="img1" width="100%" height="100%">
  	<img src="<c:url value="/resources/images/2.jpg" />" class="img2" width="100%" height="100%">
  	<img src="<c:url value="/resources/images/3.jpg" />" class="img3" width="100%" height="100%">
  	<img src="<c:url value="/resources/images/4.jpg" />" class="img4" width="100%" height="100%">
  	<img src="<c:url value="/resources/images/5.jpg" />" class="img5" width="100%" height="100%">
  	<img src="<c:url value="/resources/images/6.jpg" />" class="img6" width="100%" height="100%">
   </div>
</div> <!-- wrapper ends --> 
 
 
 <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
 
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

<script type='text/javascript' src="http://imsky.github.io/holder/holder.js"></script>


</body>
</html>
