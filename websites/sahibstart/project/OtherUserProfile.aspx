<%@ Page Language="C#" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>

<!DOCTYPE html>

<script runat="server">
//to get User likes
    public class UserLikeDetails
    {
        public string SearchTerm { get; set; }
        public string LocationTerm { get; set; }
        public string YelpID { get; set; }
    }
//to get user comments
    public class UserCommentDetails
    {
        public string SearchTerm { get; set; }
        public string LocationTerm { get; set; }
        public string YelpID { get; set; }
        public string Comment { get; set; }
    }
//to get following user likes
    public class FollowUserLikeDetails
    {
        public string UserName { get; set; }
        public string SearchTerm { get; set; }
        public string LocationTerm { get; set; }
        public string YelpID { get; set; }
    }
    //to get following user comments
    public class FollowUserCommentDetails
    {
        public string UserName { get; set; }
        public string SearchTerm { get; set; }
        public string LocationTerm { get; set; }
        public string YelpID { get; set; }
        public string Comment { get; set; }
    }
    

 

    
    //logout functionality, session becomes null, redirect to login page
    
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");
    }

    //page load functionality

    const string keyidentifier = "yelpkey";
        
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            id1.Text = KeyTools.GetKey(this, keyidentifier);
        }
        if (Session["User"] != null)
        {
           // btnLogin.Visible = false;
            string user = Request.QueryString["otheruser"];
            if (checkUserInDatabase(user))
            {
                lblUserName.Text = Request.QueryString["otheruser"];
                btnLogout.Visible = true;
                lblWelcome.Text = Session["User"].ToString();

            }
            else
            {
                Response.Redirect("IncorrectUser.aspx");

            }
          //  lblUserName.Text = Session["User"].ToString();

        }
        else
        {
            Response.Redirect("Login.aspx");
            
        }
    }

    //check if user exists in database
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

    
    //get the likes of user whos profile is visited
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

    //get the comments whose profile is visited
    [System.Web.Services.WebMethod()]
    public static UserCommentDetails[] GetUserComment(string UserName)
    {
        List<UserCommentDetails> commentdetails = new List<UserCommentDetails>();
        string query = "select SearchTerm, LocationTerm,YelpID,Comment from sahibj.CommentTable where UserName = '" + UserName + "' order by CommentID";
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
    
    // get the likes of the user who is being followed by the user whose profile is being visited
    [System.Web.Services.WebMethod()]
    public static FollowUserLikeDetails[] GetFollowUserLike(string UserName)
    {
        List<FollowUserLikeDetails> followlikedetails = new List<FollowUserLikeDetails>();

        string query = " select l.UserName,l.SearchTerm, l.LocationTerm, l.YelpID from sahibj.LikeStatusNew l,sahibj.FollowStatus f where l.UserName = f.FollowUser and f.UserName = '" + UserName + "' and l.LikeStatus = '" + true + "' and f.FollowStatus = '" + true + "'group by l.UserName,l.LocationTerm,l.SearchTerm,l.YelpID";
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
                    FollowUserLikeDetails ob = new FollowUserLikeDetails();
                    ob.UserName = reader.GetString(0);
                    ob.SearchTerm = reader.GetString(1);
                    ob.LocationTerm = reader.GetString(2);
                    ob.YelpID = reader.GetString(3);
                    followlikedetails.Add(ob);


                }
            }
            conn.Close();
        }


        return followlikedetails.ToArray();
    }

    // get the comments of the user who is being followed by the user whose profile is being visited
    [System.Web.Services.WebMethod()]
    public static FollowUserCommentDetails[] GetFollowUserComment(string UserName)
    {
        List<FollowUserCommentDetails> followcommentdetails = new List<FollowUserCommentDetails>();
        string query = "select c.UserName,c.SearchTerm, c.LocationTerm, c.YelpID,c.Comment from sahibj.CommentTable c,sahibj.FollowStatus f where c.UserName = f.FollowUser and f.UserName = '" + UserName + "' and f.FollowStatus = '" + true + "'group by c.UserName,c.LocationTerm,c.SearchTerm,c.YelpID,c.Comment";
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
                    FollowUserCommentDetails ob = new FollowUserCommentDetails();
                    ob.UserName = reader.GetString(0);
                    ob.SearchTerm = reader.GetString(1);
                    ob.LocationTerm = reader.GetString(2);
                    ob.YelpID = reader.GetString(3);
                    ob.Comment = reader.GetString(4);
                    followcommentdetails.Add(ob);


                }
            }
            conn.Close();
        }


        return followcommentdetails.ToArray();
    }

    // get the users from database to implement autocomplete functionality
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

    //redirect to user profile
    protected void btnSearchUser_Click(object sender, EventArgs e)
    {
        Response.Redirect("OtherUserProfile.aspx?otheruser=" + txtUserSearch.Value);
    }

    //insert followstatus in database
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
    //get follow status from database
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
    <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
    <title>OMNOMNOM | User Profile</title>
     <link type="text/css" rel="stylesheet" href="../css/bootstrap/css/bootstrap.css" />
   
    <link rel="stylesheet" href="CSS/OtherUserProfileCSS.css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
   
