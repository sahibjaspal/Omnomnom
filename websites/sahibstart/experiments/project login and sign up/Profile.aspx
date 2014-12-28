<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["New"] != null)
        {
            lblWelcome.Text += Session["New"].ToString();

        }
        else
            Response.Redirect("Login.aspx");
        
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["New"] = null;
        Response.Redirect("Login.aspx");
        
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="lblWelcome" runat="server" Text="Welcome..."></asp:Label>
        <br />
        <asp:Button ID="btnLogout" runat="server" OnClick="btnLogout_Click" Text="Logout" />
    
    </div>
    </form>
</body>
</html>
