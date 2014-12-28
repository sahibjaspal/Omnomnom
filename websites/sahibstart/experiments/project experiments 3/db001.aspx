<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Insert_record(object sender, DetailsViewInsertedEventArgs e)
    {
        Response.Redirect("db001.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Database insert andd update</title>
    <link rel="stylesheet" href="../../css/bootstrap/css/bootstrap.css" />

</head>
<body>
    <form id="form1" runat="server">
    <div class="container well">
        <h2>Purpose: The purpose of this experiment is to show the Update & Insert functionality in the database.</h2>
    <br />
        <h3>Project Use:This will be extensively used in the project to manage userdata, likes, comments and follow...</h3>

        <div class="main-container">
            <div class="main-content">
               <h2> Update Record in Database.</h2>
               <asp:GridView
                    ID="GridView2"
                    DataSourceID="GridView2SqlSource"
                    runat="server"
                    AllowSorting="True" AutoGenerateEditButton="True">
                </asp:GridView>

                <asp:SqlDataSource
                    ID="GridView2SqlSource"
                    runat="server"
                    ConnectionString="<%$ ConnectionStrings:sahibjCS %>"
                    SelectCommand="SELECT * FROM sahibj.StudentTable"
                    UpdateCommand="UPDATE  sahibj.StudentTable SET ID=@ID, StudentName=@StudentName, Course=@Course where ID=@ID">
                    <UpdateParameters>
                        <asp:Parameter Name="ID" Type="Int32" />
                        <asp:Parameter Name="StudentName" Type="String" />
                        <asp:Parameter Name="Course" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
            <div class="insert">
                <h2>Insert New Record</h2>
                <asp:DetailsView ID="StudentTable" runat="server" DataSourceID="Student_Table" AutoGenerateInsertButton="True" OnItemInserted="Insert_record">
                </asp:DetailsView>
                <br />

                <asp:SqlDataSource
                    ID="Student_Table"
                    runat="server"
                    ConnectionString="<%$ ConnectionStrings:sahibjCS %>"
                    SelectCommand="SELECT * FROM sahibj.StudentTable"
                    InsertCommand="INSERT INTO sahibj.StudentTable ([ID], [StudentName], [Course]) VALUES (@ID, @StudentName, @Course)">

                    <InsertParameters>
                        <asp:Parameter Name="ID" Type="Int32" />
                        <asp:Parameter Name="StudentName" Type="String" />
                        <asp:Parameter Name="Course" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <br />
                <br />
                <br />
               
            </div>

          
            
        </div>


    </div>
         <rasala:FileView ID="fileView" runat="server" />
    </form>
</body>
</html>
