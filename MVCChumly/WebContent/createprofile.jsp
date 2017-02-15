<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<link rel="styleSheet" type="text/css" href="/style.css">
</head>
<body>
<form:form action="updateProfile.do" method="POST" modelAttribute="profile">
	<form:label path="firstName">First Name:</form:label>
		<form:input path="firstName" />
		<form:errors path="firstName" />
		<br />
		<form:label path="lastName">Last Name:</form:label>
		<form:input path="lastName" />
		<form:errors path="lastName" />
		<br />
		<form:label path="description">Description:</form:label>
		<form:textarea rows="4" cols="50" path="description" />
		<form:errors path="description" />
		<br />
		<form:label path="imageURL">Image URL:</form:label>
		<form:input path="imageURL" />
		<form:errors path="imageURL" />
		<br />
		<select name="locationId">
		<c:forEach var="loc" items="${locations}">
		<option value="${loc.id}">${loc.city}, ${loc.state}</option></c:forEach></select>
		<%-- <select name="state" id="state">
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
		</select> --%>
		<input type="hidden" value="${sessionUser.id}" name="id">
		<input type="submit" value="Create Profile" />
	</form:form>

</body>
</html>