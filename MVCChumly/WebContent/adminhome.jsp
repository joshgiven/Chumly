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
		<form action="" method=POST>
	<select name="name">
	<c:forEach var="interest" items="${categories}">
		<option value="${interest.name}">${interest.name}</option>
	<input type="hidden" value="${interest.id}" name="id">
	</c:forEach>
  	</select>
	<input type="hidden" value="${sessionUser.id}" name="userId">
	<input type="submit" value="Add Interest">
	
	</form>
	
	
</body>
</html>