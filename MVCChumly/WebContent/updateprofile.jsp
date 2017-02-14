<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update</title>
</head>
<body>
	<form:form action="updateProfile.do" method="POST"
		modelAttribute="sessionUser">
		<form:label path="">Description</form:label>
		<form:input path="description" />
		<form:errors path="description" />
		<br />
		<select name="interests">
			<c:forEach var="i" items="${interests}">
				<option value="${i.name}">${i.name}</option>
			</c:forEach>
		</select><br>
		<input type="submit" value="Update" />
	</form:form>
</body>
</html>