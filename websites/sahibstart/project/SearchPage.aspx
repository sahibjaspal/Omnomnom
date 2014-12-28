<%@ Page Language="C#" %>
<%@ Import Namespace="edu.neu.ccis.rasala" %>
<!DOCTYPE html>

<script runat="server">
    //prof. rasalas get key
    const string keyidentifier = "yelpkey";

    public class UserCommentDetails
    {

        public string UserName { get; set; }
        public string Comment { get; set; }
    }

    // page load fucntionality
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            id1.Text = KeyTools.GetKey(this, keyidentifier);
        }
       
        txtsearch.Value = Request.QueryString["searchterm"];
        txtlocation.Value = Request.QueryString["locationterm"];
        //lblbusinessid.Text = Request.QueryString["busid"];
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
    
    

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        // Response.Redirect("SearchPage.aspx");
    }

    //login button click fucntionality
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }

    //logout button click functionalty
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");
    }

    //function to get database connection
    protected System.Data.SqlClient.SqlConnection getDbConnection()
    {

        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
        return conn;

    }

    // function to store the comment in database
    [System.Web.Services.WebMethod()]
    public static string INSERT_COMMENT(string UserName, string YelpID, string SearchTerm, string LocationTerm, string Comment)
    {
        try
        {

            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();

            string insertuser = "insert into sahibj.CommentTable (UserName,YelpID,SearchTerm,LocationTerm,Comment) values (@UserName, @YelpID, @SearchTerm,@LocationTerm,@Comment)";
            System.Data.SqlClient.SqlCommand insertcom = new System.Data.SqlClient.SqlCommand(insertuser, conn);

            insertcom.Parameters.AddWithValue("@UserName", UserName);
            insertcom.Parameters.AddWithValue("@YelpID", YelpID);
            insertcom.Parameters.AddWithValue("@SearchTerm", SearchTerm);
            insertcom.Parameters.AddWithValue("@LocationTerm", LocationTerm);
            insertcom.Parameters.AddWithValue("@Comment", Comment);

            insertcom.ExecuteNonQuery();

            conn.Close();
            return "success";
        }
        catch (Exception ex)
        {

            return "failure" + ex.ToString();
        }


    }

    //fucntion to delete comment from database
    [System.Web.Services.WebMethod()]
    public static string DELETE_COMMENT(string UserName, string Comment)
    {
        try
        {

            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();

            string deletecomment = "delete from sahibj.CommentTable  where UserName = '" + UserName + "' and Comment = '" + Comment + "'";
            System.Data.SqlClient.SqlCommand deletecom = new System.Data.SqlClient.SqlCommand(deletecomment, conn);

            //insertcom.Parameters.AddWithValue("@UserName", UserName);
            //insertcom.Parameters.AddWithValue("@Comment", Comment);

            deletecom.ExecuteNonQuery();

            conn.Close();
            return "success";
        }
        catch (Exception ex)
        {

            return "failure" + ex.ToString();
        }


    }

    //function to insert like in database
    [System.Web.Services.WebMethod()]
    public static string INSERT_LIKE(string UserName, string YelpID, string SearchTerm, string LocationTerm, bool Like)
    {
        // Console.WriteLine(Like);

        try
        {

            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
            conn.Open();
            string checkuser = "select count(*) from sahibj.LikeStatusNew where UserName = '" + UserName + "' and YelpID = '" + YelpID + "'";
            System.Data.SqlClient.SqlCommand com = new System.Data.SqlClient.SqlCommand(checkuser, conn);
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            conn.Close();
            if (temp == 0)
            {
                conn.Open();
                string insertlike = "insert into sahibj.LikeStatusNew (UserName,SearchTerm,LocationTerm,YelpID,LikeStatus) values (@UserName,@SearchTerm,@LocationTerm,@YelpID,@LikeStatus)";
                System.Data.SqlClient.SqlCommand insertcom = new System.Data.SqlClient.SqlCommand(insertlike, conn);

                insertcom.Parameters.AddWithValue("@UserName", UserName);
                insertcom.Parameters.AddWithValue("@SearchTerm", SearchTerm);
                insertcom.Parameters.AddWithValue("@LocationTerm", LocationTerm);
                insertcom.Parameters.AddWithValue("@YelpID", YelpID);
                insertcom.Parameters.AddWithValue("@LikeStatus", Like);

                insertcom.ExecuteNonQuery();
                conn.Close();
                return "success";
            }
            else
            {
                conn.Open();
                string updatelike = "update sahibj.LikeStatusNew  set LikeStatus = '" + Like + "'  where UserName = '" + UserName + "' and YelpID = '" + YelpID + "'";
                System.Data.SqlClient.SqlCommand updatecom = new System.Data.SqlClient.SqlCommand(updatelike, conn);

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

    // fucntion to get user comments from database
    [System.Web.Services.WebMethod()]
    public static UserCommentDetails[] GetComments(string YelpID)
    {
        List<UserCommentDetails> commentdetails = new List<UserCommentDetails>();
        string query = "select TOP 1 UserName,Comment from sahibj.CommentTable where YelpID = '" + YelpID + "' ORDER BY CommentID DESC";


        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn))
            {
                conn.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    UserCommentDetails ob = new UserCommentDetails();
                    ob.UserName = reader.GetString(0);
                    ob.Comment = reader.GetString(1);
                    commentdetails.Add(ob);

                }
            }
            conn.Close();
        }


        return commentdetails.ToArray();
    }

    // function to get all the old comments
    [System.Web.Services.WebMethod()]
    public static UserCommentDetails[] GetOldComments(string YelpID)
    {
        List<UserCommentDetails> commentdetails = new List<UserCommentDetails>();
        string query = "select UserName,Comment from sahibj.CommentTable where YelpID = '" + YelpID + "' ORDER BY CommentID";


        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn))
            {
                conn.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    UserCommentDetails ob = new UserCommentDetails();
                    ob.UserName = reader.GetString(0);
                    ob.Comment = reader.GetString(1);
                    commentdetails.Add(ob);


                }
            }
            conn.Close();
        }


        return commentdetails.ToArray();
    }

    //fucntion to get all the likes of a user
    [System.Web.Services.WebMethod()]
    public static bool GetLike(string UserName, string YelpID)
    {

        string query = "select LikeStatus from sahibj.LikeStatusNew where UserName = '" + UserName + "' and YelpID = '" + YelpID + "'";
        bool likestatus = false;

        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, conn))
            {
                conn.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    likestatus = reader.GetBoolean(0);


                }
            }
            conn.Close();
        }


        return likestatus;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
    <title>OMNOMNOM | Search</title>
     <link type="text/css" rel="stylesheet" href="../css/bootstrap/css/bootstrap.css" />
    <link type="text/css" rel="stylesheet" href="CSS/SearchPageCSS.css" />
     <style type="text/css">

       


         </style>
