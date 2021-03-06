﻿<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        txtsearch.Value = Request.QueryString["searchterm"];
        txtlocation.Value = Request.QueryString["locationterm"];
        lblbusinessid.Text = Request.QueryString["busid"];
       

    }
    protected void Details_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetailsPage.aspx?searchterm=" + txtsearch.Value +
            "&locationterm=" + txtlocation.Value + "&busid=" + lblbusinessid.Text);
    }
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
     
    <title>Project Details Page</title>
    <link rel="stylesheet" href="css/DetailsPage.css" />
</head>
<body>
    <form runat="server">
    <div class="navbar navbar-inverse navbar-fixed-top navbar-default" role="navigation" >
        <div class="container">
            <div class="navbar-header">
                
                <a class="navbar-brand" href="#"><img src="../../images/omnomnom3.png" /></a>
                 
             </div>
             <div class="topbtnpadding">

             </div>
                
             <button class="btnlogin btn btn-primary">Log In</button>
         </div>

          
     </div>
   <div class="toppadding"></div>

     <div style="width:1000px;background-color:#B63134" class="container">
        <div class="justpadding" style="padding:5px">
             <div style="width:10px"></div>
         <div class="input-group">
                  <input id="txtsearch" runat="server" style="width:370px;height:auto" type="text" class="txtsearch form-control" placeholder="Search for food"/>
                  <label style="width:100px;height:auto;color:white" class="">&nbsp&nbsp&nbsp&nbsp  Near By:</label>
             <input id="txtlocation" runat="server" style="width:370px;height:auto" type="text" class="txtlocation form-control" placeholder="Location: Ex: Boston"/>
                      <button style="width:auto;height:auto" class="btnsearch btn btn-default" type="button">
                        Search

                      </button>

              </div>
      
            
     </div>
         </div>

    <div style="padding-top:40px"></div>
    <div class="main-content details container">
      <h2> Purpose: The details view of the Food Outlet selected on the Home Page.</h2>
        <br />
        <h3>This is the details page that provides even more information of the details, that is the picture of the outlet, average rating,
            <br />contact details, reviews etc. The reviews are brief texts provided by the api. Complete reviews are not provided.
            <br />
            I will be implementing the Like, Comment fucntionality for each outlet, so that logged in users can view review comments 
            <br />
           of fellow users. Guest users will not be allowed to like an outlet or comment on it.
        </h3>
       
       <h3> Please Wait for the Details to be loaded..... </h3>
        <br />
        <br/>
        
       
    </div>

     <div id="bdetails" class="container businessdetails well">

           <asp:label runat="server" ID="lblbusinessid" ></asp:label>
            <div>
                <h2>Details</h2>
                <div class="row">
                    <div class="col-xs-4">
                        <img class="businessimage" src="#"/>

                    </div>
                    <div class="col-xs-8">
                        <h2 class="restaurantname"></h2>
                        <br />
                        Name: <label class="restaurantname"></label>&nbsp&nbsp&nbsp&nbsp<img class="reviewimage" src="#"/>
                        <br />
                        Address: <label class="restaurantaddress"></label>
                        <br />
                        Contact: <label class="restaurantphone"></label>
                        <br />
                        URL: <label class="restauranturl"></label>

                        <ul class="businessresults list-unstyled ">
                           
                        </ul>
                        <label>Brief Review Excerpts are: </label>
                        <ol class="reviewlist"></ol>

                    </div>

                </div>

            </div>

        </div>
    <div id="searchresults" class="container well" style="padding-top:20px; width:700px">
        <label style="color:red" id="msglbl">Click on any row to see more details!</label>
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <asp:Button ID="btnmoredetails" runat="server" CssClass="btn btn-success btnmoredetails" text="More Details" OnClick="Details_Click"/>
        <br />
        <br />
        <table id="tableresults" class="table table-bordered">
            <tr>
                <th>Business ID</th>
                <th>Restaurant Name</th>
                <th>Address</th>
                <th>Customer Review</th>
                <th>Average Rating</th>
                
            </tr>  
           
            <tbody class="results">

            </tbody>

        </table>
        </div>

        </form>
         <br />
    <br />
    <rasala:FileView ID="fileView" runat="server" />


      <script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    <script type="text/javascript">
        


        $(document).ready(function () {
            
            $("#bdetails").hide();
            $("#searchresults").hide();
           
            var businessid = "7ysLZWWRw4swz6x9d6KXwg";
            document.getElementById("lblbusinessid").textContent = businessid;

               var searchterm = $(".txtsearch").val();
                var locationterm = $(".txtlocation").val();
                if (searchterm === null || searchterm === "" || typeof searchterm === "undefined")
                    return;
                if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
                    return;
           

           // var searchterm = "Pizza";
           // var locationterm = "Boston";
                searchforbusiness(businessid, searchterm, locationterm, givebusinessresults);

        });

        function searchforbusiness(businessid, searchterm, locationterm, callback) {

            $.ajax({
                url: "http://api.yelp.com/business_review_search",
                dataType: "jsonp",
                data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
                success: function (response) {
                    console.log(response);
                    if (typeof callback === "function")
                        callback(response, businessid);
                    $("#bdetails").show();
                }

            });
        }


        function givebusinessresults(response, businessid) {
            var allbusinesses = response.businesses;
            var ul = $(".businessresults");
            var ol = $(".reviewlist");
            ul.empty();
            ol.empty();
            
            for (var i in allbusinesses) {
                var onebusiness = allbusinesses[i];
                if (onebusiness.id === businessid) {
                   
                    var allreviews = onebusiness.reviews;  
                    var businessid = onebusiness.id;
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

                    $(".restaurantname").html(name);
                    $(".restaurantaddress").html(fulladdress);
                    $(".restaurantphone").html(phone);
                    $(".restauranturl").html(resturl);

                    for (var k in allreviews) {
                        var onereview = onebusiness.reviews[k];
                        var reviewtext = onereview.text_excerpt;
                        

                        li = $("<li>");
                        li.append(reviewtext);
                        
                        ol.append(li);
                    }

                }
                
            }
        }

        $(function () {

            $(".btnsearch").click(searchfood);


        });

        function searchfood() {
            $("#searchresults").hide();
            $("#bdetails").hide();
            var searchterm = $(".txtsearch").val();
            var locationterm = $(".txtlocation").val();
            if (searchterm === null || searchterm === "" || typeof searchterm === "undefined")
                return;
            if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
                return;

            searchfromapi(searchterm, locationterm, giveresults);

        }

        function searchfromapi(searchterm, locationterm, callback) {

            $.ajax({
                url: "http://api.yelp.com/business_review_search",
                dataType: "jsonp",
                data: { ywsid: "gXH3Gv9MMlGimYh60baD4Q", term: searchterm, location: locationterm, category: "food" },
                success: function (response) {
                    console.log(response);
                    if (typeof callback === "function")
                        callback(response);
                    $("#searchresults").show();
                }

            });
        }

        function giveresults(response) {
            var allbusinesses = response.businesses;
            var table = $(".results");
            table.empty();
            var j = 1;
            for (var i in allbusinesses) {
                var onebusiness = allbusinesses[i];
                var allreviews = onebusiness.reviews;


                var onereview = onebusiness.reviews[0];
                var ratingimg = onebusiness.rating_img_url;
                var businessid = onebusiness.id;
                var reviewtext = onereview.text_excerpt;

                var name = onebusiness.name;
                var address1 = onebusiness.address1;
                var address2 = onebusiness.address2;
                var state_code = onebusiness.state_code;
                var fulladdress = address1 + ", " + address2 + ", " + state_code;




                var tr = $("<tr>");

                var td = $("<td id=td" + j + ">");




                var img2 = $("<img>");
                img2.attr("src", ratingimg);
                img2.height(25);
                img2.width(95);

                td.append(businessid);
                tr.append(td);

                td = $("<td>");
                td.append(name);
                tr.append(td);

                td = $("<td>");
                td.append(fulladdress);
                tr.append(td);

                td = $("<td>");
                td.append(reviewtext);
                tr.append(td);



                td = $("<td>");
                td.append(img2);
                tr.append(td);



                /*      var button = $("<button" + " onserverclick=Details_Click" + " class='btn btn-success'" + " id =btn" + j + ">");
                      button.attr("style", "width:100px; height:30px;");
                      button.attr("Text", "More Details");
                      
                      td = $("<td>");
                      td.append(button); 
                      tr.append(td);  */
                j++;

                table.append(tr);
            }
        }




</script>

</body>
</html>
