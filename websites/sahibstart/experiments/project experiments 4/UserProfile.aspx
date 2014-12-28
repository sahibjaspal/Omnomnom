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

    public class FollowUserLikeDetails
    {
        public string UserName { get; set; }
        public string SearchTerm { get; set; }
        public string LocationTerm { get; set; }
        public string YelpID { get; set; }
    }

    public class FollowUserCommentDetails
    {
        public string UserName { get; set; }
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
            btnLogout.Visible = true;
            lblWelcome.Text = Session["User"].ToString();
            lblUserName.Text = Session["User"].ToString();

        }
        else
        {
            Response.Redirect("Login.aspx");
            
        }
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
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
    <link rel="stylesheet" href="UserProfileCSS.css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">

</style>
</head>

<body>
    <form id="form1" runat="server">
         <div class="outermost">
             <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#272626;border-color:#428bca">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="#" style="color:white;"><img class="logoimg" src="../../images/omnomnom3.png" height="35" /></a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    
                    <li><a href="HomePage.aspx" style="color:white">Home</a></li>
                    <li class="active"><a href="UserProfile.aspx" style="color:white">Profile</a></li>
                    <li><a href="#" style="color:white">About</a></li>
                    <li><a href="#" style="color:white">Contact</a></li>
                    <li></li>
                    <li><a href="#" style="color:#b61111;font-weight:bold;">Welcome! <asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label></a></li>
                    
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    
                    <li class="nav navbar-nav navbar-right">
                        <asp:Button  style="margin-top:9%;" runat="server" ID="btnLogout" CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click" />

                    </li>  
           
                    
                </ul>
            </div>
        </div><!-- container -->
