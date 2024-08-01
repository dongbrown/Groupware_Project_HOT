<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<link href="${path }/css/common/loginpage.css" rel="stylesheet" type="text/css">
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.rawgit.com/tonystar/bootstrap-float-label/v3.0.1/dist/bootstrap-float-label.min.css"/>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Login</title>

    <!-- Custom fonts for this template-->
    <link href="${path }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${path }/css/sb-admin-2.min.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="ring">
  <i style="--clr:#ddfffb;"></i>
  <i style="--clr:#002db5;"></i>
  <i style="--clr:#5ffcff;"></i>
  <div class="login">
    <h2>Hot Logo.</h2>
    <form class="user" action="${path }/login" method="post" style="width:100%">
        <div class="inputBx">
        <input type="text" name="username" placeholder="ID">
        </div>
        <div class="inputBx">
        <input type="password" name="password"
        id="exampleInputPassword" placeholder="Password">
        </div>

        <div class="form-group" style="margin-top:10px ;">
            <div class="custom-control custom-checkbox small">
                <input type="checkbox" class="custom-control-input" id="customCheck" name="remember-me">
                <label class="custom-control-label" style="color:white; font-size:15px;" for="customCheck">Remember
                    Me</label>
            </div>
        </div>
        <div class="inputBx">
        <input id="loginBtn" type="submit" value="Login">
        </div>
    </form>
    <hr>
    <div class="text-center">
        <a id="forgotBtn" class="small" href="forgot-password.html">Forgot Password?</a>
    </div>
  </div>
</div>

    <!-- Bootstrap core JavaScript-->
    <script src="${path }/vendor/jquery/jquery.min.js"></script>
    <script src="${path }/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${path }/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${path }/js/sb-admin-2.min.js"></script>

</body>
</html>