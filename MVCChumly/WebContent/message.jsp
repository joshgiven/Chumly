<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Message</title>
</head>
<body>
	<form action="addMessage.do" method="POST">
		<textarea rows="4" cols="50" name="message">
        </textarea>
        <input type="hidden" value="${sender.id}" name="sessionId">
        <input type="hidden" value="${recipient.id}" name="recipientId">
		<br /> <input type="submit" value="Send Message" />
	</form>
	<ul>
	<c:forEach var="m" items="${messages}">
	<li><img src="${m.sender.profile.imageURL}"> ${m.text} ${m.timestamp}</li>
	</c:forEach>
	</ul>
</body>
</html>