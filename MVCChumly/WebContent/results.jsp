<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE >
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/styles.min.css">
<title>Search Results</title>
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
	<jsp:include page="footer.jsp" />
</body>
</html>