</head>
<body>
    
   <div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            
            <%--<a class="navbar-brand" href="#">Sitename</a>--%>
            <a class="navbar-brand" href="HomePage.aspx"><img class="logoimg" src="../images/omnomnom3.png" height="35" /></a>
       <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
             </div>
        <center>
            <div class="navbar-collapse collapse" id="navbar-main">
                <ul class="nav navbar-nav">
                    
                    <li><a href="HomePage.aspx">Home</a>
                    </li>
                    <li><a href="UserProfile.aspx">Profile</a>
                    </li>
                   
                    <li><a href="ContactUs.aspx">Contact Us</a>
                    </li>
                    <li>
                        
                    </li>
                </ul>
                <form runat="server" class="navbar-form navbar-right" role="search">
                    <span class="txtwelcome">Welcome!</span><asp:Label ID="lblWelcome" runat="server" ClientIDMode="Static"></asp:Label>
                    <div class="form-group">
                        <input id="txtsearch" runat="server"  type="text" class="txtsearch form-control" placeholder="Search for food" />
                    </div>
                    <div class="form-group">
                        <input id="txtlocation" runat="server" type="text" class="txtlocation form-control" placeholder="Location: Ex: Boston"/>
                    </div>
                    <button id="btnsearch" class="btnsearch btn btn-default" type="button">Search</button>
                    <asp:button ID="btnLogin" runat="server"  CssClass="btn btn-default" Text="Login" OnClick="btnLogin_Click"/>
                    <asp:button ID="btnLogout" runat="server"  CssClass="btn btn-default" Text="Logout" OnClick="btnLogout_Click"/>
                </form>
            </div>
        </center>
    </div>
