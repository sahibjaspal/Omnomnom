<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnCreateSession_Click(object sender, EventArgs e)
    {
        Session["Username"] = txtUserName.Text.Trim();
    }

    protected void btnRetrieveSession_Click(object sender, EventArgs e)
    {
        DisplaySessionValue();
    }

    protected void btnRemoveSession_Click(object sender, EventArgs e)
    {
        Session.Remove("Username");

        DisplaySessionValue();
    }

    protected void btnRemoveAll_Click(object sender, EventArgs e)
    {
        Session.RemoveAll();

        DisplaySessionValue();
    }

    private void DisplaySessionValue()
    {
        if (Session["Username"] != null)
            lblSessionValue.Text = Convert.ToString(Session["Username"]);
        else
            lblSessionValue.Text = "No Value has been stored in session";
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Session Handling</title>
</head>
    <link type="text/css" rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />
<body>
    <form id="form1" runat="server">
        <div class="well">
            <h1>Purpose: To show how sessions are handled in asp.net</h1>
            <h3>Use in Project: Will be used in project to maintain different sessions for different users.</h3>
            <h4>Brief description: The username is stored in a session variable and can be sent to the next page, which can futher propagate the session.</h4>
        <br />
            <br />
        </div>
    <div class="well container">
        
            <h3>How to use Session</h3>
            <div>
            Userame:<br />
            <asp:TextBox ID="txtUserName" runat="server" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" Display="Dynamic"
             CssClass="validator"  ControlToValidate="txtUserName"
             ErrorMessage="Username is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <asp:Button ID="btnCreateSession" runat="server" 
                    Text="Click to Create Session" onclick="btnCreateSession_Click" />
                <br />
                <br />
                
                <asp:Button ID="btnRetrieveSession" runat="server" CausesValidation="false" 
                    Text="Click to Retrieve Session Value" onclick="btnRetrieveSession_Click" />
                <br />
                <br />
                <asp:Button ID="btnRemoveSession" runat="server" CausesValidation="false" 
                    Text="Click to Remove Session Value" onclick="btnRemoveSession_Click" />
                <br />
                <br />
                <asp:Button ID="btnRemoveAll" runat="server" CausesValidation="false" 
                    Text="Click to Remove All Sessions" onclick="btnRemoveAll_Click" />
            </div>
            <p>
                Note: 1st create a session by providing user name in text field, then you can retrieve the value from session.
            </p>
            <div>
                Value stored in Session: 
                <strong><asp:Label ID="lblSessionValue" runat="server"></asp:Label></strong>
            </div>
       
    </div>
    </form>
</body>
</html>
