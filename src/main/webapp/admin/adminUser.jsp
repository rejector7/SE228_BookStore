<%@ page language="java" contentType="text/html; charset=utf-8"
    import="java.util.*,dao.*,entity.*,servlet.*"
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
		int pageSize=3;
		int currentPage=1;
		String currentPageStr=request.getParameter("currentPage");
		String pageSizeStr=request.getParameter("pageSize");
		if(currentPageStr!=null){
			currentPage=Integer.parseInt(currentPageStr);
		}
		if(pageSizeStr!=null){
			pageSize=Integer.parseInt(pageSizeStr);
		}
		int totalNum=UserDao.getInstance().getUserTotalNum();
		int totalPage=0;
		
			if(totalNum==0){
				totalPage=0;
			}
			else if(totalNum%pageSize!=0){
				totalPage=totalNum/pageSize+1;
			}
			else{
				totalPage=totalNum/pageSize;
			}
		String content=null;
		List<User> pageUsers=null;
		//for search content
		if(request.getParameter("content")!=null){
			content=request.getParameter("content");
			pageUsers=UserDao.getInstance().getUserByUsername(content);
			
			totalPage=1;
			currentPage=1;
			pageSize=20;
			/*
			if(pageUsers!=null){
				totalNum=pageUsers.size();
				currentPage=1;
				if(totalNum==0){
					totalPage=0;
				}
				else if(totalNum%pageSize!=0){
					totalPage=totalNum/pageSize+1;
				}
				else{
					totalPage=totalNum/pageSize;
				}
			}
			else{
				totalPage=0;
			}
			*/
		}
		else{
			pageUsers=UserDao.getInstance().getUsers(pageSize,currentPage);
		}
		
		String useridStr=null;
		if(request.getParameter("userid")!=null){
			useridStr=request.getParameter("userid");
		}
		
	%>
</head>
<body>
	<div class="container">
	   <div class="jumbotron">
	        <h1>管理员主页</h1>
	   </div>
	</div>
	<div class="container">
	<!-- 
	  <ul class="breadcrumb">
	    <li class="breadcrumb-item active">书籍管理</li>
	    <li class="breadcrumb-item"><a href="adminUser.jsp">用户管理</a></li>
	    <li class="breadcrumb-item"><a href="adminOrder.jsp">订单管理</a></li>
	  </ul> 
	   -->
	   <nav class="navbar navbar-expand-sm bg-light">
		  <ul class="nav nav-pills">
			  <li class="nav-item">
			    <a class="nav-link" href="adminHomepage.jsp">书籍管理</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active" href="#">用户管理</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="adminOrder.jsp">订单管理</a>
			  </li>
			
			  <li class="nav-item">
			  	<a class="nav-link" href="userAdd.jsp"><button type="button" class="btn btn-primary">Add User</button>
			    
			    <!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
				  Add User
				</button>  -->
				</a>
				<!-- 模态框 I delete it  -->
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="adminLogin.jsp"><button type="button" class="btn btn-danger">Exit</button></a>
			  </li>
		</ul>
				<form class="form-inline">
				<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
				<h5>Username:</h5>
			    <input class="form-control" type="text" placeholder="Search" name="searchContent">
			    <button class="btn btn-success" type="button" onclick="onSearch(this.form)">Search</button>
			    </form>
		</nav>  
	  <table class="table table-hover table-bordered">
	    <thead class="thead-light">
	      <tr>
	        <th>username</th>
	        <th>password</th>
	        <th>phone</th>
	        <th>operation</th>
	      </tr>
	    </thead>
	    <tbody>
	       <% 
	       if(pageUsers!=null){
		       for (int i=0;i<pageUsers.size();i++){ 
	      			User user=pageUsers.get(i);
	      			%>
	      			<tr>
	    	        <td><%=user.getUsername() %></td>
	    	        <td><%=user.getPassword() %></td>
	    	        <td><%=user.getPhone() %></td>
	    	        <td>
	    	        	<div class="btn-group">
						    <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
						       Opers:
						    </button>
						    <div class="dropdown-menu">
						      <a class="dropdown-item btn btn-link" href="userUpdate.jsp?userid=<%=user.getUserid()%>">update</a>
						      <a class="dropdown-item btn btn-link" href="adminUser.jsp?userid=<%=user.getUserid()%>">delete</a>
						    </div>
						  </div>
	    	        </td>
	    	      </tr>
	    	      <%
		       }
	       }
      	  %>
	    </tbody>
	  </table>
	  <ul class="pagination">
	  	 <%
	  	 	if(totalPage==1){
	  	 		%>
	  	 		<li class="page-item disabled"><a class="page-link" href="adminUser.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="adminUser.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>">1</a></li>
	  			<li class="page-item disabled"><a class="page-link" href="adminUser.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(totalPage>=2){
	  	 	if(currentPage==1){
	  	 		%>
	  	 		<li class="page-item disabled"><a class="page-link" href="adminUser.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="adminUser.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>">1</a></li>
	  			<%
		  	 	for(int i=2;i<=totalPage;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminUser.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminUser.jsp?currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(currentPage==totalPage){
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="adminUser.jsp?currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>">Previous</a></li>
	  			<%
		  	 	for(int i=1;i<=totalPage-1;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminUser.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item active"><a class="page-link" href="adminUser.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>"><%=currentPage%></a></li>
	  			<li class="page-item disabled"><a class="page-link" href="adminUser.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else{//totalPage>=3
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="adminUser.jsp?currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>">Previous</a></li>
	  			<%	
		  	 	for(int i=1;i<=totalPage;i++){
		  	 		if(currentPage==i){
		  	 			%>
			  			<li class="page-item active"><a class="page-link" href="adminUser.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 		else{
		  	 			%>
			  			<li class="page-item"><a class="page-link" href="adminUser.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminUser.jsp?currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>">Next</a></li>
	  			<%
	  	 	}
	  	 	}
	  	 %>
	  	 <li>
	  	 	<div class="btn-group">
		      <button type="button" class="dropdown-toggle btn btn-light" data-toggle="dropdown">
		        pageSize:<%=pageSize %>
		      </button>
		      <div class="dropdown-menu">
		        <a class="dropdown-item" href="adminUser.jsp?currentPage=<%=1%>&pageSize=3">3</a>
		        <a class="dropdown-item" href="adminUser.jsp?currentPage=<%=1%>&pageSize=5">5</a>
		        <a class="dropdown-item" href="adminUser.jsp?currentPage=<%=1%>&pageSize=10">10</a>
		        <a class="dropdown-item" href="adminUser.jsp?currentPage=<%=1%>&pageSize=20">20</a>
		      </div>
		    </div>
	  	 </li>
		</ul>
	</div>

<script type="text/javascript">
	function onSearch(form){
		var content=form.searchContent.value;
		form.searchContent.value=content;
		window.location.href="adminUser.jsp?content="+content;
	}
	</script>
	<!-- here Why i delete this two tags the onsearch function cannot run -->
	<script>
	function deleteUser(){
		<%
			if(useridStr!=null){
		%>
		var url="../DeleteUserServlet?userid="+<%=useridStr%>;
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
			    if(xmlhttp.responseText!="deleteUserT"){
				    alert("Something wrong when delete this User!");
				}else{
					alert("Delete succeed!");
					window.location.href="adminUser.jsp";
				}
		    }
		  }
		  xmlhttp.send();
		  <%} 
			else return;
		  %>
	}
	window.onload=deleteUser();
</script>
</body>
</html>