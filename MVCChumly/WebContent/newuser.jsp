<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New User</title>

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
		<%-- <form:label path="user.profile.firstName">First Name:</form:label>
		<form:input path="user.profile.firstName" />
		<form:errors path="user.profile.firstName" />
		<br />
		<form:label path="user.profile.lastName">Last Name:</form:label>
		<form:input path="user.profile.lastName" />
		<form:errors path="user.profile.lastName" />
		<br />
		<form:label path="user.profile.description">Description:</form:label>
		<form:input path="user.profile.description" />
		<form:errors path="user.profile.description" />
		<br />
		<form:label path="user.profile.imageURL">Image URL:</form:label>
		<form:input path="user.profile.imageURL" />
		<form:errors path="user.profile.imageURL" />
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
		</select> --%>
		<input type="submit" value="Create User" />
	</form:form>
</body>
</html>