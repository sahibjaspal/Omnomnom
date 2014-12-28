<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    public class UserCommentDetails
    {

        public string UserName { get; set; }
        public string Comment { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

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

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["User"] = null;
        Response.Redirect("Login.aspx");
    }

    protected System.Data.SqlClient.SqlConnection getDbConnection()
    {

        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["sahibjCS"].ConnectionString);
        return conn;

    }

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
    <title></title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />
    <script type="text/javascript" src="../../javascript/jquery-2.1.0.min.js"></script>
    <script type="text/javascript" src="../../css/bootstrap/js/bootstrap.js"></script>
     <style type="text/css">

         .previouscomments {
        margin-top:20%;
            height:300px;
            width:100%;
            overflow-y:scroll;
        
        }

         #btnLike {
          
            width:100px;
            margin-left:3px;
            
            
        }

        .btnLikeWrapper {
            
            
        }

         .tablearea {
        margin-top:70px;
        float:left;
        width:42%;
       
        }

        .reviewlist {
            margin:10px;
            color:black;
        
        }

        .restaurantnamewrapper {
            float:left;
        }

        .connectwithus {
        
            margin-top:5px; 
            background-color:black;
            height:350px;
            margin-bottom:-20px;
            color:white;

           }

       
        .selecteddetails {
        margin-top:70px;
            float:left;
           width:55%;
           margin-left:2%;
           height:1450px;
           color:black;
        }

        body {
        
        background-color:#b61111;
        }

        .outermost {
        
            width:100%;
        }

        .navbar-default {
            background-color: #1a1818;
            border-color: #e7e7e7;
        }           
         #lblWelcome {
            color:#b61111;
         }

         .txtwelcome {
         
            color:#b61111;
         }

         #txtComment {
         
            height:110px;

            width:200px;
         }
         </style>
