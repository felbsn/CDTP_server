<%@ Page Language="C#" %>

<%


    if(Session["User"] != null)
    {
       Response.Redirect("dashboard.aspx");
    }else
    {
      Response.Redirect("login.aspx");
    }
     


%>
