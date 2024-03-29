﻿<%@ Page Language="C#"  %>


<%     
    if (Session["User"] == null)
    {
        Response.Redirect("login.aspx");
    }
    string plotChartString = "";
    string plotDataString = "";


    UserInfo U = (UserInfo)Session["User"];


    var table = Sql.Query($"select sum(cost),sum(freeusage)/sum(energyusage),extract(year from timestamp) as selected_year, extract(month from timestamp) as selected_month from usage where deviceid = '{U.deviceID}' group by selected_year,selected_month order by selected_year,selected_month desc");

    string html = "<table class=\"table\">";
    //add header row
    html += "<tr>";
    html += "<th>#</th>";
    html += "<th>Fatura Tarihi</th>";
    html += "<th>Ücret</th>";
    html += "<th>Yenilenebilir Kullanım Oranı</th>";
    html += "</tr>";
    //add rows
    for (int i = 0; i < table.Rows.Count; i++)
    {
        var row = table.Rows[i];
        int ratio =(int) ((double)row[1] * 100);
        html += "<tr>" +

    "<td>" +
     i.ToString() +
    "</td>" +
    "<td>" +
     row[2].ToString() + "/" + row[3].ToString()+
    "</td>" +
    "<td>" +
       row[0].ToString() + " birim" +
    "</td>" +
    "<td>" +
    "  <div class=\"progress\">" +
    $"    <div class=\"progress-bar bg-gradient-success\" role=\"progressbar\" style=\"width: {ratio}%\" aria-valuenow=\"{ratio}\" " +
    "    aria-valuemin=\"0\" aria-valuemax=\"100\"></div>" +
    "  </div>" +
    "</td>";

    }
    html += "</table>";

    var tablestr = html;// Util.ConvertDataTableToHTML(table);


%>


<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>CDTP</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="../web/template/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="../web/template/vendors/css/vendor.bundle.base.css">


  <!-- endinject -->
  <!-- inject:css -->
  <link rel="stylesheet" href="../web/template/css/style.css">

    <style>

        .dropdown-item
        {
            background-color:whitesmoke;
        }
 
    </style>
  <!-- endinject -->
  <link rel="shortcut icon" href="../web/template/images/favicon.png" />
</head>
<body>
  <div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row" >
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo" href="dashboard.aspx"><img src="../web/custom/logo.png" alt="logo"/></a>
        <a class="navbar-brand brand-logo-mini" href="dashboard.aspx"><img src="../web/custom/logo_small.png" alt="logo"/></a>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-stretch">

        <ul class="navbar-nav navbar-nav-right">
          <li class="nav-item nav-profile dropdown">
            <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
              <div class="nav-profile-img">
                <%--<img src="" alt="image"> <!-- web/template/images/faces/face1.jpg -->--%>
                <span class="availability-status online"></span>             
              </div>
              <div class="nav-profile-text">
                <p class="mb-1 text-black"><%=U.name + " "+ U.surname %></p>
              </div>
            </a>
            <div class="dropdown-menu navbar-dropdown" aria-labelledby="profileDropdown">
              <a class="dropdown-item" href="#">
                <i class="mdi mdi-cached mr-2 text-success"></i>
                Activity Log
              </a>
              <div class="dropdown-divider"></div>
              <a id="log-out-user" class="dropdown-item" href="#">
                <i class="mdi mdi-logout mr-2 text-primary"></i>
                Signout
              </a>
            </div>
          </li>
          <li class="nav-item d-none d-lg-block full-screen-link">
            <a class="nav-link">
              <i class="mdi mdi-fullscreen" id="fullscreen-button"></i>
            </a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
              <i class="mdi mdi-bell-outline"></i>
              <span class="count-symbol bg-danger"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
              <h6 class="p-3 mb-0">Notifications</h6>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-success">
                    <i class="mdi mdi-calendar"></i>
                  </div>
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject font-weight-normal mb-1">Event today</h6>
                  <p class="text-gray ellipsis mb-0">
                    Just a reminder that you have an event today
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-warning">
                    <i class="mdi mdi-settings"></i>
                  </div>
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject font-weight-normal mb-1">Settings</h6>
                  <p class="text-gray ellipsis mb-0">
                    Update dashboard
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-info">
                    <i class="mdi mdi-link-variant"></i>
                  </div>
                </div>
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject font-weight-normal mb-1">Launch Admin</h6>
                  <p class="text-gray ellipsis mb-0">
                    New admin wow!
                  </p>
                </div>
              </a>
              <div class="dropdown-divider"></div>
              <h6 class="p-3 mb-0 text-center">See all notifications</h6>
            </div>
          </li>
<%--          <li class="nav-item nav-logout d-none d-lg-block">
            <a id="log-out" class="nav-link" href="#">
              <i class="mdi mdi-power"></i>
            </a>
          </li>--%>
