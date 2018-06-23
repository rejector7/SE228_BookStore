<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.util.*,dao.*,entity.*,servlet.*"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

  <head>
     <title>管理员页面</title>
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
	<div class="container">
	   <div class="jumbotron">
	        <h1>管理员登录</h1>
	   </div>
	</div>
    <div class="container">
        <div class="row">
            <!-- form: -->
            
                <div class="col-lg-8 col-lg-offset-2">
                    
                    <form id="loginForm" method="post" class="form-horizontal" action="" onsubmit="loginSubmit(this)" ><!-- action="LoginServlet" -->
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Adminname:</label>
                            <div class="col-lg-5">
                                <input type="text" id="adminname" class="form-control" name="adminname" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Password:</label>
                            <div class="col-lg-5">
                                <input type="password" id="password" class="form-control" name="password" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                            	<input type="submit" class="btn btn-primary" value="Login"/>
                                <!--  <button type="button" class="btn btn-primary" id="validateBtn">Validate</button>-->
                                <button type="button" class="btn btn-info" id="resetBtn">Reset</button>
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
            adminname: {
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

function loginSubmit(form){
	var adminname=form.adminname.value;
	var password=form.password.value;
	var url="../LoginServlet?adminname="+adminname+"&password="+password;
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
			    alert("Wrong adminname or password!");
				form.adminname.value="";
				form.password.value="";
				form.adminname.focus();
			}else{
				window.location.href="adminHomepage.jsp";
			}
	    }
	  }
	  xmlhttp.send();
}

/*
function loginSubmit(form){
	var param="adminname="+form.adminname.value+"&password="+form.password.value;
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
		alert("Wrong adminname or password!")
		form.adminname.value=="";
		form.password.value=="";
		form.adminname.focus();
	}
}
*/
</script>
</body>
</html>
