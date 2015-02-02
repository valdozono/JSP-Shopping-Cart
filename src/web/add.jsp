<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" scope="session" class="vanier.assignment.DBManager" />



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Add Product</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.css">
    </head>
    <body>
        <div class="container">
            <%
                if (request.getMethod().equals("POST")) {
                    db.addProduct(
                            request.getParameter("DESCRIPTION"),
                            Float.parseFloat(request.getParameter("PRICE")),
                            Integer.parseInt(request.getParameter("QUANTITY"))
                    );
                    out.write("<h1 class=\"btn btn-success btn-block\">Successfully Added!</h1>");
                }
            %>
            <h1>ADD PRODUCT</h1>

            <form method="post">
                <div class="table-responsive"> 
                    <table class="table table-bordered table-striped table-responsive">
                        <thead>  
                            <tr>  
                                <td><strong>Description</strong></td>  
                                <td><strong>Price</strong></td>  
                                <td><strong>Quantity</strong></td>  
                            </tr>  
                        </thead>  
                        <tbody>
                            <tr>
                                <%
                                    String[] cols = {
                                        "DESCRIPTION",
                                        "PRICE",
                                        "QUANTITY"
                                    };

                                    for (int i = 0; i < 3; i++) {%>
                                <td>
                                    <input type="text" value="" name="<%=cols[i]%>">
                                </td>  
                                <%  }%>
                            </tr>
                        </tbody>
                    </table>  </div>
                <input type="submit" value="Add">
            </form>
            <br>
            <br>
            <a href="adminInterface.jsp">Return to list</a>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </body>
</html>
