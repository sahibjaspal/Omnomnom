<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Request.QueryString["name"];
        Label2.Text = Request.QueryString["nuid"];
        Label3.Text = Request.QueryString["email"];
        Label4.Text = Request.QueryString["cell"];



    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ASP Form 2</title>
    <link rel="stylesheet" href="asp experiments/css/CSS.css" />
</head>
<body>
    <form id="form2" runat="server">
    <div class="maindiv">
        <br />
        <br />

        <h1>Your Personal Information has been passed onto this page:</h1>

        <br />
        <br />

        Name: <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>

        <br />
        <br />

        NUID: <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>

        <br />
        <br />

        Email: <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>

        <br />
        <br />

        Cell: <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
    
    </div>
    </form>

     <br />
    <br />

      <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/asp experiments/aspform2.aspx">ASPX Source</a>
  
</body>
