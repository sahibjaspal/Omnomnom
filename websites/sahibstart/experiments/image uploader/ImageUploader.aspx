<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnupload_Click(object sender, EventArgs e)
    {
        string filename = FileUpload1.FileName;
        int filesize = FileUpload1.PostedFile.ContentLength;
        

        string imagepath = "../../images/uploads/" + filename;

        if (FileUpload1.PostedFile.FileName != "" && FileUpload1.PostedFile != null)
        {

            if (filesize > 50000000)
            {
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('Please Upload a smaller file!')", true);

            }
            else
            {
                FileUpload1.SaveAs(Server.MapPath(filename));
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File Uploaded Successfully!')", true);
            }
        }
        else
        {
            Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('Please Upload a File!');", true); 
        }
        
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>File Uploader</title>
    <h1>Purpose: To show the working of an File Uploader.</h1>
   
    
    <hr />
     <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <h3>
            Project Use: Can be used in the project to facilitate uploading of images or any other documents.
        </h3>
    <div style="padding-left:50px">
        
        Upload File:
        <br />
        <asp:FileUpload ID="FileUpload1" class="btn-primary" style="width:250px;" runat="server" />
        
        <br />
        <br />
        <asp:Button style="width:200px" class="btn-success" ID="btnupload" runat="server" Text="Upload" OnClick="btnupload_Click" />
    <br />
        <br />

        
    </div>

        <rasala:FileView ID="fileView" runat="server" />
    </form>

    
</body>
</html>
 <script src="../../javascript/jquery-2.1.0.min.js" type="text/javascript"> </script>
     <script type="text/javascript" src="../../javascript/jquery-ui-1.10.4.custom.min.js"></script>
   