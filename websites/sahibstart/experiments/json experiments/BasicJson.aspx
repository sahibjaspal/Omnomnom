<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>JSON data fetch</title>
    <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
    <script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    <h1>Purpose: To show the working of API's and fetching data using jQuery and AJAX</h1>
  <link rel="stylesheet" href="css/CSS.css" />

</head>
<body >
    <br />
    <br />
    I will be using a movie API from www.rottentomatoes.com. It can be accessed using this link: http://api.openweathermap.org/data/2.5/weather?q=London,uk
    <br />
     <h4>Project Use: This will be extensively in the project to fetch JSON objects from the API</h4>
    <br />
    <form id="form1" runat="server">
    <div>
        <button class="btngo">Fetch Data</button>

    </div>
    </form>
    <br />
    <br />
    <textarea class="abc">&nbsp;</textarea>

     <br />
    <br />
    <br />
    
    

     <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/json experiments/json001.aspx">ASPX Source</a>
  

    
    
</body>
    <script type="text/javascript">


        $(".btngo").click(getData);

        function getData(event) {
            event.preventDefault();
            $.ajax({
                "url": "http://api.openweathermap.org/data/2.5/weather?q=London,uk",
                "dataType":"text",
                "success": function (response) {
                    $(".abc").val(response);
                    var jsondata = JSON.parse(response);
                    console.log(response);
                    console.log(jsondata);
                }
            })
        }

    </script>

</html>
