<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>AJAX Request using ASP.NET</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script language="C#" runat="server">
        /// <summary>
        /// Sample Class that will contains the posts data set
        /// This will be replaced in production, with some real world data which is fetched from database or some other service
        /// </summary>
        public class FaceBookPosts
        {
            public string Post { get; set; }
            public string UserName { get; set; }
            public int Likes { get; set; }
            public static List<FaceBookPosts> Posts()
            {
                List<FaceBookPosts> pts = new List<FaceBookPosts>();
                for (var i = 0; i < 100; i++)
                {
                    pts.Add(new FaceBookPosts { Post = i * 7 + " This is a Random Post " + i, Likes = i * DateTime.Now.Millisecond, UserName = "User " + i });
                }
                return pts;
            }
        }
        public void Page_Load(Object sender, EventArgs e)
        {
           
            //set the page size of the Grid
            GridView1.PageSize = 10;
            //enable paging
            GridView1.AllowPaging = true;
            //bind the page index changing event, this is IMPORTANT so as the enable paging
            //failing to do this, will throw an error
            GridView1.PageIndexChanging += new GridViewPageEventHandler(GridView1_PageIndexChanging);
            //at the end bind the data
            BindData();
        }
        /// <summary>
        /// Method which bind the data to the Grid
        /// This will be executed both in case of page load and when the user is changing the page
        /// </summary>
        private void BindData()
        {
            GridView1.DataSource = FaceBookPosts.Posts();
            GridView1.DataBind();
        }
        /// <summary>
        /// Method that will be executed when the user changes the page index
        /// This method will change the pageindex property of the grid to the one user has selected
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindData();
        }
    </script>
    <link rel="stylesheet" href="../asp experiments/css/paginationCSS.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id='mainBody'>
        <h1>
            Purpose: To show the working of Pagination using ASP.NET
        </h1>
        <br />
        <h3>Description: This experiment shows how large amounts of data can be paginated. This was discussed by Prof. Jose in class.</h3>
        <br />
        <h3>Project Use: Can be used in the project to paginate the results.</h3>
        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
            BorderStyle="None" BorderWidth="1px" CellPadding="4" EnableModelValidation="True"
            ForeColor="Black" GridLines="Vertical" Height="319px" Width="714px">
            <AlternatingRowStyle BackColor="White" />
            <FooterStyle BackColor="blue" />
            <HeaderStyle BackColor="#b61111" Font-Bold="True" ForeColor="Black" />
            <PagerStyle BackColor="white" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </div>

        <br />
        <br />
        <rasala:FileView ID="fileView" runat="server" />
    </form>
</body>
</html>
