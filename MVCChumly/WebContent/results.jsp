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
    <link rel="stylesheet" href="assets/css/Navigation-Clean1.css">
    <link href="https://fonts.googleapis.com/css?family=Finger+Paint|Fontdiner+Swanky|Irish+Grover|Mystery+Quest" rel="stylesheet">
<title>Search Results</title>
<body>

<jsp:include page="header.jsp" />

	<h2>People interested in <c:out value="${interest}"/></h2>
	
	<table>
	<c:forEach var="u" items="${users}">
	<tr>
		<td>
			<a href ="getOtherUserProfileInformation.do?id=${u.id}">
			<img class="resultsPicture" src="${u.profile.imageURL}" alt="Profile Picture">
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
