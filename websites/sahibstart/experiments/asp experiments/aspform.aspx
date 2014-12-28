<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("aspform2.aspx?name=" + TextBox1.Text +
            "&nuid=" + TextBox2.Text + "&email=" + TextBox3.Text + "&cell=" + TextBox4.Text);

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ASP Forms</title>
   <h1> Purpose: Working of a form in ASP.NET </h1>
     
</head>
<body>
    <form id="form1" runat="server">
    <div class="maindiv">

        <h1>Personal Information:</h1>

        <table>
            <tr>
                <td>
                     FirstName: 

                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
            </tr>
       

             <tr>
                <td>
                    LastName: 

                </td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </td>
            </tr>



             <tr>
                <td>
                    Address:

                </td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                </td>
            </tr>


             <tr>
                <td>
                     Introduction:

                </td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                </td>
            </tr>

             <tr>
                <td>
                  

                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
                </td>
            </tr>



        </table>
        
    </div>
    </form>

     <br />
    <br />

      <hr />
    <b>Sources:</b>
    <a href="http://net4.ccs.neu.edu/home/sahibj/fileview/Default.aspx?~/experiments/asp experiments/aspform.aspx">ASPX Source</a>
  
</body>
</html>
