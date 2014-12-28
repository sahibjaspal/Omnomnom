<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected System.Data.SqlClient.SqlConnection getDbConnection()
    {

        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
        return conn;

    }

    protected int returnUserCount()
    {
        int userctr;
        using (System.Data.SqlClient.SqlConnection conn = getDbConnection())
        {
           using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("sp_general_data", conn)) 
           {
                
               cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@username", System.Data.SqlDbType.VarChar).Value = txtUserName.Text;
                 cmd.Parameters.Add("@query", System.Data.SqlDbType.VarChar).Value = "userCount";

                conn.Open();
                userctr = Convert.ToInt32(cmd.ExecuteScalar().ToString());
            }
        }
        
        Response.Write(userctr);
        return userctr;

    }

    protected String returnPassword()
    {
        string pswd=string.Empty;
        using (System.Data.SqlClient.SqlConnection conn = getDbConnection())
        {
        
                 conn.Open();
                string checkPasswordQuery = "select password from sahibj.UserData where UserName = '" + txtUserName.Text + "'";
                System.Data.SqlClient.SqlCommand passCom = new System.Data.SqlClient.SqlCommand(checkPasswordQuery, conn);
                pswd = passCom.ExecuteScalar().ToString().Replace(" ", "");   
        
        }
        //Response.Write(pswd);
        return pswd;
    }



    
        
    protected void btnLogin_Click(object sender, EventArgs e)
        {

            
            int userCount = returnUserCount();
            if (userCount == 1)
            {
                string p = returnPassword();
               
                if (p == txtPassword.Text)
                {
                  //  Session["New"] = txtUserName.Text;
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
            margin-left:550px;
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

        .bottomlogo {
            margin-left:450px;
        
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

    </style>
</head>

<body>
    <form id="form1" runat="server">
         <div class="outermost">
             <div class="pageheader">
             <div class="navbar navbar-inverse navbar-default navigationheader" role="navigation" >
             
            <div class="logo" style="width:250px">
                     <a  href="#"><img class="logoimg" src="../../images/omnomnom3.png" /></a>
            </div>

             
          
         
         </div>
    
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
                              <asp:Button ID="btnLogin" CssClass="btn" runat="server" OnClick="btnLogin_Click" Text="Login" Width="177px" />
                          </td>
                          <td>&nbsp;</td>
                      </tr>
                  </table>


              </div>
              <div class="verticalbar"></div>
              <div class="signuplink">

                  <label style="color:#b61111;font-weight:bolder;">No Account yet?</label>
                  <br />
                  
                  <a href="SignUp.aspx" id="linkSignUp">Sign Up</a>
                  <br /><br />
                  <p>
                     
                      Omnomnom is a way to find, review and talk about<br />
                      what outlet is great and not so great.<br />
                      People give their real and honest opinions <br />
                      about the food, ambience, music at the restaurants.
                  </p>
               </div>


          </div>

          </div>

        
      <div class="connectwithus">
          <hr />
          <div class="container">
          <div class="bottomlogo">
              
              <img src="../../images/omnomnom3.png" /><br />
              &nbsp&nbsp&nbsp&nbsp&nbsp<label>For the love of food</label>
          </div>

              <div class="socialtags">


              </div>

              <div style="margin-top:200px;color:black;margin-left:150px;margin-right:150px;" class="panel-footer">
                  <label style="font-size:large">
                      &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp OMNOMNOM &nbsp&nbsp&nbsp&nbsp|
                      &nbsp&nbsp&nbsp&nbsp Northeastern University&nbsp&nbsp&nbsp&nbsp|
                      &nbsp&nbsp&nbsp&nbsp CS 5610 &nbsp&nbsp&nbsp&nbsp|
                      &nbsp&nbsp&nbsp&nbsp &nbsp&nbsp Copyright 2014
                  </label>

              </div>
              </div>
       </div>
       
        
        </div>
    </form>
</body>
</html>
