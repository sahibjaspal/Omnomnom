<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    public void Page_Load(Object sender, EventArgs e)
    {
      
    }

    protected void btnStoreCookies_Click(object sender, EventArgs e)
    {
        
        HttpCookie cookie = new HttpCookie("MyName");
         //cookie expired in 10 mins, user will have to recreate it.
        cookie.Expires = DateTime.Now.AddMinutes(10);
        cookie.Value = txtStoreCookies.Text;
        HttpContext.Current.Response.Cookies.Add(cookie);
    }

    protected void btnRetrieveCookies_Click(object sender, EventArgs e)
    {
        //retrieve cookie value
        try
        {
            var cookie = HttpContext.Current.Request.Cookies["MyName"];
            if (cookie != null)
            {
                lblCookies.Text = cookie.Value;
            }
        }
        catch (Exception error)
        {

        }
    }
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cookies in Asp.net</title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="well">
        <h1>
            Purpose: To show how values can be stored in a cookie.
        </h1>
        <h2>Brief Description: We can to store a value into the browser cookie using HTTP cookies and then retrieve them or propagate them for faster retrieval.<br />
            The cookie expire time has to be specified and after the cookie expires the user wil have to store it again.
        </h2>
        <h2>
            Use in Project: This can be used in the project to store specific user data, such as Food Interests, User name etc.
        </h2>
        <br />
        <div class="well container">
            <asp:Label ID="Label1" runat="server" Text="Value Retrieved From Cookies : " />
            <asp:Label ID="lblCookies" CssClass="UserControlDiv" runat="server" />
            <br /><br />
            <asp:TextBox ID="txtStoreCookies" runat="server" /> <asp:Button OnClick="btnStoreCookies_Click" runat="server" ID="btnStoreCookies" CssClass="button" Text="Store In Cookies" />
            <br /><br />
            <asp:Button runat="server" ID="btnRetrieveCookies" Text="Retrieve From Cookies" CssClass="button" OnClick="btnRetrieveCookies_Click" />
        </div>
    </div>
    </form>
</body>
</html>