</head>

<body>
    <form id="form1" runat="server">
         <div class="outermost">
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
                    <li class="active"><a href="UserProfile.aspx">Profile</a></li>
                   
                    <li><a href="ContactUs.aspx">ContactUs</a></li>
                    <li></li>
                    <li><a href="#" id="welcomered">Welcome! <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label></a></li>
                    
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    
                    <li class="nav navbar-nav navbar-right">
                        <asp:Button runat="server" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />

                    </li>  
           
                    
                </ul>
            </div>
        </div><!-- container -->
</div>
          <!-- label to store api key -->
         <asp:Label ID="id1" runat="server" />     
      <div class="basicuserinfo">
                 
         <div class="userpanel well container">
              <div class="exploreusers">
             <div class="ui-widget exploretxtwrapper">
             <label class="lblUserSearch" for="txtUserSearch">Explore Users: </label>
                
            <input type="text" id="txtUserSearch" runat="server" class="autosuggest form-control" />
                 
                 </div>
             <div class="btnSearchUserWrapper"><asp:Button ID="btnSearchUser" CssClass="btn btn-primary" runat="server" Text="ViewProfile" OnClick="btnSearchUser_Click" /></div>
                
              </div>
            
             <div class="txtWelcomeWrapper">
             <div class="txtWelcome"><h2><asp:Label ID="lblUserName" runat="server" ClientIDMode="Static"></asp:Label>'s Profile</h2></div>
                 <div class="btnFollowWrapper"><input type="button" class="btn btn-primary" id="btnFollow" value="Follow" /></div>
                 </div>
          
             
             <div class="userwrapper">
             
            
             <div id="useractivites" class=" useractivities">
                 <div>
                     <h3>User Activities</h3>
                   <div class="mylinks"> 
                 <a id="mylikes" class="mylikes well" href="#mylikes">Likes</a>
                  <a id="commentsfocus" class="mycomments well" href="#commentsfocus">Comments</a>
                  <a id="followlikesfocus" class="followlikes well" href="#followlikesfocus">Followers Likes</a>
                  <a id="followcommentsfocus" class="followcomments well" href="#followcommentsfocus">Followers Comments</a>
                   </div> 
                          
                </div>

                 <div id="linkresults" class="linkresults">
                        
                     <div class="likewrapper">
        <h2>Likes</h2><br />
           <label id="nolikes">No Likes.</label> 
     
               <div class="likeone">
           <div id="bdetails" class="businessdetails bdetailsitem">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="businessimage img-thumbnail img-responsive" src="#"/>

                    </div>
                    <div class="col-xs-10">
                        <div>
                            <div class="restaurantnamewrapper"><h3 class="restaurantname"></h3> </div>
                            <%--<div class="btnLikeWrapper"><input type="button" class="btn btn-primary" id="btnLike" value="Like" /></div>--%>
                        
                        
                        
                        
                        <%--ID: <asp:Label ID="restaurantID" ClientIDMode="Static" runat="server"></asp:Label>--%>
                        
                        Address: <label class="restaurantaddress"></label>
                        <br />
                       <img class="reviewimage" src="#"/>
                       <br />
                        Contact: <label class="restaurantphone"></label>
                        </div>
                        </div>
                    </div>
            </div>
    </div>
                </div>

           
            
            </div>

                     <div class="commentwrapper">
        <h2>Comments</h2><br />
           <label id="nocomments">No Comments.</label> 
     
               <div class="commentone">
           <div id="cdetails" class="cbusinessdetails">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="cbusinessimage img-thumbnail img-responsive" src="#"/>

                    </div>
                    <div class="col-xs-10">
                        <div>
                            <div class="crestaurantnamewrapper"><h3 class="crestaurantname"></h3> </div>
                            <%--<div class="btnLikeWrapper"><input type="button" class="btn btn-primary" id="btnLike" value="Like" /></div>--%>
                        
                        
                        
                        
                        <%--ID: <asp:Label ID="restaurantID" ClientIDMode="Static" runat="server"></asp:Label>--%>
                        
                        Address: <label class="crestaurantaddress"></label>
                        <br />
                       <img class="creviewimage" src="#"/>
                       <br />
                        Contact: <label class="crestaurantphone"></label>
                            <br />
                        <div class="displaycomment">Comment: <label class="comment"></label></div>
                        </div>
                        </div>
                    </div>
            </div>
    </div>
                </div>

           
            
            </div>

                     <div class="followlikewrapper">
        <h2>Following User Likes</h2><br />
           <label id="nofollowlikes">No User Followed or Followed User has no likes.</label> 
     
               <div class="flikeone">
           <div id="fbdetails" class="fbusinessdetails">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="fbusinessimage img-thumbnail img-responsive" src="#"/>

                    </div>
                    <div class="col-xs-10">
                        <div>
                            <div class="frestaurantnamewrapper"><h3 class="frestaurantname"></h3> </div>
                            <%--<div class="btnLikeWrapper"><input type="button" class="btn btn-primary" id="btnLike" value="Like" /></div>--%>
                        
                        
                        
                        
                        <%--ID: <asp:Label ID="restaurantID" ClientIDMode="Static" runat="server"></asp:Label>--%>
                        
                        Address: <label class="frestaurantaddress"></label>
                        <br />
                       <img class="freviewimage" src="#"/>
                       <br />
                        Contact: <label class="frestaurantphone"></label>
                        </div>
                        </div>
                    </div>
            </div>
    </div>
                </div>

           
            
            </div>

                     <div class="followcommentwrapper">
        <h2>Following User Comments</h2><br />
            <label id="nofollowcomments">No User Followed or Followed User has NO Comments.</label> 
     
               <div class="followcommentone">
           <div id="fcdetails" class="fcbusinessdetails">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="fcbusinessimage img-thumbnail img-responsive" src="#"/>

                    </div>
                    <div class="col-xs-10">
                        <div>
                            <div class="fcrestaurantnamewrapper"><h3 class="fcrestaurantname"></h3> </div>
                            <%--<div class="btnLikeWrapper"><input type="button" class="btn btn-primary" id="btnLike" value="Like" /></div>--%>
                        
                        
                        
                        
                        <%--ID: <asp:Label ID="restaurantID" ClientIDMode="Static" runat="server"></asp:Label>--%>
                        
                        Address: <label class="fcrestaurantaddress"></label>
                        <br />
                       <img class="fcreviewimage" src="#"/>
                       <br />
                        Contact: <label class="fcrestaurantphone"></label>
                            <br />
                        <div class="displaycomment">Comment: <label class="fcomment"></label></div>
                        </div>
                        </div>
                    </div>
            </div>
    </div>
                </div>

           
            
            </div>

                     </div>


             </div>

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
              <div style="margin-top:200px;color:black;" >
                  
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

    //store yelp api key from the hidden label
    var yelpkey = document.getElementById("id1").innerText;

    //disable link
    $("#welcomered").click(function (e) {

        e.preventDefault();
    });

    // set intial values
    $(document).ready(function () {
        $("#nolikes").hide();
        $("#nocomments").hide();
        $("#nofollowlikes").hide();
        $("#nofollowcomments").hide();
        var FollowUser = document.getElementById("lblUserName").textContent;
        var UserName = document.getElementById("lblWelcome").textContent;
       
        

        if (FollowUser === UserName) {

            $("#btnFollow").hide();
        }

        showFollow(UserName, FollowUser);

    });

    //implement follow funcitonality, store follow in db and also update button text
    $(function () {
        $("#btnFollow").click(function () {
            $(this).val(function (i, text) {
                if (text === "Follow") {
                    storeFollow(true);
                    return "Unfollow";
                } else {
                    storeFollow(false);
                    return "Follow";
                }
            })
        });
    })

    //store follow in database, calls C# webmethod and json object is recieved
    function storeFollow(Follow) {

        //  alert("we will store a Like/Unlike");
        // alert(Like);
        // var Like = true;
        var UserName = document.getElementById("lblWelcome").textContent;
        var FollowUser = document.getElementById("lblUserName").textContent;
        //var SearchTerm = $(".txtsearch").val();
        //var LocationTerm = $(".txtlocation").val();
        //var YelpID = document.getElementById("restaurantID").textContent;

        $.ajax({


            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "OtherUserProfile.aspx/INSERT_FOLLOW",
            data: "{UserName:'" + UserName + "', FollowUser:'" + FollowUser + "',Follow:'" + Follow + "'}",
            dataType: "json",
            // async: false,
            success: function (response) {
                // $("#txtComment").val('');
                // alert("Follow Record saved successfully");
                console.log(response);

            },
            error: function () {

                alert("Follow record data could not be saved");
            }
        });


    }

    //show follow status from database, calls C# webmethod and json object is recieved
    function showFollow(UserName, FollowUser) {
        // alert("inside showcomments");
        $.ajax({
            type: "POST",
            url: "OtherUserProfile.aspx/GetFollow",
            data: "{UserName:'" + UserName + "', FollowUser:'" + FollowUser + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //  alert("inside success function ajax" + data.d);
                if (data.d === true) {
                    //alert("button should be Unlike");
                    $("#btnFollow").attr("value", "Unfollow");
                }
                else {
                    // alert("button should be Like");
                    $("#btnFollow").attr("value", "Follow");

                }

            },
            failure: function (response) {
                alert("failure to show comments in ajax");
                //var r = jQuery.parseJSON(response.responseText);
                //alert("Message: " + r.Message);
                //alert("StackTrace: " + r.StackTrace);
                //alert("ExceptionType: " + r.ExceptionType);
            }
        });
    }

    //code to implement autocomplete functionality using jquery ui.
    $(document).ready(function () {
        SearchText();
    });

    //search user from database, calls webmethod in C# and checks for every keystroke
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

    //hide few initial divs

    $(document).ready(function () {
        $(".commentwrapper").hide();
        $(".likewrapper").hide();
        $(".followlikewrapper").hide();
        $(".followcommentwrapper").hide();
        var UserName = document.getElementById("lblUserName").textContent;

        $("#mylikes").click(getCurrentUserLikes);
        //  $("body").on("click", ".mylikes", getCurrentUserLikes(UserName));
        $(".mycomments").click(getCurrentUserComments);

        $(".followlikes").click(getFollowUserLikes);

        $(".followcomments").click(getFollowUserComments);

    });

    //get likes of user who is being followed. calls webmethod in C# which talks to the database and returns json object.
    function getFollowUserLikes() {
        $(".commentwrapper").hide();
        $(".likewrapper").hide();
        $(".followcommentwrapper").hide();
        $(".followlikewrapper").show();


        var UserName = document.getElementById("lblUserName").textContent;
        // alert("just clicked link" + UserName);
        var fliketemplate = $(".flikeone .fbusinessdetails");
        var flikeContainer = $(".flikeone .container");
        var flikeOne = $(".flikeone");
        flikeContainer.remove();
        $.ajax({
            type: "POST",
            url: "UserProfile.aspx/GetFollowUserLike",
            data: "{UserName:'" + UserName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // alert("inside success function ajax" + data);
                if (data.d.length == 0) {
                    $("#nofollowlikes").show();
                }
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = fliketemplate.clone();
                    var fuser = data.d[i].UserName;
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;

                    getFollowLikeData(fuser, searchterm, locationterm, YelpID, tempclone, giveFollowLikeResults);
                }
            },
            failure: function (response) {
                alert("failure to show likes in ajax");
                //var r = jQuery.parseJSON(response.responseText);
                //alert("Message: " + r.Message);
                //alert("StackTrace: " + r.StackTrace);
                //alert("ExceptionType: " + r.ExceptionType);
            }
        });

    }

    //get comments of user who is being followed. calls webmethod in C# which talks to the database and returns json object.
    function getFollowUserComments() {
        $(".commentwrapper").hide();
        $(".likewrapper").hide();
        $(".followlikewrapper").hide();
        $(".followcommentwrapper").show();


        var UserName = document.getElementById("lblUserName").textContent;
        var fcommenttemplate = $(".followcommentone .fcbusinessdetails");
        var fcommentContainer = $(".followcommentone .container");
        var fcommentOne = $(".followcommentone");
        fcommentContainer.remove();
        // alert("just clicked link" + UserName);
        $.ajax({
            type: "POST",
            url: "UserProfile.aspx/GetFollowUserComment",
            data: "{UserName:'" + UserName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //alert("inside success function ajax" + data);
                if (data.d.length == 0) {
                    $("#nofollowcomments").show();
                }
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = fcommenttemplate.clone();
                    var fuser = data.d[i].UserName;
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;
                    var Comment = data.d[i].Comment;
                    //  alert(fuser + searchterm + locationterm + YelpID + Comment);
                    getFollowCommentData(fuser, searchterm, locationterm, YelpID, Comment, tempclone, giveFollowCommentResults);
                }
            },
            failure: function (response) {
                alert("failure to show likes in ajax");
                //var r = jQuery.parseJSON(response.responseText);
                //alert("Message: " + r.Message);
                //alert("StackTrace: " + r.StackTrace);
                //alert("ExceptionType: " + r.ExceptionType);
            }
        });

    }

    //get likes of current user. calls webmethod in C# which talks to the database and returns json object.
    function getCurrentUserLikes() {

        $(".commentwrapper").hide();
        $(".followcommentwrapper").hide();
        $(".followlikewrapper").hide();
        $(".likewrapper").show();
        var UserName = document.getElementById("lblUserName").textContent;
        var liketemplate = $(".likeone .businessdetails");
        var likeContainer = $(".likeone .container");
        var likeOne = $(".likeone");
        likeContainer.remove();
       // alert("getlikes " + UserName);
        $.ajax({
            type: "POST",
            url: "UserProfile.aspx/GetUserLike",
            data: "{UserName:'" + UserName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // alert("inside success function ajax" + data);
                if (data.d.length == 0) {
                    $("#nolikes").show();
                }
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = liketemplate.clone();
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;
                    getLikeData(UserName, searchterm, locationterm, YelpID, tempclone, giveLikeResults);
                }
            },
            failure: function (response) {
                alert("failure to show likes in ajax");
                //var r = jQuery.parseJSON(response.responseText);
                //alert("Message: " + r.Message);
                //alert("StackTrace: " + r.StackTrace);
                //alert("ExceptionType: " + r.ExceptionType);
            }
        });

    }


    //get currentuser's comments who is being followed. calls webmethod in C# which talks to the database and returns json object.
    function getCurrentUserComments() {
        $(".likewrapper").hide();


        $(".followlikewrapper").hide();
        $(".followcommentwrapper").hide();
        $(".commentwrapper").show();
        var UserName = document.getElementById("lblUserName").textContent;
        var commenttemplate = $(".commentone .cbusinessdetails");
        var commentContainer = $(".commentone .container");
        var commentOne = $(".commentone");
        commentContainer.remove();
        $.ajax({
            type: "POST",
            url: "UserProfile.aspx/GetUserComment",
            data: "{UserName:'" + UserName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // alert("inside success function ajax" + data);
                if (data.d.length == 0) {
                    $("#nocomments").show();
                }
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = commenttemplate.clone();
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;
                    var Comment = data.d[i].Comment;
                    getCommentData(UserName, searchterm, locationterm, YelpID, Comment, tempclone, giveCommentResults);
                }
            },
            failure: function (response) {
                alert("failure to show comments in ajax");
                //var r = jQuery.parseJSON(response.responseText);
                //alert("Message: " + r.Message);
                //alert("StackTrace: " + r.StackTrace);
                //alert("ExceptionType: " + r.ExceptionType);
            }
        });

    }

    //get the details of outlet liked to display on user profile
    function getLikeData(UserName, searchterm, locationterm, YelpID, tempclone, callback) {


        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: yelpkey, term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID, tempclone);
                // $("#bdetails").show();

            }

        });

    }

    //get the details of outlets likes by the user followed to display on user profile
    function getFollowLikeData(fuser, searchterm, locationterm, YelpID, tempclone, callback) {
        //  alert(fuser + " " + searchterm + " " + locationterm + " " + YelpID);

        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: yelpkey, term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID, tempclone);


            }

        });

    }


    //get the details of outlets commented by the current user to display on user profile
    function getCommentData(UserName, searchterm, locationterm, YelpID, Comment, tempclone, callback) {


        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: yelpkey, term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID, Comment, tempclone);


            }

        });

    }

    //get the details of outlets commented on by the user followed to display on user profile
    function getFollowCommentData(UserName, searchterm, locationterm, YelpID, Comment, tempclone, callback) {


        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: yelpkey, term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID, Comment, UserName, tempclone);


            }

        });

    }

    //display current user comment results
    function giveCommentResults(response, businessid, Comment, tempclone) {

        var allbusinesses = response.businesses;
        // var ul = $(".likeresults");
        // var list = $(".reviewlist");
        //ul.empty();
        // list.empty();

        // var commenttemplate = $("#cdetails");
        //  commenttemplate.empty();
        // var tempclone = commenttemplate.clone();
        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container cdetailsitem");

        for (var i in allbusinesses) {
            var onebusiness = allbusinesses[i];
            var id = onebusiness.id;
            if (id === businessid) {

                var allreviews = onebusiness.reviews;
                // var businessid = onebusiness.id;
                var onereview = onebusiness.reviews[0];

                var reviewimg = onereview.rating_img_url;

                var name = onebusiness.name;
                var address1 = onebusiness.address1;
                var address2 = onebusiness.address2;
                var state_code = onebusiness.state_code;
                var fulladdress = address1 + ", " + address2 + ", " + state_code;
                var resturl = onebusiness.url;
                var busimg = onebusiness.photo_url;
                var phone = onebusiness.phone;


                var img2 = $(".cbusinessimage");

                tempclone.find(".cbusinessimage").attr("src", busimg);
                tempclone.find(img2).height(120);
                tempclone.find(img2).width(100);

                var img3 = $(".creviewimage");

                tempclone.find(".creviewimage").attr("src", reviewimg);
                tempclone.find(img3).height(25);
                tempclone.find(img3).width(95);

                // document.CurElementById("restaurantID").textContent = id;
                tempclone.find(".crestaurantname").html(name);
                tempclone.find(".crestaurantaddress").html(fulladdress);
                tempclone.find(".crestaurantphone").html(phone);
                tempclone.find(".comment").html(Comment);
                
                $(".commentone").append(tempclone);

            }

        }
    }

    //display the outlets on which the user followed has commented on
    function giveFollowCommentResults(response, businessid, Comment, UserName, tempclone) {

        var allbusinesses = response.businesses;
        // var ul = $(".likeresults");
        // var list = $(".reviewlist");
        //ul.empty();
        // list.empty();

        // var commenttemplate = $("#fcdetails");
        // var tempclone = commenttemplate.clone();
        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container fcdetailsitem");

        for (var i in allbusinesses) {
            var onebusiness = allbusinesses[i];
            var id = onebusiness.id;
            if (id === businessid) {

                var allreviews = onebusiness.reviews;
                // var businessid = onebusiness.id;
                var onereview = onebusiness.reviews[0];

                var reviewimg = onereview.rating_img_url;

                var name = onebusiness.name;
                var address1 = onebusiness.address1;
                var address2 = onebusiness.address2;
                var state_code = onebusiness.state_code;
                var fulladdress = address1 + ", " + address2 + ", " + state_code;
                var resturl = onebusiness.url;
                var busimg = onebusiness.photo_url;
                var phone = onebusiness.phone;


                var img2 = $(".fcbusinessimage");

                tempclone.find(".fcbusinessimage").attr("src", busimg);
                tempclone.find(img2).height(120);
                tempclone.find(img2).width(100);

                var img3 = $(".fcreviewimage");

                tempclone.find(".fcreviewimage").attr("src", reviewimg);
                tempclone.find(img3).height(25);
                tempclone.find(img3).width(95);

                // document.getElementById("restaurantID").textContent = id;
                tempclone.find(".fcrestaurantname").html(name);
                tempclone.find(".fcrestaurantaddress").html(fulladdress);
                tempclone.find(".fcrestaurantphone").html(phone);
                tempclone.find(".fcomment").html(Comment);
              

               
                $(".followcommentone").append(tempclone);

            }

        }
    }

    //display current users like details
    function giveLikeResults(response, businessid, tempclone) {

        var allbusinesses = response.businesses;
        var ul = $(".likeresults");
        var list = $(".reviewlist");
        //ul.empty();
        //list.empty();

        //var liketemplate = $("#bdetails");

        //var tempclone = liketemplate.clone();

        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container bdetailsitem");

        for (var i in allbusinesses) {
            var onebusiness = allbusinesses[i];
            var id = onebusiness.id;
            if (id === businessid) {

                var allreviews = onebusiness.reviews;
                // var businessid = onebusiness.id;
                var onereview = onebusiness.reviews[0];

                var reviewimg = onereview.rating_img_url;

                var name = onebusiness.name;
                var address1 = onebusiness.address1;
                var address2 = onebusiness.address2;
                var state_code = onebusiness.state_code;
                var fulladdress = address1 + ", " + address2 + ", " + state_code;
                var resturl = onebusiness.url;
                var busimg = onebusiness.photo_url;
                var phone = onebusiness.phone;


                var img2 = $(".businessimage");

                tempclone.find(".businessimage").attr("src", busimg);
                tempclone.find(img2).height(120);
                tempclone.find(img2).width(100);

                var img3 = $(".reviewimage");

                tempclone.find(".reviewimage").attr("src", reviewimg);
                tempclone.find(img3).height(25);
                tempclone.find(img3).width(95);

                // document.getElementById("restaurantID").textContent = id;
                tempclone.find(".restaurantname").html(name);
                tempclone.find(".restaurantaddress").html(fulladdress);
                tempclone.find(".restaurantphone").html(phone);
                
              
                $(".likeone").append(tempclone);

            }

        }
    }

    //display the details of the likes of user who is being followed
    function giveFollowLikeResults(response, businessid, tempclone) {
        
        var allbusinesses = response.businesses;
        
        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container fbdetailsitem");

        for (var i in allbusinesses) {
            var onebusiness = allbusinesses[i];
            var id = onebusiness.id;
            if (id === businessid) {

                var allreviews = onebusiness.reviews;
                // var businessid = onebusiness.id;
                var onereview = onebusiness.reviews[0];

                var reviewimg = onereview.rating_img_url;

                var name = onebusiness.name;
                var address1 = onebusiness.address1;
                var address2 = onebusiness.address2;
                var state_code = onebusiness.state_code;
                var fulladdress = address1 + ", " + address2 + ", " + state_code;
                var resturl = onebusiness.url;
                var busimg = onebusiness.photo_url;
                var phone = onebusiness.phone;


                var img2 = $(".fbusinessimage");

                tempclone.find(".fbusinessimage").attr("src", busimg);
                tempclone.find(img2).height(120);
                tempclone.find(img2).width(100);

                var img3 = $(".freviewimage");

                tempclone.find(".freviewimage").attr("src", reviewimg);
                tempclone.find(img3).height(25);
                tempclone.find(img3).width(95);

                // document.getElementById("restaurantID").textContent = id;
                tempclone.find(".frestaurantname").html(name);
                tempclone.find(".frestaurantaddress").html(fulladdress);
                tempclone.find(".frestaurantphone").html(phone);
               

                $(".flikeone").append(tempclone);

            }

        }
    }

    
     
</script>