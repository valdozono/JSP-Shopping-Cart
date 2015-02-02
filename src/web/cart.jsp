<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<jsp:useBean id="userBean" scope="session" class="vanier.assignment.UserBean" />
<jsp:useBean id="db" scope="session" class="vanier.assignment.DBManager" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.css">
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

            <div class="starter-template">
                <h3>
                    <%  if (!userBean.getUsername().equals("N/A")) {
                            out.println("Hello, <b>" + userBean.getUsername() + "</b>");

                            out.println("<a href=\"logout.jsp\">| Logout</a>");
                            userBean.setPassword("N/A");
                        } else {
                            out.println("<a href=\"login.jsp\">Login</a>" + " / " + "<a href=\"register.jsp\">Register</a>");
                        }
                    %>

                </h3>
                <h1 style="color:#428bca;">Products added to cart</h1>
                <div class="row" style="margin-top: 10px;">   
                    <%
                        ArrayList<ArrayList<String>> myArray1 = db.getAllProducts();
                        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

                        if (cart != null && cart.size() > 0) {
                            for (ArrayList<String> rows : myArray1) {
                                if (cart.get(Integer.parseInt(rows.get(0))) == null) {
                                    continue;
                                }
                    %>

                    <div class="col-md-4">
                        <div style=" padding: 5px 10px; background: #fff; border: 1px solid #ccc;margin-bottom: 20px;border-radius:5px;">
                            <h3><%=rows.get(1)%></h3>
                            <span class="label label-danger"><em>$<%=rows.get(2)%></em></span>
                            <hr>
                            <strong>Selected quantity: <%=cart.get(Integer.parseInt(rows.get(0)))%></strong>
                        </div></div>
                        <% }
                        %>
                </div>


                <%
                    if (!userBean.getUsername().equals("N/A")) {
                        out.print("<a class=\"btn  btn-success\" type=\"button\" href=\"checkout.jsp\">CHECKOUT</a>");
                    } else {
                        out.print("<a class=\"btn  btn-success\" type=\"button\" href=\"login.jsp\">CHECKOUT</a>");
                    }
                %>


                <%
                } else {
                %><h2 style="color:#E12A27;text-align: center;">Your cart is empty.</h2><%
                    }

                %>


            </div>
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
