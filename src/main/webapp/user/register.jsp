<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.util.*,dao.*,entity.*,servlet.*"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

  <head>
     <title>用户注册页面</title>
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   	
		<!-- æ° Bootstrap æ ¸å¿ CSS æä»¶ -->
	<link rel="stylesheet" href="../bootstrap/bootstrap.css"/>
    <link rel="stylesheet" href="../bootstrap/bootstrapValidator.css"/>

    <!-- Include the FontAwesome CSS if you want to use feedback icons provided by FontAwesome -->
    <!--<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" />-->

    <script type="text/javascript" src="../bootstrap/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="../bootstrap/bootstrapValidator.js"></script>
		
	<!--  script type="text/javascript" src ="../js/AjaxRequest.js"> </script>-->
 	<script type="text/javascript">
 	
 	</script>
 </head>
<body>
	<s:if test="hasActionErrors()">
 		<script> alert("The username has been occupied!\n Please change your username"); </script>
	 </s:if>
	 
	<div class="container">
	   <div class="jumbotron">
	        <h1>用户注册</h1>
	   </div>
	</div>
    <div class="container">
        <div class="row">
            <!-- form: -->
            
                <div class="col-lg-8 col-lg-offset-2">
                    
                    <form id="loginForm" method="post" class="form-horizontal" action="userRegisterAction" ><!-- onsubmit="loginSubmit(this)"--> <!-- action="LoginServlet" -->
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Username:</label>
                            <div class="col-lg-5">
                                <input type="text" id="username" class="form-control" name="username" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Password:</label>
                            <div class="col-lg-5">
                                <input type="password" id="password" class="form-control" name="password" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Confirm Password:</label>
                            <div class="col-lg-5">
                                <input type="password" id="confirmPassword" class="form-control" name="confirmPassword" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                            	<input type="submit" class="btn btn-primary" value="Register"/>
                                <!--  <button type="button" class="btn btn-primary" id="validateBtn">Validate</button>-->
                                <button type="button" class="btn btn-info" id="resetBtn">Reset</button>
                                <a  href="login.jsp"><button type="button" class="btn btn-info">Back</button></a>
                            </div>
                        </div>
                    </form>
                </div>
            <!-- :form -->
        </div>
    </div>

<script type="text/javascript">
$(document).ready(function() {
    
    $('#loginForm').bootstrapValidator({
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
                    },
                    stringLength: {
                        min: 5,
                        max: 30,
                        message: 'The username must be more than 5 and less than 30 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_\.]+$/,
                        message: 'The username can only consist of alphabetical, number, dot and underscore'
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
                        max: 30,
                        message: 'The password must be more than 5 and less than 30 characters long'
                    },
                    identical: {
                        field: 'confirmPassword',
                        message: 'The password and its confirm are not the same'
                    }
                }
            },
            confirmPassword:{
            	validators: {
                    notEmpty: {
                        message: 'The password is required and cannot be empty'
                    },
                    stringLength: {
                        min: 5,
                        max: 30,
                        message: 'The password must be more than 5 and less than 30 characters long'
                    },
                    identical: {
                        field: 'password',
                        message: 'The password and its confirm are not the same'
                    }
                }
            }
        }
    });
    
    // Validate the form manually
    $('#validateBtn').click(function() {
        $('#loginForm').bootstrapValidator('validate');
    });

    $('#resetBtn').click(function() {
        $('#loginForm').data('bootstrapValidator').resetForm(true);
    });
});
/*
function loginSubmit(form){
	var username=form.username.value;
	var password=form.password.value;
	var url="../LoginServlet?username="+username+"&password="+password;
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
		    if(xmlhttp.responseText!="loginT"){
			    alert("Wrong username or password!");
				form.username.value="";
				form.password.value="";
				form.username.focus();
			}else{
				window.location.href="userHomepage.jsp";
			}
	    }
	  }
	  xmlhttp.send();
}
*/
/*
function loginSubmit(form){
	var param="username="+form.username.value+"&password="+form.password.value;
	var loader=new net.AjaxRequest("LoginServlet",dealLogin,onerror,"POST",encodeURI(param));
}
function dealLogin(){
	var h=this.req.responseText;
	h=h.replace(/\s/g,"");
	if(h=="T"){
		alert("Login Succeed!");
		window.location.href="adminHomepage.jsp";
		
	}
	else{
		alert("Wrong username or password!")
		form.username.value=="";
		form.password.value=="";
		form.username.focus();
	}
}
*/
</script>
	
</body>
</html>
