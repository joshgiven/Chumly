<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/fonts/ionicons.min.css">
<link rel="stylesheet" href="assets/css/styles.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>Profile</title>
<!-- 	<script>
	$(function () {
		   var activeTab = $('[href=' + location.hash + ']');
		   activeTab && activeTab.tab('show');
		});
	</script>
 -->
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="container">

						<div class="connect-message">			
		<h2>
			<img alt="${user.username}" src="${user.profile.imageURL}">
			${user.username}
		</h2>
		<div class="connect-message-button">
				<form action="connectToUser.do">
					<input type="hidden" value="${sessionUser.id}" name="sessionId">
					<input type="hidden" value="${user.id}" name="userId"> <br />
					<input type="submit" value="Connect" />
				</form>
				<form action="messageUser.do">
						<input type="hidden" value="${sessionUser.id}" name="sessionId">
						<input type="hidden" value="${user.id}" name="id"> <br />
						<div class="messagebutton"><input type="submit" value="Message" /></div>
				</form>
				</div>
				</div>
				
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#vitals">Vitals</a></li>
			<li><a data-toggle="tab" href="#interests">Interests</a></li>
			<li><a data-toggle="tab" href="#connections">Connections</a></li>
			<li><a data-toggle="tab" href="#messages">Messages</a></li>
		</ul>


		<div class="tab-content">
			<!-- <div id="vitals" class="tab-pane fade in active"> -->
			<div id="vitals" class="tab-pane active">
				<h3>Vitals</h3>
				<h3>${user.profile.firstName}${user.profile.lastName}</h3>
				<h4>${user.profile.location.city},
					${user.profile.location.state}</h4>
				<p>${user.profile.description}</p>
			</div>
			<div id="interests" class="tab-pane">
				<h3>Interests</h3>
				<ul>
					<c:forEach var="interest" items="${user.interests}">
						<li><a href="getUsersByInterest.do?interest=${interest.name}">${interest.name}</a></li>
					</c:forEach>
				</ul>
			</div>
			<div id="connections" class="tab-pane">
				<h3>Connections</h3>
				<h4>Connections</h4>
				<ul>
					<!-- class="hide-bullets" -->
					<c:forEach var="c" items="${user.connections}">
						<li><a href="getOtherUserProfileInformation.do?id=${c.id}">
								<%-- <img class="thumbnail" src="${c.profile.imageURL}" alt="${c.username}"> --%>
								<img src="${c.profile.imageURL}" alt="${c.username}">
								${c.profile.firstName} ${c.profile.lastName}
						</a></li>
					</c:forEach>
				</ul>

			</div>
			<div id="messages" class="tab-pane">
				<h3>Messages</h3>
				<h4>Messages</h4>
				<ul>
					<c:forEach var="corres" items="${correspondents}">
						<li><a href="messageUser.do?id=${corres.id}"> <img
								src="${corres.profile.imageURL}" alt="${corres.username}" />
								${corres.profile.firstName} ${corres.profile.lastName}
						</a></li>
					</c:forEach>
				</ul>

				<form action="updateCorrespondence.do" method=POST>
					<input type="submit" value="Update List">
				</form>

			</div>
		</div>

		<p />
		<p />
		<p />
	</div>

	<script type='text/javascript'>
		$(document).ready(
				function() {

					// Javascript to enable link to tab
					var hash = document.location.hash;
					var prefix = "tab_";
					if (hash) {
						$(
								".nav-tabs a[href='" + hash.replace(prefix, "")
										+ "']").tab('show');
					}

					// Change hash for page-reload
					$('.nav-tabs a').on(
							'shown.bs.tab',
							function(e) {
								window.location.hash = e.target.hash.replace(
										"#", "#" + prefix);
							});

				});
	</script>


	<jsp:include page="footer.jsp" />
</body>
</html>