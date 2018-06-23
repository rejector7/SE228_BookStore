<%@ page language="java" contentType="text/html; charset=utf-8"
    import="java.util.*,dao.*,entity.*,servlet.*"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>添加购物项</title>
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
    int userid=0;
	if(request.getParameter("userid")!=null){
		userid=Integer.parseInt(request.getParameter("userid"));
	}
	if(request.getAttribute("userid")!=null){
		userid=Integer.parseInt(request.getAttribute("userid").toString());
	}
	int bookid=0;
	if(request.getParameter("bookid")!=null){
		bookid=Integer.parseInt(request.getParameter("bookid"));
	}
	if(request.getAttribute("bookid")!=null){
		bookid=Integer.parseInt(request.getAttribute("bookid").toString());
	}
	Book book=null;
	book=BookDao.getInstance().getBookById(bookid);
    %>
</head>
<body>
	<s:if test="hasActionErrors()">
 		<script> alert("Cartitem Add Failed!"); </script>
	 </s:if>
	 <s:if test="hasActionMessages()">
        <script> alert("Cartitem Add Succeed!"); </script>
    </s:if>
	<div class="container">
	   <div class="jumbotron">
	        <h1>添加购物项</h1>
	   </div>
	</div>
	<div class="container">
        <div class="row">
            <!-- form: -->
            
                <div class="col-lg-8 col-lg-offset-2">
                    
                    <form id="cartitemAdd" method="post" class="form-horizontal" action="cartitemAddAction"  ><!-- onsubmit="cartitemAdd(this)" action="LoginServlet" -->
                        <input type="hidden" id="userid" name="userid" value="<%=userid%>"/>
                        <input type="hidden" id="bookid" name="bookid" value="<%=bookid%>"/>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">bookname:</label>
                            <div class="col-lg-5">
                                <input type="text" id="bookname" class="form-control" name="bookname" value="<%=book.getBookname()%>" readonly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">stock:</label>
                            <div class="col-lg-5">
                                <input type="text" id="stock" class="form-control" name="stock" value="<%=book.getStock() %>" readonly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">single price:</label>
                            <div class="col-lg-5">
                                <input type="text" id="price" class="form-control" name="price" value="<%=book.getPrice() %>" readonly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">description:</label>
                            <div class="col-lg-5">
                                <input type="text" id="description" class="form-control" name="description" value="<%=book.getDescription() %>" readonly="true"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">your booknum:</label>
                            <div class="col-lg-5">
                                <input type="text" id="booknum" class="form-control" name="booknum" value="<%=1 %>" />
                            </div>
                        </div>
                       
                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                            	<input type="submit" class="btn btn-primary" value="Add"/>
                                <!--  <button type="button" class="btn btn-primary" id="validateBtn">Validate</button>-->
                                <button type="button" class="btn btn-info" id="resetBtn">Reset</button>
                                <a href="homepage.jsp?userid=<%=userid%>"><button type="button" class="btn btn-link">Homepage</button></a> 
                            </div>
                        </div>
                    </form>
                </div>
            <!-- :form -->
        </div>
    </div>
 
<script type="text/javascript">
$(document).ready(function() {
    
    $('#cartitemAdd').bootstrapValidator({
//        live: 'disabled',
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            booknum:{
            	message: 'The number is not valid',
                validators: {
                    notEmpty: {
                        message: 'The number is required and cannot be empty'
                    }
                }
            }
        }
    });
    
    // Validate the form manually
    $('#validateBtn').click(function() {
        $('#cartitemAdd').bootstrapValidator('validate');
    });

    $('#resetBtn').click(function() {
        $('#cartitemAdd').data('bootstrapValidator').resetForm(true);
    });
});

/*
function cartitemAdd(form){
	var bookid=form.bookid.value;
	var number=form.number.value;
	
	var url="../AddOrUpdateBookServlet?bookname="+bookname+"&price="+price+"&stock="+stock+"&description="+description;
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
		    if(xmlhttp.responseText!="saveBookT"){
			    //alert("Something wrong when save this book!");
			}else{
				alert("Save succeed!");
			}
	    }
	  }
	  xmlhttp.send();
}*/
</script> 
</body>
</html>