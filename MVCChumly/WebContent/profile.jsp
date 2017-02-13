<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profile<!--${sessionUser.username}--></title>
</head>
<body>
	<form method=GET action="getUsersByInterest.do">
	<select name="interest">
	<c:forEach var="i" items="${sessionUser.interests}">
		<option value="${i.id}">${i.name}</option>
	</c:forEach>
  	</select>
	<input type="submit" value="Search"/>
	</form>
	<a href="getUpdateProfile.do">Update Profile</a>
</body>
</html>