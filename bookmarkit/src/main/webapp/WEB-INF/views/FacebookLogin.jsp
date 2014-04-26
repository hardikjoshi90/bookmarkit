<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
</head>
<body>
<div id="fb-root"></div>
<div id="account-info"></div>
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
      console.log(response.authResponse.accessToken);
      showAccountInfo();

     // window.open('http://localhost:8080//doit/welcome?token='+response.authResponse.accessToken);

     //testAPI();
    } else if (response.status === 'not_authorized') {
      // In this case, the person is logged into Facebook, but not into the app, so we call
      // FB.login() to prompt them to do so. 
      // In real-life usage, you wouldn't want to immediately prompt someone to login 
      // like this, for two reasons:
      // (1) JavaScript created popup windows are blocked by most browsers unless they 
      // result from direct interaction from people using the app (such as a mouse click)
      // (2) it is a bad experience to be continually prompted to login upon page load.
      FB.login();
    } else {
      // In this case, the person is not logged into Facebook, so we call the login() 
      // function to prompt them to do so. Note that at this stage there is no indication
      // of whether they are logged into the app. If they aren't then they'll see the Login
      // dialog right after they log in to Facebook. 
      // The same caveats as above apply to the FB.login() call here.
      FB.login();
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
  
  function showAccountInfo() {
	  FB.api(
	    {
	      method: 'fql.query',
	      query: 'SELECT name, pic_square FROM user WHERE uid='+FB.getUserID()
	    },
	    function(response) {
	      Log.info('API Callback', response);
	      document.getElementById('account-info').innerHTML = (
	        '<img src="' + response[0].pic_square + '"> ' +
	        response[0].name +
	        ' <button class="btn" onclick="FB.logout()">Logout</button>'
	      );
	    }
	  );
	}



	function showLoginButton() {
	  document.getElementById('account-info').innerHTML = (
	    '<button class="btn btn-primary" onclick="FB.login()">Login</button>'
	  );
	}



	function onStatus(response) {
	  Log.info('onStatus', response);
	  if (response.status === 'connected') {
	    showAccountInfo();
	  } else {
	    showLoginButton();
	  }
	}
	FB.getLoginStatus(function(response) {
	  onStatus(response); 
	  FB.Event.subscribe('auth.statusChange', onStatus); 
	});
</script>
<fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>
</body>
</html>