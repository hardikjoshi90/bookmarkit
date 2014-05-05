<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="<c:url value="/resources/css/bootstrap-responsive.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/style.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<title>Insert title here</title>
</head>
<body  style="background-color:#eee">



	
		<div>
	    <div id="projectTitle">
   		<h2 class="form-signin-heading">bookmarkIt</h2>
   		
   		<a href="/bookmarkit/login">
				<div id="btn-signin">
					Sign Out
		</div>
		</a>
		</div>
		
		</div>
	
	<div id="publicboard">
		<div class="board" id="addboard" data-toggle="modal" data-target="#myModal">
			<div class="add">
				<img src="<c:url value="/resources/images/push-btn.png" />" />
			</div>
			<div class="text">Create a board</div>
		</div>
		
		
	</div>

	
	<div id="privateboard">
		<div class="board" id="addpriboard" data-toggle="modal" data-target="#myModal1">
			<div class="add">
				<img src="<c:url value="/resources/images/push-btn.png" />" />
			</div>
			<div class="text">Create a Private board</div>
		</div>
	</div>

	<div class="container">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Add a public Board:</h4>
					</div>
					<form role="form" method="post" id="pubBoard">
					<div class="modal-body">
						
							<div class="form-group">
								<input type="hidden" name="secret" value="false" /> <label
									for="banme">Board Name</label> <input type="text"
									class="form-control" name="bname"
									placeholder="Enter Board name">
							</div>
							<div class="form-group">
								<label for="bdescription">Board Description</label>
								<textarea class="form-control" rows="3" name="bdescription"
									placeholder="Enter Board description"></textarea>
							</div>
							<div class="form-group">
								<label for="category">Select Category</label> <select
									class="form-control" name="category">
									<option>Education</option>
									<option>Technology</option>
									<option>Art</option>
									<option>Design</option>
									<option>Geek</option>
								</select>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<input type="submit" value="Submit" class="btn btn-default"/>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
	</div>
	<div class="container" >
		<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Add a private
							Board:</h4>
					</div>
					<div class="modal-body">
						<form role="form" method="post" id="priBoard">
							<div class="form-group">
								<input type="hidden" name="secret" value="true" /> <label
									for="banme">Board Name</label> <input type="text"
									class="form-control" name="bname" placeholder="Enter Board name">
							</div>
							<div class="form-group">
								<label for="bdescription">Board Description</label>
								<textarea class="form-control" rows="3" name="bdescription"
									placeholder="Enter Board description"></textarea>
							</div>
							<div class="form-group">
								<label for="category">Select Category</label> <select
									class="form-control" name="category">
									<option>Education</option>
									<option>Technology</option>
									<option>Art</option>
									<option>Design</option>
									<option>Geek</option>
								</select>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<input type="submit" value="Submit" class="btn btn-default"/>
						</form>
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
	<script type="text/javascript" src="http://www.ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>	
	<script type="text/javascript">
	
	$("#pubBoard").submit(function(){
		event.preventDefault();
		var $form = $( this );
		var pathArray=window.location.pathname.split('/');
		var existinguser=pathArray[2];
		var bname = $form.find( "input[name='bname']" ).val();
		var formdata = $form.serialize();
		$.ajax({
			  type: 'POST',
			  data:formdata,
			  url: '/bookmarkit/'+existinguser+'/boards',
			  success: function() {
				  /*	var iDiv = document.createElement('a');
					iDiv.name = 'boardpub';
					iDiv.id = bname;
					iDiv.className = 'board1';
					var uri = "/bookmarkit/"+existinguser+"/boards/"+bname;
					//iDiv.setAttribute('href', uri);
					iDiv.setAttribute('text-align','center');
					$("<div class='boarddetails'></div><button class='deleteboards btn-primary'>Delete</button>").appendTo(iDiv);
					$('#publicboard').append(iDiv);*/
					location.reload();
				  },
				error:function() {
					alert("Invalid request");
				}
		});
	});
	
$("#priBoard").submit(function(){
		
		event.preventDefault();
		var $form = $( this );
		var pathArray=window.location.pathname.split('/');
		var existinguser=pathArray[2];
		var $form = $( this );
		var bname = $form.find( "input[name='bname']" ).val();
		var formdata = $form.serialize();
		$.ajax({
			  type: 'POST',
			  data:formdata,
			  url: '/bookmarkit/'+existinguser+'/boards',
			  success: function() {
				  	/*var iDiv = document.createElement('a');
					iDiv.name = 'boardpri';
					iDiv.id = bname;
					var uri = "/bookmarkit/"+existinguser+"/boards/"+bname;
					//iDiv.setAttribute('href', uri);
					iDiv.setAttribute('text-align','center');
					iDiv.className = 'board1';
					$("<div class='boarddetails'></div><button class='deleteboards btn-primary'>Delete</button>").appendTo(iDiv);
					$('#privateboard').append(iDiv);*/
					location.reload();
				  },
				error:function() {
					alert("Invalid request");
				}
		});
	});
	
var iDiv;
$( window ).load(function() {
	wordsarray= [];
	
	var pathArray=window.location.pathname.split('/');
	var existinguser=pathArray[2];
	$.ajax({

		url : "/bookmarkit/"+existinguser+"/boards/details",
		type : "GET",
		dataType : "JSON",
		asyc : false,
		success : function(data) {
			$.each(data, function(i, obj) {
				array = [];
				array.push(obj.name);
				wordsarray.push(array);
				iDiv = document.createElement('a'); 
				iDiv.innerHTML = obj.name;
				iDiv.id = obj.name;
				$("<div class='boarddetails'>Cover Image</div><button onClick='viewB(this);' class='deleteboards btn-primary'>View</button><button name='abc' onclick='deleteB(this);'class='deleteboards btn-primary'>Delete</button>").appendTo(iDiv);
				var uri = "/bookmarkit/"+existinguser+"/boards/"+obj.name;
				/*iDiv.setAttribute('href', uri);*/
				iDiv.setAttribute('text-align','center');
				iDiv.name = 'boardpub';
				iDiv.className = 'board1';
				if(obj.isPrivate){
					$('#privateboard').append(iDiv); 
				}
				else{
					
					$('#publicboard').append(iDiv);
				}
			});		
		}
	});
});
	$(window).ready(function(){
		
	});
	
	
	function viewB(el){
		var bid = $(el).parent().attr("id");
		var pathArray=window.location.pathname.split('/');
		var existinguser=pathArray[2];
		window.location =  "/bookmarkit/"+existinguser+"/boards/"+bid;
		
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