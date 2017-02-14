<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New User</title>
<script type="text/javascript">
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
</script>
<link rel="styleSheet" type="text/css" href="/style.css">
</head>
<body>
	<form:form action="makeUser.do" method="POST" modelAttribute="user">
		<form:label path="email">Email:</form:label>
		<form:input path="email" />
		<form:errors path="email" />
		<br>
		<form:label path="username">UserName:</form:label>
		<form:input path="username" />
		<form:errors path="username" />
		<br />
		<form:label path="password">Password:</form:label>
		<form:input path="password" />
		<form:errors path="password" />
		<br />
		<form:label path="profile.firstName">First Name:</form:label>
		<form:input path="profile.firstName" />
		<form:errors path="profile.firstName" />
		<br />
		<form:label path="profile.lastName">Last Name:</form:label>
		<form:input path="profile.lastName" />
		<form:errors path="profile.lastName" />
		<br />
		<form:label path="profile.description">Description:</form:label>
		<form:input path="profile.description" />
		<form:errors path="profile.description" />
		<br />
		<form:label path="profile.imageURL">Image URL:</form:label>
		<form:input path="profile.imageURL" />
		<form:errors path="profile.imageURL" />
		<br />
		<select name="state" id="state">
			<option value="">Select State</option>
			<c:forEach var="s" items="${location}">
				<option value="state">${s.key}</option>
		</c:forEach>
		</select>
		<select name="city" id="city">
			<option value="">Select City</option>
		<c:forEach var="c" items="${location}">
			<c:set var="st" value="${c.key}"></c:set>
			<c:forEach var="loc" items= "${c.value}">
				<option rel="${c.key}" value="${loc.id}">${loc.city}</option>
			</c:forEach>
			</c:forEach>
		</select>
		<input type="submit" value="Login" />
	</form:form>
</body>
</html>