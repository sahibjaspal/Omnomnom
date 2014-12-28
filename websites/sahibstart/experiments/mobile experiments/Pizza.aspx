<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport"content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no" />
            <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />

    <title>Mobile Page experiments</title>
     
</head>
<body>
    <br />
    <br />
    <h1>Purpose: To show the working of a Single Page Mobile Website!</h1>
    <br />
    In this experiment, all the DOM elements occupy the entire screen size, for the webpage to be scalable on mobile/tablet.
    <br />
    <h4>Project use: this will be used to make webpages responsive for mobiles and tablets using media queries.</h4>
    <br />
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" >
        <div class="container">
            <div class="navbar-header">
       <span style="color:white;padding-top:50px">Neu House of Pizza</span>  
             
    </div>
    </div>
        </div>

    

    <div id="loginform" class="form">
        <h2>Login</h2>
        Username:
        <br />
        <input style="width:100%" id="txtusername" type="text" text="UserName"/>&nbsp <label style="color:red" id="lblusername"> Please Enter UserName</label>
        <br />
        <br />
        Password:
        <br />
        <input style="width:100%" id="txtpassword" type="password" text="Password"/>&nbsp <label style="color:red" id="lblpassword">Please enter Password</label>
        <br />
        <br />
        <button style="width:100%" type="button" id="btnlogin">Login</button>
        
    </div>

    <div id="pizzaform">
        <br />
        <label id="displayusername">Welcome! Create your pizza!</label>
       <br />
        Choose Size:
       <ul class="list-unstyled">
           <li><input style="width:auto" id="rdlargepizza" type="radio" name="size" value="Large" checked/>Large</li>
           <li><input style="width:auto" id="rdmediumpizza" type="radio" name="size" value="Medium"/>Medium</li>
           <li><input style="width:auto" id="rdsmallpizza" type="radio" name="size" value="Small"/>Small</li>
       </ul>
        <br />
        Type of bread:
        <ul class="list-unstyled">
           <li><input style="width:auto" id="rdthincrust" type="radio" name="bread" value="Thin Crust" checked/>Thin Crust</li>
           <li><input style="width:auto" id="rdhandtossed" type="radio" value="Hand Tossed" name="bread"/>Hand Tossed</li>
          
       </ul>
        <br />
        Toppings:
        <br /> <input style="width:auto" id="chkbxchicken" type="checkbox" value="Chicken" checked/>Chicken
        <br />  <input style="width:auto" id="chkbxjalapenos" type="checkbox" value="Jalapenos" />Jalapenos
         <br />  <input style="width:auto" id="chkbxonions" type="checkbox" value="Onions" />Onions
         <br />  <input style="width:auto" id="chkbxpepper" type="checkbox" value="Green Pepper" />Green Pepper

        <br />
        <br />
        <button style="width:100%" type="button" id="btnsubmitorder">SubmitOrder</button>
         

    </div>


    <div id="orderdetails">
        <br />
        <h2>Order Details:</h2>
        <br />
        You have submitted the following order:
        <br />
        <br />
        Pizza Size: <label id="lblsize"></label> 
        <br />
        Bread: <label id="lblbread"></label>
        <br />
        Toppings: <label id="lbltoppings1"></label>&nbsp <label id="lbltoppings2"></label>&nbsp <label id="lbltoppings3"></label>&nbsp  <label id="lbltoppings4"></label>
        <br />
        <br />
        Thank you for Using Neu House of Pizza!
        <br />
        <br />
         <button style="width:100%" type="button" id="btnlogout">Logout</button>
    </div>

    
     <br />
    <br />
    <br />
    
    

     <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/mobile experiments/Pizza.aspx">ASPX Source</a>
  


     
    <script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    <script type="text/javascript">
        $("document").ready(function () {
            $("#pizzaform").hide();
            $("#orderdetails").hide();
            $("#lblusername").hide();
            $("#lblpassword").hide();
        })
        
        $("document").ready(function () {
            $("#btnlogin").click(function () {
                var usrname = document.getElementById("txtusername").value;
                var pswd = document.getElementById("txtpassword").value;
                if (usrname.length < 1) { 
                    $("#lblusername").show();
                    return false;
                
                }
                if (usrname.length >= 1) {
                    $("#lblusername").hide();

                }
                if (pswd.length < 1){
                    $("#lblpassword").show();
                    return false;
                }
                if (pswd.length >= 1) {
                    $("#lblpassword").hide();
                    
                }

                $("#loginform").hide();
                $("#pizzaform").show();

            })
        })

        $("document").ready(function () {
            $("#btnsubmitorder").click(function () {
                $("#pizzaform").hide();
                
                if (document.getElementById("rdlargepizza").checked) {
                    var x = document.getElementById("rdlargepizza").value;
                    document.getElementById("lblsize").textContent = x;
                }
                if (document.getElementById("rdmediumpizza").checked) {
                    var x = document.getElementById("rdsmallpizza").value;
                    document.getElementById("lblsize").textContent = x;
                }
                if (document.getElementById("rdsmallpizza").checked) {
                    var x = document.getElementById("rdsmallpizza").value;
                    document.getElementById("lblsize").textContent = x;
                }

                if (document.getElementById("rdthincrust").checked) {
                    var x = document.getElementById("rdthincrust").value;
                    document.getElementById("lblbread").textContent = x;
                }
                if (document.getElementById("rdhandtossed").checked) {
                    var x = document.getElementById("rdhandtossed").value;
                    document.getElementById("lblbread").textContent = x;
                }
                if (document.getElementById("chkbxchicken").checked) {
                    var x = document.getElementById("chkbxchicken").value;
                    document.getElementById("lbltoppings1").textContent = x;
                }
                if (document.getElementById("chkbxjalapenos").checked) {
                    var x = document.getElementById("chkbxjalapenos").value;
                    document.getElementById("lbltoppings2").textContent = x;
                }
                if (document.getElementById("chkbxonions").checked) {
                    var x = document.getElementById("chkbxonions").value;
                    document.getElementById("lbltoppings3").textContent = x;
                }
                if (document.getElementById("chkbxpepper").checked) {
                    var x = document.getElementById("chkbxpepper").value;
                    document.getElementById("lbltoppings4").textContent = x;
                }
               
                $("#orderdetails").show();
                
            })
        })

        $("document").ready(function () {
            $("#btnlogout").click(function () {
                $("#orderdetails").hide();
                $("#loginform").show();

            })
        })

        


    </script>



  
</body>
</html>
