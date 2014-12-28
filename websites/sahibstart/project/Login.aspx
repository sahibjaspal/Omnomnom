<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

//page load
    protected void Page_Load(object sender, EventArgs e)
    {
        lblLoginMsg.Visible = false;
        
        if (Session["User"] != null)
        {
            Response.Redirect("HomePage.aspx");

        }
       

        if (!Page.IsPostBack)
        {
            ViewState["GoBackTo"] = Request.UrlReferrer;
        }
       
    }
    
    
    //login button click function. validates user.
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        lblLoginMsg.Visible = false;

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
            string password = passCom.ExecuteScalar().ToString().Replace(" ", "");
            if (password == txtPassword.Text)
            {
                Session["User"] = txtUserName.Text;
                Response.Redirect(ViewState["GoBackTo"].ToString());
            }
            else
            {
                //Response.Write("Password is not Correct");
                lblLoginMsg.Visible = true;
            }

        }
        else
        {
            lblLoginMsg.Visible = true;
           // Response.Write("UserName is not Correct");

        }
    }


    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
    <title>OMNOMNOM | Login</title>
      <link type="text/css" rel="stylesheet" href="../css/bootstrap/css/bootstrap.css" />
     <link type="text/css" rel="stylesheet" href="CSS/LoginCSS.css" />
    
</head>

<body>
    <form id="form1" runat="server">
         
             <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="HomePage.aspx" ><img class="logoimg" src="../images/omnomnom3.png" height="35" /></a>
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-main">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
            </div>
            <div class="collapse navbar-collapse" id="navbar-main">
                <ul class="nav navbar-nav">
                    
                    <li><a href="HomePage.aspx">Home</a></li>
                    <li><a href="UserProfile.aspx">Profile</a></li>
                    
                    <li><a href="ContactUs.aspx">ContactUs</a></li>
                    <li></li>
                    <li><a href="#" id="welcomered">Welcome!</a></li>
                    
                </ul>
                
            </div>
        </div><!-- container -->
</div>
             
             
      <div class="loginpanel">
          
          <div class="container loginform">
              
              <div class="logintable">

                  <div>
                      <asp:Label ID="lblLoginMsg" runat="server" Text="Invalid Username/Password"></asp:Label>
                      <br />
                      <label class="lbllogin">Log In</label>

                  </div>


                  <table class="nav-justified">
                      <tr>
                          <td class="auto-style1"><label class="lblUserName">UserName:</label></td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtUserName" runat="server" Height="30px" Width="172px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="Please Enter a UserName" ForeColor="#CA4242"></asp:RequiredFieldValidator>
                          </td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1"><label class="lblPassword">Password:</label></td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtPassword" runat="server" Height="30px" TextMode="Password" Width="172px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Please Enter a Password" ForeColor="#CA4242"></asp:RequiredFieldValidator>
                          </td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">
                              <asp:Button ID="btnLogin" CssClass="btn" runat="server" OnClick="btnLogin_Click"  Text="Login" Width="177px" />
                          </td>
                          <td>&nbsp;</td>
                      </tr>
                  </table>


              </div>
              
             


          </div>
          
          </div>

     <div class="connectwithus">
          <hr />
          <div class="container">
              <center>
              <div class="bottomlogo">
              
              <img src="../images/omnomnom3.png" /><br />
              <label>For the love of food</label>
          </div>
                  </center>

              <div class="socialtags">


              </div>
              <center>
              <div id="footerimage">
                  
                  <img src="../images/footer.JPG" class="img-responsive" />
              </div>
                  </center>
              </div>
       </div>
    </form>
</body>
</html>
<script type="text/javascript" src="../javascript/jquery-2.1.0.min.js"></script>
    <script type="text/javascript" src="../css/bootstrap/js/bootstrap.js"></script>

<script type="text/javascript">


    //disable user link
    $("#welcomered").click(function (e) {

        e.preventDefault();
    });

</script>