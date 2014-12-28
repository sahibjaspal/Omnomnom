<%@ Page Language="C#" %>

<script runat="server">
    <%-- This demo page has no server side script --%>
</script>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset='utf-8' />

<title>Sahib's Web Page</title>

<style type="text/css">
    ul.master_navigation
    {
        font-size: 100%;
        font-weight: bold;
        text-align: center;
        list-style: none;
        margin: 0.5em 0;
        padding: 0;
        background-color:#b61111;
    }

    ul.master_navigation li
    {
        display: inline-block;
        padding: 0 0.5%;
    }

    a
    {
        color: #08f;
        font-weight: bold;
        text-decoration: none;
    }

    a:visited
    {
        color: #88f;
    }

    a:hover
    {
        color: #f00;
    }

    p
    {
        text-align: justify;
    }

    .imgclass {
        max-width:100%

    }

    .wrapper {
        width: 100%;
    }

    .container {
        width: 100%;
    }

    .leftdiv {
        width: 50%;
        margin-right: 0px;
       }
    

    
    .rightdiv {
        width: 50%;
        color: white;
        
    }
    


    .aboutme {
    color:white;
    font-size:20px;
    }

</style>

<style type="text/css" media="screen">
    body {
        width:100%;
        max-width: 100%;
        margin: 0;
        padding: 0;
        background-color:black;
       
    }

    .pad {
        padding: 10px;
       
    }
</style>

</head>

<body>

<div class="pad">

<form id="form1" runat="server">


<div class="wrapper">

    

<ul class="master_navigation">
    <li><a href="sitestatistics/" target="_blank">SiteStatistics</a></li>
    <li><a href="statistics/" target="_blank">Statistics</a></li>
    <li><a href="source/" target="_blank">Source</a></li>
    <li><a href="search/" target="_blank">Search</a></li>
    <li><a href="searchtree/" target="_blank">SearchTree</a></li>
    <li><a href="textview/" target="_blank">TextView</a></li>
    <li><a href="filelist.aspx" target="_blank">FileList</a></li>
    <li><a href="autofile.aspx" target="_blank">AutoFile</a></li>
    <li><a href="images/autoimage.aspx" target="_blank">Images</a></li>
    <li><a href="blog/" target="_blank">Blog</a></li>
    <li><a href="experiments.html" target="_blank">Experiments</a></li>
</ul>

<hr />

    </div>

    <br />
    <br />
    <br />
    <br />
        
<center>
 <div class="container">
   <div class="leftdiv">
    <img class="imgclass" src="images/sahibdp2.gif" style="float:left" height="300px" width="300px" />

   </div>

  <div class="rightdiv">
    <p>I am Sahib Jaspal, currently a Master's Student at Northeastern.
    This is my personal website. I am looking forward to learn a lot of
    exciting technologies in this Web Development Course.
    <br />
    <br />
    I shall be working on experiments every week.
    You can view them under the experiments tab.
    </p>
      <p>
         <h2> <a  href="experiments/project experiments 4/HomePage.aspx">Project</a></h2>

      </p>
    </div>
     
</div>

    </center>

</form>

</div>

</body>
</html>
