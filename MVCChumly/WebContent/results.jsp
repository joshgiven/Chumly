<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search Results</title>
</head>
<body>
	<h2>People interested in <c:out value="${interest}"/></h2>
	
	<table>
	<c:forEach var="u" items="${users}">
	<tr>
		<td>
			<a href ="getOtherUserProfileInformation.do?id=${u.id}">
			<img src="${u.profile.imageURL}" alt="Profile Picture">
			</a>
		</td>
		<td>
			<a href ="getOtherUserProfileInformation.do?id=${u.id}">
			${u.profile.firstName} ${u.profile.lastName}
			</a>
		</td>
	</tr>
	</c:forEach>
	</table>
	
<%-- 
	<table>
	<c:forEach var="u" items="${users}">
	<tr>
	<td><a href ="getOtherUserProfileInformation.do?id=${u.id}"><img src="${u.profile.imageURL}" alt="Profile Picture"></a></td>
	<td>${u.profile.firstName} ${u.profile.lastName}</td>
	</tr>
	</c:forEach>
	</table>
	 --%>
	
	<ul>
	<li><a href="/MVCChumly/">home</a></li>
	<li><a href="/MVCChumly/logout.do">logout</a></li>
	</ul>
	
</body>
</html>
