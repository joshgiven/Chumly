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

<title>Create Profie</title>

</head>
<body>

	<jsp:include page="header.jsp" />

<!-- <script type="text/javascript">
	$(function() {

		var $cat = $("#state"), $subcat = $("#city");

		$cat.on("change", function() {
			var _rel = $(this).val();
			$subcat.find("option").attr("style", "");
			$subcat.val("");
			if (!_rel)
				return $subcat.prop("disabled", false);
			$subcat.find("[rel=" + _rel + "]").show();
			$subcat.prop("disabled", false);
		});

	});
</script> -->



	<div class="container">
		<h2>Edit User Information</h2>
		<form:form class="form-horizontal" action="updateProfile.do" method="POST" modelAttribute="profile">
			<div class="form-group">
				<form:label class="control-label col-sm-2" path="firstName" for="firstName">first name:</form:label>
				<div class="col-sm-10">
					<form:input type="text" class="form-control" path="firstName" id="firstName" placeholder="first name" value="${sessionUser.profile.firstName}" />
				</div>
				<form:label class="control-label col-sm-2" path="firstName" for="firstName"></form:label>
				<div class="col-sm-10">
					<form:errors class="form-control alert alert-danger" path="firstName" />
				</div>
			</div>
			<div class="form-group">
				<form:label class="control-label col-sm-2" path="lastName" for="lastName">last name:</form:label>
				<div class="col-sm-10">
					<form:input type="text" class="form-control" path="lastName"
						id="lastName" placeholder="last name" value="${sessionUser.profile.lastName}" />
				</div>
				<form:label class="control-label col-sm-2" path="lastName" for="lastName"></form:label>
				<div class="col-sm-10">
					<form:errors class="form-control alert alert-danger" path="lastName" />
				</div>
			</div>
			<div class="form-group">
				<form:label class="control-label col-sm-2" path="imageURL" for="imageURL">image url:</form:label>
				<div class="col-sm-10">
				<c:choose>
				<c:when test="${empty sessionUser.profile.imageURL}">
					<form:input type="text" class="form-control" path="imageURL"
						id="imageURL" value="https://robohash.org/default.jpg?size=50x50&set=set1" />
				</c:when>
				<c:otherwise>
					<form:input type="text" class="form-control" path="imageURL"
						id="imageURL" placeholder="image url" value="${sessionUser.profile.imageURL}"  />
				</c:otherwise>
				</c:choose>
				</div>
				<form:label class="control-label col-sm-2" path="imageURL" for="imageURL"></form:label>
				<div class="col-sm-10">
					<form:errors class="form-control alert alert-danger" path="imageURL" />
				</div>
			</div>
			
			<div class="form-group">
				<form:label class="control-label col-sm-2" path="description" for="description">description:</form:label>

				<div class="col-sm-10">
<%-- 
					<textarea class="form-control" id="description" placeholder="description" rows="5" >
					<c:out value="${sessionUser.profile.description}" default="WTF?"/>
					</textarea>
 --%>
 					<c:set var="profile.description" value="${sessionUser.profile.description}" />
					<form:textarea class="form-control" path="description" id="description" placeholder="description" rows="5" />
				</div>
				<form:label class="control-label col-sm-2" path="description" for="description"></form:label>
				<div class="col-sm-10">
					<form:errors class="form-control alert alert-danger" path="description" />
				</div>
			</div>

			
			
			<div class="form-group">
				<div class="col-sm-10">
 				<label class="control-label col-sm-2" for="locationId">location:</label>
 				<div class=" col-sm-4">
				<select class="form-control" name="locationId" >
					<c:forEach var="loc" items="${location}">
						<c:set var="state" value="${loc.key}" />
						<c:set var="locs"  value="${loc.value}" />
						<c:forEach var="city" items="${locs}">
							<option value="${city.id}">${city.state} - ${city.city}</option>
						</c:forEach>
					</c:forEach>
				</select>
 				</div>
				</div>
			</div>
			

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">Submit</button>
				</div>
			</div>
		</form:form>
	</div>


	<jsp:include page="footer.jsp" />
</body>
</html>