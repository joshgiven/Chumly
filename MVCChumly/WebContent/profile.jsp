<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/styles.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/styles.min.css">
<title>Profile</title>
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
                        <li class="active" role="presentation">
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
    <img alt="Profile Picture" src="${sessionUser.profile.imageURL}">
    <h3>${sessionUser.profile.firstName} ${sessionUser.profile.lastName}</h3>
    <h4>${sessionUser.profile.location.city}, ${sessionUser.profile.location.state}</h4>
    <form action="updateProfileDescription.do" method="POST">
		<textarea rows="4" cols="50" name="description">${sessionUser.profile.description}
        </textarea>
        <input type="hidden" value="${sessionUser.id}" name="id">
		<br /> <input type="submit" value="Update description" />
	</form>
	<form method=GET action="getUsersByInterest.do">
	<select name="interest">
	<c:forEach var="i" items="${sessionUser.interests}">
		<option value="${i.name}">${i.name}</option>
	</c:forEach>
  	</select>
	<input type="submit" value="Search"/>
	</form>
	<h4>Connections</h4>
	<ul>
	<c:forEach var="c" items="${sessionUser.connections}">
	<li><a href ="getOtherUserProfileInformation.do?id=${c.id}"><img src="${c.profile.imageURL}" alt="pic"></a> ${c.profile.firstName} ${c.profile.lastName}</li>
	</c:forEach>
	</ul>
	<h4>Add Interest</h4>
	<form action="searchInterest.do" method=GET>
	<input type="text" name="name" placeholder="Interest Keyword">
	<input type="submit" value="Search for Interest">
	</form>
	<form action="addInterest.do" method=POST>
	<select name="name">
	<c:forEach var="interest" items="${interests}">
		<option value="${interest.name}">${interest.name}</option>
	<input type="hidden" value="${interest.id}" name="id">
	</c:forEach>
  	</select>
	<input type="hidden" value="${sessionUser.id}" name="userId">
	<input type="submit" value="Add Interest">
	</form>
	<hr>
	<form action="deleteUser.do" method=POST>	
	<input type="hidden" value="${sessionUser.id}" name="id">
	<input type="submit" value="Delete User">
	</form>
	
	
	<!-- <ul>
	<li><a href="/MVCChumly/">home</a></li>
	<li><a href="/MVCChumly/logout.do">logout</a></li>
	</ul> -->
	
</body>
</html>