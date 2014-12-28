<%@ Page Language="C#" %>

<!DOCTYPE html>

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
        
            display:block;
            width:100px;
            color:#b61111;
            
            
        }
        

        body {
        
        background-color:#F5F6F1;
        }

        .outermost {
        
            width:100%;
        }

        .signupform {
        
            background-color:#FFFFFF;
            height:550px;
            
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



        .lblsignup {
            color:#b61111;
            margin-left:80px;
            font-weight:bold;
            font-family:'Comic Sans MS';
            font-size:large;
            margin-bottom:20px;
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

        #btnSignUp {
            background-color:#b61111;
            color:white;
            }

        .signuptable {
        float:left;
            width: 557px;
        }

        .signuppageimage {
        margin-top:60px;
        margin-left:50px;
        float:left;
        }

        .signuppanel {
        
           
            margin-bottom:100px;
        }

        .auto-style1 {
            width: 168px;
            text-align: right;
        }
        .auto-style2 {
            width: 203px;
        }

        .signuptableouter {
        
            margin-top:10px;
           margin-bottom:100px;
        }

        .cartoonimage {
        
            height:350px;
            width:350px;
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
             
             
      <div class="signuppanel">

          <div class="container signupform">
            <div class="signuptableouter">
              <div class="signuptable">

                  <div>
                      <label class="lblsignup">Sign Up for Omnomnom</label>

                  </div>
                  

                  <table class="nav-justified">
                      <tr>
                          <td class="auto-style1" style="text-align: right">First Name:</td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtFirstName" runat="server" Height="34px" Width="188px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFirstName" ErrorMessage="FirstName is required" ForeColor="#B61111"></asp:RequiredFieldValidator>
                          </td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">Last Name:</td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtLastName" runat="server" Height="34px" Width="188px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLastName" ErrorMessage="LastName is required" ForeColor="#B61111"></asp:RequiredFieldValidator>
                          </td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">UserName:</td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtUserName" runat="server" Height="34px" Width="188px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtUserName" ErrorMessage="UserName is required" ForeColor="#B61111"></asp:RequiredFieldValidator>
                          </td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">Email:</td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtEmail" runat="server" Height="34px" Width="188px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="#B61111"></asp:RequiredFieldValidator>
                              <br />
                              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter Valid Email" ForeColor="#B61111" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                          </td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">Password:</td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtPassword" runat="server" Height="34px" Width="188px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Password is required" ForeColor="#B61111" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                          </td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">&nbsp;</td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">Confirm Password:</td>
                          <td class="auto-style2">
                              <asp:TextBox ID="txtConfirmPassword" runat="server" Height="34px" Width="188px"></asp:TextBox>
                          </td>
                          <td>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Confirm Password is required" ForeColor="#B61111" ControlToValidate="txtConfirmPassword"></asp:RequiredFieldValidator>
                              <br />
                              <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Password must match" ForeColor="#B61111"></asp:CompareValidator>
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
                  
                  <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" Height="34px" Width="196px" OnClick="btnSignUp_Click" />
                          </td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">
                              <input id="Reset1" type="reset" value="Reset" /></td>
                          <td>&nbsp;</td>
                      </tr>
                      <tr>
                          <td class="auto-style1">&nbsp;</td>
                          <td class="auto-style2">
                              Already a member? <a href="Login.aspx">Log In</a></td>
                          <td>&nbsp;</td>
                      </tr>
                  </table>
                  

                


              </div>
              
              <div class="signuppageimage">

                  
                  <img class="cartoonimage" src="http://vecto.rs/1024/vector-of-a-cartoon-couple-dining-at-a-restaurant-outlined-coloring-page-by-ron-leishman-19374.jpg" />
               </div>
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
