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
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<title>Bookmarkit</title>

<script type="text/javascript">
	function disp() {
		$.ajax({

			url : "/cmpe/image",
			type : "POST",
			dataType : "HTML",
			asyc: false,
			success : function(data) {
			
			console.log('uploaded');
			}
		});
	}
</script>
</head>
<body style="background-color:#eee">

		<div>
	    <div id="projectTitle">
   		<h2 class="form-signin-heading" style="color:white">bookmarkIt</h2>
   		
   		<a href="/bookmarkit/login">
				<div id="btn-signin">
					Sign Out
		</div>
		</a>
		</div>
		
		</div>
		
		<div id="pinboard">
		<div class="addpin" id="addpin" data-toggle="modal" data-target="#myModal">
			<div class="add">
				<img src="<c:url value="/resources/images/push-btn.png" />" />
			</div>
			<div class="text">Create a Tack</div>
		</div>
		




	</div>
	
		
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Upload a tack from
							your computer:</h4>
					</div>
					<div class="modal-body">

						<form method="POST" id="addpinsform" enctype="multipart/form-data">
							File to upload: <input type="file" id="file2" name="file"><br />
							<input type="submit" value="Upload"> <input type="hidden"
								id="pinfrom" name="pinfrom" value="com">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</form>

						<div class="modal-footer"></div>

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
	
	$("#addpinsform").submit(
			function() {

				event.preventDefault();
				var $form = $(this);
				var pathArray = window.location.pathname.split('/');
				var existinguser = pathArray[2];
				var bname = pathArray[4];
				var $form = $(this);
				var imgName = $form.find("input[name='file']").val();
				alert(imgName);

				var hide = $form.find("input[name='pinfrom']").val();
				var file2 = document.getElementById('file2');

				var oMyForm = new FormData();
				oMyForm.append("file", file2.files[0]);

				$.ajax({
					url : '/bookmarkit/' + existinguser + '/boards/'
							+ bname,
					data : oMyForm,
					dataType : 'text',
					processData : false,
					contentType : false,
					type : 'POST',
					success : function() {
						/*var iDiv = document.createElement('a');
						iDiv.name = 'tack';
						iDiv.id = imgName;
						var uri = "/bookmarkit/" + existinguser
								+ "/boards/";
						iDiv.setAttribute('href', uri);
						iDiv.className = 'pins';
						$('#pinboard').append(iDiv);*/
						location.reload();
					},
					error : function() {
						alert("Invalid request");
					}
				});

			});

	
	
$(window).load(
		function() {
			wordsarray = [];

			var pathArray = window.location.pathname.split('/');
			var existinguser = pathArray[2];
			var bname = pathArray[4];
			$.ajax({

				url : "/bookmarkit/" + existinguser + "/boards/"
						+ bname + "/tacks",
				type : "GET",
				dataType : "JSON",
				asyc : false,
				success : function(data) {
					$.each(data, function(i, obj) {
						array = [];

						wordsarray.push(array);
						var iDiv = document.createElement('a');
						iDiv.id = obj.tid;
						$("<div class='boarddetails'>Cover Image</div><button onClick='viewB(this);' class='deleteboards btn-primary'>View</button><button name='abc' onclick='deleteB(this);'class='deleteboards btn-primary'>Delete</button>").appendTo(iDiv);
		 					var uri = "/bookmarkit/" + existinguser
								+ "/boards/" + bname + "/" + obj.tid;
						//iDiv.setAttribute('href', uri);
						iDiv.name = 'tacks';
						iDiv.className = 'pins';

						$('#pinboard').append(iDiv);
					});
				}
			});
		});
		
		
function viewB(el){
	var tid = $(el).parent().attr("id");
	alert(tid);
	var pathArray=window.location.pathname.split('/');
	var existinguser=pathArray[2];
	var bname = pathArray[4];
	window.location =  "/bookmarkit/"+existinguser+"/boards/"+bname+tid;
	
}

function deleteB(el){
	var bid=$(el).parent().attr("id");
	event.preventDefault();
	var pathArray=window.location.pathname.split('/');
	var existinguser=pathArray[2];
		$.ajax({
		  type: 'DELETE',
		  url: '/bookmarkit/'+existinguser+'/boards/'+bid,
		  success: function() {
				location.reload();
			  },
			error:function() {
				alert("Invalid request");
			}
	});
}
	</script>
</body>
</html>