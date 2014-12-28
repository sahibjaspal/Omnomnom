<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    


    //protected void btnLogin_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("Login.aspx");
    //}
    //logout button functionality
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");
    }
    
    //page load
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Session["User"] != null)
        {
            // btnLogin.Visible = false;
            // string user = Request.QueryString["otheruser"];
            btnLogout.Visible = true;
            lblWelcome.Text = Session["User"].ToString();
            //  lblUserName.Text = Session["User"].ToString();

        }
        else
        {
            Response.Redirect("Login.aspx");

        }
    }
    //check if user is in database
    protected bool checkUserInDatabase(string user)
    {
        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);

        conn.Open();

        string checkuser = "select count(*) from sahibj.UserData where UserName = '" + user + "'";
        System.Data.SqlClient.SqlCommand com = new System.Data.SqlClient.SqlCommand(checkuser, conn);
        int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
        conn.Close();

        if (temp == 1)
            return true;
        else
            return false;


    }

    
    
    //get users from database
    [System.Web.Services.WebMethod()]
    public static List<string> GetAutoCompleteData(string username)
    {
        List<string> result = new List<string>();
        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString))
        {
            string query = "select DISTINCT UserName from sahibj.UserData where UserName LIKE '%'+@SearchText+'%'";
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn))
            {
                conn.Open();
                cmd.Parameters.AddWithValue("@SearchText", username);
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    result.Add(reader["UserName"].ToString());
                }
                return result;
            }
        }
    }
    //search for database user's profile
    protected void btnSearchUser_Click(object sender, EventArgs e)
    {
        Response.Redirect("OtherUserProfile.aspx?otheruser=" + txtUserSearch.Value);
    }


    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <title>OMNOMNOM | No User Found</title>
    <link type="text/css" rel="stylesheet" href="../css/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="CSS/IncorrectUserCSS.css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <style type="text/css">

</style>
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

                        <li><a href="ContactUs.aspx">ContactUs</a></li>
                        <li></li>
                        <li><a id="welcomered" href="#">Welcome!
                            <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label></a></li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">



                        <li class="nav navbar-nav navbar-right">
                            <asp:Button runat="server" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />

                        </li>


                    </ul>
                </div>
            </div>
            <!-- container -->
        </div>

        <div class="outermost">
            <div class="basicuserinfo">

                <div class="userpanel well container">


                    <div class="txtWelcomeWrapper">
                        <div class="txtWelcome">
                            <h2>Oops! No User Found! Please Enter A Valid User to Explore!<br />
                               
                            </h2>
                        </div>

                    </div>

                    <div class="exploreusers">
                        <div class="ui-widget exploretxtwrapper">
                            <label class="lblUserSearch" for="txtUserSearch">Explore Users: </label>

                            <input type="text" id="txtUserSearch" runat="server" class="autosuggest form-control" />

                        </div>
                        <div class="btnSearchUserWrapper">
                            <asp:Button ID="btnSearchUser" CssClass="btn btn-primary" runat="server" Text="ViewProfile" OnClick="btnSearchUser_Click" /></div>

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


    $(document).ready(function () {
        SearchText();
    });

    //search for users in database based on search key.
    function SearchText() {

        $("#txtUserSearch").autocomplete({
            source: function (request, response) {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "UserProfile.aspx/GetAutoCompleteData",
                    data: "{'username':'" + document.getElementById('txtUserSearch').value + "'}",
                    dataType: "json",
                    success: function (data) {
                        response(data.d);
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
            }
        });
    }

    //disable link
    $("#welcomered").click(function (e) {

        e.preventDefault();
    });


</script>
