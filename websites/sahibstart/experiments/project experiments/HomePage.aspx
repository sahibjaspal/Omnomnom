<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
     
    <title>HomePage</title>
    <link rel="stylesheet" href="css/HomePage.css" />
</head>

<body>
  
  
    
   
    <div>
        <h4 style="color:white">
            Purpose: To show the basic working of the HomePage's search functionality and details view.
            The working of this page is <span style="color:red">slow </span> due to multiple API calls. 
            It can take time for results to load.
        </h4>

        <br />
        <h3>Project Use: I will be displaying results from the Yelp API for outlets that provide a particular view.</h3><br />
       

    </div>
     
    <div style="width:1000px;" class="main-content container well">
        
             <div style="width:10px"></div>
         <div class="input-group">
                  <input style="width:370px;height:auto" type="text" class="txtsearch form-control" placeholder="Search for food"/>
                  <label style="width:100px;height:auto" class="">&nbsp&nbsp&nbsp&nbsp  Near By:</label>
             <input id="location" style="width:370px;height:auto" type="text" class="txtlocation form-control" placeholder="Location: Ex: Boston"/>
                      <button style="width:auto;height:auto" class="btnsearch btn btn-default" type="button">
                       <span class="glyphicon glyphicon-search"></span> Search

                      </button>

              </div>
      
            
     </div>

    <div id="searchresults" class="container well" style="padding-top:20px; width:700px">
        <label style="color:red" id="msglbl">Click on any row to see more details!</label>
        <table id="tableresults" class="table table-bordered">
            <thead>
                <th>Business ID</th>
                <th>Restaurant Name</th>
                <th>Address</th>
                <th>Customer Review</th>
                <th>Average Rating</th>
              
            </thead>
            <tbody class="results">

            </tbody>

        </table>
        </div>
       
    
     <div id="bdetails" class="container businessdetails well">

            <label id="lblbusinessid" class="detailsplacename"></label>
            <div>
                <h2>Details</h2>
                <div class="row">
            <!--        <div class="col-xs-4">
                        <img class="businessimage" src="#"/>

                    </div> -->
                    <div class="col-xs-8">
                        <ul class="businessresults">
                            
                        </ul>

                    </div>

                </div>

            </div>

        </div>

    
   
    
    <br />
    <br />
     <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <rasala:FileView ID="fileView" runat="server" />
</body>
</html>
 <script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    <script type="text/javascript">



        $(document).ready(function () {

            $("#tableresults").click(function (event) {
                // $("#searchresults").hide();
                var businessid = ($(this).find('td:first').text());
                document.getElementById("lblbusinessid").textContent = businessid;

                var searchterm = $(".txtsearch").val();
                var locationterm = $(".txtlocation").val();
                if (searchterm === null || searchterm === "" || typeof searchterm === "undefined")
                    return;
                if (locationterm === null || locationterm === "" || typeof locationterm === "undefined")
                    return;

                searchforbusiness(businessid, searchterm, locationterm, givebusinessresults);




            });

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
                    //  $("#bdetails").show();
                }

            });
        }


        function givebusinessresults(response, businessid) {
            var allbusinesses = response.businesses;
            var ul = $(".businessresults");
            ul.empty();

            for (var i in allbusinesses) {
                var onebusiness = allbusinesses[i];
                if (onebusiness.id === businessid) {

                    var allreviews = onebusiness.reviews;


                    var onereview = onebusiness.reviews[0];
                    var businessid = onebusiness.id;
                    var reviewtext = onereview.text_excerpt;

                    var name = onebusiness.name;
                    var address1 = onebusiness.address1;
                    var address2 = onebusiness.address2;
                    var state_code = onebusiness.state_code;
                    var fulladdress = address1 + ", " + address2 + ", " + state_code;

                    var busimg = onebusiness.photo_url;

                    var li = $("<li>");

                    li.append(name);
                    ul.append(li);

                    li = $("<li>");
                    li.append(fulladdress);
                    ul.append(li);

                    li = $("<li>");
                    li.append(reviewtext);
                    ul.append(li);

                    li = $("<li>");
                    li.append(fulladdress);
                    ul.append(li);


                    var img2 = $("<img>");
                    img2.attr("src", busimg);
                    img2.height(25);
                    img2.width(95);

                    li = $("<li>");
                    li.append(fulladdress);
                    ul.append(li);

                    //  $("businessimage").attr("src", img2);

                }

            }
        }


        //code for main search bar
        $(document).ready(function () {
            $("#searchresults").hide();
            $("#bdetails").hide();
        })

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
                var businessid = onebusiness.id;
                var reviewtext = onereview.text_excerpt;

                var name = onebusiness.name;
                var address1 = onebusiness.address1;
                var address2 = onebusiness.address2;
                var state_code = onebusiness.state_code;
                var fulladdress = address1 + ", " + address2 + ", " + state_code;

                var ratingimg = onebusiness.rating_img_url;


                var tr = $("<tr>");

                var td = $("<td id= " + j + ">");




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
                /*         
                         var button = $("<button class =" + "btn btn-primary" + "id =btn" + j + ">");
                         button.attr("style", "width:100px; height:30px;");
                         
                         td = $("<td>");
                         td.append(button); 
                         tr.append(td);  */
                j++;

                table.append(tr);
            }
        }






    </script>  