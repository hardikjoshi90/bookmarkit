<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="<c:url value="/resources/css/bootstrap-responsive.css" />"
	rel="stylesheet">
<link
	href="<c:url value="/resources/css/bootstrap-responsive.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap.css" />"
	rel="stylesheet">
	<link href="<c:url value="/resources/css/style.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<title>Insert title here</title>


</head>
<body style="background-color:#eee">
	<input type="hidden" name="uname" value="${uname}">
	
		
      <form class="navbar-form navbar-right" role="search"> -->

				<a href="http://localhost:8080/bookmarkit/login"
					class="btn btn-link">Sign Out</a>
			</form>

	<div>
	    <h1 class="ribbon">
   		<strong class="ribbon-content">bookmarkIt</strong>
		</h1>
		
		</div>
		
		<div id="tackdetails">
		
		<div class
		
		
		</div>
		

	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Create New Tacks:</h4>
				</div>
				<div class="modal-body">
							
					<form method="POST" id="addpinsform" enctype="multipart/form-data">
						File to upload: <input type="file" name="file"><br />
						<input	type="submit" value="Upload"> Press here to upload the file!
					 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</form>

					<div class="modal-footer">
					
						
					</div>

				</div>
			</div>
		</div>
	</div>


	</div>
	<script src="http://code.jquery.com/jquery-latest.min.js"
		type="text/javascript"></script>

	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

	<script type='text/javascript'
		src="http://imsky.github.io/holder/holder.js"></script>
		
	<script type= "text/javascript">
	
$("#addpinsform").submit(function(){
		
		event.preventDefault();
		var $form = $( this );
		var pathArray=window.location.pathname.split('/');
		var existinguser=pathArray[2];
		var bname = pathArray[4];
		var $form = $( this );
		var imgName = $form.find( "input[name='file']" ).val();
		alert(imgName);
		var formdata = $form.serialize();
		$.ajax({
			  type: 'POST',
			  data:formdata,
			  url: '/bookmarkit/'+existinguser+'/boards/'+bname,
			  success: function() {
				  	var iDiv = document.createElement('a');
					iDiv.name = 'tack';
					iDiv.id = imgName;
					var uri = "/bookmarkit/"+existinguser+"/boards/"+imgName;
					iDiv.setAttribute('href', uri);
					iDiv.className = 'pins';
					$('#pinboard').append(iDiv);
					window.reload();
				  },
				error:function() {
					alert("Invalid request");
				}
		});
	});
	
	
	
	$( window ).load(function() {
		wordsarray= [];
		
		var pathArray=window.location.pathname.split('/');
		var existinguser=pathArray[2];
		var bname= pathArray[4];
		$.ajax({

			url : "/bookmarkit/"+existinguser+"/boards/"+bname+"/tacks",
			type : "GET",
			dataType : "JSON",
			asyc : false,
			success : function(data) {
				$.each(data, function(i, obj) {
					array = [];
				
					wordsarray.push(array);
					var iDiv = document.createElement('a'); 
					iDiv.innerHTML = obj.imgUrl;
					iDiv.id = obj.imgUrl;
					var uri = "/bookmarkit/"+existinguser+"/boards/"+bname+"/"+obj.tid;
					iDiv.setAttribute('href', uri);
					iDiv.name = 'tacks';
					iDiv.className = 'pins';
					
					$('#pinboard').append(iDiv);
				});		
				alert(wordsarray);
			}
		});
	});
	</script>
</body>
</html>