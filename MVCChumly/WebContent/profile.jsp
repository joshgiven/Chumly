<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/fonts/ionicons.min.css">
<link rel="stylesheet" href="assets/css/styles.min.css">
<link rel="stylesheet" href="assets/css/Navigation-Clean1.css">
<link rel="stylesheet" href="profileAssets/css/Team-Grid.css">
<link href="https://fonts.googleapis.com/css?family=Finger+Paint|Fontdiner+Swanky|Irish+Grover|Mystery+Quest" rel="stylesheet">

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

		<h2>
			<img class="profilePicture" alt="${sessionUser.username}"
				src="${sessionUser.profile.imageURL}"> ${sessionUser.username}
		</h2>
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#vitals">Vitals</a></li>
			<li><a data-toggle="tab" href="#interests">Interests</a></li>
			<li><a data-toggle="tab" href="#connections">Connections</a></li>
			<li><a data-toggle="tab" href="#messages">Messages</a></li>
			<li><a data-toggle="tab" href="#search">Search</a></li>
			<li><a data-toggle="tab" href="#update">Update</a></li>
		</ul>


		<div class="tab-content">
			<!-- <div id="vitals" class="tab-pane fade in active"> -->
			<div id="vitals" class="tab-pane active">
				<h3>Vitals</h3>
				<h3>${sessionUser.profile.firstName}
					${sessionUser.profile.lastName}</h3>
				<h4>${sessionUser.profile.location.city},
					${sessionUser.profile.location.state}</h4>
				<p>${sessionUser.profile.description}</p>
			</div>
			<div id="interests" class="tab-pane">
				<h3>Interests</h3>
				<h4>Interests</h4>
				<ul>
					<c:forEach var="interest" items="${sessionUser.interests}">
						<li><a href="getUsersByInterest.do?interest=${interest.name}">${interest.name}</a></li>
					</c:forEach>
				</ul>

				<h4>Add Interest</h4>
				<form action="searchInterest.do" method=GET>
					<input type="text" name="name" placeholder="Interest Keyword">
					<input type="submit" value="Search for Interest">
				</form>
				<form action="addInterest.do" method=POST>
					<select name="id">
						<c:forEach var="interest" items="${interests}">
							<option value="${interest.id}">${interest.name}</option>
							<%-- <input type="hidden" value="${interest.id}" name="id"> --%>
						</c:forEach>
					</select> <input type="hidden" value="${sessionUser.id}" name="userId">
					<input type="submit" value="Add Interest">
				</form>

			</div>
			<div id="connections" class="tab-pane">
				<div class="team-grid">
					<div class="container">
						<div class="row people">
							<c:forEach var="c" items="${sessionUser.connections}">
								<div class="col-md-3 col-sm-4 item">
									<a href="getOtherUserProfileInformation.do?id=${c.id}">
										<div class="box"
											style="background-image:url(${c.profile.imageURL})">
											<div class="cover">
												<h3 class="name">${c.profile.firstName}
													${c.profile.lastName}</h3>
												<p class="title">${c.profile.location.city},
													${c.profile.location.state}</p>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

			</div>

			<div id="messages" class="tab-pane">
				<h3>Messages</h3>
				<h4>Messages</h4>
				<ul>
					<c:forEach var="corres" items="${correspondents}">
						<li><a href="messageUser.do?id=${corres.id}"> <img class="resultsPicture"
								src="${corres.profile.imageURL}" alt="${corres.username}" />
								${corres.profile.firstName} ${corres.profile.lastName}
						</a></li>
					</c:forEach>
				</ul>

				<form action="updateCorrespondence.do" method=POST>
					<input type="submit" value="Update List">
				</form>

			</div>
			<div id="search" class="tab-pane">
				<h3>Search</h3>
				<form method=GET action="getUsersByInterest.do">
					<select name="interest">
						<c:forEach var="i" items="${sessionUser.interests}">
							<option value="${i.name}">${i.name}</option>
						</c:forEach>
					</select> <input type="submit" value="Search" />
				</form>

			</div>
			<div id="update" class="tab-pane">
				<h3>Updates</h3>
				<form action="updateProfileDescription.do" method="POST">
					<textarea rows="4" cols="50" name="description">${sessionUser.profile.description}</textarea>
					<input type="hidden" value="${sessionUser.id}" name="id"> <br />
					<input type="submit" value="Update description" />
				</form>

				<hr>

				<form action="deleteUser.do" method=POST>
					<input type="hidden" value="${sessionUser.id}" name="id"> <input
						type="submit" value="Delete User">
				</form>


			</div>
		</div>

		<p />
		<p />
		<p />
	</div>
	<!-- </div> -->


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
	<script src="profileAssets/js/jquery.min.js"></script>
	<script src="profileAssets/bootstrap/js/bootstrap.min.js"></script>
	<jsp:include page="footer.jsp" />
</body>
</html>