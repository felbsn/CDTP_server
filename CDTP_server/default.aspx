<%@ Page Language="C#" %>

<%


    if(Session["User"] != null)
    {
       Response.Redirect("pages/dashboard.aspx");
    }else
    {
      Response.Redirect("pages/login.aspx");
    }
     


%>
