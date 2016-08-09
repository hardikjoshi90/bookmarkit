<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="<c:url value="/resources/css/bootstrap-responsive.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/login.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
	
<title>Bookmarkit</title>
</head>
<body>
<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
  FB.init({
    appId      : '',
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
 
 <div class="container"> <!-- container -->

    
<!-- Main Container Ends -->


 


 </div> <!-- container ends -->
 
 
 <div id="signup">
 		<h1 class="form-signin-heading">bookmarkIt</h1>
        <h3 class="form-signin-heading">Create your own world.Share things you love.</h3>
 	<form class="form-signin" role="form" method="post" action="/bookmarkit/login">
         <input type="text" class="form-control" name="username" placeholder="Username" required autofocus>
       	 <input type="password" class="form-control" name="password" placeholder="Password" required>
        
        <button class="btn btn-lg btn-primary btn-block btn-signup" type="submit">Sign in</button>
      <br/>
      <fb:login-button show-faces="true" width="200" max-rows="2">Connect With Facebook</fb:login-button>
  	</form>
   </div>   
   <div>
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

</form>
</body>
</html>
