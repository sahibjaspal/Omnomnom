<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
     
    <title>Image Slide Show</title>
    <link rel="stylesheet" href="css/imagecss.css" />
</head>

<body>
  
  
    
    
     <div class="main-content">
        
          <div id="container" style="position:relative;">
              <div>
                  <h3 style="color:black">Purpose: To show the working of Image Slideshow. Can be used in the project to show different images of Food Items.</h3>
             
                  <h4>Project use: This a very interesting representation of images on a webpage. They catch the users attention.</h4>
                  <h4>Food provided at different outlets can be shown using this. And users can be redirected to learn more about the outlet/food item.</h4>
              </div>
              <div>
                 <asp:Image ID="SlideShow" runat="server" />
              </div>

          </div>
            
     </div>
   
     <script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
    <script type="text/javascript">
        $(function () {
            var imgarr = [
                'http://4.bp.blogspot.com/_c2EQxmj7A80/S_oRF-IkNvI/AAAAAAAAIGU/wB62121OcfI/s1600/09_08_12_butter_chicken.jpg',
                'http://imagebank.biz/wp-content/uploads/2013/05/Foods-Pizza-Food-Hd-Wallpaper.jpg',
           'http://imagebank.biz/wp-content/uploads/2013/05/Foods-Wallpapers-HD.jpg'];


            var ctr = imgarr.length;
            var $SlideShow = $('img[id$=SlideShow]');

            $SlideShow.attr('src', imgarr[ctr - 1]);
            setInterval(Slider, 5000);
            function Slider() {
                $SlideShow.fadeOut("slow", function () {
                    $(this).attr('src', imgarr[(imgarr.length++) % ctr]).fadeIn("slow");
                });

            }
        });





    </script>  
     <br />
    <br />
    <rasala:FileView ID="fileView" runat="server" />
</body>
</html>
