<%@ Page Language="C#"%>

<%
    //   INSERT INTO public.customer(
    //name, surname, username, password)
    //VALUES ('fatih', 'E.', 'fatih0', '123456');

    if (Request.Form["username"] != null)
    {

        string username = Request.Form["username"];
        string password = Request.Form["password"];


        var data =  Sql.Query($"select username , id  , name , surname,deviceid   from customer where username = '{username}' and password='{password}'");

        if (data.Rows.Count == 0)
        {
            Response.Clear();
            Response.StatusCode = 404;
            Response.End();
        }
        else
        {
            UserInfo user = new UserInfo();


            user.username = data.Rows[0][0] as string;
            user.id = (int)data.Rows[0][1];
            user.name = data.Rows[0][2] as string;
            user.surname = data.Rows[0][3] as string;

            var val = data.Rows[0][4];
            user.deviceID = ((int)val).ToString();

            Session["User"] = user;
            Response.Write("success");

        }


    }
    else
    {
        string username = "fatih0";
        string password = "123456";



        var data =  Sql.Query($"select username , id  , name , surname   from customer where username = '{username}' and password='{password}'");

        if (data.Rows.Count == 0)
        {
            Response.Clear();
            Response.StatusCode = 404;
            Response.End();
        }
        else
        {
            UserInfo user = new UserInfo();


            user.username = data.Rows[0][0] as string;
            user.id = (int)data.Rows[0][1];
            user.name = data.Rows[0][2] as string;
            user.surname = data.Rows[0][3] as string;
 

            Session["User"] = user;
            //Response.Write(data);
            // Response.Redirect("dashboard.aspx");
        }
    }




%>