</div>
   <asp:Label ID="id1" runat="server" /> 
    <div class="outermost">
             
             
             
     

     <div class="searchresults container">
         <div id="tablebox" class=" well tablearea">
            <table id="tableresults" class="table table-bordered">
            <tr>
              
                <th>Restaurant Name</th>
                <th>Address</th>
                <th>Contact No.</th>
                <th>Average Rating</th>
                
            </tr>  
           
            <tbody class="results">

            </tbody>

        </table>
           
         </div>

         <div id="detailzarea" class="container well selecteddetails">
             <div id="bdetails" class="businessdetails">

           <asp:label runat="server" ID="lblbusinessid" ></asp:label>
            <div>
                <h2>Details</h2>
                <div class="row">
                    <div class="col-xs-4">
                        <img class="img-thumbnail businessimage img-responsive"  src="#"/>

                    </div>
                    <div class="col-xs-8">
                        <div class="main">
                            
                            <div class="restaurantnamewrapper"><h3 class="restaurantname"></h3> </div>
                            
                            
                        </div>
                        
                        
                        
                        <asp:Label ID="restaurantID" ClientIDMode="Static" runat="server"></asp:Label>
                        <br />
                        <br />
                        
                        <div class="btnLikeWrapper"><input type="button" class="btn btn-primary" id="btnLike" value="Like" /></div>
                        <br />
                        Name: <label class="restaurantname"></label>&nbsp&nbsp&nbsp&nbsp<img class="reviewimage" src="#"/>
                        <br />
                        Address: <label class="restaurantaddress"></label>
                        <br />
                        Contact: <label class="restaurantphone"></label>
                        <br />
                        URL: <label class="restauranturl"></label>

                        <br />
                        <br />
                        
                        
                        <label>Brief Review Excerpts are: </label>
                        <ol class="reviewlist">
                           
                        </ol>
                        <br />
                        <div class="previouscomments">
                             
                                Review Section : 
                           <ul id="displayoldcomments" class="list-unstyled displayoldcomments">


                           </ul>
                            
                            <div id="currentusercomments">
                            
                            <ul class="list-unstyled displaycomments">

                           
                           
                           </ul>
                             </div>
                          
                        </div>
                        
                        <br />
                        <div id="fullcommentsection">
                        <label>User Comment Section:</label>
                            <br />
                            <textarea id="txtComment" height="100px" cols="20" rows="2"></textarea>
                        <%--<asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Height="100px" ClientIDMode="Static"></asp:TextBox>--%>
                       <br />
                            <input class="btn btn-primary" type="button" id="btnComment" value="Comment" />
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
              <div class="footerimage">
                  
                  <img src="../images/footer.JPG" class="img-responsive" />
              </div>
                  </center>
              </div>
       </div>
       
       
        
        </div>
    
       
