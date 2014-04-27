<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="<c:url value="/resources/css/bootstrap-responsive.css" />"
	rel="stylesheet">
<link
	href="<c:url value="/resources/css/bootstrap-responsive.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<title>Insert title here</title>
</head>
<body>
	<form class="form-horizontal" method="post"
		action="/bookmarkit/logout/" ModelAttribute="session">
		<h1>Hello world! Your Token is, ${token}</h1>

		<P>You are logged in Successfully!.</P>
		<a data-toggle="modal" href="#myModal"><img
			src="<c:url value="/resources/images/pin.JPG" />"
			class="img-responsive" alt="Responsive image"></a>
		<div class="control-group">
			<div class="controls">
				<button type="submit" class="btn">Sign Out</button>
			</div>
			<input type="hidden" name="token" value="${token}">
		</div>
	</form>
	<div class="container">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<form class="form-horizontal">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Add a Pin From:</h4>
						</div>
						<div class="modal-body">
							<img src="<c:url value="/resources/images/com.JPG" />" alt="" class="img-rounded"> 
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="http://code.jquery.com/jquery-latest.min.js"
		type="text/javascript"></script>

	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

	<script type='text/javascript'
		src="http://imsky.github.io/holder/holder.js"></script>
</body>
</html>