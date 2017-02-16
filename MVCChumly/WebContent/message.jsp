<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
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
	<link rel="stylesheet" href="assets/css/Navigation-Clean1.css">
	<link href="https://fonts.googleapis.com/css?family=Finger+Paint|Fontdiner+Swanky|Irish+Grover|Mystery+Quest" rel="stylesheet">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<title>Message</title>
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="container">

		<%-- 		<h2>Send a Message to ${recipient.profile.firstName}
			${recipient.profile.lastName} (${recipient.username})</h2>
		<form action="addMessage.do" method="POST">
			<textarea rows="4" cols="50" name="message"></textarea>
			<input type="hidden" value="${sender.id}" name="sessionId"> <input
				type="hidden" value="${recipient.id}" name="recipientId"> <br />
			<input type="submit" value="Send Message" />
		</form>
 --%>
		<div class="form-group">
			<form action="addMessage.do" method="POST">
				<label for="comment">Send a Message to
					${recipient.profile.firstName} ${recipient.profile.lastName}
					(<a href="getOtherUserProfileInformation.do?id=${recipient.id}">${recipient.username}</a>):</label>
				<textarea class="form-control" rows="5" name="message"></textarea>
				<input type="hidden" value="${sender.id}" name="sessionId">
				<input type="hidden" value="${recipient.id}" name="recipientId">
				<input type="submit" value="Send Message" />
			</form>
		</div>

<%-- 
		<h2>Message History</h2>
		<ul class="msg-list">
			<c:forEach var="m" items="${messages}">
				<c:set var="sendUser" value="${m.sender}" />
				<c:set var="recvUser" value="${m.recipients[0]}" />

				<c:choose>
					<c:when test="${ sendUser.id eq sessionUser.id }">
						<c:set var="msgSide" value="msg-us" />
					</c:when>
					<c:otherwise>
						<c:set var="msgSide" value="msg-them" />
					</c:otherwise>
				</c:choose>

				<li>
					<ul class="msg-list-msg ${msgSide}">
								<li>To:   <a href="getOtherUserProfileInformation.do?id=${recvUser.id}"><img src="${recvUser.profile.imageURL}"> ${recvUser.username}</a></li>
						<li>From: <a
							href="getOtherUserProfileInformation.do?id=${sendUser.id}"><img
								src="${sendUser.profile.imageURL}"> ${sendUser.username}</a></li>
						<li>Date: ${m.timeStamp.toLocaleString()}</li>
						<li>Text: ${m.text}</li>
					</ul>
				</li>
			</c:forEach>
		</ul>
		
 --%>		
		
		
		<h2>Message History</h2>
			<c:forEach var="m" items="${messages}">
				<c:set var="sendUser" value="${m.sender}" />
				<c:set var="recvUser" value="${m.recipients[0]}" />

				<c:choose>
					<c:when test="${ sendUser.id eq sessionUser.id }">

					<div class="media well">
						<div class="media-left">
							<img src="${sendUser.profile.imageURL}" />
						</div>
						<div class="media-body">
							<!-- <h4 class="media-heading">Left-aligned</h4> -->
							<p><label>From:</label><a href="getOtherUserProfileInformation.do?id=${sendUser.id}"> ${sendUser.username}</a></p>
							<p><label>Date:</label> ${m.timeStamp.toLocaleString()}</p>
							<p><label>Text:</label> ${m.text}</p>
						</div>
					</div>

				</c:when>
					<c:otherwise>
					
					<div class="media well">
						<div class="media-body">
							<!-- <h4 class="media-heading">Left-aligned</h4> -->
							<p><label>From:</label><a href="getOtherUserProfileInformation.do?id=${sendUser.id}">${sendUser.username}</a></p>
							<p><label>Date:</label> ${m.timeStamp.toLocaleString()}</p>
							<p><label>Text:</label><p>${m.text}</p>
						</div>
						<div class="media-right">
							<img src="${sendUser.profile.imageURL}" />
						</div>
					</div>
					
					</c:otherwise>
				</c:choose>

<%-- 				<li>
					<ul class="msg-list-msg ${msgSide}">
								<li>To:   <a href="getOtherUserProfileInformation.do?id=${recvUser.id}"><img src="${recvUser.profile.imageURL}"> ${recvUser.username}</a></li>
						<li>From: <a
							href="getOtherUserProfileInformation.do?id=${sendUser.id}"><img
								src="${sendUser.profile.imageURL}"> ${sendUser.username}</a></li>
						<li>Date: ${m.timeStamp.toLocaleString()}</li>
						<li>Text: ${m.text}</li>
					</ul>
				</li> --%>
			</c:forEach>

<!-- 
		<h2>Media Object</h2>
		<p>Use the "media-left" class to left-align a media object. Text
			that should appear next to the image, is placed inside a container
			with class="media-body".</p>
		<p>Tip: Use the "media-right" class to right-align the media
			object.</p>
		<br>

		Left-aligned media object
		<div class="media">
			<div class="media-left">
				<img src="img_avatar1.png" class="media-object" style="width: 60px">
			</div>
			<div class="media-body">
				<h4 class="media-heading">Left-aligned</h4>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
			</div>
		</div>
		<hr>

		Right-aligned media object
		<div class="media">
			<div class="media-body">
				<h4 class="media-heading">Right-aligned</h4>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
			</div>
			<div class="media-right">
				<img src="img_avatar1.png" class="media-object" style="width: 60px">
			</div>
		</div>

 -->
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>