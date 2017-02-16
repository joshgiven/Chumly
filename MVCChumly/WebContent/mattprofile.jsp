<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<!-- <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/fonts/ionicons.min.css">
<link rel="stylesheet" href="assets/css/styles.min.css"> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="profileAssets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=News+Cycle:400,700">
<link rel="stylesheet" href="profileAssets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="profileAssets/css/user.css">
<link rel="stylesheet" href="profileAssets/css/Team-Grid.css">
<link rel="stylesheet" href="profileAssets/css/Header-Dark.css">
<title>Profile</title>
</head>
<body>
    <div>
        <div class="header-dark">
            <nav class="navbar navbar-default navigation-clean-search">
                <div class="container">
                    <div class="navbar-header"><a class="navbar-brand navbar-link" href="#">Chumly</a>
                        <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                    </div>
                    <div class="collapse navbar-collapse" id="navcol-1">
                        <ul class="nav navbar-nav">
                            <li role="presentation">
                                <a href="#"> </a>
                            </li>
                        </ul>
                        <form class="navbar-form navbar-left" target="_self">
                            <div class="form-group">
                                <label class="control-label" for="search-field"></label>
                                <input class="form-control search-field" type="search" name="search" id="search-field">
                            </div>
                        </form>
                        <p class="navbar-text navbar-right"><a class="btn btn-default action-button" role="button" href="#">Home</a><a class="btn btn-default action-button" role="button" href="/MVCChumly/logout.do">Log Out</a></p>
                    </div>
                </div>
            </nav>
        </div>
    </div>
	<!-- <div>
		<nav class="navbar navbar-default navigation-clean">
			<div class="container1">
				<div class="navbar-header">
					<strong>Chumly</strong>
					<button class="navbar-toggle collapsed" data-toggle="collapse"
						data-target="#navcol-1">
						<span class="sr-only">Toggle navigation</span><span
							class="icon-bar"></span><span class="icon-bar"></span><span
							class="icon-bar"></span>
					</button>
				</div>
				<div class="collapse navbar-collapse" id="navcol-1">
					<ul class="nav navbar-nav navbar-right">
						<li class="active" role="presentation"><a href="/MVCChumly/">Home</a>
						</li>
						<li role="presentation"><a href="#"> </a></li>
						<li role="presentation"><a href="/MVCChumly/logout.do">Logout
						</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div> -->
	<div class="container">
		<div class="row product">
			<div class="col-md-5 col-md-offset-0">
				<img class="img-responsive" alt="Profile Picture"
					src="${sessionUser.profile.imageURL}">
			</div>
			<div class="col-md-7">
				<h3>${sessionUser.profile.firstName}
					${sessionUser.profile.lastName}</h3>
				<h4>${sessionUser.profile.location.city},
					${sessionUser.profile.location.state}</h4>
			</div>
			<div class="page-header">
				<h3>Description</h3>
			</div>
			<form action="updateProfileDescription.do" method="POST">
				<textarea rows="4" cols="50" name="description">${sessionUser.profile.description}
        </textarea>
				<input type="hidden" value="${sessionUser.id}" name="id"> <br />
				<input type="submit" value="Update description" />
			</form>
			<div class="page-header">
				<h3>Search by Your Interests</h3>
				<h3>Add Interests</h3>
			</div>
			<div class="dropdown">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown" aria-expanded="false" type="button">
					Interests <span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="interest">
					<c:forEach var="i" items="${sessionUser.interests}">
						<li role="presentation"><a
							href="getUsersByInterest.do?interest=${i.name}">${i.name}</a></li>

					</c:forEach>
				</ul>


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
					</select> <input type="hidden" value="${sessionUser.id}" name="userId">
					<input type="submit" value="Add Interest">
				</form>
			</div></div>
			<%-- <form method=GET action="getUsersByInterest.do">
	<select name="interest">
	<c:forEach var="i" items="${sessionUser.interests}">
		<option value="${i.name}">${i.name}</option>
	</c:forEach>
  	</select>
	<input type="submit" value="Search"/>
	</form> --%>
			<%-- <h4>Connections</h4>
			<ul>
				<c:forEach var="c" items="${sessionUser.connections}">
					<li><a href="getOtherUserProfileInformation.do?id=${c.id}"><img
							src="${c.profile.imageURL}" alt="pic"></a>
						${c.profile.firstName} ${c.profile.lastName}</li>
				</c:forEach>
			</ul> --%>
			<div class="team-grid">
				<div class="container">
					<div class="intro">
						<h2 class="text-center">Connections</h2>
						<hr>
						<p class="text-center"></p>
					</div>
					<div class="row people">
						<c:forEach var="c" items="${sessionUser.connections}">
							<div class="col-md-3 col-sm-4 item">
								<a href="getOtherUserProfileInformation.do?id=${c.id}">
										<div class="box" style="background-image:url(${c.profile.imageURL})">
										<div class="cover">
											<h3 class="name">${c.profile.firstName}
												${c.profile.lastName}</h3>
											<p class="title">${c.profile.location.city},
												${c.profile.location.state}</p>
										</div>
									</div></a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>

		<hr>
		<form action="deleteUser.do" method=POST>
			<input type="hidden" value="${sessionUser.id}" name="id"> <input
				type="submit" value="Delete Account">
		</form>
		<footer class="site-footer">
        <div class="container">
            <hr>
            <div class="row">
                <div class="col-sm-6">
                    <h5>Chumly © 2017</h5></div>
                <div class="col-sm-6 social-icons">
                <h5>Created By: Josh Given, Geoff Edwards, Matthew Jump</h5>
                </div>
            </div>
        </div>
    </footer> 

		<!-- 	
	    <div class="container">
        <div class="row product">
            <div class="col-md-5 col-md-offset-0"><img class="img-responsive" src="assets/img/suit_jacket.jpg"></div>
            <div class="col-md-7">
                <h2>First Name Last Name</h2>
                <p>City, State</p>
                <h3> </h3></div>
        </div>
        <div class="page-header">
            <h3>Description </h3></div>
        <p>Sed mollis, urna eu tempus facilisis, diam tellus aliquam tortor, et vestibulum ante quam non justo. Nullam luctus rutrum mattis. Maecenas in pharetra mi, vel mollis odio. Morbi non mauris massa. </p>
        <div class="page-header">
            <h3>Interests </h3></div>
        <input type="text">
        <button class="btn btn-default" type="button">Button</button>
        <div class="dropdown">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" type="button">Dropdown <span class="caret"></span></button>
            <ul class="dropdown-menu" role="menu">
                <li role="presentation"><a href="#">First Item</a></li>
                <li role="presentation"><a href="#">Second Item</a></li>
                <li role="presentation"><a href="#">Third Item</a></li>
            </ul>
        </div>
        <button class="btn btn-default" type="button">Button</button>
        <h3> </h3></div>
    <div class="team-grid">
        <div class="container">
            <div class="intro">
                <h2 class="text-center">Contacts </h2>
                <p class="text-center">Nunc luctus in metus eget fringilla. Aliquam sed justo ligula. Vestibulum nibh erat, pellentesque ut laoreet.&nbsp; </p>
            </div>
            <div class="row people">
                <div class="col-md-3 col-sm-4 item">
                    <div class="box" style="background-image:url(profileAssets/img/1.jpg)">
                        <div class="cover">
                            <h3 class="name">Ben Johnson</h3>
                            <p class="title">Musician</p>
                            <div class="social"><a href="#"><i class="fa fa-facebook-official"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-instagram"></i></a></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 item">
                    <div class="box" style="background-image:url(profileAssets/img/2.jpg)">
                        <div class="cover">
                            <h3 class="name">Emily Clark</h3>
                            <p class="title">Artist </p>
                            <div class="social"><a href="#"><i class="fa fa-facebook-official"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-instagram"></i></a></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 item">
                    <div class="box" style="background-image:url(profileAssets/img/3.jpg)">
                        <div class="cover">
                            <h3 class="name">Carl Kent</h3>
                            <p class="title">Stylist </p>
                            <div class="social"><a href="#"><i class="fa fa-facebook-official"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-instagram"></i></a></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 item">
                    <div class="box" style="background-image:url(profileAssets/img/4.jpg)">
                        <div class="cover">
                            <h3 class="name">Felicia Adams</h3>
                            <p class="title">Model </p>
                            <div class="social"><a href="#"><i class="fa fa-facebook-official"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-instagram"></i></a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="site-footer">
        <div class="container">
            <hr>
            <div class="row">
                <div class="col-sm-6">
                    <h5>Fashion Store © 2016</h5></div>
                <div class="col-sm-6 social-icons"></div>
            </div>
        </div>
    </footer> -->
		<script src="profileAssets/js/jquery.min.js"></script>
		<script src="profileAssets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>