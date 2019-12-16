<%@ Page Language="C#" %>


<!DOCTYPE html>
<html>
<head>
<title>Detaylar</title>
    <meta charset="utf-8"/>

    <style>

        #header
{
	color:white; 
	background: linear-gradient(to right, violet, blue);
	width:600px;
	height: 50px;	
	margin-left:auto;
	margin-right: auto;
	margin-top: 20px;
    border-top-left-radius: 5px;
    border-top-right-radius: 5px;
   	border: 1px solid black;
}



#infoBox
{
	padding: 5px;
	text-align: center;
     border-radius: 6px;
     border: 1px solid black;
	 color:black;
	 position: absolute;
	 display: none;
	 height: auto;
	 width: auto;

	 background: linear-gradient(to bottom right, lightgray, white);

}


.selButton
{
	padding: 0px;
	width: 299px;
	margin: auto;
	border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
	border: 1px solid gray;
	background: #dee7f4;
	color black;
}

.selButton:hover
{
	padding: 0px;
	width: 299px;
	margin: auto;
	border: 1px solid lightgray;
	border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
	background: white;
	color black;
}

#report {

     background-color:white;
     border-right: 1px solid black;
     border-left: 1px solid black;
     border-bottom:2px solid black;
}


    body
{

    font-family:  'Helvetica', 'Arial', sans-serif;';
    color: #444444;
    font-size: 14px;
    background-color: #97b1db;
}


#watermark
{
	color:white;
	text-align: center;
}


    </style>



</head>
<body>
    <div id = "header" width=600 align="center">
        <h3 width=600 align="center"> Rapor Detayları </h3>
    </div>

<div align="center"  width=600 height = 400>
<div id="report" style="width:600px; height:400px; ">

    <%
    if(Request.QueryString["eid"] != null)
    {


        string eid = Request.QueryString["eid"];

        var res = Sql.Query($"select eventinfo from event where event.id = '{eid}'");
        if(res.Rows.Count > 0)
        {
            Response.Write((string)res.Rows[0][0]);

        }else
        {
            Response.Write("Bad request");
        }
    }


%>


</div>
    </div>

<div align="center"  width=600 height = 400>
     <button id="btn_reflesh" type="button"  class="selButton" style="background: lightblue" onclick="window.location = 'dashboard.aspx';">
         Geri Gel
     </button>
</div>
    
<div align="center"  width=600 height = 400>
<p id="watermark"> 5sense 2019 &copy; </p>
    </div>

</body>

</html> 


