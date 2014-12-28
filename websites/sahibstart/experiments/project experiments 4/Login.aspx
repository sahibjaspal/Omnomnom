<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            Response.Redirect("HomePage.aspx");

        }
       
    }
    
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
            string password = passCom.ExecuteScalar().ToString().Replace(" ", "");
            if (password == txtPassword.Text)
            {
                Session["User"] = txtUserName.Text;
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />

    <style type="text/css">

        

        .logo {
        float:left;
            width:auto;
            margin-left:10%;
        }

        .navigationheader {
            padding:10px 10px;
            height:11%;
           
        }

        
       

        a{
        
           
            
            color:white;
            
            
        }
        

        body {
        
        background-color:#F5F6F1;
        }

        .outermost {
        
            width:100%;
        }

        .loginform {
        
            background-color:#FFFFFF;
            height:300px;
            
        }

        .verticalbar {
        border-left:2px solid #b61111;
            height:280px;
            float:left;
            margin-top:10px;
            margin-bottom:10px;
            margin-right:50px;
            margin-left:75px;
        }

        
        .connectwithus {
        
            margin-top:5px; 
            background-color:black;
            height:350px;
            margin-bottom:-20px;
            color:white;

           }

       



        .auto-style1 {
            width: 144px;
            text-align: right;
        }
        .auto-style2 {
            width: 182px;
        }

        .lbllogin {
            color:#b61111;
            margin-left:68px;
            font-weight:bold;
            font-family:'Comic Sans MS';
            font-size:large;
        }

        .lblUserName {
        color:#b61111;
        font-weight:bold;
            font-family:'Comic Sans MS';
        }

         .lblPassword {
        color:#b61111;
        font-weight:bold;
            font-family:'Comic Sans MS';
        }


        #btnLogin {
            background-color:#b61111;
            color:white;
        font-family:'Comic Sans MS'
        }

        #linkSignUp {
            font-weight:bold;
            color:#b61111;
            
        }

        .logintable {
        float:left;
            margin-top:50px;
        }

        .signuplink {
        font-family:'Comic Sans MS';
            margin-top:50px;
            text-align:center;
        }

        .loginpanel {
        
            margin-top:100px;
            margin-bottom:100px;
        }

        .cartoonimage {
        
            height:150px;
            width:150px;
        }

    </style>
</head>

<body>
    <form id="form1" runat="server">
         
             <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#272626;border-color:#428bca">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="#" style="color:white;"><img class="logoimg" src="../../images/omnomnom3.png" height="35" /></a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    
                    <li><a href="HomePage.aspx" style="color:white">Home</a></li>
                    <li><a href="UserProfile.aspx" style="color:white">Profile</a></li>
                    <li><a href="#" style="color:white">About</a></li>
                    <li><a href="#" style="color:white">Contact</a></li>
                    <li></li>
                    <li><a href="#" style="color:#b61111;font-weight:bold;">Welcome!</a></li>
                    
                </ul>
                
            </div>
        </div><!-- container -->
</div>
             
             
      <div class="loginpanel">
          
          <div class="container loginform">
              
              <div class="logintable">

                  <div>
                      <label class="lbllogin">Log In</label>

                  </div>


                  <table class="nav-justified">
                      <tr>
                          <td class="auto-style1" style="text-align: right"><label class="lblUserName">UserName:</label></td>
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
              
              <img src="../../images/omnomnom3.png" /><br />
              <label>For the love of food</label>
          </div>
                  </center>

              <div class="socialtags">


              </div>
              <center>
              <div style="margin-top:200px;color:black;" >
                  
                  <img src="../../images/footer.JPG" class="img-responsive" />
              </div>
                  </center>
              </div>
       </div>
    </form>
</body>
</html>
