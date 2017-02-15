<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Home</title>
</head>
<body>
	<form action="createInterest.do" method=POST>
	<select name="categories">
	<c:forEach var="c" items="${categories}">
		<option value="${c.name}">${c.name}</option>
		<input type="hidden" value="${c.id}" name="id">
	</c:forEach>
	</select>
	<input type="text" name="interest">
	<input type="submit" value="Add Interst">
	</form>
	<form action="getOtherUserProfileInformation.do" method=GET>
	<select name="user">
	<c:forEach var="u" items="${users}">
		<option value="${u.name}">${u.name}</option>
		<input type="hidden" value="${u.id}" name="id">
		<input type="submit" value="Go to User">
	</c:forEach>
	</select>
	</form>
</body>
</html>