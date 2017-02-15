<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<%--<c:forEach var ="c" items="${sessionUser.connections}">
	<c:set var="name" value="${c.username}"/>
	<c:if test="${!fn:contains(name, '${user.username}'">--%>
	<form action="connectToUser.do">
		<input type="hidden" value="${sessionUser.id}" name="sessionId">
		<input type="hidden" value="${user.id}" name="userId"> <br />
		<input type="submit" value="Connect" />
	</form>
	
	<%--</c:if></c:forEach>--%>
	<a href="messageUser.do?id=${user.id}">Message</a>
	<ul>
	<c:forEach var="c" items="${user.connections}">
	<li> ${c.profile.firstName} ${c.profile.lastName}</li>
	</c:forEach>
	</ul>
	<c:if test="${sessionUser.role == 'ADMIN'}">
	<form action="deleteUser.do" method="POST">
		<input type="hidden" value="${user.id}" name="id"> <br />
		<input type="hidden" value="${sessionUser.id}" name="sessionId"> <br />
		<input type="submit" value="Delete" />
	</form>	
	</c:if>	
	<ul>
	<li><a href="/MVCChumly/">home</a></li>
	<li><a href="/MVCChumly/logout.do">logout</a></li>
	</ul>
</body>
</html>