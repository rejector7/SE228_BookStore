<%@ page language="java" contentType="text/html; charset=utf-8"
    import="java.util.*,dao.*,entity.*,servlet.*"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>您的订单</title>
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
		
		String useridStr=null;
		String username=null;
		int userid=1;
		if(request.getParameter("userid")!=null){
			useridStr=request.getParameter("userid");
			userid=Integer.parseInt(useridStr);
			username=UserDao.getInstance().getUserById(userid).getUsername();
		
		}
		int totalNum=OrderDao.getInstance().getOrderTotalNumByUserid(userid);
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
	
		pageOrders=OrderDao.getInstance().getOrdersByUserid(pageSize,currentPage,userid);
		
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
	        <h1>订单页面</h1>
	        <h2>Dear <%=username %></h2>
	   </div>
	</div>
	<div class="container">
	<!-- 
	  <ul class="breadcrumb">
	    <li class="breadcrumb-item active">书籍管理</li>
	    <li class="breadcrumb-item"><a href="userOrder.jsp">用户管理</a></li>
	    <li class="breadcrumb-item"><a href="userOrder.jsp">订单管理</a></li>
	  </ul> 
	   -->
	   <nav class="navbar navbar-expand-sm bg-light">
		  <ul class="nav nav-pills">
			  <li class="nav-item">
			    <a class="nav-link" href="homepage.jsp?userid=<%=userid %>">图书浏览</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="cartManage.jsp?userid=<%=userid %>">购物车管理</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active" href="#">订单查看</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="login.jsp"><button type="button" class="btn btn-danger">Exit</button></a>
			  </li>
		</ul>
		</nav>  
	  <table class="table table-hover table-bordered">
	    <thead class="thead-light">
	      <tr>
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
	      			
	      			%>
	      			<tr>
	    	        <td><%=order.getStatus() %></td>
	    	        <td><%=order.getDate() %></td>
	    	        <td><%=order.getAddress() %></td>
	    	        <td><%=order.getPhone() %></td>
	    	        <td>
	    	        	
						  <a href="userOrderitem.jsp?orderid=<%=order.getOrderid()%>" class="btn btn-info" role="button">orderitems detail</a>
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
	  	 		<li class="page-item disabled"><a class="page-link" href="userOrder.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=currentPage%>&pageSize=<%=pageSize%>">1</a></li>
	  			<li class="page-item disabled"><a class="page-link" href="userOrder.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(totalPage>=2){
	  	 	if(currentPage==1){
	  	 		%>
	  	 		<li class="page-item disabled"><a class="page-link" href="userOrder.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=currentPage%>&pageSize=<%=pageSize%>">1</a></li>
	  			<%
		  	 	for(int i=2;i<=totalPage;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(currentPage==totalPage){
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>">Previous</a></li>
	  			<%
		  	 	for(int i=1;i<=totalPage-1;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item active"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=currentPage%>&pageSize=<%=pageSize%>"><%=currentPage%></a></li>
	  			<li class="page-item disabled"><a class="page-link" href="userOrder.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else{//totalPage>=3
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>">Previous</a></li>
	  			<%	
		  	 	for(int i=1;i<=totalPage;i++){
		  	 		if(currentPage==i){
		  	 			%>
			  			<li class="page-item active"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 		else{
		  	 			%>
			  			<li class="page-item"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=i%>&pageSize=<%=pageSize%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>">Next</a></li>
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
		        <a class="dropdown-item" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=1%>&pageSize=3">3</a>
		        <a class="dropdown-item" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=1%>&pageSize=5">5</a>
		        <a class="dropdown-item" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=1%>&pageSize=10">10</a>
		        <a class="dropdown-item" href="userOrder.jsp?userid=<%=userid %>&currentPage=<%=1%>&pageSize=20">20</a>
		      </div>
		    </div>
	  	 </li>
		</ul>
	</div>


<script>
	
</script>
</body>
</html>