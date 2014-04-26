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
<form class="form-horizontal" method="post" action="/doit/logout/" ModelAttribute="session">
<h1>
	Hello world!  
	Your Token is, ${token}
</h1>

<P>  You are logged in Successfully!. </P>
<div class="control-group">
    <div class="controls">
      <button type="submit" class="btn">Sign Out</button>
    </div>
    <input type="hidden" name="token" value="${token}">
  </div>
  </form>
</body>
</html>