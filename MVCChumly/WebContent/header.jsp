 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
 <div>
        <nav class="navbar navbar-default navigation-clean">
            <div class="container">
                <div class="navbar-header"><a class="navbar-brand navbar-link" href="#"><strong>Chumly </strong></a>
                    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                </div>
                <div class="collapse navbar-collapse" id="navcol-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li role="presentation">
                            <a href="/MVCChumly/">Home</a>
                        </li>
    	<c:if test="${sessionUser.role == 'ADMIN'}">
                        <li role="presentation">
                            <a href="/MVCChumly/admin.do">Admin</a>
                        </li>
                        </c:if>
                        <li role="presentation">
                            <a href="/MVCChumly/logout.do">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
    
		<form action="deleteUser.do" method="POST">
			<input type="hidden" value="${user.id}" name="id"> <br /> <input
				type="hidden" value="${sessionUser.id}" name="sessionId"> <br />
			<input type="submit" value="Delete" />
		</form>