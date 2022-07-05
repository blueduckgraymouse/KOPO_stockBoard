<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="./stock_error.jsp" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>

<head>
  <%
    int id = Integer.parseInt(request.getParameter("id"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "abcd1234");	
    
    String query = "delete from stock_twice where pid=?";

    PreparedStatement pstmt = conn.prepareStatement(query);

    pstmt.setInt(1, id);

    pstmt.executeUpdate();

    pstmt.close();
    conn.close();
    
    // 해당 id의 img 파일 삭제
    try {
      String path = "/var/lib/tomcat9/webapps/ROOT/ch07_2/img/" + id;
      Runtime.getRuntime().exec("chmod -R 777 " + path);

      File folder = new File(path); 
      File[] files = null;

      if (folder.exists()) {
          files = folder.listFiles();

          for (File file : files) {
            out.println("삭제");
            file.delete();
          }
      }
  } catch (Exception e) {
      e.printStackTrace();
  }
  %>
  <script>
    alert("삭제 완료");
   window.location.href = "stock_list.jsp";
  </script>
</head>

<body>
  
</body>

</html>