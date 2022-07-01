<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
  <%
    int id = Integer.parseInt(request.getParameter("pid"));
    int stock = Integer.parseInt(request.getParameter("pstock"));
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "abcd1234");	
    
    String query = "update stock_twice set pstock=? where pid=?";

    PreparedStatement pstmt = conn.prepareStatement(query);

    pstmt.setInt(1, stock);
    pstmt.setInt(2, id);

    pstmt.executeUpdate();

    pstmt.close();
    conn.close();
  %>
  <script>
    alert("수정 완료");
    window.location.href = "stock_view.jsp?id=<%= id%>";
  </script>
</head>

<body>
  
</body>

</html>