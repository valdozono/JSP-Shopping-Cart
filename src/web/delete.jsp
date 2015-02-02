<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" scope="session" class="vanier.assignment.DBManager" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Delete Product</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.css">
    </head>
    <body>
        <div class="container">


            <h1>Delete Product</h1>
            <%
                if (request.getMethod().equals("POST")) {
                    db.deleteProduct(
                            Integer.parseInt(request.getParameter("id"))
                    );
                    out.write("<h1 class=\"btn btn-success btn-block\">Successfully Deleted!</h1>");
                } else {
            %>
            <form method="post">
                Are you sure you want to delete product #<%=request.getParameter("id")%>?
                <button type="submit">CONFIRM</button>
            </form>
            <%
                }
            %>

            <br>
            <br>
            <div>
                <a href="adminInterface.jsp">Return to list</a>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </body>
</html>
