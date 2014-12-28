<%@ Page Language="C#" MasterPageFile="~/experiments/master page experiments/ProjectMaster.master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="well container">
    <h2> Project Master Page Working</h2>

     <p>
         <h3>Purpose: To show the working of a Master Page and Content page</h3>

     </p>

     <h3>Master Page file Working</h3>
     <p>
         The Master Page can be created by selecting 'Master Page' item in the new item category.
         <br />
         The Master Page is like a basic template for all the pages, which provides the whole project
         <br />
         a consistent look and feel. By implementing a master page we save a lot of time and effort
         <br />
         in rebuilding the basic lookout of each page every time.
         <br />
         The basic template usually includes the header, footer and css references.

     </p>
    <h3>
        Use in Project

    </h3>
     <p>
         This is the Master Page that will be used in my Project.
         <br />
         It will provide a consistent look to the whole website.
         <br />
         Only the content page area will change each time. But, the headers and footers will
         <br />
         remain the same. The final output of any page is a combination of the master page
         <br />
         and content page.


     </p>
     <p>
        <b> Source Files: </b>
         <rasala:FileView ID="fileView" runat="server" />

     </p>
</div>

    
   
</asp:Content>