</body>
</html>


    <script type="text/javascript" src="../javascript/jquery-2.1.0.min.js"></script>
    <script type="text/javascript" src="../css/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">

    
    var yelpkey = document.getElementById("id1").innerText;

    //disable link click
    $("#welcomered").click(function (e) {

        e.preventDefault();
    });

    //to change button like/unlike text and store like/unlike in database
    $(function () {
        $("#btnLike").click(function () {
            $(this).val(function (i, text) {
                if (text === "Like") {
                    storeLike(true);
                    return "Unlike";
                } else {
                    storeLike(false);
                    return "Like";
                }
            })
        });
    })

    //store like in database, calls webmethod in C# to retrieve likes from db
    function storeLike(Like) {

        //  alert("we will store a Like/Unlike");
        // alert(Like);
        // var Like = true;
        var UserName = document.getElementById("lblWelcome").textContent;
        var SearchTerm = $(".txtsearch").val();
        var LocationTerm = $(".txtlocation").val();
        var YelpID = document.getElementById("restaurantID").textContent;

        $.ajax({


            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "SearchPage.aspx/INSERT_LIKE",
            data: "{UserName:'" + UserName + "', YelpID:'" + YelpID + "',SearchTerm:'" + SearchTerm + "',LocationTerm:'" + LocationTerm + "',Like:'" + Like + "'}",
            dataType: "json",
            // async: false,
            success: function (response) {
                // $("#txtComment").val('');
                // alert("Like Record saved successfully");
                console.log(response);

            },
            error: function () {

                alert("Like data could not be saved");
            }
        });


    }

    // set some initial values etc
    $(document).ready(function () {
        $("#id1").hide();
        var UserName = document.getElementById("lblWelcome").textContent;

        $(".tablearea").hide();
        $(".selecteddetails").hide();

        if (UserName === "Guest") {

            $("#currentusercomments").hide();
            $("#fullcommentsection").hide();
            $(".btnLikeWrapper").hide();
            $(".deletebuttons").hide();
        }

    });

    //comment button click functionaltiy
    $(document).ready(function () {

        $("#btnComment").click(comment_button_click);
    });

    //delete button click functionality
    $(document).ready(function () {

        $("body").on("click", ".deletebuttons", delete_button_click);
    });

    //search button click functinality
    $(function () {
        $("#btnsearch").click(search_button_click);
        $("body").on("click", ".wam-details", handleDetailsLink);

    });

    //delete comment functionality
    function delete_button_click() {

       // alert("delete button clicked");
        var $current = $(this);
        var id = $current.attr("id");
        var commentid = document.getElementById("comment" + id).getAttribute("id");
        commentid = commentid.trim();
        var commenttext = document.getElementById(commentid).textContent;
       // alert(commenttext);
        var userwhocommentedid = document.getElementById("user" + id).getAttribute("id");
        userwhocommentedid = userwhocommentedid.trim();
        var userwhocommented = document.getElementById(userwhocommentedid).textContent;
       // alert(userwhocommented);
        $(this).parent().remove();
        $(this).remove();

        delete_comment_fromdb(userwhocommented, commenttext);

       

    }

    //delete comment from database, calls webmethod in C# to delete comment from database
    function delete_comment_fromdb(UserName, Comment) {


        $.ajax({


            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "SearchPage.aspx/DELETE_COMMENT",
            data: "{UserName:'" + UserName + "',Comment:'" + Comment + "'}",
            dataType: "json",
            // async: false,
            success: function (response) {

              //  alert("Record deleted successfully");

            },
            error: function () {

                alert("data could not be deleted");
            }
        });


    }

    //post comment, call webmethod which stores comment in database, empty comments are not allowed!
    function comment_button_click() {
        // alert("comment butn clicked");
        var UserName = document.getElementById("lblWelcome").textContent;
        var SearchTerm = $(".txtsearch").val();
        var LocationTerm = $(".txtlocation").val();
        var YelpID = document.getElementById("restaurantID").textContent;
        var Comment = $("#txtComment").val();
        //Comment = Comment.replace(/^\s+|\s+$/gm,'');
        // alert("comment butn clicked" + UserName + SearchTerm + LocationTerm + YelpID + Comment);
       
        Comment = Comment.replace(/(^\s*)|(\s*$)/gi, "");
        Comment = Comment.replace(/[ ]{2,}/gi, " ");
        Comment = Comment.replace(/\n /, "\n");
        document.getElementById("txtComment").value = Comment;
        Comment = document.getElementById("txtComment").value;
        if (!(Comment == "")) {





            $.ajax({


                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "SearchPage.aspx/INSERT_COMMENT",
                data: "{UserName:'" + UserName + "', YelpID:'" + YelpID + "',SearchTerm:'" + SearchTerm + "',LocationTerm:'" + LocationTerm + "',Comment:'" + Comment + "'}",
                dataType: "json",
                // async: false,
                success: function (response) {
                    $("#txtComment").val('');
                    //  alert("Record saved successfully");
                    showComments(UserName, YelpID);
                },
                error: function () {

                    alert("data could not be saved");
                }
            });
        }

    }

    //show comments from database, webmethod called and json object recieved
    function showComments(UserName, YelpID) {
        //  alert("inside showcomments");
        $.ajax({
            type: "POST",
            url: "SearchPage.aspx/GetComments",
            data: "{YelpID:'" + YelpID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //        alert("inside success function ajax");
                var list = $(".displaycomments");
                $("#noreviews").hide();
                for (var i = 0; i < data.d.length; i++) {
                    var user = data.d[i].UserName;
                    var j = 99 + i;
                    var Comment = data.d[i].Comment;
                    var li = $("<li>");
                    var label = $("<label>");
                    label.append(user);
                    label.attr("id", "user" + j);
                    li.append(label);
                    li.append(":");
                    li.attr("style", "color:blue;width:100%;height:10%;text-align:left;");
                    li.attr("id", "userli" + j);
                    var label = $("<label>");
                    label.append(Comment);
                    label.attr("id", "comment" + j);
                    li.append(label);

                    var btn = $("<input type='button' class='btn btn-danger deletebuttons'>");
                    btn.attr("id", j);
                    btn.attr("value", "x");
                    btn.attr("style", "float:right;width:auto;height:auto;");
                    li.append(btn);
                    li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                    li.attr("class", "well");
                    li.attr("id", "commentli" + j);
                    
                    list.append(li);




                    //var li = $("<li>");
                    //li.append(user + " :");
                    //li.attr("style", "color:blue;width:100%;height:10%;text-align:left;");
                    //list.append(li);
                    //var li = $("<li>");
                    //li.append(Comment);
                    //li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                    //li.attr("class", "well");

                    //list.append(li);

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

    //show more details view
    function handleDetailsLink() {
        

        var link = $(this);
        var businessid = link.attr("id");

        var searchterm = $(".txtsearch").val();
        var locationterm = $(".txtlocation").val();
        if (searchterm === null || searchterm === "" || typeof searchterm === "undefined")
            return;
        if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
            return;
        searchforbusiness(businessid, searchterm, locationterm, givebusinessresults);
    }

    //counter to check how many times handledetails link is clicked.
    var ctr = 1;
    function searchforbusiness(businessid, searchterm, locationterm, callback) {
        if (ctr === 1) {

            $(".tablearea").toggleClass("newtablearea");
            ctr++;
        }
        var UserName = document.getElementById("lblWelcome").textContent;
        
        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: yelpkey, term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, businessid);
                // $("#bdetails").show();
                $("#restaurantID").hide();
                showOldComments(UserName, businessid);
                showLike(UserName, businessid);
                
                $(".row").show();
                $(".selecteddetails").stop().show("slow");
                //$(".selecteddetails").show();
            }

        });
    }

    //show user like/unlike of current user for current outlet
    function showLike(UserName, YelpID) {
        // alert("inside showcomments");
        $.ajax({
            type: "POST",
            url: "SearchPage.aspx/GetLike",
            data: "{UserName:'" + UserName + "', YelpID:'" + YelpID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //  alert("inside success function ajax" + data.d);
                if (data.d === true) {
                    //button should be Unlike
                    $("#btnLike").attr("value", "Unlike");
                }
                else {
                    //button should be Like
                    $("#btnLike").attr("value", "Like");

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

    //show old comments, webmethod called, json object recieved
    function showOldComments(UserName, YelpID) {
        // alert("inside showcomments");
        $.ajax({
            type: "POST",
            url: "SearchPage.aspx/GetOldComments",
            data: "{YelpID:'" + YelpID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // alert("inside success function ajax");
                var list = $(".displayoldcomments");
                list.empty();
                var list2 = $(".displaycomments");
                list2.empty();
                if (data.d.length == 0) {
                    var li = $("<li>");
                    li.append("No Reviews Yet!!");
                    li.attr("id", "noreviews");
                    li.attr("style", "color:blue;width:100%;height:10%;text-align:left;");
                    li.attr("class", "well");
                    list.append(li);

                }
                else {
                    for (var i = 0; i < data.d.length; i++) {
                        var user = data.d[i].UserName;

                        var Comment = data.d[i].Comment;
                        //  var divblock = $("<div>");
                        //divblock.attr("id", "div" + i);
                        var li = $("<li>");
                        var label = $("<label>");
                        label.append(user);
                        label.attr("id", "user" + i);
                        li.append(label);
                        li.append(":");
                        li.attr("style", "color:blue;width:100%;height:10%;text-align:left;");
                        li.attr("id", "userli" + i);
                        //divblock.append(li);
                        //list.append(li);
                        // var li = $("<li>");
                        var label = $("<label>");
                        label.append(Comment);
                        label.attr("id", "comment" + i);
                        li.append(label);


                        
                        //trim any extra spaces
                        UserName = UserName.trim();
                        user = user.trim();
                        if (UserName === user) {
                            // alert("hi" + UserName + user);
                            var btn = $("<input type='button' class='btn btn-danger deletebuttons'>");
                            btn.attr("id", i);
                            btn.attr("value", "x");
                            btn.attr("style", "float:right;width:auto;height:auto;");
                            li.append(btn);
                        }

                        li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                        li.attr("class", "well");
                        li.attr("id", "commentli" + i);
                        //divblock.append(li);
                        //list.append(divblock);
                        list.append(li);

                        //var li = $("<li>");
                        //var btn = $("<button>");
                        //li.append(btn);
                        //li.attr("style", "width:2px;height:2px;text-align:left;");
                        //li.attr("class", "btn btn-danger");

                        //list.append(li);

                    }

                }


                // alert(commenttext);


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

    //get search results
    function givebusinessresults(response, businessid) {

        var allbusinesses = response.businesses;
        var ul = $(".businessresults");
        var list = $(".reviewlist");
        ul.empty();
        list.empty();

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

                img2.attr("src", busimg);
                img2.height(250);
                img2.width(250);

                var img3 = $(".reviewimage");

                img3.attr("src", reviewimg);
                img3.height(25);
                img3.width(95);

                document.getElementById("restaurantID").textContent = id;
                $(".restaurantname").html(name);
                $(".restaurantaddress").html(fulladdress);
                $(".restaurantphone").html(phone);
                $(".restauranturl").html(resturl);

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

                for (var k in allreviews) {
                    var onereview = onebusiness.reviews[k];
                    var reviewtext = onereview.text_excerpt;


                    li = $("<li>");
                    li.append(reviewtext);
                    li.attr("style", "color:black;width:100%;height:10%;text-align:left;");
                    li.attr("class", "well");

                    list.append(li);
                }


            }

        }
    }

    //get more details of outlet
    function search_button_click() {
        $(".selecteddetails").stop().hide("slow");
       
        $(".row").hide();
        $(".results").stop().hide("slow");
        var searchterm = $(".txtsearch").val();
        var locationterm = $(".txtlocation").val();
        if (searchterm === null || searchterm === "" || typeof searchterm === "undefined")
            window.location.replace("EmptySearch.aspx");
        if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
            window.location.replace("EmptySearch.aspx");

        searchforbusiness2(searchterm, locationterm, giveresults);
    }


    //show search results
    $(document).ready(function () {
        //  $(".wam-li-template").hide();
        //  $("#bdetails").hide();
        //$("#searchresults").hide();

        //   var businessid = "7ysLZWWRw4swz6x9d6KXwg";
        //  document.getElementById("lblbusinessid").textContent = businessid;

        $(".row").hide();

        var searchterm = $(".txtsearch").val();
        var locationterm = $(".txtlocation").val();
        if (searchterm === null || searchterm === "" || typeof searchterm === "undefined")
            window.location.replace("EmptySearch.aspx");
        if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
            window.location.replace("EmptySearch.aspx");


        // var searchterm = "Pizza";
        // var locationterm = "Boston";
        searchforbusiness2(searchterm, locationterm, giveresults);

    });


    //get search results from yelp api
    function searchforbusiness2(searchterm, locationterm, callback) {

        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: yelpkey, term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (response.businesses.length === 0) {
                    window.location.replace("IncorrectSearch.aspx");

                }
                if (typeof callback === "function")
                    callback(response);
                //$("#bdetails").show();
                $(".results").stop().show("slow");
                $(".tablearea").stop().show("slow");
               
            }

        });
    }

    //display search results
    function giveresults(response) {
        var allbusinesses = response.businesses;
        // var ul = $(".wam-results-1");
        // ul.empty();
        // var ol = $(".reviewlist");

        // ol.empty();
        var table = $(".results");
        table.empty();
        //var template = $(".wam-li-template li:first");
        for (var i in allbusinesses) {
            var onebusiness = allbusinesses[i];
            var businessid = onebusiness.id;

            var allreviews = onebusiness.reviews;
            var businessid = onebusiness.id;
            var onereview = onebusiness.reviews[0];

            var reviewimg = onereview.rating_img_url;

            var name = onebusiness.name;

            // $(".restaurantname").html(name);

            var address1 = onebusiness.address1;
            var address2 = onebusiness.address2;
            var state_code = onebusiness.state_code;
            var fulladdress = address1 + ", " + address2 + ", " + state_code;
            var resturl = onebusiness.url;
            var busimg = onebusiness.photo_url;
            var phone = onebusiness.phone;


            var tr = $("<tr>");
            var td = $("<td>");
            var img2 = $("<img>");
            img2.attr("src", reviewimg);
            img2.height(25);
            img2.width(95);

            // td.append(businessid);
            // tr.append(td);

            var titleLink = $("<a href='#detailzarea' class='wam-details'>");
            titleLink.append(name);
            titleLink.attr("id", businessid);
            titleLink.attr("style", "color:blue");

            td = $("<td>");
            td.append(titleLink);
            tr.append(td);

            td = $("<td>");
            td.append(fulladdress);
            tr.append(td);

            td = $("<td>");
            td.append(phone);
            tr.append(td);



            td = $("<td>");
            td.append(img2);
            tr.append(td);
            table.append(tr);
            //var instance = template.clone();

            //instance.attr("id", businessid);
            ////  instance.find(".wam-id").html(businessid);
            //instance.find(".wam-title").html(name);
            //instance.find(".wam-address").html(fulladdress);
            //instance.find(".wam-phone").html(phone);
            //instance.find(".wam-thumbnail").attr("src", busimg);
            //ul.append(instance);

            // var img2 = $(".businessimage");

            //var img2 = $("<img>");
            //img2.attr("src", busimg);
            //img2.height(150);
            //img2.width(100);
            //li.append(img2);


            //var img3 = $(".reviewimage");

            //img3.attr("src", reviewimg);
            //img3.height(25);
            //img3.width(95);



            // li = $("<li>");
            //li.append(name);


            //li = $("<li>");
            //li.append(fulladdress);


            //li = $("<li>");
            //li.append(phone);
            //ul.append(li);

            //ul.append("<br />");

            /*     for (var k in allreviews) {
                     var onereview = onebusiness.reviews[k];
                     var reviewtext = onereview.text_excerpt;


                     li = $("<li>");
                     li.append(reviewtext);

                     ol.append(li);
                 }
                 */

        }

    }


</script>