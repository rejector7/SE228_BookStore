<%@ page language="java" contentType="text/html; charset=utf-8"
    import="java.util.*,dao.*,entity.*,servlet.*"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>用户主页</title>
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
		int totalNum=BookDao.getInstance().getBookTotalNum();
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
		List<Book> pageBooks=null;
		if(request.getParameter("content")!=null){
			content=request.getParameter("content");
			pageBooks=BookDao.getInstance().getBookByBookname(content);
			totalPage=1;
			currentPage=1;
			pageSize=20;
		}
		else{
			pageBooks=BookDao.getInstance().getBooks(pageSize,currentPage);
		}
		
		String bookidStr=null;
		if(request.getParameter("bookid")!=null){
		 bookidStr=request.getParameter("bookid");
		}
		
		int userid=0;
		if(request.getAttribute("userid")!=null){
			userid=Integer.parseInt(request.getAttribute("userid").toString());
		}
		if(request.getParameter("userid")!=null){
			userid=Integer.parseInt(request.getParameter("userid"));
		}
		String username=null;
		User currentUser=null;
		currentUser=UserDao.getInstance().getUserById(userid);
		username=currentUser.getUsername();
	 	%>
</head>
<body>
	<div class="container">
	   <div class="jumbotron">
	        <h1>用户主页</h1>
	        <h2>Welcome: <%=username %></h2>
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
			    <a class="nav-link active" href="#">图书浏览</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="cartManage.jsp?userid=<%=userid %>">购物车管理</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="userOrder.jsp?userid=<%=userid %>">订单查看</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="login.jsp"><button type="button" class="btn btn-danger">Exit</button></a>
			  </li>
		</ul>
				<form class="form-inline">
				<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
				<h5>Bookname:</h5>
			    <input class="form-control" type="text" placeholder="Search" name="searchContent">
			    <button class="btn btn-success" type="button" onclick="onSearch(this.form)">Search</button>
			    </form>
			    <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
			    <a class="nav-link" href="profile.jsp?userid=<%=userid %>"><button type="button" class="btn btn-primary">Profile</button></a>
		</nav>  
	  <table class="table table-hover table-bordered">
	    <thead class="thead-light">
	      <tr>
	        <th>bookname</th>
	        <th>price</th>
	        <th>stock</th>
	        <th>description</th>
	        <th>operation</th>
	      </tr>
	    </thead>
	    <tbody>
	       <% 
	       if(pageBooks!=null){
		       for (int i=0;i<pageBooks.size();i++){ 
	      			Book book=pageBooks.get(i);
	      			%>
	      			<tr>
	    	        <td><%=book.getBookname() %></td>
	    	        <td><%=book.getPrice() %></td>
	    	        <td><%=book.getStock() %></td>
	    	        <td><%=book.getDescription() %></td>
	    	        <td>
	    	        	<div class="btn-group">
						    <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
						       Opers:
						    </button>
						    <div class="dropdown-menu">
						      <a class="dropdown-item btn btn-link" href="cartitemAdd.jsp?bookid=<%=book.getBookid()%>&userid=<%=userid %>">Add To Cart</a>
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
	  	 		<li class="page-item disabled"><a class="page-link" href="homepage.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="homepage.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>&userid=<%=userid%>">1</a></li>
	  			<li class="page-item disabled"><a class="page-link" href="homepage.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(totalPage>=2){
	  	 	if(currentPage==1){
	  	 		%>
	  	 		<li class="page-item disabled"><a class="page-link" href="homepage.jsp">Previous</a></li>
	  			<li class="page-item active"><a class="page-link" href="homepage.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>&userid=<%=userid%>">1</a></li>
	  			<%
		  	 	for(int i=2;i<=totalPage;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="homepage.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>&userid=<%=userid%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="homepage.jsp?currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>&userid=<%=userid%>">Next</a></li>
	  			<%
	  	 	}
	  	 	else if(currentPage==totalPage){
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="homepage.jsp?currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>&userid=<%=userid%>">Previous</a></li>
	  			<%
		  	 	for(int i=1;i<=totalPage-1;i++){
	  			%>
	  			<li class="page-item"><a class="page-link" href="homepage.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>&userid=<%=userid%>"><%=i%></a></li>
		  	 	<%
		  	 	}
	  			%>
	  			<li class="page-item active"><a class="page-link" href="homepage.jsp?currentPage=<%=currentPage%>&pageSize=<%=pageSize%>&userid=<%=userid%>"><%=currentPage%></a></li>
	  			<li class="page-item disabled"><a class="page-link" href="homepage.jsp">Next</a></li>
	  			<%
	  	 	}
	  	 	else{//totalPage>=3
	  	 		%>
	  	 		<li class="page-item"><a class="page-link" href="homepage.jsp?currentPage=<%=currentPage-1%>&pageSize=<%=pageSize%>&userid=<%=userid%>">Previous</a></li>
	  			<%	
		  	 	for(int i=1;i<=totalPage;i++){
		  	 		if(currentPage==i){
		  	 			%>
			  			<li class="page-item active"><a class="page-link" href="homepage.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>&userid=<%=userid%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 		else{
		  	 			%>
			  			<li class="page-item"><a class="page-link" href="homepage.jsp?currentPage=<%=i%>&pageSize=<%=pageSize%>&userid=<%=userid%>"><%=i%></a></li>
				  	 	<%
		  	 		}
		  	 	}
	  			%>
	  			<li class="page-item"><a class="page-link" href="homepage.jsp?currentPage=<%=currentPage+1%>&pageSize=<%=pageSize%>&userid=<%=userid%>">Next</a></li>
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
		        <a class="dropdown-item" href="homepage.jsp?currentPage=<%=1%>&pageSize=3&userid=<%=userid%>">3</a>
		        <a class="dropdown-item" href="homepage.jsp?currentPage=<%=1%>&pageSize=5&userid=<%=userid%>">5</a>
		        <a class="dropdown-item" href="homepage.jsp?currentPage=<%=1%>&pageSize=10&userid=<%=userid%>">10</a>
		        <a class="dropdown-item" href="homepage.jsp?currentPage=<%=1%>&pageSize=20&userid=<%=userid%>">20</a>
		      </div>
		    </div>
	  	 </li>
		</ul>
	</div>

<script type="text/javascript">
	function onSearch(form){
		var content=form.searchContent.value;
		form.searchContent.value=content;
		window.location.href="homepage.jsp?content="+content+"&userid="+<%=userid%>;
	}
	</script>
</body>
</html>