<%@ Page Language="C#" %>

<%


    var deviceid = Request.QueryString["deviceid"];

    if (deviceid != null)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("login.aspx");
        }
        string plotChartString = "";
        string plotDataString = "";
        string plotColorString = "";

        UserInfo U = (UserInfo)Session["User"];


        var table = Sql.Query("select timestamp,energyusage,freeusage from usage where deviceid='" + U.deviceID + "' order by timestamp DESC limit 30 ");
        var sumtable = Sql.Query("select sum(energyusage),sum(freeusage) from usage where deviceid='" + U.deviceID + "'");

        double totalUsage = (double)sumtable.Rows[0][0];
        double totalFree  = (double)sumtable.Rows[0][1];
        double weeklyUsage = 0;

        if (table.Rows.Count > 0)
        {
            DateTime lastDate = (DateTime)table.Rows[0][0];
            var days = DateTime.DaysInMonth(lastDate.Year, lastDate.Month);
            var dailyUsages = new double[lastDate.Day+1, 2];


            int index = 0;
            while (index < table.Rows.Count && ((DateTime)table.Rows[index][0]).Month == lastDate.Month)
            {
                if(index < 7)
                {
                    weeklyUsage += (double)table.Rows[index][1];
                }

                var day = ((DateTime)table.Rows[index][0]).Day;
                dailyUsages[day, 0] = (double)table.Rows[index][1];
                dailyUsages[day, 1] = (double)table.Rows[index][2];
                index++;
            }

            var dayCount = 1;

            var sb0 = new StringBuilder();
            var sb1 = new StringBuilder();
            var sb2 = new StringBuilder();

            sb0.Append(dailyUsages[0, 0]);
            sb1.Append(dailyUsages[0, 1]);
            sb2.Append(dayCount.ToString());


            for (int i = 1; i < dailyUsages.Length / 2; i++)
            {
                sb0.Append(",");
                sb0.Append(dailyUsages[i, 0]);
                sb1.Append(",");
                sb1.Append(dailyUsages[i, 1]);
                sb2.Append(",");
                sb2.Append(dayCount.ToString());

                dayCount++;
            }

            var json = "{\"datasets\":[{\"label\":\"EnergyUsage\"," +
            "\"backgroundColor\":\"rgba(210 , 60,60,0.2)\"," +
            "\"borderColor\":\"rgba(210 ,110,110,0.8)\"," +
            "\"data\":[" +
             sb0.ToString()+
            "]}," +
            "{\"label\":\"My First dataset\"," +
            "\"backgroundColor\":\"rgba(60 , 210,60,0.2)\"," +
            "\"borderColor\":\"rgba(60 , 210,60,0.9)\"," +
            "\"data\":[" +
             sb1.ToString()+
            "]}]," +
            "\"labels\":[" +
             sb2.ToString()+
            "]," +
            "\"extra\":{" +
                "\"weeklyUsages\":" + weeklyUsage.ToString()+ ","+
                "\"totalUsages\":"  + totalUsage.ToString()+ ","+
                "\"freeUsages\":"   + totalFree.ToString()+ ""+
            "},"+
            "\"date\":\"" +
            lastDate.ToLongDateString()+
            "\"}";


            Response.ContentType = "application/json";
            //Response.Write("{\"test\":12}");
            Response.Write(json);
            Response.Flush();
            Response.End();


        }

        var tablestr = Util.ConvertDataTableToHTML(table);

    }

    Response.ContentType = "application/json";
    //Response.Write("{\"test\":12}");
    Response.Write("{test:12}");
    Response.Flush();



%>


