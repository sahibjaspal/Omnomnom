<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Google Maps Experiment</title>
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="container well">
        <h2>Purpose: To show the embedding of Google Maps</h2>
       <br />

        <h3>Use in my Project</h3>
        <p>
            This will be used in the project to show the location of a restaurant that a user selects
            <br />
            It will be a part of the details view.
        </p>
        <p>
            The map below will shows the location of Times Square, New York City.

        </p>

        <iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Times+Square,+New+York,+NY&amp;aq=0&amp;oq=Times&amp;sll=40.779402,-73.963386&amp;sspn=0.003485,0.006888&amp;ie=UTF8&amp;hq=&amp;hnear=&amp;ll=40.758895,-73.985131&amp;spn=0.006295,0.006295&amp;t=m&amp;iwloc=A&amp;output=embed"></iframe><br /><small><a href="https://www.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Times+Square,+New+York,+NY&amp;aq=0&amp;oq=Times&amp;sll=40.779402,-73.963386&amp;sspn=0.003485,0.006888&amp;ie=UTF8&amp;hq=&amp;hnear=&amp;ll=40.758895,-73.985131&amp;spn=0.006295,0.006295&amp;t=m&amp;iwloc=A" style="color:#0000FF;text-align:left">View Larger Map</a></small>
    </div>
        <rasala:FileView ID="fileView" runat="server" />
    </form>
</body>
</html>
