<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ASP Texts</title>
    <h1>Purpose: To depict static and dynamic texts in ASP.NET</h1>
    <link rel="stylesheet" href="css/CSS.css" />
     
</head>
<body>
    <form id="form1" runat="server">
        <p>
            <h4>This experiment has been done to understand the static and dynamic concept in asp.net pages.</h4>

        </p>
    <div class="maindiv">
    Hello World ASP.NET! This is static.

        <br />
        <br />


        <%string hello = "Hello World from ASP.NET. This is dynamic."; %>

        <%=hello %>
    </div>
    </form>
    <br />
    <br />

      <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/asp experiments/asp001.aspx">ASPX Source</a>
  
</body>
</html>
