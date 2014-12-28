<%@ Page Language="C#" %>

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
      <link type="text/css" rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />
    <script type="text/javascript" src="../../javascript/jquery-2.1.0.min.js"></script>
    <script type="text/javascript" src="../../css/bootstrap/js/bootstrap.js"></script>
    <style type="text/css">

         .outersearchpanel {
        
            margin-top:70px;
        height:500px;
         background-image:url(https://palacestation.sclv.com/~/media/Images/Page%20Background%20Images/Palace/Dining/PS_Dining_Main.jpg);
        
        }
        .searchpanel {
        /*margin-left:3%;*/
        margin-top:170px;
        /*padding-top:100px;*/
        /*padding-left:0px;*/
        
        /*background-repeat:no-repeat;*/
        /*height:600px;*/
        /*width:100%;*/
        
        
         text-align:center;
        }

        .searchbar {
       /*margin-left:50px;*/
      /*height:150px;*/
      /*width:970px;*/
  width:47%;
      background-color:#fff;
      color:#fff;
       background-image:url(http://www.ledr.com/colours/white.jpg);
        }

       

        

        .txtsearchkey, .location, .lbllocation, .txtbxlocation, .searchbutton {
        
            float:left;
        }

        #btnsearch {
            /*width:75px;
            margin-left:4px;
            margin-top:2px;*/
             background-color:#b61111;
            color:white;
            float:left;
        }

        body {
        
        background-color:#b61111;
        }

        .outermost {
        
            width:100%;
        }
        .searchdescription {
        
            /*padding-top:100px;*/
            /*padding-left:150px;*/
            /*width:875px;*/
            /*margin-left:100px;*/
            margin-top:70px;
            /*margin-right:100px;*/
        }
        .lbldescription {
        
            /*text-align:center;*/
            /*margin-left:-100px;*/
            /*margin-top:-50px;*/
            color:#b61111; 
            font-family:'Comic Sans MS';
            font-size:30px;
            font-weight:bolder;
        }


        .locationdiv {
        
            float:left;
            
        }

        .btnSearchWrapper {
            float:left;
            
        }

        .txtsearchkey {
        
            float:left;
            
            
        }
        .nearbylabel {
        float:left;
          
        }
        .lblNearBy {
            margin-top:7%;
        }
        .toppadding {
        
            height:70px;
        }

        .searchfields {
        
          
        }

        .connectwithus {
        
            background-color:#0c0b0b;
        }

        .bottomlogo {
        
        color:white;
        }

        
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#272626;border-color:#428bca">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="#" style="color:white;"><img class="logoimg" src="../../images/omnomnom3.png" height="35" /></a>
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-main">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
            </div>
            <div class="collapse navbar-collapse" id="navbar-main">
                <ul class="nav navbar-nav">
                    
                    <li class="active"><a href="HomePage.aspx" style="color:white">Home</a></li>
                    <li><a href="UserProfile.aspx" style="color:white">Profile</a></li>
                    <li><a href="#" style="color:white">About</a></li>
                    <li><a href="#" style="color:white">Contact</a></li>
                    <li></li>
                    <li><a href="#" style="color:#b61111;font-weight:bold;">Welcome! <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label></a></li>
                    
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    
                    
                    <li class="navbar-right">
                            
                                
                                <asp:Button style="margin-top:10%;" runat="server" ID="btnLogin" CssClass="btn btn-default" Text="Login" OnClick="btnLogin_Click" />
                               
                             </li>
                    <li class="nav navbar-nav navbar-right">
                        <asp:Button  style="margin-top:9%;" runat="server" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />

                    </li>  
           
                    
                </ul>
            </div>
        </div><!-- container -->
</div>
   <div class="outersearchpanel container well">
                <div class="toppadding">


                </div> 
         <center>
              <div style="" class="searchbar">
        
             <div class="searchfields">
                        <div class="txtsearchkey"><input id="txtsearch" runat="server" style="height:auto;float:left;" type="text" class="txtsearch form-control" placeholder="Search for food" />
                           </div>
                            <div class="nearbylabel"> <label style="float:left;" class="lblNearBy">Near By:</label>
                               </div>
                               <div class="locationdiv"> <input id="txtlocation" runat="server" style="height:auto;float:left;" type="text" class="txtlocation form-control" placeholder="Location: Ex: Boston"/>
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
