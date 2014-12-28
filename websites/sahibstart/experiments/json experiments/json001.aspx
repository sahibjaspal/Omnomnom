<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Render JSON Dynamically</title>
    <h1>Purpose: To depict how to dynamically render JSON object</h1>
    <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <br />
        The following information of student has been updated dynamically using JSON Object:
        <br />
        <br />
        <p>

            <h4>Project Use: This will be extensively in the project to render DOM elements.</h4>
        </p>

        <ul>
            <li id="nuid">&nbsp;</li>
            <li id="email">&nbsp;</li>
            <li id="department">&nbsp;</li>
        </ul>

       
     <br />
    <br />
    <br />
    
    

     <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/json experiments/json001.aspx">ASPX Source</a>
  

    </div>
    </form>
</body>
</html>
<script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    <script type="text/javascript">
        var student = {
            "NUID": "994292",
            "Email": "abc@husky.neu.edu",
            "department": "CCIS"
        };

        $(function () {
            $("#nuid").html(student.NUID);
            $("#email").html(student.Email);
            $("#department").html(student.department);
        })

    </script>