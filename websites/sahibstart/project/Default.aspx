<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link type="text/css" rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />
    <title></title>
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
                    
                    <li class="active"><a href="HomePage.aspx" style="color:white">Home</a></li>
                    <li><a href="UserProfile.aspx" style="color:white">Profile</a></li>
                    <li><a href="#" style="color:white">About</a></li>
                    <li><a href="#" style="color:white">Contact</a></li>
                    <li>
                        <form class="navbar-form navbar-left" role="search">
                            <div class="form-group">
                                <input id="txtsearch" runat="server" type="text" class="txtsearch form-control" placeholder="Search for food" />

                            </div>
                        </form>

                    </li>
                        
                    <li><a href="#" style="color:white"> Near By: </a></li>
                    <li>
                        <form class="navbar-form navbar-left" role="search">
                            <div class="form-group">
                                <input id="txtlocation" runat="server" type="text" class="txtlocation form-control" placeholder="Location: Ex: Boston"/>
                            </div>
                        </form>
                     </li>  
                    <li><button id="btnsearch" class="btnsearch btn btn-default" type="button">
                     Search</button></li>
                    <li><a href="#" style="color:#b61111;font-weight:bold;">Welcome! <asp:Label runat="server" ID="lblWelcome" ClientIDMode="Static"></asp:Label></a></li>
                    
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    
                    
                    <li class="navbar-right">
                            
                                
                                <asp:Button style="margin-top:10%;" ID="btnLogin" CssClass="btn btn-default" Text="Login" OnClick="btnLogin_Click" />
                               
                             </li>
                    <li class="nav navbar-nav navbar-right">
                        <asp:Button  style="margin-top:9%;" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />

                    </li>  
           
                    
                </ul>
            </div>
        </div><!-- container -->
</div>
        </form>
</body>
</html>
