<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Session Handling</title>
</head>
<link type="text/css" rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />

<style type="text/css">
    #dvLoading {
        background: #000 url(images/loader.gif) no-repeat center center;
        height: 100px;
        width: 100px;
        position: fixed;
        z-index: 1000;
        left: 50%;
        top: 50%;
        margin: -25px 0 0 -25px;
    }
</style>
<body>
    <form id="form1" runat="server">
        <div id="dvLoading"></div>

    </form>
</body>
</html>
<script src="../../javascript/jquery-2.1.0.min.js"></script>
<script>
    
    $(window).load(function () {
        
        $('#dvLoading').fadeOut(10000);
        
    });
    
</script>
