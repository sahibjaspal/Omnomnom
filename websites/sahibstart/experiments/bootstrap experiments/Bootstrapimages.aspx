<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Boostrap images

    </title>

        <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
   <link rel="stylesheet" href="css/CSS.css" />
</head>
<body>
    <form id="form1" runat="server">

        <h2>    Purpose: To show how images can be manipulated using Bootstrap</h2>
        <div class="outer">
    <div class="image1">
        <br />
        <br />
       <h3> Rendered Using Bootstrap CSS class img-responsive and img-round:</h3>

        <br />

        <img class="img-responsive img-round" src="http://www.oassf.com/en/media/images/dogs-wallpaper.jpg"  width="400px" height="300px"/>
        
       

    
    </div>
        <div class="image2">
            <br />
        <br />
        <h3>Rendered Using Bootstrap CSS class img-responsive and img-circle:</h3>
        <br />

            <img class="img-responsive img-circle" src="http://2.bp.blogspot.com/_LDF9z4ZzZHo/TQAJ32ILP7I/AAAAAAAAAJI/_izkqRoi0bQ/s1600/1600DOG_11019.jpg" width="400px" height="300px" />
        </div>

        <div class="image3">
            <br />
        <br />
        <h3>Rendered Using Bootstrap CSS class img-responsive and img-thumbnail: </h3>
        <br />
             <img class="img-responsive img-thumbnail" src="http://www.redorbit.com/media/uploads/2013/09/dog-robot-thinkstock-158894647-617x416.jpg" width="400px height=300px"/>
        </div>
            </div>

                <br />
    <br />
    <br />
    <br />
    
    

     <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/bootstrap experiments/Bootstrapimages.aspx">ASPX Source</a>
  

    </form>


    <script src="js/bootstrap.min.js"></script>


</body>
</html>
