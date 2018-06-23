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
	        <h1>创建新用户</h1>
	   </div>
	</div>
	<div class="container">
        <div class="row">
            <!-- form: -->
            
                <div class="col-lg-8 col-lg-offset-2">
                    
                    <form id="addUserForm" method="post" class="form-horizontal" action="" onsubmit="addUser(this)" ><!-- action="LoginServlet" -->
                        <div class="form-group">
                            <label class="col-lg-3 control-label">username:</label>
                            <div class="col-lg-5">
                                <input type="text" id="username" class="form-control" name="username" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">password:</label>
                            <div class="col-lg-5">
                                <input type="text" id="password" class="form-control" name="password" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">phone:</label>
                            <div class="col-lg-5">
                                <input type="text" id="phone" class="form-control" name="phone" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                            	<input type="submit" class="btn btn-primary" value="Save"/>
                                <!--  <button type="button" class="btn btn-primary" id="validateBtn">Validate</button>-->
                                <button type="button" class="btn btn-info" id="resetBtn">Reset</button>
                                <a href="adminUser.jsp"><button type="button" class="btn btn-link">AdminHome</button></a> 
                            </div>
                        </div>
                    </form>
                </div>
            <!-- :form -->
        </div>
    </div>
 
<script type="text/javascript">

$(document).ready(function() {
    
    $('#addUserForm').bootstrapValidator({
//        live: 'disabled',
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            username: {
                message: 'The username is not valid',
                validators: {
                    notEmpty: {
                        message: 'The username is required and cannot be empty'
                    }
                }
            },
            password: {
                validators: {
                    notEmpty: {
                        message: 'The password is required and cannot be empty'
                    },
                    stringLength: {
                        min: 5,
                        max: 11,
                        message: 'The password must be more than 5 characters or less than 11 characters long'
                    },
                    regexp: {
                        regexp: /^[0-9a-zA-Z]+$/,
                        message: 'The password can only consist of number or characters'
                    }
                    
                }
            },
            phone:{
                validators: {
                    stringLength: {
                        min: 6,
                        max: 13,
                        message: 'The phone must be more than 6 or less than 13 characters long'
                    },
                    regexp: {
                        regexp: /^1[0-9]{5,12}$/,
                        message: 'The phone must be like 1xxx and can only consist of numbers'
                    }
                }
            }
        }
    });
    
    // Validate the form manually
    $('#validateBtn').click(function() {
        $('#addUserForm').bootstrapValidator('validate');
    });

    $('#resetBtn').click(function() {
        $('#addUserForm').data('bootstrapValidator').resetForm(true);
    });
});
function addUser(form){
	var username=form.username.value;
	var password=form.password.value;
	var phone=form.phone.value;
	
	var url="../AddOrUpdateUserServlet?username="+username+"&password="+password+"&phone="+phone;
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
		    if(xmlhttp.responseText!="saveUserT"){
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