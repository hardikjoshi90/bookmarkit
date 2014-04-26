<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="<c:url value="/resources/css/bootstrap-responsive.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/fixed-top.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/login.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
	
<title>Insert title here</title>
</head>
<body>
<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
  FB.init({
    appId      : '684460474944601',
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });

  // Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
  // for any authentication related change, such as login, logout or session refresh. This means that
  // whenever someone who was previously logged out tries to log in again, the correct case below 
  // will be handled. 
  FB.Event.subscribe('auth.authResponseChange', function(response) {
    // Here we specify what we do with the response anytime this event occurs. 
    if (response.status === 'connected') {
      // The response object is returned with a status field that lets the app know the current
      // login status of the person. In this case, we're handling the situation where they 
      // have logged in to the app.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // In this case, the person is logged into Facebook, but not into the app, so we call
      // FB.login() to prompt them to do so. 
      // In real-life usage, you wouldn't want to immediately prompt someone to login 
      // like this, for two reasons:
      // (1) JavaScript created popup windows are blocked by most browsers unless they 
      // result from direct interaction from people using the app (such as a mouse click)
      // (2) it is a bad experience to be continually prompted to login upon page load.
    	FB.login(function(response){});
    } else {
      // In this case, the person is not logged into Facebook, so we call the login() 
      // function to prompt them to do so. Note that at this stage there is no indication
      // of whether they are logged into the app. If they aren't then they'll see the Login
      // dialog right after they log in to Facebook. 
      // The same caveats as above apply to the FB.login() call here.
      FB.login(function(response){});
    }
  });
  };

  // Load the SDK asynchronously
  (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
  }(document));

  // Here we run a very simple test of the Graph API after login is successful. 
  // This testAPI() function is only called in those cases. 
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Good to see you, ' + response.name + '.');
    });
  }
  
  FB.login(function(response) {
	    if (response.authResponse) {
	    	$.ajax({
	    		  type: "POST",
	    		  url: "http://localhost:8080/welcome",
	    		  data: data,
	    		  success: success,
	    		  dataType: "json"
	    		});
	    } else {
	        // The person cancelled the login dialog
	    }
	});
</script>
 <form class="form-horizontal" method="post" action="/doit/login/" ModelAttribute="login">
  <div class="navbar navbar-fixed-top navbar-inverse" role="navigation"> <!-- Navbar -->
 		<div class="navbar-header">
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
 				<li><a href="#">DoIt</a></li>
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
 	</div>	<!-- navbar ends -->
</div>
 <div class="container"> <!-- container -->
<div class="container login">
    <div class="row ">
        <div class="center span4 well">
            <legend>Please Sign In</legend>
            <input type="text" id="username"  name="username" placeholder="Username" />
            <input type="password" id="password" name="password" placeholder="Password" />
            <label class="checkbox">
                <input type="checkbox" name="remember" value="1" /> Remember Me
            </label>
            <button type="submit" name="submit" class="btn btn-primary btn-block">Sign in</button>
            <br>
            <fb:login-button show-faces="true" width="200" max-rows="2">Connect With Facebook</fb:login-button>
        </div>
    </div>
</div>
<p class="text-center muted ">&copy; Copyright 2013 - Powered by Hardik Joshi</p>
<!-- Main Container Ends -->

<!-- Contact Us Model Box -->
<div id="contact" class="modal hide fade in" style="display: none; ">
<div class="modal-header">
<a class="close" data-dismiss="modal">×</a>
<h3>Contact Us</h3>
</div>
<div class="modal-body">
<form>
      <div class="controls controls-row">
          <input id="name" name="name" type="text" class="span3" placeholder="Name" />
      </div>
 
       <div class="controls controls-row">
       <input id="email" name="email" type="email" class="span3" placeholder="Email address" />
       </div>
 
      <div class="controls">
          <textarea id="message" name="message" class="span5" placeholder="Your Message" rows="5"></textarea>
      </div>
 
  </form>
</div>
 
<div class="modal-footer">
<a href="#" class="btn btn-primary">Submit</a>
<a href="#" class="btn" data-dismiss="modal">Close</a>
</div>
</div>
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
 
 
 <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
 
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

<script type='text/javascript' src="http://imsky.github.io/holder/holder.js"></script>

</form>
</body>
</html>