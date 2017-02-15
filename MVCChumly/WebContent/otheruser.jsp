<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/styles.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
    <div>
        <nav class="navbar navbar-default navigation-clean">
            <div class="container">
                <div class="navbar-header"><strong>Chumly </strong></a>
                    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                </div>
                <div class="collapse navbar-collapse" id="navcol-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li role="presentation">
                            <a href="/MVCChumly/">Home</a>
                        </li>
                        <li role="presentation">
                            <a href="#"> </a>
                        </li>
                        <li role="presentation">
                            <a href="/MVCChumly/logout.do">Logout </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
    <img alt="Profile Picture" src="${user.profile.imageURL}">
    <h3>${user.profile.firstName} ${user.profile.lastName}</h3>
    <h4>${user.profile.location.city}, ${user.profile.location.state}</h4>
    <h4>Interests</h4>
	<ul>
	<c:forEach var="i" items="${user.interests}">
	<li> ${i.name}</li>
	</c:forEach>
	</ul>
	<%--<c:forEach var ="c" items="${sessionUser.connections}">
	<c:set var="name" value="${c.username}"/>
	<c:if test="${!fn:contains(name, '${user.username}'">--%>
	<h4>Connections</h4>
	<ul>
	<c:forEach var="c" items="${user.connections}">
	<li><a href="getOtherUserProfileInformation.do?id=${c.id}"><img src="${c.profile.imageURL}"></a> ${c.profile.firstName} ${c.profile.lastName}</li>
	</c:forEach>
	</ul>
	<hr>
	<form action="connectToUser.do">
		<input type="hidden" value="${sessionUser.id}" name="sessionId">
		<input type="hidden" value="${user.id}" name="userId"> <br />
		<input type="submit" value="Connect" />
	</form>
	<hr>
	<%--</c:if></c:forEach>--%>
	<a href="messageUser.do?id=${user.id}">Message</a>
	<c:if test="${sessionUser.role == 'ADMIN'}">
	<form action="deleteUser.do" method="POST">
		<input type="hidden" value="${user.id}" name="id"> <br />
		<input type="hidden" value="${sessionUser.id}" name="sessionId"> <br />
		<input type="submit" value="Delete" />
	</form>	
	</c:if>	
	<!-- <ul>
	<li><a href="/MVCChumly/">home</a></li>
	<li><a href="/MVCChumly/logout.do">logout</a></li>
	</ul> -->
</body>
</html>