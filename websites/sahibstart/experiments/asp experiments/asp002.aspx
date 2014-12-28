<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Loops in ASP</title>
    Purpose: To illustrate how a loop can be iterated dynamically.

    <link rel="stylesheet" href="css/CSS.css"

</head>
<body>
    <form id="form1" runat="server">
    <div class="maindiv">
        <br />
        <br />
        <ul>
    <% for(int i=0; i<10 ; i++) {%>
        <li>Hello World <%=i %></li>    
        <%} %>
        </ul>

    </div>
    </form>

     <br />
    <br />

      <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/asp experiments/asp002.aspx">ASPX Source</a>
  
</body>
</html>