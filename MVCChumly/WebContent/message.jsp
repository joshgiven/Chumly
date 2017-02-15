<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/styles.min.css">
<title>Message</title>
</head>
<body>

   <div>
        <nav class="navbar navbar-default navigation-clean">
            <div class="container">
                <div class="navbar-header"><strong>Chumly</strong>
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


	<h2>Send a Message to ${recipient.profile.firstName} ${recipient.profile.lastName} (${recipient.username})</h2>
	<form action="addMessage.do" method="POST">
		<textarea rows="4" cols="50" name="message"></textarea>
		<input type="hidden" value="${sender.id}" name="sessionId"> <input
			type="hidden" value="${recipient.id}" name="recipientId"> <br />
		<input type="submit" value="Send Message" />
	</form>
	
	<h2>Message History</h2>
	<ul class="msg-list">
		<c:forEach var="m" items="${messages}">
			<c:set var="sendUser" value="${m.sender}" />
			<c:set var="recvUser" value="${m.recipients[0]}" />
			
			<c:choose >
				<c:when test="${ sendUser.id eq sessionUser.id }">
					<c:set var="msgSide" value="msg-us" />
				</c:when>
				<c:otherwise>
					<c:set var="msgSide" value="msg-them" />
				</c:otherwise>
			</c:choose>
			
		<li>
		<ul class="msg-list-msg ${msgSide}">
<%-- 		<li>To:   <a href="getOtherUserProfileInformation.do?id=${recvUser.id}"><img src="${recvUser.profile.imageURL}"> ${recvUser.username}</a></li> --%>
			<li>From: <a href="getOtherUserProfileInformation.do?id=${sendUser.id}"><img src="${sendUser.profile.imageURL}"> ${sendUser.username}</a></li>
			<li>Date: ${m.timeStamp.toLocaleString()}</li>
			<li>Text: ${m.text}</li>
		</ul>
		</li>
		</c:forEach>
	</ul>
	
</body>
</html>