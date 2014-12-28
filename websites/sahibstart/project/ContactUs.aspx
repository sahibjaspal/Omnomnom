<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

//function for LOGOUT button
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");


    }

//Login button functionality
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("Login.aspx");
    }

    //page load function
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["User"] != null)
            
        {
            btnLogin.Visible = false;
           // string user = Request.QueryString["otheruser"];
            btnLogout.Visible = true;
            lblWelcome.Text = Session["User"].ToString();
          //  lblUserName.Text = Session["User"].ToString();

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
    <title>OMNOMNOM | Contact Us</title>
    <link type="text/css" rel="stylesheet" href="../css/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="CSS/ContactUsCSS.css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
   
</head>

<body>
    <form id="form1" runat="server">
         

             <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="HomePage.aspx"><img class="logoimg" src="../images/omnomnom3.png" height="35" /></a>
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
                    
                    <li><a href="ContactUs.aspx">Contact Us</a></li>
                    <li></li>
                    <li><a id="welcomered" href="#">Welcome! <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label></a></li>
                    
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    
                    
                   
                    <li class="nav navbar-nav navbar-right">
                        <asp:Button runat="server" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />
                        <asp:Button runat="server" ID="btnLogin" CssClass="btn btn-default" Text="Login" OnClick="btnLogin_Click" />
                    </li>  
           
                    
                </ul>
            </div>
        </div><!-- container -->
</div>
             
      <div class="outermost">       
      <div class="basicuserinfo">
                 
         <div class="userpanel well container">
             
           
             <div class="txtWelcomeWrapper">
                 <center>
             <div class="txtWelcome">
                 <h2>OMNOMNOM</h2>
                 <br />
                 Sahib Jaspal
                 <br />

                 Northeastern University
                 <br />
                 360 Huntington Avenue<br />
                 Boston<br />
                 Massachusetts<br />
                 <br />
                 Phone: +1(508)667-7647<br />
                 Email:sahibj@ccs.neu.edu
                 <br />
                 <br />

             </div>
                     </center>
                 </div>
                 <div class="map">
                 <iframe class="iframemap" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Northeastern+University,+Huntington+Avenue,+Boston,+MA&amp;aq=0&amp;oq=Nort&amp;sll=42.339807,-71.089172&amp;sspn=0.004259,0.010257&amp;ie=UTF8&amp;hq=&amp;hnear=&amp;ll=42.339807,-71.089172&amp;spn=0.006295,0.006295&amp;t=m&amp;iwloc=A&amp;output=embed"></iframe><br /><small><a href="https://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Northeastern+University,+Huntington+Avenue,+Boston,+MA&amp;aq=0&amp;oq=Nort&amp;sll=42.339807,-71.089172&amp;sspn=0.004259,0.010257&amp;ie=UTF8&amp;hq=&amp;hnear=&amp;ll=42.339807,-71.089172&amp;spn=0.006295,0.006295&amp;t=m&amp;iwloc=A" style="color:#0000FF;text-align:left">View Larger Map</a></small>
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
       
        
        </div>
    </form>
</body>
</html>
  
     <script type="text/javascript" src="../javascript/jquery-2.1.0.min.js"></script>

  <script type="text/javascript" src="../javascript/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript" src="../css/bootstrap/js/bootstrap.js"></script>

<script type="text/javascript">


    //to disable link click
    $("#welcomered").click(function (e) {

        e.preventDefault();
    });
     
</script>