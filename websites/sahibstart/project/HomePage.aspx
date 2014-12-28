<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">


 
//search button click functionality. redirects to search page
    protected void btnsearch_Click(object sender, EventArgs e)
    {

        Response.Redirect("SearchPage.aspx?searchterm=" + txtsearch.Value +
           "&locationterm=" + txtlocation.Value);
    }

  //login button fucntionality
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }

  //logout button functionality
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");
    }

    //page load functionality
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
    <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
    <title>OMNOMNOM | Home</title>
    <link type="text/css" rel="stylesheet" href="../css/bootstrap/css/bootstrap.css" />
    
    <link type="text/css" rel="stylesheet" href="CSS/HomePageCSS.css" />
      
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="HomePage.aspx">
                        <img class="logoimg" src="../images/omnomnom3.png" height="35" /></a>
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-main">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="collapse navbar-collapse" id="navbar-main">
                    <ul class="nav navbar-nav">

                        <li class="active"><a href="HomePage.aspx">Home</a></li>
                        <li><a href="UserProfile.aspx">Profile</a></li>
                       
                        <li><a href="ContactUs.aspx">Contact Us</a></li>
                        <li></li>
                        <li><a id="link" class="welcomestyle" href="#">Welcome!
                            <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label></a></li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">


                        <li class="navbar-right">


                            <asp:Button Style="margin-top: 10%;" runat="server" ID="btnLogin" CssClass="btn btn-default" Text="Login" OnClick="btnLogin_Click" />

                        </li>
                        <li class="nav navbar-nav navbar-right">
                            <asp:Button Style="margin-top: 9%;" runat="server" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />

                        </li>


                    </ul>
                </div>
            </div>
            <!-- container -->
        </div>
        <div class="outersearchpanel container well">
            <div class="toppadding">
            </div>
            <center>
              <div class="searchbar">
        
             <div class="searchfields">
                        <div class="txtsearchkey"><input id="txtsearch" runat="server" type="text" class="txtsearch form-control" placeholder="Search for food" />
                           </div>
                            <div class="nearbylabel"> <label class="lblNearBy">Near By:</label>
                               </div>
                               <div class="locationdiv"> <input id="txtlocation" runat="server" type="text" class="txtlocation form-control" placeholder="Location: Ex: Boston"/>
              </div> 
                                  <div class="btnSearchWrapper">  <asp:Button ID="btnsearch" CssClass="btn btn-default" runat="server" Text="Search" OnClick="btnsearch_Click" />
               </div>
               
      </div>
            
     </div>
         </center>
            <div class="searchpanel">




                <div class="well">

                    <label class="lbldescription">Search for your favourite food in any city in the United States</label>



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
              <div class="footerimage">
                  
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
    //disable link click
    $("#link").click(function (e) {
       
        e.preventDefault();
    });
</script>