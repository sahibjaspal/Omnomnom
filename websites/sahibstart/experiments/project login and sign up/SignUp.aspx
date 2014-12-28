<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(Object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();
            string checkuser = "select count(*) from UserData where UserName = '" + txtUserName.Text + "'";
            System.Data.SqlClient.SqlCommand com = new System.Data.SqlClient.SqlCommand(checkuser, conn);
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            conn.Close();
            if (temp == 1)
            {
                Response.Write("User Already exists!");
            }
            
           
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
           

            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();
            
            string insertuser = "insert into UserData (UserName,Email,Password) values (@UserName, @email, @password)";
            System.Data.SqlClient.SqlCommand insertcom = new System.Data.SqlClient.SqlCommand(insertuser, conn);
      
            insertcom.Parameters.AddWithValue("@UserName", txtUserName.Text);
            insertcom.Parameters.AddWithValue("@Email", txtEmail.Text);
            insertcom.Parameters.AddWithValue("Password", txtPassword.Text);

            insertcom.ExecuteNonQuery();
            Response.Redirect("ViewUserData.aspx");
            conn.Close();
        
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.ToString());
        }

        
        

    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            text-align: right;
            width: 200px;
        }
        .auto-style3 {
            width: 200px;
        }
        .auto-style4 {
            width: 190px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">User Name:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtUserName" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="UserName is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">E-mail:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtEmail" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter valid email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Password:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Confirm Password:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                    <br />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Password doesn't match" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Sign Up" />
                    <input id="Reset1" type="reset" value="Reset" /></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
