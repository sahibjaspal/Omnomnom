<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <h1> Purpose: To show the working of JSON and AJAX. </h1>
    <hr />
   
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding-left:50px;" class="input-group">
        <h2>To represent movie data as a list:</h2>
         <br />
        <h3>Project Use: This will be used in the project to parse the JSON object and render results in the API.</h3>
        <br />
        <br />
        <h3>Search for a movie: </h3>
        <input type="text" style="padding-left:10px; width:200px; height:auto" class="form-control txtmoviename" placeholder="Movie Name" value="Die Hard"/>
        <br />
        <br />
        <button style="padding-left:10px; width:100px;height:auto;" class="btn btn-primary btnsearch" type="button">Search</button>
        <br />
        <br />
        <ul class="results"></ul>
        <br />
        <br />
        <br />
        
    </div>
        <rasala:FileView ID="fileView" runat="server" />
    </form>
    
   

</body>

</html>
<script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
     <script type="text/javascript" src="../../javascript/jquery-ui-1.10.4.custom.min.js"></script>
    <script>
        $(function () {

            $(".btnsearch").click(searchmovie);

        });

        function searchmovie() {
            var moviename = $(".txtmoviename").val();
            if (moviename === null || moviename === "" || typeof moviename === "undefined")
                return;

            searchfromapi(moviename, giveresults);

        }

        function searchfromapi(moviename, callback) {

            $.ajax({
                url: "http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                dataType: "jsonp",
                data: { apikey: "sjq7esep6kexbmpq7but6dg9", q: moviename },
                success: function (response) {
                    console.log(response);
                    if (typeof callback === "function")
                        callback(response);
                }

            });
        }

        function giveresults(response) {
            var allmovies = response.movies;
            var ul = $(".results");
            ul.empty();
            for (var i in allmovies) {
                var onemovie = allmovies[i];
                var name = onemovie.title;
                var li = $("<li>");
                li.append(name);
                ul.append(li);
            }
        }



    </script>