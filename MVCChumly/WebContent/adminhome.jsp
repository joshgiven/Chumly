<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
	<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/fonts/ionicons.min.css">
	<link rel="stylesheet" href="assets/css/styles.min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/fonts/ionicons.min.css">
	<link rel="stylesheet" href="assets/css/styles.min.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<title>Admin Control Panel</title>
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="container">
		<h2>Admin Control Panel</h2>
		<p></p>

		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#users">Users</a></li>
			<li><a data-toggle="tab" href="#interests">Interests</a></li>
			<li><a data-toggle="tab" href="#locations">Locations</a></li>
		</ul>


		<div class="tab-content">
			<div id="users" class="tab-pane fade in active">
				<h3>Users</h3>
				<p>Visit a User</p>
				<form action="getOtherUserProfileInformation.do" method=GET>
					<select name="id">
						<c:forEach var="user" items="${users}">
							<option value="${user.id}">
								${user.profile.firstName} ${user.profile.lastName}
							</option>
						</c:forEach>
					</select>
					<%-- 		<input type="hidden" value="${user.id}" name="id"> --%>
					<input type="submit" value="Go to User">
				</form>

			</div>
			<div id="interests" class="tab-pane fade">
				<h3>Interests</h3>
				<p>Add an Interest</p>
				<form action="createInterest.do" method=POST>
					<select name="id">
						<c:forEach var="cat" items="${categories}">
							<option value="${cat.id}">${cat.name}</option>
						</c:forEach>
					</select> <input type="text" name="interest"> <input type="submit"
						value="Add Interst">
				</form>

			</div>
			<div id="locations" class="tab-pane fade">
				<h3>Locations</h3>
				<p>Sed ut perspiciatis unde omnis iste natus error sit
					voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
			</div>
		</div>
	</div>


</body>
</html>