<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy, java.io.*" %>
<!DOCTYPE html>
<html>

<head>
  <%
    MultipartRequest multipartRequest = null;
    String uploadPath = "/var/lib/tomcat9/webapps/ROOT/ch07_2/img/";
    String encType = "UTF-8";
    int maxFileSize = 5 * 1024 * 1024;
    String imgname = null;

    try {
      // 파일 업로드
      multipartRequest = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());

      // 저장한 파일명 변수에 저장
      Enumeration files = multipartRequest.getFileNames();
      String file = (String)files.nextElement();
      String fileName = multipartRequest.getFilesystemName(file);

      // 상품 번호에 해당하는 디렉토리 생성
      File dir = new File(uploadPath + "/" + multipartRequest.getParameter("pid"));
      dir.mkdir();
      Runtime.getRuntime().exec("chmod -R 777 " + dir);

      // 해당 디렉토리로 파일 이동
      File oldFile = new File(uploadPath + fileName);
      File newFile = new File(uploadPath + "/" + multipartRequest.getParameter("pid") + "/" + fileName);
      oldFile.renameTo(newFile);

      // DB에 저장할 파일위치+파일명 변수에 저장
      imgname = multipartRequest.getParameter("pid") + "/" + fileName;

    } catch (Exception e) { }
    
    // DB 트렌젝션
    int pid = Integer.parseInt(multipartRequest.getParameter("pid"));
    String pname = multipartRequest.getParameter("pname");
    int pstock = Integer.parseInt(multipartRequest.getParameter("pstock"));
    String regdate = multipartRequest.getParameter("regdate");
    String chkdate = multipartRequest.getParameter("chkdate");
    String pcontent = multipartRequest.getParameter("pcontent");
    
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "abcd1234");	
    
    String query1 = "insert into stock_twice(pid, pname, pstock, regdate, chkdate, pcontent, imgname) values(?, ?, ?, ?, ?, ?, ?);";
    
    PreparedStatement pstmt = conn.prepareStatement(query1);
    
    pstmt.setInt(1, pid);
    pstmt.setString(2, pname);
    pstmt.setInt(3, pstock);
    pstmt.setString(4, regdate);
    pstmt.setString(5, chkdate);
    pstmt.setString(6, pcontent);
    pstmt.setString(7, imgname);
    
    pstmt.executeUpdate();
    
    String query2 = "select pid from stock_twice order by pid desc limit 1";
    
    pstmt = conn.prepareStatement(query2);
    
    ResultSet rset = pstmt.executeQuery();
    
    rset.next();
    
    int newId = rset.getInt(1);
    
    pstmt.close();
    conn.close();
  %>
  <script>
    alert("등록 완료");
    window.location.href = "stock_view.jsp?id=<%= newId%>";
  </script>
</head>

<body>
  
</body>

</html>