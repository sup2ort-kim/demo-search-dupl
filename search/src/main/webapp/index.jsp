
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='/css/user/slick.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/user/font.css' />" media="all" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/user/xeicon.css' />" media="all" />
<link rel="stylesheet" href="<c:url value='/css/user/style.css' />">
<link rel="stylesheet" href="<c:url value='/css/user/snu_style.css' />">
<link rel="stylesheet" href="<c:url value='/css/user/sub_style.css' />">
<link rel="stylesheet" href="<c:url value='/css/user/mobile_style.css' />">
<link rel="stylesheet" type="text/css"href="<c:url value='/css/user/tstyle.css' />" media="all" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/user/tboard.css' />" media="all" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/user/member.css' />"/>
<link rel="stylesheet" type="text/css"href="<c:url value='/css/user/sub_responsive.css' />" media="all" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/user/s-carousel.css' />" media="all" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Demo Search</title>
</head>
<body>
	<%@ include file="/jsp/demoSearchMain.jsp" %>
	<%@ include file="/jsp/chat/chat_script.jsp" %>
</body>
</html>