<%--          <li class="nav-item nav-settings d-none d-lg-block">
            <a class="nav-link" href="#">
              <i class="mdi mdi-format-line-spacing"></i>
            </a>
          </li>--%>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="mdi mdi-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_sidebar.html -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">


          <li class="nav-item nav-profile">
            <a href="#" class="nav-link">
 
              <div class="nav-profile-text d-flex flex-column">
                <span class="font-weight-bold mb-2"><%=U.name + " "+ U.surname %></span>
                <span class="text-secondary text-small"> ... </span>
              </div>
              <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
            </a>
          </li>

            
            
          <li class="nav-item">
            <a class="nav-link" href="dashboard.aspx">
              <span class="menu-title">Ana Ekran</span>
              <i class="mdi mdi-home menu-icon"></i>
            </a>
          </li>
               
            

          <li class="nav-item">
            <a class="nav-link" href="dashboard.aspx">
              <span class="menu-title">Hesap Ayarları</span>
              <i class="mdi mdi-account-settings-variant menu-icon"></i>
            </a>
          </li>

         <li class="nav-item">
            <a class="nav-link" href="#"  onclick="event.preventDefault();fillData()">
              <span class="menu-title">Yenile</span>
              <i class="mdi mdi mdi-flattr menu-icon"></i>
            </a>
          </li>
           
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <span class="menu-title">İstekler</span>
              <i class="menu-arrow"></i>
              <i class="mdi mdi-crosshairs-gps menu-icon"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="#">Rapor Talep</a></li>
                <li class="nav-item"> <a class="nav-link" href="#">İzleme Aralığı</a></li>
              </ul>
            </div>
          </li>

 

        </ul>
      </nav>
  
      <div class="main-panel">
        <div class="content-wrapper">
 
 
          <div class="page-header">
            <h3 class="page-title">
              <span class="page-title-icon bg-gradient-primary text-white mr-2">
                <i class="mdi mdi-home"></i>                 
              </span>
               Aktiviteler
            </h3>
            <nav aria-label="breadcrumb">
              <ul class="breadcrumb">
                <li class="breadcrumb-item active"  >
                  <span></span>Görünüm
                  <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
                </li>
              </ul>
            </nav>
          </div>
          <div class="row">
            <div class="col-md-4 stretch-card grid-margin">
              <div class="card bg-gradient-danger card-img-holder text-white">
                <div class="card-body">
                  <img src="../web/template/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image"/>
                  <h4 class="font-weight-normal mb-3" >Haftalık Kullanım
                    <i class="mdi mdi-chart-line mdi-24px float-right"></i>
                  </h4>
                  <h2 class="mb-5"  id="weeklyUsages" > 0 </h2> <%--------------------------------------------------------------------------%>
                  <h6 class="card-text"> </h6>
                </div>
              </div>
            </div>
            <div class="col-md-4 stretch-card grid-margin">
              <div class="card bg-gradient-info card-img-holder text-white">
                <div class="card-body">
                  <img src="../web/template/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image"/>                  
                  <h4 class="font-weight-normal mb-3"> Toplam Harcama
                    <i class="mdi mdi-bookmark-outline mdi-24px float-right"></i>
                  </h4>
                  <h2 class="mb-5" id="totalUsages"> 0</h2> <%--------------------------------------------------------------------------%>
                  <a href="#all_usages"><h6 class="card-text"  >  tüm harcamalar </h6></a>
                </div>
              </div>
            </div>
            <div class="col-md-4 stretch-card grid-margin">
              <div class="card bg-gradient-success card-img-holder text-white">
                <div class="card-body">
                  <img src="../web/template/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image"/>                                    
                  <h4 class="font-weight-normal mb-3"> Kazanılan Enerji
                    <i class="mdi mdi-diamond mdi-24px float-right"></i>
                  </h4>
                  <h2 class="mb-5"  id="freeUsages">0</h2>
                  <h6 class="card-text"></h6><%-- Increased by 5%--%>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-7 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <div class="clearfix">
                    <h4 id="line-chart-title" class="card-title float-left">Aylık Takip Tablosu 2019</h4>
                    <div id="visit-sale-chart-legend" class="rounded-legend legend-horizontal legend-top-right float-right"></div>                                     
                  </div>
                  <canvas id="visit-sale-chart" class="mt-4"></canvas>
                </div>
              </div>
            </div>
            <div class="col-md-5 grid-margin stretch-card">
              <div class="card">

            
                <div class="card-body">
                      <h4 class="card-title">Enerji Kullanım Oranı</h4>
                    <br />
    
                    <canvas id="traffic-chart" class='img-responsive'></canvas>
                
                </div>
                      
              </div>
            </div>
          </div>
          <div class="row" id="all_usages">
            <div class="col-12 grid-margin">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title"  >Son Faturalar</h4>
                  <div class="table-responsive" >
                        <%=tablestr%>
                  </div>
                </div>
              </div>
            </div>
          </div>
 
 
        </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2019  CDTP.  All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> </span>
          </div>
        </footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- plugins:js -->
  <script src="../web/template/vendors/js/vendor.bundle.base.js"></script>
  <script src="../web/template/vendors/js/vendor.bundle.addons.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src="../web/template/js/off-canvas.js"></script>
  <script src="../web/template/js/misc.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="../web/template/js/dashboard.js"></script>
  <!-- End custom js for this page-->

    <script>
        
        $("#log-out").click(function (e) {
            e.preventDefault();
                $.ajax({
                    type: 'POST',
                    url: 'logOut.aspx',
                    success: function (data) {

                        console.log("logout succesfull "  );
                        window.location = "login.aspx"
 
                    },
                    error: function () {

                        console.log("logout unsuccessful "  );
                    }
                });
        });
        
        $("#log-out-user").click(function (e) {
            e.preventDefault();
                $.ajax({
                    type: 'POST',
                    url: 'logOut.aspx',
                    success: function (data) {

                        console.log("logout succesfull "  );
                        window.location = "login.aspx"
 
                    },
                    error: function () {

                        console.log("logout unsuccessful "  );
                    }
                });
        });


        
     

          
   
         var ctx = document.getElementById('visit-sale-chart').getContext("2d");

        var lineChart = new Chart(ctx, {
            type: 'line',
            data:[ ]
        })

        var trafficChartOptions = {
            responsive: true,
            animation: {
                animateScale: true,
                animateRotate: true
            },
            legend: false,
        };

 
        var trafficChart = new Chart(document.getElementById("traffic-chart"), {
            type: 'doughnut',
            responsive: true
    
        //,data: trafficChartData,
        //options: trafficChartOptions
      });
       //$("#traffic-chart-legend").html(trafficChart.generateLegend());      

        function setChartData(chart, labels, datasets) {
            let data = chart.config.data;
            data.datasets = datasets;
            data.labels = labels;
            chart.update();
        }

 

 




        function sse_begin(url, onmessage, onopen, onerror) {
            var source = new EventSource(url);
            if (onopen)
                source.onopen = onopen;
            if (onmessage)
                source.onmessage = onmessage;
            if (onerror)
                source.onerror = onerror;
        }


        sse_begin("../sse?deviceid=<%=U.deviceID%>", (e) =>
        {
            console.log("try to update now...");
            fillData()
            console.log("xda");
        })


        function call_ajax(url, response_type, callback) {
            var xhttp = new XMLHttpRequest();
            xhttp.responseType = response_type;
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    if (callback)
                        callback(xhttp.response);
                }
            };
            xhttp.open("GET", url, true);
            xhttp.send();
        }


        function fillData() {
            call_ajax('../R.aspx?deviceid=0', 'json', (response) => {

                //alert(response);

                setChartData(lineChart, response.labels,
                    [
                        {
                            data: response.datasets[0].data,
                            label: "Enerji Kullanımı",
                            backgroundColor: 'rgba(255, 87, 25, 0.2)',
                            borderColor: 'rgba(255, 87, 25, 0.8)'
                        },
                        {
                            data: response.datasets[1].data,
                            label: "Yenilenebilir Enerji Kullanımı",
                            backgroundColor: 'rgba(60, 210, 60, 0.2)',
                            borderColor: 'rgba(60, 210, 60, 0.9)'
                        }

                    ]
                )
                setChartData(trafficChart, ["Enerji Kullanımı", "Yenilenebilir Enerji Kullanımı"],
                    [{
                        label: 'Kullanım oranları',
                        data: [response.extra.totalUsages - response.extra.freeUsages, response.extra.freeUsages],
                        backgroundColor: [
                            'rgba(255, 87, 25, 1)',
                            'rgba(60, 210, 60, 1)'
                        ],
                        borderColor: [
                            'rgba(255, 87, 25,1)',
                            'rgba(60, 210, 60, 1)'
                        ],
                        borderWidth: 1
                    }])

                //$("#traffic-chart-legend").html(trafficChart.generateLegend());    
                // document.getElementById("traffic-chart-legend").innerHTML = (trafficChart.generateLegend());   

                let month = new Intl.DateTimeFormat('tr', { month: 'long' }).format(new Date(response.date));
                document.getElementById("line-chart-title").innerText = month + " Kullanım Grafiği";
                document.getElementById("totalUsages").innerText = response.extra.totalUsages.toString() + " birim";
                document.getElementById("weeklyUsages").innerText = response.extra.weeklyUsages.toString() + " birim";
                document.getElementById("freeUsages").innerText = response.extra.freeUsages.toString() + " birim";
            })
        }

   
        fillData();



    </script>
</body>

</html>
