<%@page import="vanier.assignment.DBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="userBean" scope="page" class="vanier.assignment.UserBean" />
<jsp:useBean id="db" scope="session" class="vanier.assignment.DBManager" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrative Login</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp">E-commerce</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="about.html">About</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </div>
        <div class="container">
            <form name="login" action="" method="POST" class="form-signin" role="form">
                <h2 class="form-signin-heading">Administrator Login!</h2>
                <input class="form-control" type="text" name="username" value="" placeholder="Username" required autofocus>
                <input class="form-control" type="password" name="password" value="" placeholder="Password" required>
                <button class="btn btn-lg btn-primary btn-block" type="submit">OK!</button>
            </form>

            <jsp:setProperty name="userBean" property="username" />
            <jsp:setProperty name="userBean" property="password" />
            <%! String message = "";
                                                                 %>


            <br>
            <h2 style="color: #D42323; text-align: center;">
                <%
                    if (db.isValidAdminLogin(userBean)) {
                        response.sendRedirect("adminInterface.jsp");
                    } else {

                        if ((userBean.getUsername() != "N/A") || (userBean.getPassword() != "N/A")) {
                            message = "Invalid login or password!";
                            out.print(message);
                            session.invalidate();
                        }
                    }
                    userBean.setUsername("N/A");
                    userBean.setPassword("N/A");
                %>

            </h2>
        </div>

        <div id="footer" style="margin-top: 100px;">
            <div class="container">
                <p class="muted credit">Developed by <a href="#">Victor Hilotii</a>, <a href="#">Georgi Vasilev</a> and <a href="#">Volodymyr Zubko</a>.</p>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </body>
</html>
