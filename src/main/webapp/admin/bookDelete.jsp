<!-- ATEENTION!!!! in fact this page does not work, but i save this in case i need it -->
<%@ page language="java" contentType="text/html; charset=utf-8"
    import="java.util.*,dao.*,entity.*,servlet.*"
    import="java.io.IOException,java.io.PrintWriter,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>管理员主页</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	   	
		<!-- æ° Bootstrap æ ¸å¿ CSS æä»¶ -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/bootstrap.css"/>
    <link rel="stylesheet" href="../bootstrap/bootstrapValidator.css"/>

    <!-- Include the FontAwesome CSS if you want to use feedback icons provided by FontAwesome -->
    <!--<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" />-->

    <script type="text/javascript" src="../bootstrap/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="../bootstrap/bootstrapValidator.js"></script>
    <%
    	request.setCharacterEncoding("utf-8");
    	String bookidStr=request.getParameter("bookid");
		
    %>
</head>
<body>
	<script type="text/javascript">
		function deleteBook(){
			var url="../DeleteBookServlet?bookid="+<%=bookidStr%>;
			var xmlhttp;
			  if (window.XMLHttpRequest)
			  {
			    // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			    xmlhttp=new XMLHttpRequest();
			  }
			  else
			  {
			    // IE6, IE5 浏览器执行代码
			    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			  }
			  xmlhttp.open("GET",url,true);

			  
			  xmlhttp.onreadystatechange=function()
			  {
			    if (xmlhttp.readyState==4 && xmlhttp.status==200)
			    {
				    if(xmlhttp.responseText!="deleteBookT"){
					    alert("Something wrong when delete this book!");
					}else{
						alert("Delete succeed!");
						window.location.href="adminHomepage.jsp";
					}
			    }
			  }
			  xmlhttp.send();
		}
		window.onload=deleteBook();
	</script>
</body>
</html>