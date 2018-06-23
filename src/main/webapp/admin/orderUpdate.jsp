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
		String orderidStr=request.getParameter("orderid");
		int orderid=Integer.parseInt(orderidStr);
		Order order=new Order();
		order=OrderDao.getInstance().getOrderById(orderid);
	%>
</head>
<body>
	<div class="container">
	   <div class="jumbotron">
	        <h1>更新订单状态</h1>
	   </div>
	</div>
	<div class="container">
        <div class="row">
            <!-- form: -->
                <div class="col-lg-8 col-lg-offset-2">
                    
                    <form id="updateOrderForm" method="post" class="form-horizontal" action="" onsubmit="updateOrder(this)" ><!-- action="LoginServlet" -->
                        <input type="hidden" id="userid" name="userid" value="<%=order.getUserid()%>"/>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">orderid:</label>
                            <div class="col-lg-5">
                            	<input type="text" id="orderid" class="form-control" name="orderid" value="<%=order.getOrderid()%>" disabled="disabled"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">status:</label>
                            <div class="col-lg-5">
                                <input type="text" id="status" class="form-control" name="status" value="<%=order.getStatus()%>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Status Number</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" value="0:未付款，1：已付款 未处理，2：已发货" readonly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Meaning :</label>
                            <div class="col-lg-5">
                                <input type="text" class="form-control" value="3：已收货，4：已过期" readonly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                            	<input type="submit" class="btn btn-primary" value="Save"/>
                                <!--  <button type="button" class="btn btn-primary" id="validateBtn">Validate</button>-->
                                <button type="button" class="btn btn-info" id="resetBtn">Reset</button>
                                <a href="adminOrder.jsp"><button type="button" class="btn btn-link">AdminHome</button></a> 
                            </div>
                        </div>
                    </form>
                </div>
            <!-- :form -->
        </div>
    </div>
 
<script type="text/javascript">
$(document).ready(function() {
    
    $('#updateOrderForm').bootstrapValidator({
//        live: 'disabled',
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            status:{
                validators: {
                	notEmpty: {
                        message: 'The status is required and cannot be empty'
                    },
                    stringLength: {
                        min: 1,
                        max: 1,
                        message: 'The status must be only 1 character long'
                    },
                    regexp: {
                        regexp: /^[0-4]$/,
                        message: 'The status must be a number between 0 and 4'
                    }
                }
            }
        }
    });
    
    // Validate the form manually
    $('#validateBtn').click(function() {
        $('#addOrderForm').bootstrapValidator('validate');
    });

    $('#resetBtn').click(function() {
        $('#addOrderForm').data('bootstrapValidator').resetForm(true);
    });
});

function updateOrder(form){
	var status=form.status.value;

	var userid=form.userid.value;
	var orderid=form.orderid.value;
	var url="../AddOrUpdateOrderServlet?orderid="+orderid+"&userid="+userid+"&status="+status;
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
		    if(xmlhttp.responseText!="updateOrderT"){
			    alert("Something wrong when update this order!");
			}else{
				alert("Update succeed!");
			}
	    }
	  }
	  xmlhttp.send();
}
</script> 
</body>
</html>