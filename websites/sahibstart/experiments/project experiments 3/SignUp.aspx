<%@ Page Language="C#" MasterPageFile="~/experiments/project experiments 3/MasterPage.master"%>



<script runat="server">

    protected void Page_Load(Object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();
            string checkuser = "select count(*) from sahibj.UserData where UserName = '" + txtUserName.Text + "'";
            System.Data.SqlClient.SqlCommand com = new System.Data.SqlClient.SqlCommand(checkuser, conn);
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            conn.Close();
            if (temp == 1)
            {
                Response.Write("User Already exists!");
            }
            
           
        }
    }
    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        try
        {
           

            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();
        
            string insertuser = "insert into sahibj.UserData (UserName,Email,Password) values (@UserName, @email, @password)";
            System.Data.SqlClient.SqlCommand insertcom = new System.Data.SqlClient.SqlCommand(insertuser, conn);
      
            insertcom.Parameters.AddWithValue("@UserName", txtUserName.Text);
            insertcom.Parameters.AddWithValue("@email", txtEmail.Text);
            insertcom.Parameters.AddWithValue("@password", txtPassword.Text);

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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <div>
    
        <table class="auto-style1">
            <tr>
                <td class="auto-style5">User Name:</td>
                <td class="auto-style6">
                    <asp:TextBox ID="txtUserName" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td class="auto-style7">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="UserName is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style8">E-mail:</td>
                <td class="auto-style9">
                    <asp:TextBox ID="txtEmail" runat="server" Width="180px"></asp:TextBox>
                </td>
                <td class="auto-style10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter valid email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">Password:</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                </td>
                <td class="auto-style4">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">Confirm Password:</td>
                <td>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                </td>
                <td class="auto-style4">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required!" ForeColor="Red" style="text-align: left"></asp:RequiredFieldValidator>
                    <br />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Password doesn't match" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style11">&nbsp;</td>
                <td>
                    <asp:Button ID="Button1" runat="server" OnClick="btnSignUp_Click" Text="Sign Up" Width="195px" />
                    </td>
                <td class="auto-style4">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style11">&nbsp;</td>
                <td>
                    <input id="Reset1" type="reset" value="Reset" /></td>
                <td class="auto-style4">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style11">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
            </tr>
        </table>
    
    </div>
 
    </asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="head">
    <style type="text/css">
    .auto-style1 {
        width: 584px;
    }
    .auto-style3 {
        width: 156px;
        text-align: right;
    }
    .auto-style4 {
        width: 400px;
    }
    .auto-style5 {
        width: 156px;
        text-align: right;
        height: 24px;
    }
    .auto-style6 {
        height: 24px;
    }
    .auto-style7 {
        width: 400px;
        height: 24px;
    }
    .auto-style8 {
        width: 156px;
        text-align: right;
        height: 41px;
    }
    .auto-style9 {
        height: 41px;
    }
    .auto-style10 {
        width: 400px;
        height: 41px;
    }
    .auto-style11 {
        width: 156px;
    }
</style>
</asp:Content>