</head>
<body>
    
   <div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <%--<a class="navbar-brand" href="#">Sitename</a>--%>
            <a class="navbar-brand" href="#" style="color:white;"><img class="logoimg" src="../../images/omnomnom3.png" height="35" /></a>
        </div>
        <center>
            <div class="navbar-collapse collapse" id="navbar-main">
                <ul class="nav navbar-nav">
                    
                    <li><a href="HomePage.aspx">Home</a>
                    </li>
                    <li><a href="UserProfile.aspx">Profile</a>
                    </li>
                    <li><a href="#">About</a>
                    </li>
                    <li><a href="#">Contact</a>
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
    
    <div class="outermost">
             
             
             
     

     <div class="searchresults container">
         <div class=" well tablearea">
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

         <div class="container well selecteddetails">
             <div id="bdetails" class="businessdetails">

           <asp:label runat="server" ID="lblbusinessid" ></asp:label>
            <div>
                <h2>Details</h2>
                <div class="row">
                    <div class="col-xs-4">
                        <img class="businessimage" src="#"/>

                    </div>
                    <div class="col-xs-8">
                        <div class="main">
                            
                            <div class="restaurantnamewrapper"><h3 class="restaurantname"></h3> </div>
                            
                            
                        </div>
                        
                        
                        
                        <asp:Label ID="restaurantID" ClientIDMode="Static" runat="server"></asp:Label>
                        <br />
                        <br />
                        <br>
                        <input type="button" class="btn btn-primary" id="btnLike" value="Like" />
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
    
       
</body>
</html>
<script type="text/javascript">

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

    //function storeUnlike() {

    //    alert("we will store an Unlike");

    //    var Unlike = false;
    //    var UserName = document.getElementById("lblWelcome").textContent;
    //    var SearchTerm = $(".txtsearch").val();
    //    var LocationTerm = $(".txtlocation").val();
    //    var YelpID = document.getElementById("restaurantID").textContent;

    //    $.ajax({


    //        type: "POST",
    //        contentType: "application/json; charset=utf-8",
    //        url: "SearchPage.aspx/INSERT_UNLIKE",
    //        data: "{UserName:'" + UserName + "', YelpID:'" + YelpID + "',SearchTerm:'" + SearchTerm + "',LocationTerm:'" + LocationTerm + "',Unlike:'" + Unlike + "'}",
    //        dataType: "json",
    //        // async: false,
    //        success: function (response) {
    //            // $("#txtComment").val('');
    //            alert("Unlike Record saved successfully");

    //        },
    //        error: function () {

    //            alert("Unlike data could not be saved");
    //        }
    //    });



    //}

    $(document).ready(function () {
        var UserName = document.getElementById("lblWelcome").textContent;

        if (UserName === "Guest") {

            $("#currentusercomments").hide();
            $("#fullcommentsection").hide();
            $(".btnLikeWrapper").hide();
            $(".deletebuttons").hide();
        }

    });

    $(document).ready(function () {

        $("#btnComment").click(comment_button_click);
    });

    $(document).ready(function () {

        $("body").on("click", ".deletebuttons", delete_button_click);
    });

    $(function () {
        $("#btnsearch").click(search_button_click);
        $("body").on("click", ".wam-details", handleDetailsLink);

    });

    function delete_button_click() {

        alert("delete button clicked");
        var $current = $(this);
        var id = $current.attr("id");
        var commentid = document.getElementById("comment" + id).getAttribute("id");
        commentid = commentid.trim();
        var commenttext = document.getElementById(commentid).textContent;
        alert(commenttext);
        var userwhocommentedid = document.getElementById("user" + id).getAttribute("id");
        userwhocommentedid = userwhocommentedid.trim();
        var userwhocommented = document.getElementById(userwhocommentedid).textContent;
        alert(userwhocommented);
        $(this).parent().remove();
        $(this).remove();

        delete_comment_fromdb(userwhocommented, commenttext);

        //  $current = $current.prev();
        //  $current.parent().remove();
        // $current.parent().parent().remove();
        // alert(id);
        //var commentid = document.getElementById("comment" + id).getAttribute("id");
        //commentid = commentid.trim();
        //var commenttext = document.getElementById(commentid).textContent;
        //alert(commenttext);

        // current.parent().prev().remove();

        //  alert(id); 
        //  var userwhocommentedid = document.getElementById("user" + id).getAttribute("id");
        //  userwhocommentedid = userwhocommentedid.trim();
        //  var userwhocommented = document.getElementById(userwhocommentedid).textContent;
        //  alert(userwhocommented);
        //  //console.log(userwhocommented);
        //  var commentid = document.getElementById("comment" + id).getAttribute("id");
        //  commentid = commentid.trim();
        //  var commenttext = document.getElementById(commentid).textContent;
        //  alert(commenttext);
        // // console.log(userwhocommented);
        //  console.log(commenttext);
        //  alert(id);
        // // var divblock = document.getElementById("div" + id).getAttribute("id");

        //  var userli = document.getElementById("userli" + id).getAttribute("id");
        //  var commentli = document.getElementById("commentli" + id).getAttribute("id");
        //  //alert(divblock);
        // // $("displayoldcomments li")[1].css("display", "none");
        //  var ul = $("#displayoldcomments")[1].css("display", "none");

        //  alert(userli);
        ////  $("#" + divblock).hide();
        //  document.getElementById(commentli).style.display = "none";
        //  document.getElementById(userli).style.display = "none";
        ////  document.getElementById(divblock).style.display = "none";
        //  document.getElementById(id).style.display = "none";




    }

    function delete_comment_fromdb(UserName, Comment) {


        $.ajax({


            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "SearchPage.aspx/DELETE_COMMENT",
            data: "{UserName:'" + UserName + "',Comment:'" + Comment + "'}",
            dataType: "json",
            // async: false,
            success: function (response) {

                alert("Record deleted successfully");

            },
            error: function () {

                alert("data could not be deleted");
            }
        });


    }


    function comment_button_click() {
        // alert("comment butn clicked");
        var UserName = document.getElementById("lblWelcome").textContent;
        var SearchTerm = $(".txtsearch").val();
        var LocationTerm = $(".txtlocation").val();
        var YelpID = document.getElementById("restaurantID").textContent;
        var Comment = $("#txtComment").val();
        //Comment = Comment.replace(/^\s+|\s+$/gm,'');
        // alert("comment butn clicked" + UserName + SearchTerm + LocationTerm + YelpID + Comment);

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

    function searchforbusiness(businessid, searchterm, locationterm, callback) {

        var UserName = document.getElementById("lblWelcome").textContent;

        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response, businessid);
                // $("#bdetails").show();
                $("#restaurantID").hide();
                showOldComments(UserName, businessid);
                showLike(UserName, businessid);
                $(".row").show();
            }

        });
    }

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
                    //alert("button should be Unlike");
                    $("#btnLike").attr("value", "Unlike");
                }
                else {
                    // alert("button should be Like");
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


                        // alert(UserName + " " + user);

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
                img2.width(200);

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

    function search_button_click() {

        $(".row").hide();
        $(".results").hide();
        var searchterm = $(".txtsearch").val();
        var locationterm = $(".txtlocation").val();
        if (searchterm === null || searchterm === "" || typeof searchterm === "undefined")
            return;
        if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
            return;

        searchforbusiness2(searchterm, locationterm, giveresults);
    }



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
            return;
        if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
            return;


        // var searchterm = "Pizza";
        // var locationterm = "Boston";
        searchforbusiness2(searchterm, locationterm, giveresults);

    });

    function searchforbusiness2(searchterm, locationterm, callback) {

        $.ajax({
            url: "http://api.yelp.com/business_review_search",
            dataType: "jsonp",
            data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
            success: function (response) {
                console.log(response);
                if (typeof callback === "function")
                    callback(response);
                //$("#bdetails").show();
                $(".results").show();
            }

        });
    }


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

            var titleLink = $("<a href='#' class='wam-details'>");
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