<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <link href="<c:url value="/resources/css/bootstrap-responsive.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/bootstrap-responsive.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<title>Insert title here</title>
</head>
<body>
<form class="form-horizontal" method="post" action="/bookmarkit/signUp/" ModelAttribute="signUp">
  <div class="control-group">
    <label class="control-label" for="inputUsername">Username</label>
    <div class="controls">
      <input type="text" id="inputUsername" name="username">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="inputPassword">Password</label>
    <div class="controls">
      <input type="password" id="inputPassword" name="password">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="inputVerifiedPassword">Verify Password</label>
    <div class="controls">
      <input type="password" id="inputVerifiedPassword" name="VerifiedPassword">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="inputEmail">Email</label>
    <div class="controls">
      <input type="text" id="inputEmail" name="email">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="inputFname">First Name</label>
    <div class="controls">
      <input type="text" id="inputFname" name="fname">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="inputLname">Last Name</label>
    <div class="controls">
      <input type="text" id="inputLname" name="lname">
    </div>
  </div>
  <div class="radio">
  <label>
    <input type="radio" name="male" id="male" value="option1" checked>
    Male
  </label>
</div>
<div class="radio">
  <label>
    <input type="radio" name="female" id="female" value="option2">
    Female
  </label>
</div>
  <div class="control-group">
    <div class="controls">
      <button type="submit" class="btn">Sign Up</button>
    </div>
  </div>
</form>
</body>
</html>