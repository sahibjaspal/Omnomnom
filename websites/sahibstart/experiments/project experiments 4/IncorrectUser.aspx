<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    public class UserLikeDetails
    {
        public string SearchTerm { get; set; }
        public string LocationTerm { get; set; }
        public string YelpID { get; set; }
    }

    public class UserCommentDetails
    {
        public string SearchTerm { get; set; }
        public string LocationTerm { get; set; }
        public string YelpID { get; set; }
        public string Comment { get; set; }
    }
    

    //protected void btnLogin_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("Login.aspx");
    //}

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");
    }

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

    [System.Web.Services.WebMethod()]
    public static UserLikeDetails[] GetUserLike(string UserName)
    {
        List<UserLikeDetails> likedetails = new List<UserLikeDetails>();
        string query = "select SearchTerm, LocationTerm,YelpID from sahibj.LikeStatusNew where UserName = '" + UserName + "' and LikeStatus = '" + true + "' order by ID";
        //string location;
        //string searchkey;
        //string YelpID;

        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn))
            {
                conn.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    UserLikeDetails ob = new UserLikeDetails();
                    ob.SearchTerm = reader.GetString(0);
                    ob.LocationTerm = reader.GetString(1);
                    ob.YelpID = reader.GetString(2);
                    likedetails.Add(ob);
                    

                }
            }
            conn.Close();
        }


        return likedetails.ToArray();
    }


    [System.Web.Services.WebMethod()]
    public static UserCommentDetails[] GetUserComment(string UserName)
    {
        List<UserCommentDetails> commentdetails = new List<UserCommentDetails>();
        string query = "select TOP 4 SearchTerm, LocationTerm,YelpID,Comment from sahibj.CommentTable where UserName = '" + UserName + "' order by CommentID";
        //string location;
        //string searchkey;
        //string YelpID;

        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn))
            {
                conn.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    UserCommentDetails ob = new UserCommentDetails();
                    ob.SearchTerm = reader.GetString(0);
                    ob.LocationTerm = reader.GetString(1);
                    ob.YelpID = reader.GetString(2);
                    ob.Comment = reader.GetString(3);
                    commentdetails.Add(ob);


                }
            }
            conn.Close();
        }


        return commentdetails.ToArray();
    }


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

    protected void btnSearchUser_Click(object sender, EventArgs e)
    {
        Response.Redirect("OtherUserProfile.aspx?otheruser=" + txtUserSearch.Value);
    }


    [System.Web.Services.WebMethod()]
    public static string INSERT_FOLLOW(string UserName, string FollowUser, bool Follow)
    {
        // Console.WriteLine(Like);

        try
        {

            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();
            string checkuser = "select count(*) from sahibj.FollowStatus where UserName = '" + UserName + "' and FollowUser = '" + FollowUser + "'";
            System.Data.SqlClient.SqlCommand com = new System.Data.SqlClient.SqlCommand(checkuser, conn);
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            conn.Close();
            if (temp == 0)
            {
                conn.Open();
                string insertfollow = "insert into sahibj.FollowStatus (UserName,FollowUser,FollowStatus) values (@UserName,@FollowUser,@FollowStatus)";
                System.Data.SqlClient.SqlCommand insertcom = new System.Data.SqlClient.SqlCommand(insertfollow, conn);

                insertcom.Parameters.AddWithValue("@UserName", UserName);
                insertcom.Parameters.AddWithValue("@FollowUser", FollowUser);
                insertcom.Parameters.AddWithValue("@FollowStatus", Follow);

                insertcom.ExecuteNonQuery();
                conn.Close();
                return "success";
            }
            else
            {
                conn.Open();
                string updatefollow = "update sahibj.FollowStatus set FollowStatus = '" + Follow + "'  where UserName = '" + UserName + "' and FollowUser = '" + FollowUser + "'";
                System.Data.SqlClient.SqlCommand updatecom = new System.Data.SqlClient.SqlCommand(updatefollow, conn);

                updatecom.ExecuteNonQuery();
                conn.Close();
                return "success";
            }

        }
        catch (Exception ex)
        {

            return "failuure" + ex.ToString();
        }


    }

    [System.Web.Services.WebMethod()]
    public static bool GetFollow(string UserName, string FollowUser)
    {

        string query = "select FollowStatus from sahibj.FollowStatus where UserName = '" + UserName + "' and FollowUser = '" + FollowUser + "'";
        bool followstatus = false;

        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn))
            {
                conn.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    followstatus = reader.GetBoolean(0);


                }
            }
            conn.Close();
        }


        return followstatus;
    }
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="IncorrectUserCSS.css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">

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
                    
                    <li class="active"><a href="HomePage.aspx" style="color:white">Home</a></li>
                    <li><a href="UserProfile.aspx" style="color:white">Profile</a></li>
                    <li><a href="#" style="color:white">About</a></li>
                    <li><a href="#" style="color:white">Contact</a></li>
                    <li></li>
                    <li><a href="#" style="color:#b61111;font-weight:bold;">Welcome! <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label></a></li>
                    
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    
                    
                   
                    <li class="nav navbar-nav navbar-right">
                        <asp:Button runat="server" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />

                    </li>  
           
                    
                </ul>
            </div>
        </div><!-- container -->
</div>
             
      <div class="outermost">       
      <div class="basicuserinfo">
                 
         <div class="userpanel well container">
             
           
             <div class="txtWelcomeWrapper">
             <div class="txtWelcome"><h2>Oops! No User Found! Please Enter A Valid User to Explore!</h2></div>
                
                 </div>

              <div class="exploreusers">
             <div class="ui-widget exploretxtwrapper">
             <label class="lblUserSearch" for="txtUserSearch">Explore Users: </label>
                
            <input type="text" id="txtUserSearch" runat="server" class="autosuggest form-control" />
                 
                 </div>
             <div class="btnSearchUserWrapper"><asp:Button ID="btnSearchUser" CssClass="btn btn-primary" runat="server" Text="ViewProfile" OnClick="btnSearchUser_Click" /></div>
                
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
       
        
        </div>
    </form>
</body>
</html>
<script type="text/javascript" src="../../javascript/jquery-2.1.0.min.js"></script>   
  <script type="text/javascript" src="../../javascript/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript">


    $(document).ready(function () {
        SearchText();
    });
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

     
</script>