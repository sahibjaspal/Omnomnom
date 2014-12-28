<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Label1.Text = "Hey! You just clicked me!";
    }
</script>

<head id="Head1" runat="server">
    <title>ASP Buttons</title>
   Purpose: To depict the working of buttons and other ASP.NET form elements

<link rel="stylesheet" href="css/CSS.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="maindiv">
        <br />
        <br />

       <asp:Button ID="Button1" runat="server" Text="ClickMe!" OnClick="Button1_Click" />
        <br />
        <br />

       <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>
    </form>

     <br />
    <br />

      <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/asp experiments/asp003.aspx">ASPX Source</a>
  
</body>
</html>

