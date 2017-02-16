<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/fonts/ionicons.min.css">
<link rel="stylesheet" href="assets/css/styles.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>New User</title>

</head>
<body>

	<jsp:include page="header.jsp" />


	<div class="container">
		<h2>Create a new User</h2>
		<form:form class="form-horizontal" action="makeUser.do" method="POST" modelAttribute="user">
			<div class="form-group">
				<form:label class="control-label col-sm-2" path="email" for="email">email:</form:label>
				<div class="col-sm-10">
					<form:input type="email" class="form-control" path="email" id="email" placeholder="Enter email" />
				</div>
				<form:label class="control-label col-sm-2" path="email" for="email"></form:label>
				<div class="col-sm-10">
					<form:errors class="form-control alert alert-danger" path="email" />
				</div>
			</div>
			<div class="form-group">
				<form:label class="control-label col-sm-2" path="username" for="username">username:</form:label>
				<div class="col-sm-10">
					<form:input type="text" class="form-control" path="username"
						id="username" placeholder="Enter username" />
				</div>
				<form:label class="control-label col-sm-2" path="username" for="username"></form:label>
				<div class="col-sm-10">
					<form:errors class="form-control alert alert-danger" path="username" />
				</div>
			</div>
			<div class="form-group">
				<form:label class="control-label col-sm-2" path="password" for="password">password:</form:label>
				<div class="col-sm-10">
					<form:input type="password" class="form-control" path="password"
						id="password" placeholder="Enter password" />
				</div>
				<form:label class="control-label col-sm-2" path="password" for="password"></form:label>
				<div class="col-sm-10">
					<form:errors class="form-control alert alert-danger" path="password" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">Submit</button>
				</div>
			</div>
			
			<input type="hidden" name="id" value="${sessionUser.id}">
		</form:form>
	</div>



 </body>

<jsp:include page="footer.jsp" />

</html>
