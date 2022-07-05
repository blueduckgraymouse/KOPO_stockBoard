<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="./stock_error.jsp" %>    
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>상품 신규 등록</title>
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
    .table-input {
      width: 600px;
      border-collapse: collapse;
    }
    .table-input td {
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
      height: 50px;
    }
    div.div-button {
      text-align: right;
    }
    img {
      width: 99%;
    }
    </style>
    <%
      Date nowDate = new Date();
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    %>
</head>

<body>
  <div class="container">
    <jsp:include page="stock_banner.jsp"/>

    <h1>상품 신규 등록</h1>

    <form method="post" action="stock_insert.jsp" enctype="multipart/form-data">
      <table class="table-input">
        <tr>
          <td class="title"><b>상품 번호</b></td>
          <td width="450px">
            <input type="text" name="pid" size="63" maxlength="70">
          </td>
        </tr>
        <tr>
          <td class="title"><b>상품명</b></td>
          <td>
            <input type="text" name="pname" size="63" maxlength="70">
          </td>
        </tr>
        <tr>
          <td class="title"><b>재고 현황</b></td>
          <td>
            <input type="number" name="pstock" size="63" maxlength="70">
          </td>
        </tr>
        <tr>
          <td class="title"><b>상품 등록일</b></td>
          <td>
            <%= sdf.format(nowDate)%>
            <input type="hidden" name="regdate" value="<%= sdf.format(nowDate)%>">
          </td>
        </tr>
        <tr>
          <td class="title"><b>재고 파악일</b></td>
          <td>
            <%= sdf.format(nowDate)%>
            <input type="hidden" name="chkdate" value="<%= sdf.format(nowDate)%>">
          </td>
        </tr>
        <tr>
          <td class="title"><b>상품 설명</b></td>
          <td>
            <textarea name="pcontent" cols="70" row="600"></textarea>
          </td>
        </tr>
        <tr>
          <td class="title"><b>상품 업로드</b></td>
          <td>
            <input type="file" name="imgname" onchange="showThumbnail(this, 'thumbnail')">
          </td>
        </tr>
        <tr height="481px">
          <td class="title"><b>상품 사진</b></td>
          <td>
            <img id="thumbnail">
          </td>
        </tr>
      </table>

      <br>

      <div class="div-button">
        <input type="submit" value="등록">
        <input type="button" value="취소" onclick="location.href='stock_list.jsp'">
      </div>
    </div>
  </form>

  <script>
    // 미리보기 구현
    function showThumbnail(input, preview) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
          document.getElementById("thumbnail").src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
      }
    }

  </script>
</body>

</html>