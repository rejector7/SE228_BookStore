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
</head>
<body>
	<div class="container">
	   <div class="jumbotron">
	        <h1>新建图书</h1>
	   </div>
	</div>
	<div class="container">
        <div class="row">
            <!-- form: -->
            
                <div class="col-lg-8 col-lg-offset-2">
                    
                    <form id="addBookForm" method="post" class="form-horizontal" action="" onsubmit="addBook(this)" ><!-- action="LoginServlet" -->
                        <div class="form-group">
                            <label class="col-lg-3 control-label">bookname:</label>
                            <div class="col-lg-5">
                                <input type="text" id="bookname" class="form-control" name="bookname" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">stock:</label>
                            <div class="col-lg-5">
                                <input type="text" id="stock" class="form-control" name="stock" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">price:</label>
                            <div class="col-lg-5">
                                <input type="text" id="price" class="form-control" name="price" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">description:</label>
                            <div class="col-lg-5">
                                <input type="text" id="description" class="form-control" name="description" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                            	<input type="submit" class="btn btn-primary" value="Save"/>
                                <!--  <button type="button" class="btn btn-primary" id="validateBtn">Validate</button>-->
                                <button type="button" class="btn btn-info" id="resetBtn">Reset</button>
                                <a href="adminHomepage.jsp"><button type="button" class="btn btn-link">AdminHome</button></a> 
                            </div>
                        </div>
                    </form>
                </div>
            <!-- :form -->
        </div>
    </div>
 
<script type="text/javascript">
$(document).ready(function() {
    
    $('#addBookForm').bootstrapValidator({
//        live: 'disabled',
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            bookname: {
                message: 'The bookname is not valid',
                validators: {
                    notEmpty: {
                        message: 'The bookname is required and cannot be empty'
                    }
                }
            },
            stock: {
                validators: {
                    notEmpty: {
                        message: 'The stock is required and cannot be empty'
                    },
                    stringLength: {
                        min: 1,
                        max: 11,
                        message: 'The stock must be less than 11 characters long'
                    },
                    regexp: {
                        regexp: /^0|([1-9][0-9]*)$/,
                        message: 'The stock can only consist of valid number'
                    }
                    
                }
            },
            price:{
                validators: {
                    notEmpty: {
                        message: 'The price is required and cannot be empty'
                    },
                    stringLength: {
                        min: 1,
                        max: 11,
                        message: 'The price must be less than 11 characters long'
                    },
                    regexp: {
                        regexp: /^(0|([1-9][0-9]*))(\.[0-9]+)?$/,
                        message: 'The price can only consist of valid double or integer'
                    }
                }
            }
        }
    });
    
    // Validate the form manually
    $('#validateBtn').click(function() {
        $('#addBookForm').bootstrapValidator('validate');
    });

    $('#resetBtn').click(function() {
        $('#addBookForm').data('bootstrapValidator').resetForm(true);
    });
});

function addBook(form){
	var bookname=form.bookname.value;
	var price=form.price.value;
	var stock=form.stock.value;
	var description=form.description.value;
	
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
}
</script> 
</body>
</html>