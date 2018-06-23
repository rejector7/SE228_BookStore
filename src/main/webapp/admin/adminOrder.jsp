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
		int totalNum=OrderDao.getInstance().getOrderTotalNum();
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
		List<Order> pageOrders=null;
		//for search content
		if(request.getParameter("content")!=null){
			content=request.getParameter("content");
			pageOrders=OrderDao.getInstance().getOrderByUsername(content);//attention here, we search one user's orders according to the username
			
			totalPage=1;
			currentPage=1;
			pageSize=20;
			/*
			if(pageorders!=null){
				totalNum=pageorders.size();
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
			pageOrders=OrderDao.getInstance().getOrders(pageSize,currentPage);
		}
		//for delete
		String orderidStr=null;
		if(request.getParameter("orderid")!=null){
			orderidStr=request.getParameter("orderid");
		}
		
		//User user=new User();
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
	    <li class="breadcrumb-item"><a href="adminOrder.jsp">用户管理</a></li>
	    <li class="breadcrumb-item"><a href="adminOrder.jsp">订单管理</a></li>
	  </ul> 
	   -->
	   <nav class="navbar navbar-expand-sm bg-light">
		  <ul class="nav nav-pills">
			  <li class="nav-item">
			    <a class="nav-link" href="adminHomepage.jsp">书籍管理</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="adminUser.jsp">用户管理</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active" href="#">订单管理</a>
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
	        <th>orderid</th>
	        <th>username</th>
	        <th>status</th>
	        <th>date</th>
	        <th>address</th>
	        <th>phone</th>
	        
	        <th>Operation</th>
	      </tr>
	    </thead>
	    <tbody>
	       <% 
	       if(pageOrders!=null){
		       for (int i=0;i<pageOrders.size();i++){ 
		    	   	Order order=new Order();
	      			order=pageOrders.get(i);
	      			String tempUsername=null;
	      			int userid=0;
	      			userid=order.getUserid();
	      			User user=new User();
	      			user=UserDao.getInstance().getUserById(userid);
	      			if(user!=null){
	      				tempUsername=user.getUsername();//get the user accord to the order's userid
	      			}
	      			%>
	      			<tr>
	    	        <td><%=order.getOrderid() %></td>
	    	        <td><%=tempUsername %></td>
	    	        <td><%=order.getStatus() %></td>
	    	        <td><%=order.getDate() %></td>
	    	        <td><%=order.getAddress() %></td>
	    	        <td><%=order.getPhone() %></td>
	    	        <td>
	    	        	<div class="btn-group">
						    <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
						       Opers:
						    </button>
						    <div class="dropdown-menu">
						      <a class="dropdown-item btn btn-link" href="orderUpdate.jsp?orderid=<%=order.getOrderid()%>">update</a>
						      <a class="dropdown-item btn btn-link" href="adminOrder.jsp?orderid=<%=order.getOrderid()%>">delete</a>
						    </div>
						  </div>
						  <a href="adminOrderitem.jsp?orderid=<%=order.getOrderid()%>" class="btn btn-info" role="button">orderitems detail</a>
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
	  	 		<li class="page-item disabled"><a class="page-link" href="adminOrder.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="adminOrder.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>">1</a></li>
	  			<li class="page-item disabled"><a class="page-link" href="adminOrder.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(totalPage>=2){
	  	 	if(currentPage==1){
	  	 		%>
	  	 		<li class="page-item disabled"><a class="page-link" href="adminOrder.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="adminOrder.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>">1</a></li>
	  			<%
		  	 	for(int i=2;i<=totalPage;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminOrder.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminOrder.jsp?currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(currentPage==totalPage){
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="adminOrder.jsp?currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>">Previous</a></li>
	  			<%
		  	 	for(int i=1;i<=totalPage-1;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminOrder.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item active"><a class="page-link" href="adminOrder.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>"><%=currentPage%></a></li>
	  			<li class="page-item disabled"><a class="page-link" href="adminOrder.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else{//totalPage>=3
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="adminOrder.jsp?currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>">Previous</a></li>
	  			<%	
		  	 	for(int i=1;i<=totalPage;i++){
		  	 		if(currentPage==i){
		  	 			%>
			  			<li class="page-item active"><a class="page-link" href="adminOrder.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 		else{
		  	 			%>
			  			<li class="page-item"><a class="page-link" href="adminOrder.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="adminOrder.jsp?currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>">Next</a></li>
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
		        <a class="dropdown-item" href="adminOrder.jsp?currentPage=<%=1%>&pageSize=3">3</a>
		        <a class="dropdown-item" href="adminOrder.jsp?currentPage=<%=1%>&pageSize=5">5</a>
		        <a class="dropdown-item" href="adminOrder.jsp?currentPage=<%=1%>&pageSize=10">10</a>
		        <a class="dropdown-item" href="adminOrder.jsp?currentPage=<%=1%>&pageSize=20">20</a>
		      </div>
		    </div>
	  	 </li>
		</ul>
	</div>

<script type="text/javascript">
	function onSearch(form){
		var content=form.searchContent.value;
		form.searchContent.value=content;
		window.location.href="adminOrder.jsp?content="+content;
	}
</script>
<script>
	function deleteOrder(){
		<%
			if(orderidStr!=null){
		%>
		var url="../DeleteOrderServlet?orderid="+<%=orderidStr%>;
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
			    if(xmlhttp.responseText!="deleteOrderT"){
				    alert("Something wrong when delete this Order!");
				}else{
					alert("Delete succeed!");
					window.location.href="adminOrder.jsp";
				}
		    }
		  }
		  xmlhttp.send();
		  <%} 
			else return;
		  %>
	}
	window.onload=deleteOrder();
</script>
</body>
</html>