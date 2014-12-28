<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />

   

<link rel="stylesheet" href="css/CSS.css" />

</head>

<body>
    <h2>Purpose: To show the basic login page functionality I'll be using in my project.</h2>
    <br />
    Validations have been ensured using Javascript. In my final project I'll be saving a lot of user data in the database.
    <br />
    <h4>Project Use: This is a SINGLE PAGE APPLICATION and can be used in the project to Work on single pages.</h4>
 
    <div>

        <div id="login">
            <h2 class="form-sign-heading">Login</h2>
            <br />
            <input style="width:300px;" class="form-control" type="text" id="txtusername"  
                placeholder="Username"/>
            &nbsp
            <label style="color:red;" id="lblloginname"></label>
            <br />
            <input style="width:300px;" class="form-control" type="password" id="txtpassword"  
                 placeholder="Password" />
            &nbsp
            <label style="color:red;" id="lblloginpassword"></label>
            <br />
            <button id="btnsignin" style="color:white; width:300px; padding-bottom:5px; height:auto;" 
                class="btn btn-lg btn-primary">Sign in</button>
            <br />
            
            <br />
            <button id="btnnewuser" style="color:white; width:100px; height:auto;" class="btn" >New User?</button>
           
        </div>
        
        <div style="padding:50px;"id="signupform">

            <h2  class="form-sign-heading">Sign Up</h2>
            <br />
            <input style="width:300px;"  class="form-control" type="text" id="txtnewusername"  placeholder="New Username"/>
         
            <label style="color:red;" id="lblwrongusername"></label>
            
             <br />
            <input style="width:300px;"  class="form-control" type="text" id="txtname"   placeholder="Name" />
           
             
            <label style="color:red;" id="lblwrongname"></label>
            <br />
            <input style="width:300px;"  class="form-control" type="password" id="txtnewpassword"   placeholder="New Password"/>
            
            <label style="color:red;" id="lblnopassword"></label>
            <br />
            <input style="width:300px;"  class="form-control" type="password" id="txtnewpassword2"   placeholder="Retype Password" />
            
            <label style="color:red;" id="lblwrongpassword"></label>
            <br /><br />
            <button style="width:300px; height:auto;"  id="btncreateaccount" style="color:white; width:100%; padding-bottom:5px; height:auto;" 
                class="btn btn-lg btn-success">Create Account</button>
            <br />
            
           
            </div>

        
            <div style="padding-left:50px" id="profilepage">
                <h2 class="form-sign-heading">Profile Page</h2>
                <br />

                Welcome&nbsp;<label id="lblusername"></label>!!
                <br />
                <br />
               
                Your Status:
                <br />
                <br />
                 <textarea rows="8" cols="8" style="height:70px; width:300px;" id="txtstatus"></textarea>
                <br />
                <br />

                <label id="yourstatus">Status: &nbsp</label>  <label id="lblstatus"></label>
               
                <br /><br />
                
                <button style="width:300px; height:auto;"  id="btnupdatestatus"
                 style="color:white; width:100%; padding-bottom:5px; height:auto;" 
                class="btn btn-lg btn-primary" >Update Status</button>
                
                <br /><br />
            
                <button style="width:300px; height:auto;"  id="btnlogout"
                 style="color:white; width:100%; padding-bottom:5px; height:auto;" 
                class="btn btn-lg btn-danger">Logout</button>

            </div>

    
    </div>


    
     <br />
    <br />
    <br />
    
    

     <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/login page/loginpage.aspx">ASPX Source</a>
  

  

     <script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    <script type="text/javascript">

       $("document").ready(function () {
            $("#signupform").hide();
            $("#profilepage").hide();
           
        })

        $("document").ready(function () {
            $("#btnsignin").click(function () {
               
                var usrname = document.getElementById("txtusername").value;
                var pswd = document.getElementById("txtpassword").value;
                if (usrname.length < 1) {
                    document.getElementById("lblloginname").textContent = "Please Enter a Username!";
                    return false;
                }
                if(usrname.length >= 1){
                    $("#lblloginname").hide();
                }

                if (pswd.length < 1) {
                    document.getElementById("lblloginpassword").textContent = "Please Enter a Password!";
                    return false;
                }
                if (pswd.length >= 1) {
                    $("#lblloginpassword").hide();
                }

                if (usrname.length >= 1 && pswd.length >= 1) {
                    $("#profilepage").show();
                    $("#login").hide();
                    
                    document.getElementById("lblusername").textContent = usrname;
                    

                }

            })
        })


        $("document").ready(function () {
            $("#btnnewuser").click(function () {
              
                    $("#login").hide();
                    $("#signupform").show();
            })
        })

        $("document").ready(function () {
            $("#btncreateaccount").click(function () {
                
                var newusrname = document.getElementById("txtnewusername").value;
                var name = document.getElementById("txtname").value;
                var newpswd = document.getElementById("txtnewpassword").value;
                var newpswd2 = document.getElementById("txtnewpassword2").value;
               
                
                if (newusrname.length < 1) {
                    document.getElementById("lblwrongusername").textContent = "Please Enter the a Username!";
                    return false;
                } else {
                    $("lblwrongusername").hide();
                }

                if (name.length < 1) {
                    document.getElementById("lblwrongname").textContent = "Please Enter your Name!";
             
                    return false;
                } else {
                    $("#lblwrongname").hide();
                }

                if (newpswd.length < 1) {
                    document.getElementById("lblnopassword").textContent = "Please Enter a Password!";

                    return false;
                } else {
                    $("#lblnopassword").hide();
                }

                if (!(newpswd === newpswd2)) {
                    document.getElementById("lblwrongpassword").textContent = "Please Enter the same password!";

                    return false;
                } else {
                    $("#lblwrongpassword").hide();
                }

                if (newusrname.length >= 1 && name.length>=1 && newpswd.length>=1 && newpswd2.length>=1 && newpswd===newpswd2) {
                    $("#signupform").hide();
                    document.getElementById("lblusername").textContent = newusrname;
                    $("#profilepage").show();

                }

            })
        })

        $("document").ready(function () {
            $("#btnupdatestatus").click(function () {
               
                var status = document.getElementById("txtstatus").value;
               
                if (status.length >= 1) {
                 
                    $("#yourstatus").show();
                    document.getElementById("lblstatus").textContent = status;
                  
                   
                }

            })
        })

        $("document").ready(function () {
            $("#btnlogout").click(function () {
                document.getElementById("txtusername").value= "";
                document.getElementById("txtpassword").value = "";
                document.getElementById("txtstatus").value = "";
                document.getElementById("txtname").value = "";
                document.getElementById("txtnewpassword").value = "";
                document.getElementById("txtnewpassword2").value = "";
                document.getElementById("txtnewusername").value = "";
                document.getElementById("lblstatus").textContent = " ";
                document.getElementById("lblloginpassword").textContent = " ";
                document.getElementById("lblloginname").textContent = " ";
                $("#login").show();
                $("#profilepage").hide();

            })
        })




    </script>



</body>
</html>
