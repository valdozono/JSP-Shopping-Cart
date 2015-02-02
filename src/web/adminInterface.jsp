<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" scope="session" class="vanier.assignment.DBManager" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrative Interface</title>
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
            <h1 class="btn btn-primary btn-block">Administrative interface</h1>

            <h2 class="btn btn-success btn-md" style="margin-bottom: 10px;">Users</h2>
            <div class="table-responsive"> 
                <table class="table table-bordered table-striped table-hover">
                    <tr>
                        <th>Username</th>
                        <th>Full name</th>
                        <th>Address</th>
                        <th>Admin?</th>
                    </tr>
                    <%
                        ArrayList<ArrayList<String>> myArray2 = db.getAllUsers();
                        for (ArrayList<String> rows : myArray2) {%>  
                    <tr>
                        <%  for (int i = 0; i < 3; i++) {%>
                        <td>
                            <%=rows.get(i)%></td>  
                            <%  }%>
                        <td><% if (rows.get(3) != null && rows.get(3).equals("1")) {
                                out.write("yes");
                            } else {
                                out.write("no");
                            } %></td>
                    </tr>
                    <% } %>
                </table></div>
            <h2 class="btn btn-warning btn-md" style="margin-bottom: 10px;">Orders</h2>
            <div class="table-responsive"> 
                <table class="table table-bordered table-striped table-hover">
                    <tr>
                        <th>Buyer</th>
                        <th>Product</th>
                        <th>Quantity</th>
                    </tr>
                    <%
                        ArrayList<ArrayList<String>> myArray3 = db.getAllOrders();
                        for (ArrayList<String> rows : myArray3) {%>  
                    <tr>
                        <%  for (int i = 0; i < 3; i++) {%>
                        <td>
                            <%=rows.get(i)%></td>  
                            <%  }%>
                    </tr>
                    <% } %>
                </table>
            </div>

            <h2 class="btn btn-info btn-md" style="margin-bottom: 10px;">Products</h2>
            <div class="table-responsive"> 
                <table class="table table-bordered table-striped table-hover">

                    <tr>  
                        <th>Description</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Available actions</th>

                    </tr>  


                    <%
                        ArrayList<ArrayList<String>> myArray1 = db.getAllProducts();
                        for (ArrayList<String> rows : myArray1) {%>  
                    <form method="POST">
                        <tr>
                            <%  for (int i = 1; i <= 3; i++) {%>
                            <td>
                                <%=rows.get(i)%></td>  
                                <%  }%>
                            <td>
                                <a href="edit.jsp?id=<%=rows.get(0)%>">
                                    <button type="button" class="btn btn-success btn-xs">
                                        Edit
                                    </button></a>
                                <a href="delete.jsp?id=<%=rows.get(0)%>">
                                    <button type="button" class="btn btn-danger btn-xs">
                                        Delete
                                    </button>
                                </a>
                            </td>
                        </tr>
                    </form>

                    <%  }%>                 

                </table></div>

            <a href="add.jsp">
                <button type="button" class="btn btn-primary btn-md">
                    <span class="glyphicon glyphicon-plus"></span> Add Product
                </button>
            </a>

            <a href="." type="button" class="btn btn-primary btn-md">
                <span class="glyphicon glyphicon-home"></span> Return to Store
            </a>

            <div id="footer" style="margin-top: 100px;">
                <div class="container">
                    <p class="muted credit">Developed by <a href="#">Victor Hilotii</a>, <a href="#">Georgi Vasilev</a> and <a href="#">Volodymyr Zubko</a>.</p>
                </div>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </body>
</html>
