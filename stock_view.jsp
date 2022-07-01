<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="./stock_error.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>재고 상세 조회</title>
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
    .table-view {
      width: 600px;
      border-collapse: collapse;
    }
    .table-view td {
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
    div.div-button {
      text-align: right;
    }
    textarea {
      width: 98%;
      height: 3em;
      border: none;
      resize: none;
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

    <h1>재고 상세 조회</h1>

    <table class="table-view">
      <tr>
        <td class="title"><b>삼품 번호</b></td>
        <td width="450px"><%= rset.getString("pid")%></td>
      </tr>
      <tr>
        <td class="title"><b>상품명</b></td>
        <td><%= rset.getString("pname")%></td>
      </tr>
      <tr>
        <td class="title"><b>재고 현황</b></td>
        <td><%= rset.getInt("pstock")%></td>
      </tr>
      <tr>
        <td class="title"><b>재고 파악일</b></td>
        <td><%= rset.getDate("chkdate")%></td>
      </tr>
      <tr>
        <td class="title"><b>상품 등록일</b></td>
        <td><%= rset.getDate("regdate")%></td>
      </tr>
      <tr>
        <td class="title"><b>상품 설명</b></td>
        <td>
          <textarea><%= rset.getString("pcontent")%></textarea>
        </td>
      </tr>
      <tr>
        <td class="title"><b>상품 사진</b></td>
        <td><img src="./img/<%= rset.getString("imgname")%>"></td>
      </tr>
    </table>

    <br>
    
    <div class="div-button">
      <input type="button" value="목록" onclick="location.href='stock_list.jsp'">
      <input type="button" value="수정" onclick="location.href='stock_updateForm.jsp?id=<%= rset.getString("pid")%>'">
    </div>
  </div>
  <%	
    rset.close();	
    pstmt.close();	
    conn.close();	
  %>
</body>

</html>