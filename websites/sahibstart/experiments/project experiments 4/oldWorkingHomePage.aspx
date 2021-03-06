﻿<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

   

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("SearchPage.aspx?searchterm=" + txtsearch.Value +
           "&locationterm=" + txtlocation.Value);
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            btnLogin.Visible = false;
            btnLogout.Visible = true;
            lblWelcome.Text += Session["User"].ToString();

        }
        else
        {
            btnLogout.Visible = false;
            btnLogin.Visible = true;
            lblWelcome.Text = "Guest";
            
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />

    <style type="text/css">

        .horizontalpartition {
        
            
         }

        .logo {
        float:left;
            width:20%;
            margin-left:5%;
        }

        .navigationheader {
            padding:10px 10px;
            height:11%;
           
        }

        .pageheader {
        
            
        }
        .links {
        float:left;
            color:white;
            margin-left:5%;
            margin-right:30%;
        }
        .usersession {
            margin-top:5px;
        color:white;
        float:left;
        }

        li {
        float:left;
        width:100px;
        /*border:1px solid red;*/
        height:60px;
        text-align:center; 
        color:white;
        
        }

        a{
        
            display:block;
            width:100px;
            color:white;
            
            
        }
        

        .nav-pills>li.active>a, .nav-pills>li.active>a:hover, .nav-pills>li.active>a:focus {
            color: #fff;
            background-color: #b61111;
        }

        .nav-pills {
            color:white;
        }
       
        a:hover {
        color:white;
       /*background-color:red;*/
        }
        .btnLogin {
            width:inherit;
           
            margin-right:10px;
            height:auto;
            
            
        }
        .btnLogout {
        
            width:inherit;
        }

        input, button, select, textarea {
            font-family: inherit;
            width: 70%;
        }

        .btnSignUp {
            width:auto;
           margin-top:2px;

        }

        .loginbutton {
            
            
        }

        .signupbutton {
        
          margin-left:6%;
           
        }

        .newactive {
        
            background-color:#b61111;
        }
        .outersearchpanel {
        
            
        height:500px;
        
        }
        .searchpanel {
        
        /*margin-top:100px;*/
        padding-top:100px;
        /*padding-left:0px;*/
         background-image:url(https://palacestation.sclv.com/~/media/Images/Page%20Background%20Images/Palace/Dining/PS_Dining_Main.jpg);
        background-repeat:no-repeat;
        height:600px;
        width:100%;
        
        
        
        }

        .searchbar {
       margin-left:50px;
      height:70px;
      width:970px;
     
      
        }

        .topsearchpadding {
            padding-top:100px;
        
        }
        .bottomsearchpadding {
            padding-bottom:400px;
        
        }

        .leftpaddingsearchpanel {
           /*padding-left:500px;*/
           float:left;
           width:100px;
        }

        .txtsearchkey, .location, .lbllocation, .txtbxlocation, .searchbutton {
        
            float:left;
        }

        #btnsearch {
            width:75px;
            margin-left:4px;
            margin-top:2px;
             background-color:#b61111;
            color:white;
        }

        body {
        
        background-color:#b61111;
        }

        .outermost {
        
            width:100%;
        }
        .searchdescription {
        
            padding-top:100px;
            padding-left:150px;
            width:875px;
            margin-left:100px;
            margin-top:100px;
            margin-right:100px;
        }
        .lbldescription {
        
            text-align:center;
            margin-left:-100px;
            margin-top:-50px;
            color:#b61111; 
            font-family:'Comic Sans MS';
            font-size:30px;
            font-weight:bolder;
        }

        @media (min-width: 50px) and (max-width:600px) {
            .outermost {
            
                width:100%;
            }
        
        }

        .topfoodies {
        
            margin-top:150px;
            background-color:#fcfbfb;
            height:350px;
            margin-bottom:-20px;
        }

        .trendingrestaurants {
        
            margin-top:5px;
             background-color:#808080;
            height:350px;
            margin-bottom:-20px;

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

        .signuplink {
        
        
            
        }

</style>
</head>

<body>
    <form id="form1" runat="server">
         <div class="outermost">
             <div class="pageheader">
             <div class="navbar navbar-inverse navbar-default navigationheader" role="navigation" >
             
            <div class="logo">
                     <a  href="#"><img class="logoimg" src="../../images/omnomnom3.png" /></a>
            </div>

             
             
            <div class="links">

                <ul class="nav nav-pills">
                    <li class="active"><a href="HomePage.aspx">Home</a></li>
                    <li><a href="UserProfile.aspx">Profile</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">About</a></li>
                 </ul>
            </div>

            <div class="usersession">
             
                
                <div class="loginbutton">
                    <asp:Button runat="server" ID="btnLogin" CssClass="btn btn-default btnLogin" Text="Login" OnClick="btnLogin_Click" />
                    <asp:Button  runat="server" ID="btnLogout" CssClass="btn btn-default btnLogout" Text="Logout" OnClick="btnLogout_Click" />
                   <%--<button class="btnLogin btn ">Log In</button>--%>

               </div>
                <div class="signupbutton">
                    
                    <%--<button class="btnSignUp btn btn-primary">Sign Up</button>--%>
                    <%--<a id="signuplink" class="" href="SignUp.aspx">Sign Up</a>--%>
                     Welcome! <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label>
                </div>
            </div>
         
         </div>
    
      </div>
             
            
      <div class="outersearchpanel container">
                 
         
             
         
          <div class="searchpanel">

                 
           <div style="" class="container well searchbar  main-content">
        
             
                <div class="inputfields">
                  
                    <div class="txtsearchkey">
                        <input id="txtsearch" runat="server" style="width:370px;height:auto" type="text" class="txtsearch form-control" placeholder="Search for food" />
                    </div>
                    
                    <div class="location">
                        
                        <div class="lbllocation">
                            
                            <label style="width:100px;height:auto" class="">&nbsp&nbsp&nbsp&nbsp  Near By:</label>
                        
                        </div>
                        
                        <div class="txtbxlocation">
                        
                                <input id="txtlocation" runat="server" style="width:370px;height:auto" type="text" class="txtlocation form-control" placeholder="Location: Ex: Boston"/>
                        
                        </div>
                     </div>
                  
                    <div class="searchbutton">
                     
                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" />
                        <%--<button id="btnsearch" runat="server" style="width:auto;height:auto" class="btnsearch btn btn-default" type="button">
                        Search</button>--%>
                    </div>
              </div>
      
            
     </div>
<div class="well searchdescription">

    <label class="lbldescription" style="">Search for your favourite food in any city in the United States</label>



</div>
      </div>

             
          </div>

            
    <div class="topfoodies">
        <hr />
        <div class="container">
        These are the top foodies.<br />
           
            </div>
    </div>

     <div class="trendingrestaurants">
         <hr />
         <div class="container">
             These are the trending restaurants

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

<script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    
    
<script type="text/javascript">

    //$(document).ready(function () {

    //    var UserName = document.getElementById("lblWelcome").textContent;

    //    if (UserName != "Guest") {

    //        $("#btnLogin").hide();
    //        $("#btnLogout").show();

    //    }

    //});


     
</script>