</div>
             
             
      <div class="basicuserinfo">
                 
         <div class="userpanel well container">
             
              <div class="exploreusers">
             <center>
                  <div class="ui-widget exploretxtwrapper">
            
                  <label class="lblUserSearch" for="txtUserSearch">Explore Users: </label>
                
            <input type="text" id="txtUserSearch" runat="server" class="autosuggest form-control" />
                 
                 </div>
             <div class="btnSearchUserWrapper">
                 <asp:Button ID="btnSearchUser" CssClass="btn btn-primary" runat="server" Text="ViewProfile" OnClick="btnSearchUser_Click" /></div>
                </center>
              </div>
                 
            <hr class="horizontalpartition" />
             <div class="txtWelcome"><h2>Welcome!
             <asp:Label ID="lblUserName" runat="server" ClientIDMode="Static"></asp:Label></h2>
                 </div>
             <div class="userwrapper">
             <div class="userdetails">
             <div class="userphoto">
                 <%--<img src="http://www.kaczmarek-photo.com/wp-content/uploads/2012/06/guinnes-150x150.jpg" alt="post img" class="pull-left img-responsive thumb margin10 img-thumbnail" />--%>

             </div>
             <div class="aboutme">
                 <div class="labelaboutme">

                     <%--<asp:Label ID="lblAboutMe" runat="server" Text="Label">About Me ! User Introduction</asp:Label>--%>
                 </div>
                <%-- <asp:TextBox ID="txtAboutMe" runat="server" TextMode="MultiLine" Height="100px" ClientIDMode="Static"></asp:TextBox>
                       <input class="btn btn-primary" type="button" id="btnSave" value="Save" />--%>

                 
             </div>
                 
                 </div>
            
             <div id="useractivites" class=" useractivities">
                 <div>
                     <h3>User Activities</h3>
                   <div class="mylinks"> 
                 <a id="mylikes" class="mylikes well" href="#useractivities">My Likes</a>
                  <a class="mycomments well" href="#useractivities">My Comments</a>
                  <a class="followlikes well" href="#useractivities">Following User Likes</a>
                  <a class="followcomments well" href="#useractivities">Following User Comments</a>
                   </div> 
                          
                </div>

                 <div style="" id="linkresults" class="linkresults">
                        
                     <div class="likewrapper">
        <h2>My Likes</h2><br />
           
     
               <div class="likeone">
           <div id="bdetails" class="businessdetails">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="businessimage" src="#"/>

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
        <h2>My Comments</h2><br />
           
     
               <div class="commentone">
           <div id="cdetails" class="cbusinessdetails">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="cbusinessimage" src="#"/>

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
        <h2>Follow Likes</h2><br />
           
     
               <div class="flikeone">
           <div id="fbdetails" class="fbusinessdetails">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="fbusinessimage" src="#"/>

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
        <h2>Follow Comments</h2><br />
           
     
               <div class="followcommentone">
           <div id="fcdetails" class="fcbusinessdetails">

          
            <div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <img class="fcbusinessimage" src="#"/>

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

    $(document).ready(function () {
        $(".commentwrapper").hide();
        $(".likewrapper").hide();
        $(".followlikewrapper").hide();
        $(".followcommentwrapper").hide();
        var UserName = document.getElementById("lblWelcome").textContent;

        $("#mylikes").click(getCurrentUserLikes);
      //  $("body").on("click", ".mylikes", getCurrentUserLikes(UserName));
        $(".mycomments").click(getCurrentUserComments);

        $(".followlikes").click(getFollowUserLikes);

        $(".followcomments").click(getFollowUserComments);

    });

    function getFollowUserLikes() {
        $(".commentwrapper").hide();
        $(".likewrapper").hide();
        $(".followcommentwrapper").hide();
        $(".followlikewrapper").show();

       
        var UserName = document.getElementById("lblWelcome").textContent;
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
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = fliketemplate.clone();
                    var fuser = data.d[i].UserName;
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;
                    
                   getFollowLikeData(fuser, searchterm, locationterm, YelpID,tempclone,giveFollowLikeResults);
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

   
    function getFollowUserComments() {
        $(".commentwrapper").hide();
        $(".likewrapper").hide();
        $(".followlikewrapper").hide();
        $(".followcommentwrapper").show();
       

        var UserName = document.getElementById("lblWelcome").textContent;
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
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = fcommenttemplate.clone();
                    var fuser = data.d[i].UserName;
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;
                    var Comment = data.d[i].Comment;
                  //  alert(fuser + searchterm + locationterm + YelpID + Comment);
                    getFollowCommentData(fuser, searchterm, locationterm, YelpID,Comment,tempclone, giveFollowCommentResults);
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
    

    function getCurrentUserLikes() {
        
        $(".commentwrapper").hide();
        $(".followcommentwrapper").hide();
        $(".followlikewrapper").hide();
        $(".likewrapper").show();
        var UserName = document.getElementById("lblWelcome").textContent;
        var liketemplate = $(".likeone .businessdetails");
        var likeContainer = $(".likeone .container");
        var likeOne = $(".likeone");
        likeContainer.remove();
        alert("getlikes " + UserName);
        $.ajax({
            type: "POST",
            url: "UserProfile.aspx/GetUserLike",
            data: "{UserName:'" + UserName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
               // alert("inside success function ajax" + data);
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = liketemplate.clone();
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;
                    getLikeData(UserName, searchterm, locationterm, YelpID,tempclone,giveLikeResults);
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

    function getCurrentUserComments() {
        $(".likewrapper").hide();
       

        $(".followlikewrapper").hide();
        $(".followcommentwrapper").hide();
        $(".commentwrapper").show();
        var UserName = document.getElementById("lblWelcome").textContent;
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
                for (var i = 0; i < data.d.length; i++) {
                    var tempclone = commenttemplate.clone();
                    var searchterm = data.d[i].SearchTerm;
                    var locationterm = data.d[i].LocationTerm;
                    var YelpID = data.d[i].YelpID;
                    var Comment = data.d[i].Comment;
                    getCommentData(UserName, searchterm, locationterm, YelpID,Comment,tempclone, giveCommentResults);
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

    function getLikeData(UserName, searchterm, locationterm, YelpID, tempclone, callback) {


        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID,tempclone);
               // $("#bdetails").show();
                
            }

        }); 

    }


    function getFollowLikeData(fuser, searchterm, locationterm, YelpID,tempclone, callback) {
      //  alert(fuser + " " + searchterm + " " + locationterm + " " + YelpID);

        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID,tempclone);


            }

        });

    }

    

    function getCommentData(UserName, searchterm, locationterm, YelpID,Comment,tempclone, callback) {

        
        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID,Comment,tempclone);


            }

        });

    }

    function getFollowCommentData(UserName, searchterm, locationterm, YelpID, Comment,tempclone, callback) {


        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, YelpID, Comment,UserName,tempclone);


            }

        });

    }

    function giveCommentResults(response, businessid,Comment,tempclone) {
       
        var allbusinesses = response.businesses;
       // var ul = $(".likeresults");
       // var list = $(".reviewlist");
        //ul.empty();
       // list.empty();

       // var commenttemplate = $("#cdetails");
      //  commenttemplate.empty();
       // var tempclone = commenttemplate.clone();
        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container");

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
                //  $(".restauranturl").html(resturl);

                //var onereview = allreviews[0];
                //var reviewtext = onereview.text_excerpt;
                //$(".review1").html(reviewtext);
                //alert(reviewtext);

                //tworeview = allreviews[1];
                // reviewtext = tworeview.text_excerpt;  
                // $(".review2").html(reviewtext);

                // threereview = allreviews[2];
                // reviewtext = threereview.text_excerpt;
                // $(".review3").html(reviewtext);

                //for (var k in allreviews) {
                //    var onereview = onebusiness.reviews[k];
                //    var reviewtext = onereview.text_excerpt;


                //    li = $("<li>");
                //    li.append(reviewtext);
                //    li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                //    li.attr("class", "well");

                //    list.append(li);
                //}
                $(".commentone").append(tempclone);

            }

        }
    }


    function giveFollowCommentResults(response, businessid, Comment, UserName,tempclone) {

        var allbusinesses = response.businesses;
        // var ul = $(".likeresults");
        // var list = $(".reviewlist");
        //ul.empty();
        // list.empty();

       // var commenttemplate = $("#fcdetails");
       // var tempclone = commenttemplate.clone();
        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container");

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
                //  $(".restauranturl").html(resturl);

                //var onereview = allreviews[0];
                //var reviewtext = onereview.text_excerpt;
                //$(".review1").html(reviewtext);
                //alert(reviewtext);

                //tworeview = allreviews[1];
                // reviewtext = tworeview.text_excerpt;  
                // $(".review2").html(reviewtext);

                // threereview = allreviews[2];
                // reviewtext = threereview.text_excerpt;
                // $(".review3").html(reviewtext);

                //for (var k in allreviews) {
                //    var onereview = onebusiness.reviews[k];
                //    var reviewtext = onereview.text_excerpt;


                //    li = $("<li>");
                //    li.append(reviewtext);
                //    li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                //    li.attr("class", "well");

                //    list.append(li);
                //}
                $(".followcommentone").append(tempclone);

            }

        }
    }

    function giveLikeResults(response, businessid,tempclone) {
      
        var allbusinesses = response.businesses;
        var ul = $(".likeresults");
        var list = $(".reviewlist");
        //ul.empty();
        //list.empty();

        //var liketemplate = $("#bdetails");
        
        //var tempclone = liketemplate.clone();
        
        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container");

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
              //  $(".restauranturl").html(resturl);
                    
                //var onereview = allreviews[0];
                //var reviewtext = onereview.text_excerpt;
                //$(".review1").html(reviewtext);
                //alert(reviewtext);

                //tworeview = allreviews[1];
                // reviewtext = tworeview.text_excerpt;  
                // $(".review2").html(reviewtext);

                // threereview = allreviews[2];
                // reviewtext = threereview.text_excerpt;
                // $(".review3").html(reviewtext);

                //for (var k in allreviews) {
                //    var onereview = onebusiness.reviews[k];
                //    var reviewtext = onereview.text_excerpt;

                        
                //    li = $("<li>");
                //    li.append(reviewtext);
                //    li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                //    li.attr("class", "well");
                        
                //    list.append(li);
                //}
                $(".likeone").append(tempclone);

            }

        }
    }

    function giveFollowLikeResults(response, businessid,tempclone) {
       // alert(businessid+fUserName);
        var allbusinesses = response.businesses;
       // var ul = $(".likeresults");
        //var list = $(".reviewlist");
        //ul.empty();
        //list.empty();

        //var followliketemplate = $("#fbdetails");
        //var tempclone = followliketemplate.clone();
        tempclone.attr("style", "width:25%;float:left;");
        tempclone.attr("class", "container");

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
                //  $(".restauranturl").html(resturl);

                //var onereview = allreviews[0];
                //var reviewtext = onereview.text_excerpt;
                //$(".review1").html(reviewtext);
                //alert(reviewtext);

                //tworeview = allreviews[1];
                // reviewtext = tworeview.text_excerpt;  
                // $(".review2").html(reviewtext);

                // threereview = allreviews[2];
                // reviewtext = threereview.text_excerpt;
                // $(".review3").html(reviewtext);

                //for (var k in allreviews) {
                //    var onereview = onebusiness.reviews[k];
                //    var reviewtext = onereview.text_excerpt;


                //    li = $("<li>");
                //    li.append(reviewtext);
                //    li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                //    li.attr("class", "well");

                //    list.append(li);
                //}
                $(".flikeone").append(tempclone);

            }

        }
    }
     
</script>