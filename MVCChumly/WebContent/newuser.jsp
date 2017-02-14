<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
				return $subcat.prop("disabled", true);
			$subcat.find("[rel=" + _rel + "]").show();
			$subcat.prop("disabled", false);
		});

	});
</script>
</head>
<body>
	<form:form action="login.do" method="POST" modelAttribute="user">
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
		<form:label path="firstName">First Name:</form:label>
		<form:input path="firstName" />
		<form:errors path="firstName" />
		<br />
		<form:label path="lastName">Last Name:</form:label>
		<form:input path="lastName" />
		<form:errors path="lastName" />
		<br />
		<form:label path="description">Description:</form:label>
		<form:input path="description" />
		<form:errors path="description" />
		<br />
		<form:label path="imageURL">Image URL:</form:label>
		<form:input path="imageURL" />
		<form:errors path="imageURL" />
		<br />
		<select name="state" id="state">
			<option value="">Select State</option>
			<c:forEach var="s" items="${location}">
				<option value="state">${s.key}</option>
			</c:forEach>
		</select>
		<br>
		<select disabled="disabled" name="city" id="city">
			<option value="">Select City</option>
			<c:forEach var="c" items="${location}">
				<option release="${c.key}" value="city">${c.value}</option>
			</c:forEach>
		</select>
		<input type="submit" value="Login" />
	</form:form>
</body>
</html>