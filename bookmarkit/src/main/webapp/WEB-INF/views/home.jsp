<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="<c:url value="/resources/css/fixed-top.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
</head>

<body>
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
 	</div>	<!-- navbar ends -->
 	
 	<div class="container"> <!-- container -->
 	 <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="item active">
          <img src="<c:url value="/resources/images/1.jpg" />" alt="First slide" class="img-responsive">
          <div class="container">
            <div class="carousel-caption">
              <h1>Example headline.</h1>
              <p>Note: If you're viewing this page via a <code>file://</code> URL, the "next" and "previous" Glyphicon buttons on the left and right might not load/display properly due to web browser security rules.</p>
              <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
            </div>
          </div>
        </div>
        <div class="item">
          <img src="<c:url value="/resources/images/2.jpg" />" alt="Second slide" class="img-responsive">
          <div class="container">
            <div class="carousel-caption">
              <h1>Another example headline.</h1>
              <p>Hardik Joshi</p>
              <p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
            </div>
          </div>
        </div>
        <div class="item">
          <img src="<c:url value="/resources/images/3.jpg" />" alt="Third slide" class="img-responsive">
          <div class="container">
            <div class="carousel-caption">
              <h1>One more for good measure.</h1>
              <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
              <p><a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a></p>
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
      <a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
    </div><!-- /.carousel -->
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

	
</body>
</html>
