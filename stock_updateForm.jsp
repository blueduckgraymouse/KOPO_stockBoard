<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="./stock_error.jsp" %>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>상품 재고 수정</title>
  <style>
    .container {
      max-width: 600px;
      margin:0 auto;
    }
    table {
      text-align: center;
    }
    td {
      border: 1px solid black;
    }
    .table-update {
      width: 600px;
      border-collapse: collapse;
    }
    .table-update td {
      height: 30px;
      border: 1px solid grey;
    }
    td.title {
      border-right: 3px double grey;
      background-color: lightgrey;
    }
    .align-left {
      text-align: right;
    }
    a {
      color: black;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    textarea {
      width: 450px; 
      height: 250px;
    }
    div.div-button {
      text-align: right;
    }
    img {
      width: 99%;
    }
    </style>
    <%
      int id = Integer.parseInt(request.getParameter("id"));
    
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "abcd1234");	
      
      String query = "select * from stock_twice where pid=?";
  
      PreparedStatement pstmt = conn.prepareStatement(query);
      
      pstmt.setInt(1, id);
  
      ResultSet rset = pstmt.executeQuery();
      rset.next();
    %>
</head>

<body>
  
  <div class="container">
    <jsp:include page="stock_banner.jsp"/>

    <h1>상품 재고 수정</h1>

    <form method="post" action="stock_update.jsp">
      <table class="table-update">
        <tr>
          <td class="title"><b>상품 번호</b></td>
          <td width="450px">
            <%= rset.getInt("pid")%>
            <input type="hidden" name="pid" value="<%= id%>">
          </td>
        </tr>
        <tr>
          <td class="title"><b>상품명</b></td>
          <td>
            <%= rset.getString("pname")%>
          </td>
        </tr>
        <tr>
          <td class="title"><b>재고 현황</b></td>
          <td>
            <input type="number" name="pstock" size="63" maxlength="70" value="<%= rset.getInt("pstock")%>">
          </td>
        </tr>
        <tr>
          <td class="title"><b>상품 등록일</b></td>
          <td>
            <%= rset.getDate("regdate")%>
          </td>
        </tr>
        <tr>
          <td class="title"><b>재고 파악일</b></td>
          <td>
            <%= rset.getDate("chkdate")%>
          </td>
        </tr>
        <tr>
          <td class="title"><b>상품 설명</b></td>
          <td>
            <%= rset.getString("pcontent")%>
          </td>
        </tr>
        <tr height="481px">
          <td class="title"><b>상품 사진</b></td>
          <td><img src="./img/<%= rset.getString("imgname")%>"></td>
        </tr>
      </table>

      <br>

      <div class="div-button">
        <input type="submit" value="저장">
        <input type="button" value="삭제" onclick="location.href='stock_delete.jsp?id=<%= rset.getString("pid")%>'">
        <input type="button" value="취소" onclick="location.href='stock_list.jsp'">
      </div>
    </form>
  </div>

  <%
    rset.close();
    pstmt.close();
    conn.close();
  %>
</body>

</html>