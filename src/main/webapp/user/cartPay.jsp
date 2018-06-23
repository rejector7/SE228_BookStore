<%@ page language="java" contentType="text/html; charset=utf-8"
    import="java.util.*,dao.*,entity.*,servlet.*,org.json.*"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>下单明细</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	 
	 <!-- ionic -->
	<link href="https://cdn.bootcss.com/ionic/1.3.2/css/ionic.css" rel="stylesheet">
	<script src="https://cdn.bootcss.com/ionic/1.3.2/js/ionic.bundle.min.js"></script>
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
		
		
		
		String selectedItems=request.getParameter("selectedItems");
		String useridStr=request.getParameter("userid");
		int userid=1;
		userid=Integer.parseInt(useridStr);
		String username=null;
		username=UserDao.getInstance().getUserById(userid).getUsername();
	
		String[] itemids=selectedItems.split(",");
		int totalNum=itemids.length;
		
		
		double totalPrice=0.0;
	%>
</head>
<body>
	<div class="container">
	   <div class="jumbotron">
	        <h1>下单明细</h1>
	        <h2>Dear <%=username %></h2>
	   </div>
	</div>
	<div class="container">
		<table class="table table-hover table-bordered">
		    <thead class="thead-light">
		      <tr>
		        <th>itemid</th>
		        <th>bookname</th>
		        <th>booknum</th>
		        <th>single price</th>
		        <th>item total price</th>
		      </tr>
		    </thead>
		    <tbody>
		       <% 
		       if(totalNum!=0){
		    	   double singlePrice=0.0;
		    	   int booknum=0;
		    	   double itemTotalPrice=0.0;
		    	   int itemid=1;
			       for (int i=0;i<totalNum;i++){ 
			    	    itemid=Integer.parseInt(itemids[i]);
		      			Cartitem item=CartitemDao.getInstance().getCartitemById(itemid);
		      			//User user=UserDao.getInstance().getUserById(item.getUserid());//get the user accord to the order's userid
		      			
		      			singlePrice=BookDao.getInstance().getBookById(item.getBookid()).getPrice();
		      			booknum=item.getBooknum();
		      			itemTotalPrice=singlePrice*booknum;
		      			totalPrice+=itemTotalPrice;
		      			%>
		      			<tr>
		    	        <td><%=item.getCartitemid() %></td>
		    	        <td><%=BookDao.getInstance().getBookById(item.getBookid()).getBookname() %></td>
		    	        <td><%=booknum %></td>
		    	        <td><%=singlePrice %></td>
		    	        <td><%=itemTotalPrice %></td>
		    	      </tr>
		    	      <%
			       }
		       }
	      	  %>
		    </tbody>
		    
		  </table>
		  <h4 class="font-weight-bold">Total Price: <%=totalPrice %></h4>
		  <button type="button" class="btn btn-primary" align="right" onclick="doPay()">PAY</button>
		</div>
</body>
<script type="text/javascript">
	function doPay(){
		 <% 
	       if(totalNum!=0){
	    	   Order order=new Order();
	    	   order.setUserid(userid);
	    	   int orderid=1;
	    	   orderid=OrderDao.getInstance().getMaxId()+1;
	    	   OrderDao.getInstance().saveOrder(order);
	    	   
	    	   
	    	   int itemid=1;
	    	   int flag=1;
		       for (int i=0;i<totalNum;i++){ 
		    	    itemid=Integer.parseInt(itemids[i]);
	      			Cartitem item=CartitemDao.getInstance().getCartitemById(itemid);
	      			//User user=UserDao.getInstance().getUserById(item.getUserid());//get the user accord to the order's userid
	      			Orderitem orderitem=new Orderitem();
	      			orderitem.setOrderid(orderid);
	      			orderitem.setBookid(item.getBookid());
	      			orderitem.setBooknum(item.getBooknum());
	      			
	      			CartitemDao.getInstance().destroyCartitem(itemid);
	      			
	      			OrderitemDao.getInstance().saveOrderitem(orderitem);
	      			
	      			/*
	      			if(flag==1){
	      				int sellBooknum=0;
	      				int stock=0;
	      				sellBooknum=item.getBooknum();
	      				stock=BookDao.getInstance().getBookById(item.getBookid()).getStock();
	      				BookDao.getInstance().getBookById(item.getBookid()).setStock(stock-sellBooknum);
	      			}
	      			*/
	      			

	      			
		       }
		 if(flag==1){
			 %>
			alert("Pay succeed!");
			window.location.href="cartManage.jsp?userid=<%=userid%>";
			 <%
		 	}
		 else{
			 %>
				alert("Some parts of pay failed!");
				window.location.href="cartManage.jsp?userid=<%=userid%>";
				 <%
		 }
	      }
    	%>  
	}
</script>

</html>