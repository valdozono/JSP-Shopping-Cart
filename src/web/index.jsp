<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<jsp:useBean id="userBean" scope="session" class="vanier.assignment.UserBean" />
<jsp:useBean id="db" scope="session" class="vanier.assignment.DBManager" />


<%
    int addedProduct = 0;

    if (request.getMethod().equals("POST")) {
        int productId = Integer.parseInt(request.getParameter("PRODUCT_ID"));
        int quantity = Integer.parseInt(request.getParameter("QUANTITY"));

        if (session.getAttribute("cart") == null) {
            Map<Integer, Integer> cart = new HashMap();
            session.setAttribute("cart", cart);
        }

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        cart.put(productId, quantity);
        session.setAttribute("cart", cart);

        addedProduct = productId;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Store</title>

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
                        <li class="active"><a href="index.jsp">Home</a></li>
                        <li><a href="about.html">About</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </div>

        <div class="container">

            <div class="starter-template">
                <div style=" width:100%">
                    <h3 style="display:inline-block; width: 90%;">
                        <%
                            if (!userBean.getUsername().equals("N/A")) {
                                out.println("Hello, <b>" + userBean.getUsername() + "</b>");

                                out.println("<a href=\"logout.jsp\">| Logout</a>");
                                userBean.setPassword("N/A");
                            } else {
                                out.println("<a href=\"login.jsp\">Login</a>" + " / " + "<a href=\"register.jsp\">Register</a>");
                            }
                        %>

                    </h3>

                    <a class="btn  btn-success" type="button" href="cart.jsp">VIEW CART</a>
                </div>
                <div class="row" style="margin-top: 10px;">


                    <%
                        ArrayList<ArrayList<String>> myArray1 = db.getAllProducts();
                        for (ArrayList<String> rows : myArray1) {%>  

                    <div class="col-md-4">
                        <div style="height: 195px; padding: 0px 30px; background: #fff; border: 1px solid #ccc;margin-bottom: 20px;border-radius:5px;">
                            <h3><%=rows.get(1)%></h3>

                            <span class="label label-danger"><em>$<%=rows.get(2)%></em></span>

                            <form method="post">
                                <input type="hidden" name="PRODUCT_ID" value="<%=rows.get(0)%>">
                                <div class="row" style="margin-top:10px; margin-bottom: 12px;">
                                    <div class="col-md-6">
                                        <select class="form-control" name="QUANTITY">
                                            <%
                                                for (int i = 1; i <= Integer.parseInt(rows.get(3)); i++) {
                                            %>
                                            <option value="<%=i%>"><%=i%> unit(s)
                                                <%
                                                    }
                                                %>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <button type="submit" class="btn btn-primary">ADD TO CART</button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <%
                                            if (addedProduct == Integer.parseInt(rows.get(0))) {
                                        %><div class="alert alert-success" style="padding:12px !important;" role="alert"><strong>Added to Cart!</strong></div><%
                                            }
                                        %>
                                    </div>
                                </div>

                            </form>

                        </div></div>
                        <% }%>
                </div>

            </div>

        </div>

    </div><!-- /.container -->

    <div id="footer" style="margin-top: 100px;">
        <div class="container">
            <p class="muted credit">Developed by <a href="#">Victor Hilotii</a>, <a href="#">Georgi Vasilev</a> and <a href="#">Volodymyr Zubko</a>.</p>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>
