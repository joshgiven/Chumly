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
	<form action="updateProfileDescription.do" method="POST">
		<textarea rows="4" cols="50" name="description">${sessionUser.profile.description}
        </textarea>
		<br /> <input type="submit" value="Update description" />
	</form>
	<br />
	<form action="updateProfileDescription.do" method="POST">
		<input type="text"name="description" value="${sessionUser.profile.description}">
		<br /> <input type="submit" value="Update description" />
	</form>
	<br />
	<form action="updateInterest.do" method="POST">
		<select name="interest">
			<c:forEach var="i" items="${interests}">
				<option value="${i.id}">${i.name}</option>
			</c:forEach>
		</select><br> <input type="submit" value="Add Interest" />
	</form>
</body>
</html>