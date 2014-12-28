<%@ Page Language="C#" MasterPageFile="~/experiments/project experiments 3/MasterPage.master" %>



<script runat="server">

   

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
        conn.Open();
        string checkuser = "select count(*) from sahibj.UserData where UserName = '" + txtUserName.Text + "'";
        System.Data.SqlClient.SqlCommand com = new System.Data.SqlClient.SqlCommand(checkuser, conn);
        int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
        conn.Close();
        if (temp == 1)
        {
            conn.Open();
            string checkPasswordQuery = "select password from sahibj.UserData where UserName = '" + txtUserName.Text + "'";
            System.Data.SqlClient.SqlCommand passCom = new System.Data.SqlClient.SqlCommand(checkPasswordQuery, conn);
            string password = passCom.ExecuteScalar().ToString().Replace(" ","");
            if (password == txtPassword.Text)
            {
                Session["New"] = txtUserName.Text;
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                Response.Write("Password is not Correct");

            }

        }
        else
        {

            Response.Write("UserName is not Correct");

        }

       
    }


    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="text-left">
    
        <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User Login<br />
        <br />
        <br />
        </strong></div>
        <table class="auto-style2">
            <tr>
                <td class="auto-style3">UserName:</td>
                <td class="auto-style6">
                  <asp:TextBox ID="txtUserName" runat="server" Height="21px" Width="128px"></asp:TextBox>
                </td>
                <td class="auto-style5">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="Please Enter UserName" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style6">
                    &nbsp;</td>
                <td class="auto-style5">
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">Password:</td>
                <td class="auto-style6">
                   
                    <asp:TextBox ID="txtPassword" runat="server" Height="21px" style="text-align: left" TextMode="Password" Width="130px"></asp:TextBox>
                </td>
                <td class="auto-style5">
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Please Enter Password" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style6">
                    &nbsp;</td>
                <td class="auto-style5">
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style4">
                    <%--<button id="btnLogin" style="width:100px; height:auto;"  runat="server" onclick="btnLogin_Click();"  text="Login">Login</button>--%>
                </td>
                <td class="auto-style6">
                    <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" />
                    </td>
                <td class="auto-style5">
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style4">
                    &nbsp;</td>
                <td class="auto-style6">
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/experiments/project experiments 3/SignUp.aspx">New User?</asp:HyperLink>
                </td>
                <td class="auto-style5">
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>

 </asp:Content>