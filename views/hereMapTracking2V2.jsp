<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <html>
 <%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/soniyatech.tld" prefix="soniyatech" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>

<%@ page import="com.soniyatech.common.Config" %>
<%@ page import="com.soniyatech.server.safone.common.SafoneApplication" %>
<%@ page import="com.soniyatech.server.core.engine.Engine" %>
<%@ page import="com.soniyatech.framework.IFrameworkConstants" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ page import="com.soniyatech.server.core.engine.Engine" %>
<%@ page import="com.soniyatech.server.safone.common.*" %>

<% 
    SafoneApplication _safoneApplication1 = (SafoneApplication) Engine.getInstance().getApplication("SAFONE");
   //String language = _safoneApplication.getContext().getAttribute("LANGUAGE");
   String companyName = _safoneApplication1.getAttribute("COMPANY_NAME");
   System.out.println("companyName1 = " + companyName);
   //String gmapkey = Config.get("gmapkey");
   //WeiMeng v3.0: Now reading Google Map key from SafoneConfig.xml instead of app.properties
   String gmapkey = _safoneApplication1.getAttribute("GOOGLE_MAPKEY");
   String bingmapkey = _safoneApplication1.getAttribute("BINGMAP_MAPKEY");
   String heremapcode = _safoneApplication1.getAttribute("HEREMAP_MAPKEY");
   String heremapid = _safoneApplication1.getAttribute("HEREMAP_MAPID");
 %>
<%
com.soniyatech.hibernate.bml.SoniyaUsers user = (com.soniyatech.hibernate.bml.SoniyaUsers)(session.getAttribute(com.soniyatech.framework.IFrameworkConstants.USER_KEY));
com.soniyatech.hibernate.bml.SoniyaUsers adminUser = (com.soniyatech.hibernate.bml.SoniyaUsers)(session.getAttribute(IFrameworkConstants.ADMIN_KEY));
boolean isAdminUser1 = false;
boolean isDefaultLeader1 = false;

if (adminUser != null){
	if (adminUser.getRole().equalsIgnoreCase("A")){
		System.out.println(adminUser.getRole());
		System.out.println(adminUser.getContactMode());
	    isAdminUser1 = true;
        if (adminUser.getContactMode().contains("Defaultgroup"))
	       isDefaultLeader1 =  true;
    }
}else{
	System.out.println("adminUser1 is null");
}
%>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="images/favicon.gif">

    <title>Soniya United Tracking</title>

    <!-- Bootstrap -->
    <link href="stylesheets/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap theme -->
    <link href="stylesheets/bootstrap-theme.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" media="all" href="js/calendar-win2k-1.css" title="system" />
    <!-- Custom styles for this template -->
    <link href="stylesheets/soniya.css" rel="stylesheet">
    <link href="stylesheets/soniyamap.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://js.api.here.com/v3/3.0/mapsjs-ui.css" />    
        <!-- calendar stylesheet -->
    <!-- main calendar program -->
    <script type="text/javascript" src="js/calendar1.js"></script>
    <!-- language for the calendar -->
    <script type="text/javascript" src="js/lang/calendar-en.js"></script>
    <script type="text/javascript" src="js/calendar-setup.js"></script>
    
    <script type="text/javascript" src="js/general.js"></script>  
    <script type="text/javascript" src="js/general2.js"></script>    
  </head>
  <body onload="initOnLoad()">
  <!--body-->
    <div class="navbar navbar-fixed-top navbar-inverse" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Soniya United Tracking</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <!-- Admin header nav START -->
            <%if (isAdminUser1 == true && isDefaultLeader1 == true){%>
            <!-- li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" title="Admin">
                <span class="admin"><span class="glyphicon glyphicon-cog"></span> Admin<b class="caret"></b></span>
              </a>
              <ul class="dropdown-menu">
                <li><a href="javascript:goAdminServicePage()">Admin Service Subscription</a></li>
                <li><a href="jsp/locationHistoryDel.do?page=history">Admin Delete History</a></li>
                <li class=""><a href="jsp/deviceList.do?page=deviceList">Admin Device</a></li>
              </ul>
            </li -->
            <%} %>
            <!-- Admin header nav END -->
            <li class="hidden-sm"><a href="#" onClick="GoToGoogleMapAllDevicesTab();return false;"><span class="glyphicon glyphicon-flash"></span> Live</a></li>
            <li class="hidden-sm active"><a href="#" onClick="GoToLiveMapForGoogleTab();return false;"><span class="glyphicon glyphicon-record"></span> Summary</a></li>
            <li class="hidden-sm"><a href="#" onClick="GotoDeviceHistoryInfoTab();return false;"><span class="glyphicon glyphicon-stats"></span> History</a></li>
            <li class="hidden-sm"><a href="#" onClick="GotoDeviceSetupTab();return false;"><span class="glyphicon glyphicon-phone"></span> Device</a></li>
            <li class="hidden-sm"><a href="#" onClick="GoToAlertTab();return false;"><span class="glyphicon glyphicon-bell"></span> Alert</a></li>
            <li class="dropdown visible-sm active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span class=""><span class="glyphicon glyphicon-cog"></span> more<b class="caret"></b></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#" onClick="GoToGoogleMapAllDevicesTab();return false;"><span class="glyphicon glyphicon-flash"></span> Live</a></li>
                    <li class="active"><a href="#" onClick="GoToLiveMapForGoogleTab();return false;"><span class="glyphicon glyphicon-record"></span> Summary</a></li>
                    <li><a href="#" onClick="GotoDeviceHistoryInfoTab();return false;"><span class="glyphicon glyphicon-stats"></span> History</a></li>
                    <li><a href="#" onClick="GotoDeviceSetupTab();return false;"><span class="glyphicon glyphicon-phone"></span> Device</a></li>
                    <li><a href="#" onClick="GoToAlertTab();return false;"><span class="glyphicon glyphicon-bell"></span> Alert</a></li>
                </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <span class="glyphicon glyphicon-user"></span> <span style="color:#2CD3FE" id="userName">
        </span> <b class="caret"></b>
              </a>
              <ul class="dropdown-menu">
                <li><a href="#" onClick="GoToMyAccountTab()"><span class="glyphicon glyphicon-cloud"></span>&nbsp; My Service</a></li>
                <li><a href="#" onclick="window.location='jsp/account/profile.do?page=account&page2=profile'"><span class="glyphicon glyphicon-file"></span>&nbsp; My Profile</a></li>
                <li><a href="#" onclick="window.location='jsp/account/password.do?page=account&page2=changePassword'"><span class="glyphicon glyphicon-pencil"></span>&nbsp; Change Password</a></li>
                <li><%if (adminUser == null){ %>
                     <a href="/logout.do"><span class="glyphicon glyphicon-log-out"></span>&nbsp; Sign Out</a>
                <%}else{ %>
                     <a href="javascript:window.close();"><span class="glyphicon glyphicon-log-out"></span>&nbsp; Sign Out</a>                
                 <%} %>
                 </li>
              </ul>
            </li>
          </ul>
        </div>
      </div><!-- /.container -->
    </div><!-- /.navbar -->
<input type="hidden" name="date" id="f_date_e" style="visibility:hidden"/>
    <div class="panel-container hight-full">
      <div id="side_panel_div" class="side-panel">
        <div class="btn-group btn-group-justified">
          <div class="btn-group">
            <button type="button" onclick="location.href='jsp/statusHistory.do?page=history'" class="btn btn-primary btn-md"><span class="glyphicon glyphicon-stats"></span> Reception</button>
          </div>
          <div class="btn-group">
            <button type="button" onclick="window.location='jsp/account/devicePaymentHistory.do?page=account&page2=devicePaymentHistory'" class="btn btn-primary btn-md"><span class="glyphicon glyphicon-cloud"></span> My Service</button>
          </div>
        </div>
        <div class="checkbox center-chkbox">
          <label>
            <input type="checkbox" name="selectType" id="selectType" value="breasdcrumbs" onClick="retrieveLocWithType();">
            Daily Trace
          </label>
        </div>
        <p>
          <a href="javascript:googleMapForCurrentDeviceLocation()" class="btn btn-primary btn-md width-full">
            <img src="images/icon-street-view.png" class="img-rounded img-responsive glyphicon btn-icon">&nbsp;
            What's nearby
          </a>
        </p>
        <div class="panel panel-default">
          <div class="panel-heading padding-sm-vertical"><h3 class="panel-title"><strong>Device List</strong></h3></div>
          <div class="panel-body padding-sm-vertical">
            <!--  ul class="list-unstyled margin-zero" -->
            <table id="tablep">
            </table>            
            <!--
              <li class="in-service"><a href="#">USAPOV: </a><span class="content-text">14 Min 27 Sec</span></li>
              <li class="out-service selected"><a href="#">BitchN: </a><span class="content-text">3 Days 5 Hr</span></li>
             -->
             <!--/ul -->
          </div>
        </div>
        <div id="date" class="input-group">
<input type="hidden" name="date" id="f_date_e" style="visibility:hidden"/>        
          <span class="input-group-addon width-full">
            <span class="glyphicon glyphicon-time"></span>
            <span id="show_e">Feb 16, 2014</span>
          </span>
          <span class="input-group-btn">
            <button class="btn btn-info" type="button" id="f_trigger_e">Select Date</button>
          </span>
        </div>
        <div class="panel panel-default margin-bottom-zero">
          <div class="panel-heading padding-sm-vertical"><h3 class="panel-title"><strong>Summary of Day</strong></h3></div>
          <div class="panel-body padding-sm-vertical">
            <ul class="list-unstyled margin-zero">
            <div id="tableAS">
              <!--
              <li>Captured Locates of Day: <span class="content-text">6689</span></li>
              <li>Approx Travel of Day: <span class="content-text">3,089.37 mile(s)</span></li>
              <li>Top Speed of Day: <span class="content-text">46.0 mph</span></li>
              <li>Last Reception of Day: <span class="content-text">Captured 23:02:03 PST</span></li>
              <li>Last Battery of Day: <span class="content-text">14.2V</span></li>
            -->
              </div>
            </ul>
          </div>
        </div>
      </div><!-- side-panel -->

      <a id="button_toggle_panel" class="control-button" href="#"><span id="button_toggle_icon" class="glyphicon glyphicon-chevron-right icon"></span></a>
    </div>

    <div class="mapfooter">
      <small> &copy; 2005-2016 SONIYA TECHNOLOGY INTERNATIONAL INC.</small>
    </div>

    <div id="myMap" class="bing-map">
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <!--  script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script -->
    <!--  script type="text/javascript" src="http://api.maps.nokia.com/2.2.3/jsl.js?with=all" charset="utf-8"></script --> 
          <script src="http://js.api.here.com/v3/3.0/mapsjs-core.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-pano.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-service.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-mapevents.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-ui.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-data.js"></script>
    
    <script src="js/soniyamap.js"></script>
    <!--  script src="js/soniya-bing-map.js"></script -->
       <script defer="defer" type="text/javascript">

//<![CDATA[ 		

	  var haveNewLocation = 0;

	  var xmlDoc;

	  var newDocument;

	  var j = 1;

	  var lastLocTimestamp;

	  var lastLocIndex;

	  var global_deviceId;

	  var locationHistoryListDOMObj = null;

	  var deviceListDOMObj;

	  var selectType = 1;

	  //var layer_polyline;

	  var PrePoint;

      var currentPoint;	 

	  var markerList = [];

	  var global_googlepoint;

	  var lastMarker_g;

	  var isSoniyatech = 0;



	//map

    var map; // = null;

	var serverfbAlert = "Select a Device and click on map to pick a new center. Name it and define Radius. Click Refresh to verify coverage.";





var radius= 0.5;

var landmarkName= new Date().getTime();

var lmDescription = "My Geofence";

var alertType = 2;

var map;

var centerPoint = new H.geo.Point(42.394933,-83.138132);

var centerMarker = null;

var radiusMarker = null;

var polygon = null;

var customIcon = null;



function roundFloat(strFloat)

{

  //var strFloat = num.value;

  var newFloat;



  if(strFloat.length - strFloat.indexOf(".") > 5)

  {

    strFloat = strFloat.substring(0,strFloat.indexOf(".") + 6);

    return strFloat;

  }

  else

  {

    return strFloat;

  }

}







//function DeleteShape()

//{

//	if (centerMarker != null)

//	{

		//map.removeOverlay(centerMarker);
//        centerMarker.setMap(null);
//		centerMarker = null;

//	}

	

//	if (polygon != null)

//	{

		//map.removeOverlay(polygon);
//		polygon.setMap(null);
//		polygon = null;

//	}

		

//}



function delPreLatLon(){

  document.getElementById("inputlat").value = "";

}



//var geocoder = new google.maps.Geocoder(); //new GClientGeocoder();



function ShowLocationWithRadius() {

    //var lat = parseFloat(document.getElementById("inputlat").value); 

    var latlon = document.getElementById("inputlat").value;  

    var latlon1 = latlon.toString().split("/");

    var lat = parseFloat(latlon1[0]);

	var lon = parseFloat(latlon1[1]);      

           

    //var lon = parseFloat(document.getElementById("inputlon").value);

	radius = parseFloat(document.getElementById("inputradius").value) * 1.609347;



    if (!isNaN(lat) && !isNaN(lon) && lat>=-90 && lat<=90 && lon>=-180 && lon<=180) {

       //alert( "ShowLocationWithRadius = " + lat+"/"+lon);

        showBoundry(null, new google.maps.LatLng(lat, lon));

    }else

    {

        alert("Not valid decimal degrees");

    }

}



//function draw(point){

//var bounds = map.getBounds(); //new GLatLngBounds;

       // var center = new GLatLng(35.974417, -97.033050);

//	   var center = point;



        //convert kilometers to miles-diameter

        //var radius = radius*1.609344;



//        var latOffset = 0.01;

//        var lonOffset = 0.01;

//        var latConv = center.distanceFrom(new google.maps.LatLng(center.lat()+0.1, center.lng()))/100;

//        var lngConv = center.distanceFrom(new google.maps.LatLng(center.lat(), center.lng()+0.1))/100;



        // nodes = number of points to create circle polygon

 //       var nodes = 40;

        //Loop

//        var points = [];

//        var step = parseInt(360/nodes)||10;

//        for(var i=0; i<=360; i+=step)

//        {

//          var pint = new google.maps.LatLng(center.lat() + (radius/latConv * Math.cos(i * Math.PI/180)), center.lng() + (radius/lngConv * Math.sin(i * Math.PI/180)));

                        // push pints into points array

//          points.push(pint);

//		  bounds.extend(pint);

 //       }



//	if (polygon != null)

//		map.removeOverlay(polygon);

    //polygon = new GPolygon(points, "#999999", 1, 1, "#96BDFE", 0.4);
//    polygon = new google.maps.Polygon({
//        paths: triangleCoords,
//        strokeColor: "#999999",
//        strokeOpacity: 1,
//        strokeWeight: 1,
//        fillColor: "#96BDFE",
//        fillOpacity: 0.4
//      });
//    polygon.setMap(map);
    //map.addOverlay(polygon); 

	//map.setZoom(map.getBoundsZoomLevel(bounds) -1);

	//map.setCenter(bounds.getCenter());

//	}

	

  //var geocoder = new GClientGeocoder();

	//function GeoCoding(){

	//var address = document.getElementById("inputaddress").value;

	//if (!address){

	//  ShowLocationWithRadius();

	//  return;

	//}
    //geocoder.geocode( { 'address': address}, function(results, status) {
    //    if (status == google.maps.GeocoderStatus.OK) {
    //    	centerMarker.setMap(null);
    //    	centerMarker = null;
    //      map.setCenter(results[0].geometry.location);
    //      centerMarker = new google.maps.Marker({
     //         map: map,
     //         position: results[0].geometry.location
      //    });
	 //       radius = parseFloat(document.getElementById("inputradius").value) * 1.609347;
	 //       document.getElementById("serverfbAlert").innerHTML=serverfbAlert;	           
     //       draw(results[0].geometry.location);          
     //   } else {
    //      alert("Geocode was not successful for the following reason: " + status);
    //    }
   //   });

	  //geocoder.getLatLng(    address,   

	  // function(point) {      

	  //   if (!point) {        

	  //      alert(address + " not found"); 

	  //      return;     

	  //   } else { 

	  //   	document.getElementById("inputlat").value = roundFloat(point.lat().toString())+"/"+roundFloat(point.lng().toString()); 

	  //      //document.getElementById("inputlon").value = point.lng();	     

	  //      if (centerMarker != null)

	//	      map.removeOverlay(centerMarker);

	 //       centerMarker = new GMarker(point,customIcon);

//        //centerMarker = createMarker(point,'Start','', 1)

	//        map.addOverlay(centerMarker);

	 //       radius = parseFloat(document.getElementById("inputradius").value) * 1.609347;

	 //       document.getElementById("serverfbAlert").innerHTML=serverfbAlert;	           

    //        draw(point)	

    //     }  

	 //  }  

	 // );

	

//	}

function icon(){

//customIcon = new GIcon();

customIcon = "images/alertPin.gif"; //customIcon.image = "images/alertPin.gif";



//customIcon.iconSize = new GSize(30, 30);

//customIcon.iconAnchor = new GPoint(15, 15);

//customIcon.infoWindowAnchor = new GPoint(15, 15);

return customIcon;



}



//function showBoundry(marker, point) {

//	var zoom = map.getZoom();

	

//	{

//	if (point == null)

//	   return;

	//check if genfence window is open

//	var visibility = document.getElementById('toolpanel').style.visibility;

//	if (visibility != 'visible')

//		return;

//	document.getElementById("inputlat").value = roundFloat(point.lat().toString())+"/"+roundFloat(point.lng().toString());        

	//document.getElementById("inputlon").value = point.lng();

    //document.getElementById("inputaddress").value = "";

//	if (centerMarker != null){
//	       centerMarker.setMap(null);
//	       centerMarker = null;
//	}
	//if (centerMarker != null)
	//	map.removeOverlay(centerMarker);

//	centerMarker = new google.maps.Marker({
//		position: point,
//		map: map,
//		icon: customIcon,
//		shadow: 'shadow.png'
//	});  //new GMarker(point,customIcon);
//	centerMarker.setMap(map);
	//centerMarker = createMarker(point,'Start','', 1)

	//map.addOverlay(centerMarker);

//	radius = parseFloat(document.getElementById("inputradius").value) * 1.609347;

//	document.getElementById("serverfbAlert").innerHTML=serverfbAlert;

//	draw(point);



//	}

	

//}



//function mapClick(marker, point) {

//	var zoom = map.getZoom();

	

//	{

//	if (point == null)

//	   return;

	//check if genfence window is open

//	var visibility = document.getElementById('toolpanel').style.visibility;

//	if (visibility != 'visible')

//		return;

//	document.getElementById("inputlat").value = roundFloat(point.lat().toString())+"/"+roundFloat(point.lng().toString());        

	//document.getElementById("inputlon").value = point.lng();

//    document.getElementById("inputaddress").value = "";

//    document.getElementById("inputaddress").blur();

	//if (centerMarker != null)

	//	map.removeOverlay(centerMarker);
//	if (centerMarker != null){
//	       centerMarker.setMap(null);
//	       centerMarker = null;
//	}

//	centerMarker = new google.maps.Marker({
//		position: point,
//		map: map,
//		icon: customIcon,
//		shadow: 'shadow.png'
//	});  //new GMarker(point,customIcon);
//	centerMarker.setMap(map);
	//centerMarker = createMarker(point,'Start','', 1)

	//map.addOverlay(centerMarker);

//	radius = parseFloat(document.getElementById("inputradius").value) * 1.609347;

//	document.getElementById("serverfbAlert").innerHTML=serverfbAlert;

//	draw(point);



//	}

	

//}

	 function viewOptionsUpdateForm()

	  {

		var dataDays  = "<s:property value='viewOptions.dataDays'/>"; 

		dateSelected  = "<s:property value='viewOptions.weekDayDisplayed'/>";

		if (dataDays != null && dateSelected != null)

		{

			eval(dataDays);

			if (dateSelected == "null" || dateSelected == null )

			{

				if (subEvent != "update")

				//document.getElementById("show_e").innerHTML="No Data Available";
				//12-22-2011 WeiMeng: grant color.
				document.getElementById("show_e").innerHTML='<span style="color:#FFFF00">No Data Available!</span>';

			}

			else{

				var tmp = dateSelected.split("/");

				var dateFormat = "";

				if (!isNaN(tmp[1])){

					if (tmp[1] == 1)

						dateFormat = "Jan ";

					if (tmp[1] == 2)

						dateFormat = "Feb ";

					if (tmp[1] == 3)

						dateFormat = "Mar ";

					if (tmp[1] == 4)

						dateFormat = "Apr ";

					if (tmp[1] == 5)

						dateFormat = "May ";

					if (tmp[1] == 6)

						dateFormat = "Jun ";

					if (tmp[1] == 7)

						dateFormat = "Jul ";

					if (tmp[1] == 8)

						dateFormat = "Aug ";

					if (tmp[1] == 9)

						dateFormat = "Sep ";

					if (tmp[1] == 10)

						dateFormat = "Oct ";

					if (tmp[1] == 11)

						dateFormat = "Nov ";

					if (tmp[1] == 12)

						dateFormat = "Dec ";

				}

				dateFormat = dateFormat + tmp[2] + ", "+ tmp[0];

				//alert(dateSelected +";" + dateFormat);

				document.getElementById("show_e").innerHTML=dateFormat;

				//document.getElementById("show_e").innerHTML=dateSelected;

			}

		

			//document.getElementById("show_e").innerHTML=dateSelected;

			//gcalendar.parseDate();

			//gcalendar.refresh();

		}

	  };

	

	  /**

	   * Get the contents of the URL via an Ajax call

	   * url - to get content from (e.g. /struts-ajax/sampleajax.do?ask=COMMAND_NAME_1) 

	   * nodeToOverWrite - when callback is made

	   * nameOfFormToPost - which form values will be posted up to the server as part 

	   *					of the request (can be null)

	   */

	  function retrieveXML() {

	  

			//var selectType = 2;

         var deviceId = global_deviceId;		  

	     var url;

	     var date = new Date().getTime();

		 if (selectType == 1)

		   url = "dd.action?deviceId="+deviceId+"&viewOptions.clientDataSize="+lastLocIndex+"&timestamp="+lastLocTimestamp+"&viewOptions.mapAll=15&viewOptions.returnCode=xml&viewOptions.refresh=true&d="+date;

		 if (selectType == 2)

		   url = "dd.action?deviceId="+deviceId+"&viewOptions.clientDataSize="+lastLocIndex+"&timestamp="+lastLocTimestamp+"&viewOptions.mapAll=12&viewOptions.returnCode=xml&viewOptions.refresh=true&d="+date;



		//Do the Ajax call

		if (window.XMLHttpRequest) { // Non-IE browsers

		  try{

			 req = new XMLHttpRequest();

		  } catch (e) {

			req = new ActiveXObject("Msxml2.XMLHTTP");

			//alert("Internet connection interrupted:\n"+e);

		  }

		  try{

			req.onreadystatechange = processResponseXML;

			req.open("POST", url, true); //was get

			req.setRequestHeader('Pragma', 'no-cache');

			req.setRequestHeader('Expires', '-1');

			req.send(null);

			} catch (e) {

			 alert("Internet connection interrupted:\n"+e);

			}

		} else if (window.ActiveXObject) { // IE

		  

		  req = new ActiveXObject("Microsoft.XMLHTTP");

		  if (req) {

			//alert("in window ActiveXObject");

			req.onreadystatechange = processResponseXML;

			req.open("GET", url, true);

			req.send();

		  }

		}

	  }

	

	/*

	   * Set as the callback method for when XmlHttpRequest State Changes 

	   * used by retrieveUrl

	  */

	  function processResponseXML() {

	     // HideProgressBar();

		  if (req.readyState == 4) { // Complete

		  //try{

		  if (req.status == 200) { // OK response

			newDocument=req.responseXML;

	        if(isSessionExpire()){

			  alert("Session expired due to user inactivity over 60 minutes. Please login again.\n ");

			  returnToLoginPage();

			}

			

			if (selectType == 1)

			   deviceLocInfo5Loc();

			if (selectType == 2)

			   deviceLocInfoAllLocRefresh();

			if (selectType == 3)

			   allDeviceCurrentLoc();

	

			haveNewLocation++;

		  } else {

			alert("Internet connection interrupted:\n " + req.statusText);

			returnToLoginPage();

		  }

		//}catch(e){

		//   alert("Internet connection interrupted:\n " + e);

		//   returnToLoginPage();

		//}

		}

	  }

	 

	   function deviceLocInfoAllLocRefresh(){

		//alert("go deviceLocInfoAllLocRefresh()");

	     var last_dInfo;

	     var last_index;

		

		 j=0;

		 haveNewLocation = 0;

	   if (newDocument){

		  var deviceList = newDocument.getElementsByTagName("deviceList");

		  var deviceInfoSet = deviceList[0].childNodes;

		  var user;

		  var dNickname;

		  var dId;

		  var deviceID;

		  var items11 = newDocument.getElementsByTagName("locationList");

		  var itemList11 = items11[0].childNodes;

		  for(var ii=0; ii<deviceInfoSet.length; ii++){

			 var deviceInfo = deviceInfoSet[ii].childNodes;

			 user = deviceInfo[22].childNodes[0].nodeValue;

			 dId = deviceInfo[4].childNodes[0].nodeValue;

			   if (global_deviceId == dId){

			      dNickname = deviceInfo[6].childNodes[0].nodeValue;			   

				  break;

			   }

		  }

		var alert_flag_for_latest_location  = false;

		var alertInfo;

        var lastPinAlertIcon;

	   for(var i=0; i < items11.length; i++){

		 var itemList = items11[i].childNodes;

		if(itemList){

        if (itemList.length <=0){

		 for(var k=0; k < itemList.length; k++){ //items

		   var deviceLocInfoList = itemList[k].childNodes;

				  var address1 = deviceLocInfoList[0].childNodes[0].nodeValue;

				  var address2 = deviceLocInfoList[1].childNodes[0].nodeValue;

				  var city = deviceLocInfoList[4].childNodes[0].nodeValue;

				  var country = deviceLocInfoList[5].childNodes[0].nodeValue;

				  var course = deviceLocInfoList[6].childNodes[0].nodeValue;

				  var timestamp = deviceLocInfoList[7].childNodes[0].nodeValue;

				  var duration = deviceLocInfoList[11].childNodes[0].nodeValue;

				  var index = deviceLocInfoList[12].childNodes[0].nodeValue;

				  var landMarkDescriptions = deviceLocInfoList[13].childNodes[0].nodeValue;

				  var landMarkName = deviceLocInfoList[14].childNodes[0].nodeValue;

				  var landmarkId = deviceLocInfoList[15].childNodes[0].nodeValue;

				  var lat = deviceLocInfoList[16].childNodes[0].nodeValue;

				  var locationAge = deviceLocInfoList[17].childNodes[0].nodeValue;

				  var lon = deviceLocInfoList[18].childNodes[0].nodeValue;

				  var speed = deviceLocInfoList[19].childNodes[0].nodeValue;

				  var speedUnit = deviceLocInfoList[20].childNodes[0].nodeValue;

				  var state = deviceLocInfoList[21].childNodes[0].nodeValue;

				  var timeSinceLastReport = deviceLocInfoList[22].childNodes[0].nodeValue;

				  var utctimestamp = deviceLocInfoList[23].childNodes[0].nodeValue;

				  var zipCode = deviceLocInfoList[24].childNodes[0].nodeValue;

				  var zkAlert = deviceLocInfoList[25].childNodes[0].nodeValue;

				  

				  //var address = address1+","+city+","+state+" " + zipCode;

				  var address = "";

				  if (address1 != "null")

				    address = address1;

				  if (city != "null")

				    address = address +", "+city;

				  if (state != "null")

				    address = address +", "+state;

				  if (zipCode != "null")

				    address = address +" " + zipCode;

				  

		          var dInfo =  index + ": " + timestamp + "<br>" + address;

                  var alert_flag = false;

                  if ( zkAlert == 'null'){ 

                    ;

                  }else{

					   alertInfo = zkAlert.split(":");

					   if (alertInfo.length == 2){

					   alert_flag = true;

					     dInfo = dInfo + "<br> " + alertInfo[1];

					   }

			      }

	 

				  if(k==0){

					 lastLocTimestamp = utctimestamp;

					 lastLocIndex = index;

				     alert_flag_for_latest_location = alert_flag;		

				     if (alert_flag)

				       lastPinAlertIcon = alertInfo[0];			                              

				  }

	               var course1 = course;
	               if (course1 == 'null'){
	                  course1 = 360; 
	               }
	               if (speed <= 2){
	                  course1 = 360;
	               }
				  
				  if (k != 0){ 

					 if (k == itemList.length -1){

					   //map.DeletePushpin(index);

					   //map.removeOverlay(lastMarker_g);
					   lastMarker_g.setMap(null);
					   lastMarker_g = null;
					 }        

                     var point = new H.geo.Point(lat, lon); //LatLng(lat, lon);

				     var marker;

				     if (alert_flag == false){
				    	 if (course1 == 360){
					    	 var idx1 = "arrow_360";
				    		 marker = createInfoMarker2(ui, point, dInfo, index, "adarrow/" + idx1 + ".gif");
				    	 }else{
					    	 var idx1 = "arrow_"+course1;
					    	 marker = createInfoMarker1(ui, point, dInfo, index, "adarrow/" + idx1 + ".gif"); ;
				    	 }
				       //marker = createInfoMarker(point, dInfo, index, null);
				     }else

				    	 marker = createInfoMarker(ui,point, dInfo, index, alertInfo[0]);				         				 
                     					 
				     group.addObject(marker);
					 j++;

				  }

			 

		 

				 if (k == 0){

		          var point = new H.geo.Point(lat, lon);

		          global_googlepoint = new H.geo.Point(lat, lon);

		          last_dInfo = dInfo;

				  last_index = index;		          

		          //map.setCenter(point, 12);

				     //var marker = createLastLocInfoMarker(point, dInfo, index);					 

				     //map.addOverlay(marker);   

				     

				  j++;    

				 }

				  

			 //}

		  }

		}

	   }

	   }

	    //var marker_last = createLastLocInfoMarker(global_googlepoint, last_dInfo, last_index);

	   var marker_last;

	   if (alert_flag_for_latest_location == false)

		   marker_last = createLastLocInfoMarker(global_googlepoint, last_dInfo, last_index, null);
	   else
		   marker_last = createLastLocInfoMarker(global_googlepoint, last_dInfo, last_index, lastPinAlertIcon);	

	    group.addObject(marker_last);

	    lastMarker_g = marker_last;					 

	    map.setViewBounds(group.getBounds());
   viewOptionsUpdateXML();   

   //changeDisplayInfo();

   if (deviceInfoSet.length != 0){

          changeDisplayInfoXML();

          displayDeviceSummaryInfoXML();

   }

   }

	  

		 

	  }

	/////////////////////////////////////////





	

		function popUpWindow(url,name,width,height,left,top,status,scrollbars)

		{

		if((left == null)||(top == null)||(status == null)||(scrollbars == null)){

			var left = 130

			var top = 1

			var status = "no"

			var scrollbars = "no";

		}

		var var_popWindow = window.open(url,name,"menubar=no,toolbar=no,location=no,directories=0,"

			+ "status=" + status + ",titlebar=no,"

			+ "width=" + width + ",height=" + height + ","

			+ "scrollbars=" + scrollbars + ",resizable=no,copyhistory=0,"

			+ "hotkeys=0,screenx=0,screeny=0,left=" + left + ",top=" + top);

			var_popWindow.focus();

		}

	

	  function changeDisplayInfoForm2(){

		  

		  var righttable = document.getElementById("tablep");

          var righttableChild = righttable.childNodes;

                  if (righttable.hasChildNodes()){

                     while ( righttable.childNodes.length >=1){

                       righttable.removeChild(righttable.firstChild);

                     }

                  }

		  var righttablebody = document.createElement("tbody");

	

		  var user;

		  var dNickname;

		  var dId;

		  var deviceID;
		  var accountStatus;
		  deviceID = global_deviceId;

  ////////////////////////////////////////////////

       if(deviceInfoSet.length != 0){

           var righttable_row = document.createElement("tr");

            

            //righttable_row.style.backgroundColor = "#333333";

             righttable_row.style.fontWeight="bold";

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            righttable_column.align = "center";

            righttable_column.className = "subtitle";

            var text= document.createTextNode("Tracker List:");

            //righttable_column.appendChild(text);

            //righttable_row.appendChild(righttable_column);

            //righttablebody.appendChild(righttable_row); 

  ///////////////////////////////////////////////          

      var righttable_row = document.createElement("tr");

      var righttable_column = document.createElement("td");

      var righttable_div = document.createElement("div");
      //righttable_div.className = "devinfo";
      righttable_div.className = "decontents";
      righttable_div.style.overflow = "auto";
      righttable_div.style.height = "90px";

      <s:iterator value="deviceList" status="aa">
      accountStatus = "<s:property value='accountStatus'/>";

            user = "<s:property value='user'/>";  

            dNickname = "<s:property value='deviceNickname'/>";

            dId =  "<s:property value='deviceId'/>";

            commuAge =  "<s:property value='deviceId'/>";//lastKnownLocationAgoValue

            pLevel =  "<s:property value='lastBatteryLevel'/>"; //13

				var righttable_span = document.createElement("span");
				//if(accountStatus == "INACTIVE"){
				//	righttable_span.style.backgroundColor = "#848482";
				//}

				if (global_deviceId == dId){

				    righttable_span.style.backgroundColor = "#000000";

				}

				

			    var browser = navigator.appName;

                if (browser == "Microsoft Internate Explorer"){

                   righttable_span.style.cursor = "hand";

                }else{

				  righttable_span.style.cursor = "pointer";

				}

				

            var fromDeviceList = true;

            righttable_span.onclick = new Function("evt", "getDeviceLocinfo1("+dId+","+fromDeviceList+");");

            var str_span = dNickname+":"; // + commuAge;         
			if(accountStatus == "INACTIVE"){
				righttable_span.style.color = "#C36241";
			}

            var text_span= document.createTextNode(str_span);

            righttable_span.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "devinfo";

            var str_subspan =  commuAge;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);

            

            righttable_span.appendChild(righttable_subspan);

            righttable_div.appendChild(righttable_span);

            var righttable_br = document.createElement("br");

            righttable_div.appendChild(righttable_br);

        </s:iterator>

        righttable_column.appendChild(righttable_div);

        righttable_row.appendChild(righttable_column);

        righttablebody.appendChild(righttable_row);

        righttable.appendChild(righttablebody); 

        }  

	  }



	 function displayDeviceSummaryInfoForm(){

		  //alert("displayDeviceSummaryInfoForm");

		  var righttable = document.getElementById("tableAS");

          var righttableChild = righttable.childNodes;

                  if (righttable.hasChildNodes()){

                     while ( righttable.childNodes.length >=1){

                       righttable.removeChild(righttable.firstChild);

                     }

                 }

		  //var righttablebody = document.createElement("tbody");

		  var user;

		  var dNickname;

		  var dId;

		  var deviceID;

					 deviceID = global_deviceId;

  ////////////////////////////////////////////////

           //var righttable_row = document.createElement("tr");

            

            ////righttable_row.style.backgroundColor = "#333333";

             //righttable_row.style.fontWeight="bold";

            //var righttable_column = document.createElement("td");

            //righttable_column.noWrap=true;

           // righttable_column.align = "center";

            //righttable_column.className = "subtitle";

            //var text= document.createTextNode("Activity Summary:");

            /////righttable_column.appendChild(text);

            ////righttable_row.appendChild(righttable_column);

            ////righttablebody.appendChild(righttable_row); 

  ///////////////////////////////////////////////          

      //var righttable_row = document.createElement("tr");

      //var righttable_column = document.createElement("td");

      //var righttable_div = document.createElement("div");

      //righttable_div.className = "decontents";

      //righttable_div.style.height = "110px";

      <s:iterator value="deviceList" status="aa">

            user = "<s:property value='user'/>";  

            dNickname = "<s:property value='deviceNickname'/>";

            dId =  "<s:property value='deviceId'/>";

            var last_reception =  "<s:property value='lastKnownGpsStatus'/>";
            

            commuAge =  "<s:property value='deviceId'/>";//lastKnownLocationAgoValue

            pLevel =  "<s:property value='lastBatteryLevel'/>"; //13

            lastLocationOn =  "<s:property value='lastLocationOn'/>"; //13            

            maxSpeed = "<s:property value='maxSpeed'/>"; 

            totalDistance = "<s:property value='totalDistance'/>";

            totalIntransit =  "<s:property value='totalIntransit'/>";

            totalLocationRecords =  "<s:property value='totalLocationRecords'/>";//lastKnownLocationAgoValue

            totalStop =  "<s:property value='totalStops'/>"; //13

            if (pLevel.length == 0)
            	pLevel = "n/a% ";
		    if (pLevel == "%")
		    	pLevel = "n/a% ";
            
            if (pLevel.indexOf("%") == -1){
          	  pLevel = pLevel + "% ";
            }  

            pLevel = pLevel + " " + lastLocationOn;
            last_reception = last_reception + " " + lastLocationOn;

           if (global_deviceId == dId){

            //var righttable_row = document.createElement("tr");

				//if (deviceID == dId){

				

			var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Captured Locates of Day: "; // + totalLocationRecords;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";

            var str_subspan =  totalLocationRecords;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);

                        

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            //var righttable_span = document.createElement("span");

			////righttable_span.className = "devinfo";				            

            //var str_span = "No. of Stops: "; //+ totalStop;         

            //var text_span= document.createTextNode(str_span);

            //righttable_span.appendChild(text_span);

            

            //var righttable_subspan = document.createElement("span");

            //righttable_subspan.className = "devinfo";

            //var str_subspan =  totalStop;

            //var text_subspan= document.createTextNode(str_subspan);

            //righttable_subspan.appendChild(text_subspan);            

            //righttable_span.appendChild(righttable_subspan);

                        

            righttable.appendChild(righttable_li);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Approx Travel of Day: "; //+ totalDistance;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";

            var str_subspan =  totalDistance;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);

                        

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            //var righttable_span = document.createElement("span");

			////righttable_span.className = "devinfo";				            

            //var str_span = "No. of Movements: "; //+ totalIntransit;         

            //var text_span= document.createTextNode(str_span);

            //righttable_span.appendChild(text_span);

            

            //var righttable_subspan = document.createElement("span");

            //righttable_subspan.className = "devinfo";

            //var str_subspan =  totalIntransit;

            //var text_subspan= document.createTextNode(str_subspan);

            //righttable_subspan.appendChild(text_subspan);            

            //righttable_span.appendChild(righttable_subspan);

            righttable.appendChild(righttable_li); 

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Top Speed of Day: "; // + maxSpeed;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";


            var str_subspan =  maxSpeed;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);
            righttable.appendChild(righttable_li);
            

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            //var righttable_span = document.createElement("span");

			////righttable_span.className = "devinfo";				            

            //var str_span = "Last Heard: "; //+ lastLocationOn;         

            //var text_span= document.createTextNode(str_span);

            //righttable_span.appendChild(text_span);

            //var righttable_subspan = document.createElement("span");

            //righttable_subspan.className = "devinfo";

            //var str_subspan =  lastLocationOn;

            //var text_subspan= document.createTextNode(str_subspan);

            //righttable_subspan.appendChild(text_subspan);            

            //righttable_span.appendChild(righttable_subspan);

            
            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Last Reception of Day: ";// + pLevel;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";

            var str_subspan =  last_reception;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);
            righttable.appendChild(righttable_li);
            
            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Last Battery of Day: ";// + pLevel;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            var righttable_subspan = document.createElement("span");
            var str1 = pLevel.split('%');
            if (!isNaN(str1[0])){
                if (str1[0] <= 10 && str1[0] >= 6 )
                	righttable_subspan.style.color =  "yellow";
                  else if (str1[0] <= 5)
                	  righttable_subspan.style.color =  "red";
                  else  
                	  righttable_subspan.className = "content-text";
            }else{
                  righttable_subspan.className = "content-text";
		    }

            if (pLevel.length == 0)
            	pLevel = "n/a% ";
		    if (pLevel == "%")
		    	pLevel = "n/a% ";
		    
            if (pLevel.indexOf("%") == -1){
          	  pLevel = pLevel + "% ";
            }  
	    
            var str_subspan =  pLevel;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);

            

            righttable.appendChild(righttable_li);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

          }  



        </s:iterator>   

        //righttable_column.appendChild(righttable_div);

        //righttable_row.appendChild(righttable_column);

        //righttablebody.appendChild(righttable_row);

        //righttable.appendChild(righttablebody);

        

	  }



	 function viewOptionsUpdateMainForm(){

		if (newDocument){

			//var vps = "<s:property value='user'/>"newDocument.getElementsByTagName("viewOptions")[0];

			var dataDaysString = "<s:property value='viewOptions.dataDays'/>"; // vps.getElementsByTagName("dataDays")[0].childNodes[0].nodeValue;

			dateSelected = "<s:property value='viewOptions.weekDayDisplayed'/>"; //vps.getElementsByTagName("weekDayDisplayed")[0].childNodes[0].nodeValue;

			var subEvent = "<s:property value='viewOptions.subEvent'/>"; //newDocument.getElementsByTagName("subEvent")[0].childNodes[0].nodeValue;

			if (dataDaysString != null && dateSelected != null)

			{	

				if (window._dynarch_popupCalendar != null && subEvent != "update" && dateSelected != "null" && dateSelected != null)

				{

						window._dynarch_popupCalendar.parseDate(dateSelected);

						window._dynarch_popupCalendar.refresh();

				}

				eval(dataDaysString);//for special day only	//parse date to get the right month first

			    if (window._dynarch_popupCalendar != null && subEvent != "update" && dateSelected != "null" && dateSelected != null)

				{

						window._dynarch_popupCalendar.parseDate(dateSelected);

						window._dynarch_popupCalendar.refresh();

				}

			  			

			}

			if (dateSelected == "null" || dateSelected == null )

				{

					if (subEvent != "update")

					//document.getElementById("show_e").innerHTML="No Data Available";
					//12-22-2011 WeiMeng: grant color.
					document.getElementById("show_e").innerHTML='<span style="color:#FFFF00">No Data Available!</span>';

				}

				else{

					var tmp = dateSelected.split("/");

					var dateFormat = "";

					if (!isNaN(tmp[1])){

						if (tmp[1] == 1)

							dateFormat = "Jan ";

						if (tmp[1] == 2)

							dateFormat = "Feb ";

						if (tmp[1] == 3)

							dateFormat = "Mar ";

						if (tmp[1] == 4)

							dateFormat = "Apr ";

						if (tmp[1] == 5)

							dateFormat = "May ";

						if (tmp[1] == 6)

							dateFormat = "Jun ";

						if (tmp[1] == 7)

							dateFormat = "Jul ";

						if (tmp[1] == 8)

							dateFormat = "Aug ";

						if (tmp[1] == 9)

							dateFormat = "Sep ";

						if (tmp[1] == 10)

							dateFormat = "Oct ";

						if (tmp[1] == 11)

							dateFormat = "Nov ";

						if (tmp[1] == 12)

							dateFormat = "Dec ";

					}

					dateFormat = dateFormat + tmp[2] + ", "+ tmp[0];

					//alert(dateSelected +";" + dateFormat);

					document.getElementById("show_e").innerHTML=dateFormat;

					//document.getElementById("show_e").innerHTML=dateSelected;

				}
		}

	  }

		
	 var group;
	 var ui;
	 var behavior;
		function initOnLoad(){  
			bingmapLocationsArray.length = 0;
			var platform = new H.service.Platform({
				app_id: '<%=heremapid%>',
				app_code: '<%=heremapcode%>',
				useCIT: false
				});
            var defaultLayers = platform.createDefaultLayers();
            platform.configure(H.map.render.panorama.RenderEngine);
            map = new H.Map(document.getElementById("myMap"), defaultLayers.normal.map);
            behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

            ui = H.ui.UI.createDefault(map, defaultLayers);
            var mapSettings = ui.getControl('mapsettings');
            var zoom = ui.getControl('zoom');
            var scalebar = ui.getControl('scalebar');
            var panorama = ui.getControl('panorama');
            panorama.setAlignment('top-left');
            mapSettings.setAlignment('top-left');
            zoom.setAlignment('top-left');
            scalebar.setAlignment('top-left');
                        
            var greyPlaneBitmap;
            group = new H.map.Group();
             map.addObject(group);

		 customIcon = icon();

		var alert_flag_for_latest_location  = false;

		var alertInfo;

		var lastPinAlertIcon;

		

		//ShowProgressBar();

		//retrieveXML("%{livemaplink}",this);

		var dataTime_1;var lon_1;var lat_1;var speed_1;var speedUnit_1;

		var age_1; var address_1;

		var user;var dNickName;var dId;

		 <s:iterator value="deviceList" status="rr">

		   <s:if test="#rr.index == 0">  

				user = "<s:property value='user'/>"; 

				dNickname = "<s:property value='deviceNickname'/>"; 

				dId =  "<s:property value='deviceId'/>";

				global_deviceId = dId;

				//alert("initOnLoad dId = " + dId);

                if(user)

                document.getElementById("userName").innerHTML =  user;

				//if(dNickname)

				  //document.getElementById("Label2").value =  dNickname;

				  

			<s:iterator value="locationList" status="rr1">

			  <s:if test="#rr1.index == 0">

				dataTime_1='<s:property value="dateTime"/>';

				lon_1='<s:property value="longitude"/>';

				lat_1='<s:property value="latitude"/>';

				speed_1='<s:property value="speed"/>' ;

				speedUnit_1='<s:property value="speedUnit"/>';

				age_1='<s:property value="locationAge"/>';

				address_1='<s:property value="address1"/> <s:property value="city"/> <s:property value="state"/> <s:property value="zipCode"/>';

	            var dInfo = "Name:"+ dNickname+ "; Age:" + age_1 + "; Speed:" + speed_1;

			  </s:if>

			</s:iterator>

		   </s:if>

		 </s:iterator>       

		var timestamp;var lon;var lat;var speed;var speedUnit;

		var age; var address; var index; var course; var address1; var address2;

		var addressId; var addressString; var city; var county; var dateTime;  var deviceid; var deviceNickname;

		var timestamp; var duration; var landMarkDescriptions; var landMarkName; var landmarkId; 

		var locationAge;  var speed; var speedUnit;  var state; var timeSinceLastRepor; var utctimestamp; var zipCod; var zkAlert;

		//locationHistoryListDOMObj = document.createElement("locationList"); 
// Creates a collection to store multiple pins
    //var pins = new Microsoft.Maps.EntityCollection();
		var k = 0;

			<s:iterator value="locationList" status="rr3">

				address1 = '<s:property value="address1"/>';

				address2 = '<s:property value="address2"/>';

				addressId = '<s:property value="addressId"/>';

				addressString = '<s:property value="addressString"/>';

				city = '<s:property value="city"/>';

				county = '<s:property value="county"/>';

				course = '<s:property value="course"/>';;             

				dateTime='<s:property value="dateTime"/>';

				dNickname ='<s:property value="deviceNickname"/>';

				deviceid='<s:property value="deviceid"/>';

				if (!dId){

				  dId = deviceid;

				  global_deviceId = dId;

				}

				   

				timestamp='<s:property value="dateTime"/>';  //displaytime

				duration='<s:property value="duration"/>';

				index = '<s:property value="index"/>';

				landMarkDescriptions = '<s:property value="landMarkDescriptions"/>';

				landMarkName = '<s:property value="landMarkName"/>';

				landmarkId = '<s:property value="landmarkId"/>';

				lat='<s:property value="latitude"/>';

				locationAge = '<s:property value="locationAge"/>';            

				lon='<s:property value="longitude"/>';

				speed='<s:property value="speed"/>'; 

				speedUnit='<s:property value="speedUnit"/>';

				state = '<s:property value="state"/>';

				timeSinceLastReport = '<s:property value="timeSinceLastReport"/>';

				utctimestamp = '<s:property value="timestamp"/>';

				zipCode = '<s:property value="zipCode"/>';

	            zkAlert = '<s:property value="zkAlert"/>';

		        address = "";

				  if (address1 != 'null' && address1 != '')

				    address = address1;

				  if (city != 'null' && city != '')

				    address = address +", "+city;

				  if (state != 'null' && state != '')

				    address = address +", "+state;

				  if (zipCode != 'null' && zipCode != '')

				    address = address +" " + zipCode;

				    

			      var dInfo =  index + ": " + timestamp + "<br>" + address;

                  var alert_flag = false;

                  if ( zkAlert == 'null'){ 

                    ;

                  }else{

					   alertInfo = zkAlert.split(":");

					   if (alertInfo.length == 2){

					   alert_flag = true;

					     dInfo = dInfo + "<br> " + alertInfo[1];

					   }

			      }

				

				///////////////////////////////////////////    

				///////////////////////////////////////////            
               // bounds.extend(new google.maps.LatLng(parseFloat(lat), parseFloat(lon)));
               bingmapLocationsArray.push(new H.geo.Point(parseFloat(lat), parseFloat(lon)));
				<s:if test="#rr3.index == 0">
                  alert_flag_for_latest_location = alert_flag;
                  if (alert_flag){
                    lastPinAlertIcon = alertInfo[0];
                  }

                  	 //var point2 = new google.maps.LatLng(parseFloat(lat), parseFloat(lon));
                  	var point2 = new H.geo.Point(parseFloat(lat), parseFloat(lon));
				     global_googlepoint = new H.geo.Point(parseFloat(lat), parseFloat(lon));
				     last_dInfo = dInfo;
				     last_index = index;				     
				     //map.setCenter(point2, 13);
				     //map.setView({center:point2});
				     //map.set('center', point2);
				     map.setCenter(point2);
				  lastLocTimestamp = utctimestamp;
				  lastLocIndex = index;
				</s:if>

	               var course1 = course;
	               if (course1 == 'null'){
	                  course1 = 360; 
	               }
	               if (speed <= 2){
	                  course1 = 360;
	               }
				<s:if test="#rr3.index != 0">

					 //var point1 = new google.maps.LatLng(parseFloat(lat), parseFloat(lon));
					 var point1 = new H.geo.Point(parseFloat(lat), parseFloat(lon));
				     var marker;

				     if (alert_flag == false){
				    	 if (course1 == 360){
					    	 var idx1 = "arrow_360";
				    		 //marker = createInfoMarker2(point1, dInfo, index, "adarrow/" + idx1 + ".gif");
				    		 marker = createInfoMarker2(ui,point1, dInfo, index, "adarrow/" + idx1 + ".gif");
				    		 //var pushpinOptions = {icon: virtualPath + '/Content/SpaceNeedle.jpg', width: 30, height: 50};
				    		 //var pushpin= new Microsoft.Maps.Pushpin(point1, pushpinOptions);
				    	 }else{
					    	 var idx1 = "arrow_"+course1;
					    	 marker = createInfoMarker1(ui, point1, dInfo, index, "adarrow/" + idx1 + ".gif"); 
				    	 }
				       //marker = createInfoMarker(point1, dInfo, index, null);

				     }else
				    	 marker = createInfoMarker(ui, point1, dInfo, index, alertInfo[0]);				         				 
				     group.addObject(marker);
				</s:if>

			  j++; 

			  k++; 

			</s:iterator>

	      var marker_last;

	      if (alert_flag_for_latest_location == false){
	        marker_last = createLastLocInfoMarker(ui, global_googlepoint, last_dInfo, last_index, null);
	      }else{
	        marker_last = createLastLocInfoMarker(ui, global_googlepoint, last_dInfo, last_index, lastPinAlertIcon);
	      }
	      group.addObject(marker_last);
	      map.setViewBounds(group.getBounds());
		   changeDisplayInfoForm();

		   viewOptionsUpdateMainForm();

		   displayDeviceSummaryInfoForm();

				//if(!locationHistoryListDOMObj){

		               //getDeviceLocinfo1(dId, true);//display loading message

				//}

		

		}

		



	  function retrieveDataViaCalendar(did){

	 

		   if (selectType == 3){

			   //alert("selectType = " + selectType);

			   document.forms[0].selectType.selectedIndex = 0;

			   document.forms[0].selectType.options[document.forms[0].selectType.selectedIndex].selected = true;

			   selectType = 1;

			   //alert("selectType = " + selectType);

		  }

	

			var date = new Date().getTime();

		//alert(" retrieveDeviceLoc(did) selectType = " + selectType);

		 if (selectType == 2){ //retrieve all loc of one device

		 var url;

		 if (d == null) //user clicked on month and year only

			 url = "dd.action?page=locateRealtimeDetails&deviceId="+did+"&viewOptions.mapAll=12&viewOptions.returnCode=xml&d="+date+"&viewOptions.timeStamp="+y+":"+m; 

		 else

			 url = "dd.action?page=locateRealtimeDetails&deviceId="+did+"&viewOptions.mapAll=12&viewOptions.returnCode=xml&d="+date+"&viewOptions.timeStamp="+y+":"+m+":"+d;    

		 }else if (selectType == 1){//retrieve 5 loc of one device

			 url = "dd.action?page=locateRealtimeDetails&deviceId="+did+"&viewOptions.mapAll=15&viewOptions.returnCode=xml&d="+date;

		 }   

		//alert("url = " + url);

		//Do the Ajax call

	 

		if (window.XMLHttpRequest) { // Non-IE browsers

		  try{

			 req = new XMLHttpRequest();

		  } catch (e) {

			req = new ActiveXObject("Msxml2.XMLHTTP");

			//alert("Internet connection interrupted:\n"+e);

		  }  

		  try{    

		  req.onreadystatechange = processResponseRetrieveDeviceDataXML;

		  

			//alert("in XMLHttpRequest Object");

			req.open("POST", url, true); //was get

			req.setRequestHeader('Pragma', 'no-cache');

			req.setRequestHeader('Expires', '-1');

			

			req.send(null);

			} catch (e) {

			 alert("Internet connection interrupted:\n"+e);

			}

		  //req.send(null);

		} else if (window.ActiveXObject) { // IE

		  

		  req = new ActiveXObject("Microsoft.XMLHTTP");

		  if (req) {

			//alert("in window ActiveXObject");

			req.onreadystatechange = processResponseRetrieveDeviceDataXML;

			req.open("POST", url, true);

			req.send();

		  }

		}    

	  }

		 

		

	 function retrieveDeviceLoc(did){

	 

		   if (selectType == 3){

			   //alert("selectType = " + selectType);

			   document.forms[0].selectType.selectedIndex = 0;

			   document.forms[0].selectType.options[document.forms[0].selectType.selectedIndex].selected = true;			   

			   //document.forms[0].selectType[1].checked = true;

			   selectType = 1;

			   //alert("selectType = " + selectType);

		  }

	

			var date = new Date().getTime();

		//alert(" retrieveDeviceLoc(did) selectType = " + selectType);

		 if (selectType == 2){ //retrieve all loc of one device

			 var url = "dd.action?page=locateRealtimeDetails&deviceId="+did+"&viewOptions.mapAll=12&viewOptions.returnCode=xml&d="+date;
		 }else if (selectType == 1){//retrieve 5 loc of one device

			 var url = "dd.action?page=locateRealtimeDetails&deviceId="+did+"&viewOptions.mapAll=15&viewOptions.returnCode=xml&d="+date;
		 }   

		//alert("retrieveDeviceLoc url = " + url);

		//Do the Ajax call

	 

		if (window.XMLHttpRequest) { // Non-IE browsers

		  try{

			 req = new XMLHttpRequest();

		  } catch (e) {

			req = new ActiveXObject("Msxml2.XMLHTTP");

			//alert("Internet connection interrupted\n"+e);

		  }  

		  try{    

		  req.onreadystatechange = processResponseRetrieveDeviceDataXML;

		  

			//alert("in XMLHttpRequest Object");

			req.open("POST", url, true); //was get

			req.setRequestHeader('Pragma', 'no-cache');

			req.setRequestHeader('Expires', '-1');

			

			req.send(null);

			} catch (e) {

			 alert("Internet connection interrupted\n"+e);

			}

		  //req.send(null);

		} else if (window.ActiveXObject) { // IE

		  

		  req = new ActiveXObject("Microsoft.XMLHTTP");

		  if (req) {

			//alert("in window ActiveXObject");

			req.onreadystatechange = processResponseRetrieveDeviceDataXML;

			req.open("POST", url, true);

			req.send();

		  }

		}    

	  }

	  	  

	  function isSessionExpire(){

         var event = newDocument.getElementsByTagName("event");

         var eventtext = event[0].childNodes[0].nodeValue;	

         //alert(eventtext);

         if ( eventtext == 'login')

            return true;

         else

            return false;   	  

	  }

	

	  function processResponseRetrieveDeviceDataXML() {

	     // HideProgressBar();

		  if (req.readyState == 4) { // Complete

		  //try{

		  if (req.status == 200) { // OK response

			newDocument=req.responseXML;
            if (!newDocument){
            	fromDeviceList = false;
            	//document.getElementById("show_e").innerHTML="Device is out of service!";
            	//12-22-2011 weiMeng: grant color.
            	document.getElementById("show_e").innerHTML='<span style="color:#FF0000">Out of Service!</span>';
            	return false;
            }
                
			if(isSessionExpire()){

			  alert("Session expired due to user inactivity over 60 minutes. Please login again.\n ");

			  returnToLoginPage();

			}

			if (selectType == 1){

			  viewOptionsUpdateXML();

			  deviceLocInfo5Loc();

			}else if (selectType == 2){

				viewOptionsUpdateXML();

			  deviceLocInfoAllLoc();

			}

			//OnLoadDeviceLocInfo();

			haveNewLocation++;

		  } else {

			alert("Internet connection interrupted:\n " + req.statusText);

			returnToLoginPage();

		  }

		  //}catch(e){

		//	alert("Problem with internet connection:\n " + e);

		//	returnToLoginPage();		  

		//  }

		}

		

	  }

	  

	  

	  function getDeviceLocinfo(){

				var listBox = document.getElementById("Listbox3");

				//var subListBox = document.getElementById("lstOtherStuff");

				//subListBox.options.length=0;

				for(i=0; i<listBox.length; i++) {

					if( listBox.options[i].selected ) {

						var key = listBox.options[i].value;

						//alert("key = " + key);

						retrieveDeviceLoc(key);					

					}

				}

	  

	  }

	  

		function getDeviceLocinfo1(key, fromDeviceList){

			//alert("deviceID = " + key);

			if (fromDeviceList) //display loadiging message

				//document.getElementById("show_e").innerHTML="Loading..."; 
				//12-22-2011 WeiMeng: grant color and font.
				document.getElementById("show_e").innerHTML='<span style="font-size:15px;color:#FF0000">Loading...</span>';

			locationHistoryListDOMObj = null;

			//HideIntervalWindow();

			//HidePollingWindow();

            //HideGeofenceWindow();			

			global_deviceId = key;

			retrieveDeviceLoc(key);	

			//return false;				

	  }

	  

	  function processResponseDeviceDataXMLWithSelectType() {

	      // HideProgressBar();

		  if (req.readyState == 4) { // Complete

		  //try{		  

		  if (req.status == 200) { // OK response

			//xmlDoc=req.responseXML.documentElement;

			//xmlDoc=req.responseText;

			newDocument=req.responseXML;

			if(isSessionExpire()){

			  alert("Session expired due to user inactivity over 60 minutes. Please login again.\n ");

			  returnToLoginPage();

			}

			

			//alert("xmlDoc =" +xmlDoc);

			//newDocument = processor.transformToDocument(xmlDoc);

			//alert("newDocument =" +newDocument);

			//alert("processResponseDeviceDataXMLWithSelectType() selectType = " + selectType);

			if (selectType == 1)

			   deviceLocInfo5Loc();

			if (selectType == 2)

			   deviceLocInfoAllLoc();

			if (selectType == 3)

			   allDeviceCurrentLoc();

	   

			//OnLoadDeviceLocInfo();

			haveNewLocation++;

		  } else {

			alert("Internet connection interrupted:\n " + req.statusText);

			returnToLoginPage();

		  }

		//}catch(e){

		//	alert("Internet connection interrupted:\n " + e);

		//	returnToLoginPage();		  

		//  }

	   }

	  }

	  

	  function deviceLocInfo5Loc(){

	  //alert("go deviceLocInfo5Loc()");
bingmapLocationsArray = [];
	     var last_dInfo;

	     var last_index;

		 j=0;

		 haveNewLocation = 0;

		 //map = new GMap2(document.getElementById("myMap")); 

         //map.addControl(new GMapTypeControl());

         //map.addControl(new GLargeMapControl()); 

		 

		 //GetMap2();

	   if (newDocument){

		  var deviceList = newDocument.getElementsByTagName("deviceList");

		  //alert("deviceList.length = "+ deviceList.length);

		  var deviceInfoSet = deviceList[0].childNodes;

		  var user;

		  var dNickname;

		  var dId;

		  var deviceID;

	      var items11 = newDocument.getElementsByTagName("locationList");

		  //deviceID = deviceLocInfoList[8].childNodes[0].nodeValue;

		  for(var ii=0; ii<deviceInfoSet.length; ii++){

			 var deviceInfo = deviceInfoSet[ii].childNodes;

			 user = deviceInfo[22].childNodes[0].nodeValue;

			 dId = deviceInfo[4].childNodes[0].nodeValue;

			   if (global_deviceId == dId){

			      dNickname = deviceInfo[6].childNodes[0].nodeValue;			   

				  break;

			   }

		  }
			//var bounds = new google.maps.LatLngBounds(); 

		  //alert("dNickname = " + dNickname);

    	 var items1 = newDocument.getElementsByTagName("locationList");

	   //alert("items1.length = "+ items1.length+ " and nodeTypa = " + items1.nodeType);

	   var childNodes = items1[0].childNodes;

	   //alert("childNodes.length = "+ childNodes.length); 

	   if(childNodes.length > 0){

		 //map = new GMap2(document.getElementById("myMap")); 

         //map.addControl(new GMapTypeControl());

         //map.addControl(new GLargeMapControl()); 
         //var myLatlng = new google.maps.LatLng(37.379311,-121.941095);
         if (!map){
 			var platform = new H.service.Platform({
 				app_id: '<%=heremapid%>',
 				app_code: '<%=heremapcode%>',
				useCIT: false
				});
            var defaultLayers = platform.createDefaultLayers();
            platform.configure(H.map.render.panorama.RenderEngine);
            map = new H.Map(document.getElementById("myMap"), defaultLayers.normal.map);
            behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

            ui = H.ui.UI.createDefault(map, defaultLayers);
            var mapSettings = ui.getControl('mapsettings');
            var zoom = ui.getControl('zoom');
            var scalebar = ui.getControl('scalebar');
            var panorama = ui.getControl('panorama');
            panorama.setAlignment('top-left');
            mapSettings.setAlignment('top-left');
            zoom.setAlignment('top-left');
            scalebar.setAlignment('top-left');
                        
            var greyPlaneBitmap;
            group = new H.map.Group();
             map.addObject(group);
         }else{
        	 map.removeObject(group);
             group = new H.map.Group();
             map.addObject(group);
             if (!ui){
             ui = H.ui.UI.createDefault(map, defaultLayers);
             var mapSettings = ui.getControl('mapsettings');
             var zoom = ui.getControl('zoom');
             var scalebar = ui.getControl('scalebar');
             var panorama = ui.getControl('panorama');
             panorama.setAlignment('top-left');
             mapSettings.setAlignment('top-left');
             zoom.setAlignment('top-left');
             scalebar.setAlignment('top-left');
             }
         }

		 customIcon = icon();

		var alert_flag_for_latest_location  = false;

		var alertInfo;

        var lastPinAlertIcon;

		 

	    for(var i=0; i < items1.length; i++){

		 //alert("items1[i].nodeName = "+items1[i].nodeName+ " and nodeTypa = " + items1[i].nodeType);

		 var itemList = items1[i].childNodes;

		 //alert("itemList.length = "+ itemList.length);

		 for(var k=0; k < itemList.length; k++){ //items

		   var deviceLocInfoList = itemList[k].childNodes;

		   //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);

				  var address1 = deviceLocInfoList[0].childNodes[0].nodeValue;

				  var address2 = deviceLocInfoList[1].childNodes[0].nodeValue;

				  var city = deviceLocInfoList[4].childNodes[0].nodeValue;

				  var country = deviceLocInfoList[5].childNodes[0].nodeValue;

		          var course = deviceLocInfoList[6].childNodes[0].nodeValue;

				  

				  var timestamp = deviceLocInfoList[7].childNodes[0].nodeValue;

				  var duration = deviceLocInfoList[11].childNodes[0].nodeValue;

				  var index = deviceLocInfoList[12].childNodes[0].nodeValue;

				  var landMarkDescriptions = deviceLocInfoList[13].childNodes[0].nodeValue;

				  var landMarkName = deviceLocInfoList[14].childNodes[0].nodeValue;

				  var landmarkId = deviceLocInfoList[15].childNodes[0].nodeValue;

				  var lat = deviceLocInfoList[16].childNodes[0].nodeValue;

				  var locationAge = deviceLocInfoList[17].childNodes[0].nodeValue;

				  var lon = deviceLocInfoList[18].childNodes[0].nodeValue;

				  var speed = deviceLocInfoList[19].childNodes[0].nodeValue;

				  var speedUnit = deviceLocInfoList[20].childNodes[0].nodeValue;

				  var state = deviceLocInfoList[21].childNodes[0].nodeValue;

				  var timeSinceLastReport = deviceLocInfoList[22].childNodes[0].nodeValue;

				  var utctimestamp = deviceLocInfoList[23].childNodes[0].nodeValue;

				  var zipCode = deviceLocInfoList[24].childNodes[0].nodeValue;

				  var zkAlert = deviceLocInfoList[25].childNodes[0].nodeValue;

				  //var address = address1+","+city+","+state+" " + zipCode;

				  var address = "";

				  if (address1 != "null")

				    address = address1;

				  if (city != "null")

				    address = address +", "+city;

				  if (state != "null")

				    address = address +", "+state;

				  if (zipCode != "null")

				    address = address +" " + zipCode;

				  

				  var dInfo =  index + ": " + timestamp + "<br>" + address;

                  var alert_flag = false;

                  if ( zkAlert == 'null'){ 

                    ;

                  }else{

					   alertInfo = zkAlert.split(":");

					   if (alertInfo.length == 2){

					   alert_flag = true;

					     dInfo = dInfo + "<br> " + alertInfo[1];

					   }

			      }

				  if(k==0){

				    alert_flag_for_latest_location = alert_flag;

				    if (alert_flag)

				       lastPinAlertIcon = alertInfo[0];

				  }

	               var course1 = course;
	               if (course1 == 'null'){
	                  course1 = 360; 
	               }
	               if (speed <= 2){
	                  course1 = 360;
	               }
				  
	               //bounds.extend(new google.maps.LatLng(parseFloat(lat), parseFloat(lon)));
	               bingmapLocationsArray.push(new H.geo.Point(parseFloat(lat), parseFloat(lon)));
				  if (k != 0){         

					 var point1 = new H.geo.Point(parseFloat(lat), parseFloat(lon));

				     var marker;

				     if (alert_flag == false){
				    	 if (course1 == 360){
					    	 var idx1 = "arrow_360";
				    		 marker = createInfoMarker2(ui,point1, dInfo, index, "adarrow/" + idx1 + ".gif");
				    	 }else{
					    	 var idx1 = "arrow_"+course1;
					    	 marker = createInfoMarker1(ui,point1, dInfo, index, "adarrow/" + idx1 + ".gif"); ;
				    	 }

				       //marker = createInfoMarker(point1, dInfo, index, null);
				     }else

				    	 marker = createInfoMarker(ui,point1, dInfo, index, alertInfo[0]);				         				 
				     group.addObject(marker);
					 j++;

				  }

			 

		 

				 if (k == 0){

				     //alert("go k = 0 =" + k);

				     var point2 = new H.geo.Point(parseFloat(lat), parseFloat(lon));

				     global_googlepoint = new H.geo.Point(parseFloat(lat), parseFloat(lon));

				     last_dInfo = dInfo;

				     last_index = index;				     

				     //map.setCenter(point2, 13);
				     //map.setView({center:point2});
				     //map.set('center', point2);
				     map.setCenter(point2);
				  j++;    

				 }				  

		  }

	

	   }

	   //alert("alert_flag_for_latest_location = " + alert_flag_for_latest_location);

	   //alert("lastPinAlertIcon = " + lastPinAlertIcon);

	   var marker_last;

	   if (!alert_flag_for_latest_location){

		   marker_last = createLastLocInfoMarker(ui, global_googlepoint, last_dInfo, last_index, null);

	   }else{

		   marker_last = createLastLocInfoMarker(ui, global_googlepoint, last_dInfo, last_index, lastPinAlertIcon);	

	   }
	   group.addObject(marker_last);
	   map.setViewBounds(group.getBounds());
	      viewOptionsUpdateXML();

         changeDisplayInfoXML();

         displayDeviceSummaryInfoXML();

	   }

	   changeDisplayInfoXML();

	   }

	  

		 

	  }

	  



	  

	  function deviceLocInfoAllLoc(){

		//alert("go deviceLocInfoAllLoc()");
bingmapLocationsArray = [];
		var last_dInfo, last_index;

		 j=0;

		 haveNewLocation = 0;
         if (!map){
  			var platform = new H.service.Platform({
  				app_id: '<%=heremapid%>',
  				app_code: '<%=heremapcode%>',
 				useCIT: false
 				});
             var defaultLayers = platform.createDefaultLayers();
             platform.configure(H.map.render.panorama.RenderEngine);
             map = new H.Map(document.getElementById("myMap"), defaultLayers.normal.map);
             behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

             ui = H.ui.UI.createDefault(map, defaultLayers);
             var mapSettings = ui.getControl('mapsettings');
             var zoom = ui.getControl('zoom');
             var scalebar = ui.getControl('scalebar');
             var panorama = ui.getControl('panorama');
             panorama.setAlignment('top-left');
             mapSettings.setAlignment('top-left');
             zoom.setAlignment('top-left');
             scalebar.setAlignment('top-left');
                          
             var greyPlaneBitmap;
             group = new H.map.Group();
              map.addObject(group);
          }else{
         	 map.removeObject(group);
              group = new H.map.Group();
              map.addObject(group);
              if (!ui){
              ui = H.ui.UI.createDefault(map, defaultLayers);
              var mapSettings = ui.getControl('mapsettings');
              var zoom = ui.getControl('zoom');
              var scalebar = ui.getControl('scalebar');
              var panorama = ui.getControl('panorama');
              panorama.setAlignment('top-left');
              mapSettings.setAlignment('top-left');
              zoom.setAlignment('top-left');
              scalebar.setAlignment('top-left'); 
              }             
          }
		 customIcon = icon();

	   if (newDocument){

		  var deviceList = newDocument.getElementsByTagName("deviceList");

		  var deviceInfoSet = deviceList[0].childNodes;

		  var user;

		  var dNickname;

		  var dId;

		  var deviceID;

			   var items11 = newDocument.getElementsByTagName("locationList");

		  var itemList11 = items11[0].childNodes;

		  for(var ii=0; ii<deviceInfoSet.length; ii++){

			 var deviceInfo = deviceInfoSet[ii].childNodes;

			 user = deviceInfo[22].childNodes[0].nodeValue;

			 dId = deviceInfo[4].childNodes[0].nodeValue;

			   if (global_deviceId == dId){

			      dNickname = deviceInfo[6].childNodes[0].nodeValue;			   

				  break;

			   }

		  }

		var alert_flag_for_latest_location  = false;

		var alertInfo;

		var lastPinAlertIcon;

	   var items1 = newDocument.getElementsByTagName("locationList");

	   for(var i=0; i < items1.length; i++){

		 var itemList = items1[i].childNodes;

		 for(var k=0; k < itemList.length; k++){ //items

		   var deviceLocInfoList = itemList[k].childNodes;

		   //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);

				  var address1 = deviceLocInfoList[0].childNodes[0].nodeValue;

				  var address2 = deviceLocInfoList[1].childNodes[0].nodeValue;

				  var city = deviceLocInfoList[4].childNodes[0].nodeValue;

				  var country = deviceLocInfoList[5].childNodes[0].nodeValue;

				  var course = deviceLocInfoList[6].childNodes[0].nodeValue;

				  var timestamp = deviceLocInfoList[7].childNodes[0].nodeValue;

				  var duration = deviceLocInfoList[11].childNodes[0].nodeValue;

				  var index = deviceLocInfoList[12].childNodes[0].nodeValue;

				  var landMarkDescriptions = deviceLocInfoList[13].childNodes[0].nodeValue;

				  var landMarkName = deviceLocInfoList[14].childNodes[0].nodeValue;

				  var landmarkId = deviceLocInfoList[15].childNodes[0].nodeValue;

				  var lat = deviceLocInfoList[16].childNodes[0].nodeValue;

				  var locationAge = deviceLocInfoList[17].childNodes[0].nodeValue;

				  var lon = deviceLocInfoList[18].childNodes[0].nodeValue;

				  var speed = deviceLocInfoList[19].childNodes[0].nodeValue;

				  var speedUnit = deviceLocInfoList[20].childNodes[0].nodeValue;

				  var state = deviceLocInfoList[21].childNodes[0].nodeValue;

				  var timeSinceLastReport = deviceLocInfoList[22].childNodes[0].nodeValue;

				  var utctimestamp = deviceLocInfoList[23].childNodes[0].nodeValue;

				  var zipCode = deviceLocInfoList[24].childNodes[0].nodeValue;

				  var zkAlert = deviceLocInfoList[25].childNodes[0].nodeValue;

				  //var address = address1+","+city+","+state+" " + zipCode;

				  var address = "";

				  if (address1 != "null")

				    address = address1;

				  if (city != "null")

				    address = address +", "+city;

				  if (state != "null")

				    address = address +", "+state;

				  if (zipCode != "null")

				    address = address +" " + zipCode;

				  

                  var dInfo =  index + ": " + timestamp + "<br>" + address;	

                  var alert_flag = false;

                  if ( zkAlert == 'null'){ 

                    ;

                  }else{

					   alertInfo = zkAlert.split(":");

					   if (alertInfo.length == 2){

					   alert_flag = true;

					     dInfo = dInfo + "<br> " + alertInfo[1];

					   }

			      }
                  //bounds.extend(new google.maps.LatLng(parseFloat(lat), parseFloat(lon)));
                  bingmapLocationsArray.push(new H.geo.Point(parseFloat(lat), parseFloat(lon)));
				  if(k==0){

				    alert_flag_for_latest_location = alert_flag;

				    if(alert_flag)

				      lastPinAlertIcon = alertInfo[0];

				  }

	               var course1 = course;
	               if (course1 == 'null'){
	                  course1 = 360; 
	               }
	               if (speed <= 2){
	                  course1 = 360;
	               }
				  
				  if (k != 0){   

				     var point = new H.geo.Point(lat, lon);

				     var marker;

				     if (alert_flag == false){
				    	 if (course1 == 360){
					    	 var idx1 = "arrow_360";
				    		 marker = createInfoMarker2(ui,point, dInfo, index, "adarrow/" + idx1 + ".gif");
				    	 }else{
					    	 var idx1 = "arrow_"+course1;
					    	 marker = createInfoMarker1(ui,point, dInfo, index, "adarrow/" + idx1 + ".gif"); ;
				    	 }

				       //marker = createInfoMarker(point, dInfo, index, null);

				     }else

				    	 marker = createInfoMarker(ui,point, dInfo, index, alertInfo[0]);				         				 
					 j++;
					 group.addObject(marker);
				  }

			 

		 

				 if (k == 0){

				  lastLocTimestamp = utctimestamp;

				  lastLocIndex = index;

				  last_dInfo = dInfo;

				  last_index = index;

				  var point = new H.geo.Point(lat, lon);

				  global_googlepoint = new H.geo.Point(lat, lon);

				  //map.setCenter(point, 12);
				  //map.setView({center:point});
				  //map.set('center', point);
				  map.setCenter(point);
				  //var marker = createLastLocInfoMarker(point, dInfo, index);					 

				  //map.addOverlay(marker);   				  

				  j++;    

				 }

				  

             if (k == 0){

               polypins = "[new H.geo.Point("+lat+","+lon+"),";

             }else{

               if (k == itemList.length -1){

                  polypins = polypins + "new H.geo.Point("+lat+","+lon+")]";

               }else{

                  polypins = polypins + "new H.geo.Point("+lat+","+lon+"),";

               }

               //DrawPoly(index,polypins);

               //k1 = 0; 

              //polypins = "[new VELatLong("+lat+","+lon+"),";            

		  }

	

         //}

      }

	   }

	   var marker_last;

	   if (alert_flag_for_latest_location == false)

		   marker_last = createLastLocInfoMarker(ui,global_googlepoint, last_dInfo, last_index, null);

	   else

		   marker_last = createLastLocInfoMarker(ui,global_googlepoint, last_dInfo, last_index, lastPinAlertIcon);	
	   group.addObject(marker_last);
	   lastMarker_g = marker_last;		 
	    
	   map.setViewBounds(group.getBounds());	   

   viewOptionsUpdateXML();   

   changeDisplayInfoXML();

   displayDeviceSummaryInfoXML();

	   }

	  

		 

	  }

	  

	  

	  function allDeviceCurrentLoc(){

	  //alert("go allDeviceCurrentLoc()");

		   j=0;

		 haveNewLocation = 0;

		 //map= new VEMap('myMap');

		 

		 //GetMap2();

		 if (newDocument){

				 var items2 = newDocument.getElementsByTagName("locationList");

			//alert("items1.length = "+ items1.length+ " and nodeTypa = " + items1.nodeType);

			var lat_f;

			var lon_f;

		   for(var is=0; is < items2.length; is++){

			 //alert("items2[is].nodeName = "+items2[is].nodeName+ " and nodeTypa = " + items2[is].nodeType);

			 var itemList2 = items2[is].childNodes;

			 //alert("itemList2.length = "+ itemList2.length);

			 for(var k2=0; k2 < itemList2.length; k2++){ //items

				  var deviceLocInfoList = itemList2[k2].childNodes;

				  //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);

				  var lat_f = deviceLocInfoList[16].childNodes[0].nodeValue;

				  var lon_f = deviceLocInfoList[18].childNodes[0].nodeValue;

				  //alert("allDeviceCurrentLoc lat_f and lon_f = " + lat_f + " and " + lon_f);              

				  break;

			  }

		  }

		  //alert("allDeviceCurrentLoc lat_f and lon_f = " + lat_f + " and " + lon_f);


	         if (!map){
	  			var platform = new H.service.Platform({
	  				app_id: '<%=heremapid%>',
	  				app_code: '<%=heremapcode%>',
	 				useCIT: false
	 				});
	             var defaultLayers = platform.createDefaultLayers();
	             platform.configure(H.map.render.panorama.RenderEngine);
	             map = new H.Map(document.getElementById("myMap"), defaultLayers.normal.map);
	             behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

	             var ui = H.ui.UI.createDefault(map, defaultLayers);
	             var mapSettings = ui.getControl('mapsettings');
	             var zoom = ui.getControl('zoom');
	             var scalebar = ui.getControl('scalebar');
	             var panorama = ui.getControl('panorama');
	             panorama.setAlignment('top-left');
	             mapSettings.setAlignment('top-left');
	             zoom.setAlignment('top-left');
	             scalebar.setAlignment('top-left');
	             	             
	             var greyPlaneBitmap;
	             group = new H.map.Group();
	              map.addObject(group);
	          }else{
	         	 map.removeObject(group);
	              group = new H.map.Group();
	              map.addObject(group);
	              if (!ui){
	              ui = H.ui.UI.createDefault(map, defaultLayers);
	              var mapSettings = ui.getControl('mapsettings');
	              var zoom = ui.getControl('zoom');
	              var scalebar = ui.getControl('scalebar');
	              var panorama = ui.getControl('panorama');
	              panorama.setAlignment('top-left');
	              mapSettings.setAlignment('top-left');
	              zoom.setAlignment('top-left');
	              scalebar.setAlignment('top-left');
	              }	              
	          }
		 

		   //var xmlString = new XMLSerializer().serializeToString(newDocument);

		  //document.writeln("newDocument.toString() = " + xmlString);

		  var deviceList = newDocument.getElementsByTagName("deviceList");

		  //alert("deviceList.length = "+ deviceList.length);

		  var deviceInfoSet = deviceList[0].childNodes;

		  //alert("deviceInfoSet.length = "+ deviceInfoSet.length);

		  for (var e=0; e < deviceInfoSet.length; e++){

			 var deviceInfo = deviceInfoSet[e].childNodes;

			 var user_d = deviceInfo[22].childNodes[0].nodeValue;

			 var dNickname_d = deviceInfo[6].childNodes[0].nodeValue;

			 var dId_d = deviceInfo[4].childNodes[0].nodeValue; 

			 var index_d =  deviceInfo[7].childNodes[0].nodeValue; 

			 

			 //////////////////////////////////////////

			var items1 = newDocument.getElementsByTagName("locationList");

			//alert("items1.length = "+ items1.length+ " and nodeTypa = " + items1.nodeType);

		   for(var i=0; i < items1.length; i++){

			 //alert("items1[i].nodeName = "+items1[i].nodeName+ " and nodeTypa = " + items1[i].nodeType);

			 var itemList = items1[i].childNodes;

			 //alert("itemList.length = "+ itemList.length);

			 for(var k=0; k < itemList.length; k++){ //items

			   var deviceLocInfoList = itemList[k].childNodes;

						 var index = deviceLocInfoList[11].childNodes[0].nodeValue;

			   if(index == index_d){

			   //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);

				  var address1 = deviceLocInfoList[0].childNodes[0].nodeValue;

				  var address2 = deviceLocInfoList[1].childNodes[0].nodeValue;

				  var city = deviceLocInfoList[4].childNodes[0].nodeValue;

				  var country = deviceLocInfoList[5].childNodes[0].nodeValue;

				  var course = deviceLocInfoList[6].childNodes[0].nodeValue;

				  var timestamp = deviceLocInfoList[7].childNodes[0].nodeValue;

				  var duration = deviceLocInfoList[11].childNodes[0].nodeValue;

				  var landMarkDescriptions = deviceLocInfoList[13].childNodes[0].nodeValue;

				  var landMarkName = deviceLocInfoList[14].childNodes[0].nodeValue;

				  var landmarkId = deviceLocInfoList[15].childNodes[0].nodeValue;

				  var lat = deviceLocInfoList[16].childNodes[0].nodeValue;

				  var locationAge = deviceLocInfoList[17].childNodes[0].nodeValue;

				  var lon = deviceLocInfoList[18].childNodes[0].nodeValue;

				  var speed = deviceLocInfoList[19].childNodes[0].nodeValue;

				  var speedUnit = deviceLocInfoList[20].childNodes[0].nodeValue;

				  var state = deviceLocInfoList[21].childNodes[0].nodeValue;

				  var timeSinceLastReport = deviceLocInfoList[22].childNodes[0].nodeValue;

				  var utctimestamp = deviceLocInfoList[23].childNodes[0].nodeValue;

				  var zipCode = deviceLocInfoList[24].childNodes[0].nodeValue;

				  var address = address1+","+city+","+state+" " + zipCode;

					 //alert("dNickname_d = " + dNickname_d + "," + "index_d = " + index_d + "," + "index = " + index);

					 addPin1(index, lat, lon, 'images/pin.gif', index, dNickname_d+':'+timestamp+'<br>Speed:&nbsp;'+speed+'<br>address:&nbsp;'+address+'<br>Index:&nbsp;'+index);

					 document.getElementById(index).oncontextmenu = function(){myRC(index+'|'+timestamp+'|'+lat+'|'+lon);return false;}

					 document.getElementById(index).onclick = function(){alert(address);return false;}

					 document.getElementById(index).style.backgroundColor='#00FF00';

					 j++;

				 }

				}  

			  } //end of for(var k=0; k < itemList.length; k++)

	

		   }         

		  }

		  var deviceInfo = deviceInfoSet[0].childNodes;

		  //alert("deviceInfo.length = "+ deviceInfo.length);

		  var user;

		  var dNickname;

		  var dId;

		  

		  for(var ii=0; ii<deviceInfo.length; ii++){

			 user = deviceInfo[10].childNodes[0].nodeValue;

			 dNickname = deviceInfo[6].childNodes[0].nodeValue;

			 dId = deviceInfo[4].childNodes[0].nodeValue;  

		  }

	  

    SPECIAL_DAYS = {};

    gcalendar.refresh();

    //changeDisplayInfo();

    changeDisplayInfoXML();

    displayDeviceSummaryInfoXML();

    changeDisplayCurrentInfoForAllDevicesXML();  

	  }

	  

	  

	   function retrieveLocWithTypeSub1(sType,did){

	   

		 var url;

		 var date = new Date().getTime();

		 if (sType == 1)

		   url = "dd.action?deviceId="+did+"&viewOptions.mapAll=15&viewOptions.returnCode=xml&d="+date;

		 if (sType == 2)

		   url = "dd.action?deviceId="+did+"&viewOptions.mapAll=12&viewOptions.returnCode=xml&d="+date;

		 if (sType == 3)

		   url = "dd.action?viewOptions.mapAll=21&viewOptions.returnCode=xml&d="+date;

		 selectType =  sType;

		//alert("retrieveLocWithTypeSub1 url = " + url);

		//Do the Ajax call

		 

		if (window.XMLHttpRequest) { // Non-IE browsers

		  try{

			 req = new XMLHttpRequest();

		  } catch (e) {

			req = new ActiveXObject("Msxml2.XMLHTTP");

			//alert("Problem Communicating with Server\n"+e);

		  }

		  try{

		  req.onreadystatechange = processResponseDeviceDataXMLWithSelectType;

		

			//alert("in XMLHttpRequest Object");

			req.open("POST", url, true); //was get

				  req.setRequestHeader('Pragma', 'no-cache');

		  req.setRequestHeader('Expires', '-1');

			

			req.send(null);

			} catch (e) {

			 alert("Internet connection interrupted\n"+e);

			}

	 

		  //req.send(null);

		} else if (window.ActiveXObject) { // IE

		  

		  req = new ActiveXObject("Microsoft.XMLHTTP");

		  if (req) {

			//alert("in window ActiveXObject");

			req.onreadystatechange = processResponseDeviceDataXMLWithSelectType;

			req.open("POST", url, true);

			req.send();

		  }

		}

		

	  }

	  

	  function retrieveLocWithType(){

		  var deviceId;

		deviceId = global_deviceId;

		var stype = document.getElementById("selectType");

		//alert("stype.checked = " + stype.checked);

		if (stype.checked)  //for all locations of this device

		    retrieveLocWithTypeSub1(2, deviceId);

		else                                       //for 5 locations of this device

		    retrieveLocWithTypeSub1(1, deviceId);

		  

	  locationHistoryListDOMObj = null;

	  

	  }

	  

	  function isRefreshOn(){

		var reFresh = document.getElementById("reFresh");

		return reFresh.checked;       

	  }

	  

	  

	  

	  function changeDisplayInfoForm(){

	  

		//update calendar

		viewOptionsUpdateForm();

		

		  var righttable = document.getElementById("tablep");

		  //var numrows=righttable.rows.length;

		  //alert("numrows = " + numrows);

		  //for( var count = 1; count < numrows; count++)

		  //{

		  //  righttable.deleteRow(1);

		  //}

		  //alert(righttable.tBodies[0].outerHtml);

		  var righttablebody = document.createElement("tbody");

		  

		    ////////////////////////////////////////////////

           var righttable_row = document.createElement("tr");

            

            //righttable_row.style.backgroundColor = "#333333";

             righttable_row.style.fontWeight="bold";

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            righttable_column.align = "center";

            righttable_column.className = "subtitle";

            var text= document.createTextNode("Tracker List:");

            //righttable_column.appendChild(text);

            //righttable_row.appendChild(righttable_column);

            //righttablebody.appendChild(righttable_row); 

            

            var righttable_row = document.createElement("tr");

            var righttable_column = document.createElement("td");

            var righttable_div = document.createElement("div");
            //righttable_div.className = "devinfo";
            righttable_div.className = "decontents";
            righttable_div.style.overflow = "auto";

  ///////////////////////////////////////////////          

		  var accountStatus;

		 

		   <s:iterator value="deviceList" status="rr5"> 
		        accountStatus = "<s:property value='accountStatus'/>";
				user = "<s:property value='user'/>"; 

				dNickname = "<s:property value='deviceNickname'/>"; 

				dId =  "<s:property value='deviceId'/>";

				commuAge =  "<s:property value='lastKnownLocationAgoValue'/>";

				pLevel =  "99";

				var righttable_span = document.createElement("span");

				righttable_span.className = "devinfo";				

				
				//if(accountStatus == "INACTIVE"){
				//	righttable_span.style.backgroundColor = "#848482";
				//}

				if (global_deviceId == dId){

				    righttable_span.style.backgroundColor = "#000000";

				   //righttable_span.style.backgroundColor = "#00FF00";

				}//else{

				//   righttable_span.style.backgroundColor = "#F5F5DC";

				//}

				

			    var browser = navigator.appName;

                if (browser == "Microsoft Internate Explorer"){

                   righttable_span.style.cursor = "hand";

                }else{

				  righttable_span.style.cursor = "pointer";

				}

            

			var fromDeviceList = true;

            righttable_span.onclick = new Function("evt", "getDeviceLocinfo1("+dId+","+fromDeviceList+");");

            var str_span = dNickname+": "; // + commuAge;         
			if(accountStatus == "INACTIVE"){
				righttable_span.style.color = "#C36241";
			}

            var text_span= document.createTextNode(str_span);

            righttable_span.appendChild(text_span);

            righttable_div.appendChild(righttable_span);
       ///////////////////////////////////////////////////////////////
            var righttable_subspan = document.createElement("span");
            righttable_subspan.className = "devinfo";
            var str_subspan =  commuAge;
            var text_subspan= document.createTextNode(str_subspan);
            righttable_subspan.appendChild(text_subspan);
            righttable_span.appendChild(righttable_subspan);
            righttable_div.appendChild(righttable_span);       
       ////////////////////////////////////////////////////////////////
            

            var righttable_br = document.createElement("br");

            righttable_div.appendChild(righttable_br);

			</s:iterator>   

            righttable_column.appendChild(righttable_div);

            righttable_row.appendChild(righttable_column);

            righttablebody.appendChild(righttable_row);

            righttable.appendChild(righttablebody);   

	  }

	  

	   

	  

	  function changeDisplayInfoXML(){

		  var righttable = document.getElementById("tablep");

          var righttableChild = righttable.childNodes;

                  //alert("changeDisplayToLocationHistoryInfoXML righttableChild length = " + righttableChild.length);

		  var deviceList = newDocument.getElementsByTagName("deviceList");

		  //alert("changeDisplayInfoXML deviceList.length = "+ deviceList.length);

		  var deviceInfoSet = deviceList[0].childNodes;

          if(deviceInfoSet.length != 0){

                  if (righttable.hasChildNodes()){

                     while ( righttable.childNodes.length >=1){

                       righttable.removeChild(righttable.firstChild);

                     }

                  }

		  }

	   

		  //alert(righttable.tBodies[0].outerHtml);

		  var righttablebody = document.createElement("tbody");

	

		  //alert(" changeDisplayInfoXML deviceInfoSet.length = "+ deviceInfoSet.length);

		  //var deviceInfo = deviceInfoSet[0].childNodes;

		  //alert("deviceInfo.length = "+ deviceInfo.length);

		  var user;

		  var dNickname;

		  var dId;

		  var deviceID;
		  var accountStatus;
					  var items1 = newDocument.getElementsByTagName("locationList");

				//alert("items1.length = "+ items1.length+ " and nodeTypa = " + items1.nodeType);

				for(var i=0; i < items1.length; i++){

				//alert("items1[i].nodeName = "+items1[i].nodeName+ " and nodeTypa = " + items1[i].nodeType);

				  var itemList = items1[i].childNodes;

				//alert("itemList.length = "+ itemList.length);

				  for(var k=0; k < itemList.length; k++){ //items

					 var deviceLocInfoList = itemList[k].childNodes;

					 //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);

					 deviceID = deviceLocInfoList[8].childNodes[0].nodeValue;

					 break;

				  }

				}

  ////////////////////////////////////////////////

       if(deviceInfoSet.length != 0){

           var righttable_row = document.createElement("tr");

            

            //righttable_row.style.backgroundColor = "#333333";

             righttable_row.style.fontWeight="bold";

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            righttable_column.align = "center";

            righttable_column.className = "subtitle";

            var text= document.createTextNode("Tracker List:");

            //righttable_column.appendChild(text);

            //righttable_row.appendChild(righttable_column);

            //righttablebody.appendChild(righttable_row); 

  ///////////////////////////////////////////////          

      var righttable_row = document.createElement("tr");

      var righttable_column = document.createElement("td");

      var righttable_div = document.createElement("div");

      //righttable_div.className = "devinfo";

      righttable_div.className = "decontents";
      righttable_div.style.overflow = "auto";
      righttable_div.style.height = "90px";

      for(var i=0; i < deviceInfoSet.length; i++){

     //alert("items11[i].nodeName = "+items11[i].nodeName+ " and nodeTypa = " + items11[i].nodeType);

            var itemList11 = deviceInfoSet[i].childNodes;

            user = itemList11[22].childNodes[0].nodeValue; 

            dNickname = itemList11[6].childNodes[0].nodeValue;

            dId =  itemList11[4].childNodes[0].nodeValue;

            commuAge =  itemList11[12].childNodes[0].nodeValue;//lastKnownLocationAgoValue

            pLevel =  itemList11[14].childNodes[0].nodeValue; //13
  		     accountStatus = itemList11[0].childNodes[0].nodeValue;;//accountStatus
            //var righttable_row = document.createElement("tr");

				//if (deviceID == dId){

				

				var righttable_span = document.createElement("span");

				//righttable_span.className = "devinfo";				

				//if(accountStatus == "INACTIVE"){
				//	righttable_span.style.backgroundColor = "#848482";
				//}
				

				if (global_deviceId == dId){

				    righttable_span.style.backgroundColor = "#222222";

				   //righttable_span.style.backgroundColor = "#00FF00";

				}//else{

				//   righttable_span.style.backgroundColor = "#F5F5DC";

				//}

				

			    var browser = navigator.appName;

                if (browser == "Microsoft Internate Explorer"){

                   righttable_span.style.cursor = "hand";

                }else{

				  righttable_span.style.cursor = "pointer";

				}

				

            var fromDeviceList = true;

            righttable_span.onclick = new Function("evt", "getDeviceLocinfo1("+dId+","+fromDeviceList+");");

            var str_span = dNickname+": "; // + commuAge;         
			if(accountStatus == "INACTIVE"){
				righttable_span.style.color = "#C36241";
			}

            var text_span= document.createTextNode(str_span);

            righttable_span.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "devinfo";

            var str_subspan =  commuAge;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);

            

            righttable_span.appendChild(righttable_subspan);

            righttable_div.appendChild(righttable_span);

            var righttable_br = document.createElement("br");

            righttable_div.appendChild(righttable_br);

        }

        righttable_column.appendChild(righttable_div);

        righttable_row.appendChild(righttable_column);

        righttablebody.appendChild(righttable_row);

        righttable.appendChild(righttablebody); 

        }  

	  }

	  

	 function displayDeviceSummaryInfoXML(){

		  //alert("displayDeviceSummaryInfoXML");

		  var righttable = document.getElementById("tableAS");

          var righttableChild = righttable.childNodes;

          var deviceList = newDocument.getElementsByTagName("deviceList");

		  //alert("displayDeviceSummaryInfoXML deviceList.length = "+ deviceList.length);

		  var deviceInfoSet = deviceList[0].childNodes;

          

                  //alert("changeDisplayToLocationHistoryInfoXML righttableChild length = " + righttableChild.length);

          if(deviceInfoSet.length != 0){        

                  if (righttable.hasChildNodes()){

                     while ( righttable.childNodes.length >=1){

                       righttable.removeChild(righttable.firstChild);

                     }

                 }

		  }

	   

		  //alert(righttable.tBodies[0].outerHtml);

		  //var righttablebody = document.createElement("tbody");

	

		  //alert(" changeDisplayInfoXML deviceInfoSet.length = "+ deviceInfoSet.length);

		  //var deviceInfo = deviceInfoSet[0].childNodes;

		  //alert("deviceInfo.length = "+ deviceInfo.length);

		  var user;

		  var dNickname;

		  var dId;

		  var deviceID;

			    var items1 = newDocument.getElementsByTagName("locationList");

				//alert("items1.length = "+ items1.length+ " and nodeTypa = " + items1.nodeType);

				for(var i=0; i < items1.length; i++){

				//alert("items1[i].nodeName = "+items1[i].nodeName+ " and nodeTypa = " + items1[i].nodeType);

				  var itemList = items1[i].childNodes;

				//alert("itemList.length = "+ itemList.length);

				  for(var k=0; k < itemList.length; k++){ //items

					 var deviceLocInfoList = itemList[k].childNodes;

					 //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);

					 deviceID = deviceLocInfoList[8].childNodes[0].nodeValue;

					 break;

				  }

				}

  ////////////////////////////////////////////////

         if(deviceInfoSet.length != 0){

           //var righttable_row = document.createElement("tr");

            

            ////righttable_row.style.backgroundColor = "#333333";

             //righttable_row.style.fontWeight="bold";

            //var righttable_column = document.createElement("td");

            //righttable_column.noWrap=true;

            //righttable_column.align = "center";

            //righttable_column.className = "subtitle";

            //var text= document.createTextNode("Activity Summary:");

            ////righttable_column.appendChild(text);

            ////righttable_row.appendChild(righttable_column);

            ////righttablebody.appendChild(righttable_row); 

  ///////////////////////////////////////////////          

      //var righttable_row = document.createElement("tr");

      //var righttable_column = document.createElement("td");

      //var righttable_div = document.createElement("div");

      //righttable_div.className = "decontents";

      //righttable_div.style.height = "110px";

      for(var i=0; i < deviceInfoSet.length; i++){

     //alert("items11[i].nodeName = "+items11[i].nodeName+ " and nodeTypa = " + items11[i].nodeType);

            var itemList11 = deviceInfoSet[i].childNodes;

            user = itemList11[22].childNodes[0].nodeValue; 

            dNickname = itemList11[6].childNodes[0].nodeValue;

            dId =  itemList11[4].childNodes[0].nodeValue;

            var last_reception =  itemList11[11].childNodes[0].nodeValue;

            commuAge =  itemList11[12].childNodes[0].nodeValue;//lastKnownLocationAgoValue

            pLevel =  itemList11[14].childNodes[0].nodeValue; //13            

            lastLocationOn =  itemList11[15].childNodes[0].nodeValue; //13            

            maxSpeed = itemList11[16].childNodes[0].nodeValue; 

            totalDistance = itemList11[18].childNodes[0].nodeValue;

            totalIntransit =  itemList11[19].childNodes[0].nodeValue;

            totalLocationRecords =  itemList11[20].childNodes[0].nodeValue;//lastKnownLocationAgoValue

            totalStop =  itemList11[21].childNodes[0].nodeValue; //13

            if (pLevel.length == 0)
            	pLevel = "n/a% ";
		    if (pLevel == "%")
		    	pLevel = "n/a% ";
            
            if (pLevel.indexOf("%") == -1){
          	  pLevel = pLevel + "% ";
            }  


            pLevel = pLevel + " " + lastLocationOn;
            last_reception = last_reception + " " + lastLocationOn;
            

           if (global_deviceId == dId){

            //var righttable_row = document.createElement("tr");

				//if (deviceID == dId){

				
   			var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Captured Locates of Day: "; // + totalLocationRecords;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";

            var str_subspan =  totalLocationRecords;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);

                        

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            //var righttable_span = document.createElement("span");

			////righttable_span.className = "devinfo";				            

            //var str_span = "No. of Stops: "; //+ totalStop;         

            //var text_span= document.createTextNode(str_span);

            //righttable_span.appendChild(text_span);

            

            //var righttable_subspan = document.createElement("span");

            //righttable_subspan.className = "devinfo";

            //var str_subspan =  totalStop;

            //var text_subspan= document.createTextNode(str_subspan);

            //righttable_subspan.appendChild(text_subspan);            

            //righttable_span.appendChild(righttable_subspan);

                        

            righttable.appendChild(righttable_li);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Approx Travel of Day: "; //+ totalDistance;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";

            var str_subspan =  totalDistance;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);

                        

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            //var righttable_span = document.createElement("span");

			////righttable_span.className = "devinfo";				            

            //var str_span = "No. of Movements: "; //+ totalIntransit;         

            //var text_span= document.createTextNode(str_span);

            //righttable_span.appendChild(text_span);

            

            //var righttable_subspan = document.createElement("span");

            //righttable_subspan.className = "devinfo";

            //var str_subspan =  totalIntransit;

            //var text_subspan= document.createTextNode(str_subspan);

            //righttable_subspan.appendChild(text_subspan);            

            //righttable_span.appendChild(righttable_subspan);

            righttable.appendChild(righttable_li); 

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Top Speed of Day: "; // + maxSpeed;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";


            var str_subspan =  maxSpeed;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);
            righttable.appendChild(righttable_li);
            

            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            //var righttable_span = document.createElement("span");

			////righttable_span.className = "devinfo";				            

            //var str_span = "Last Heard: "; //+ lastLocationOn;         

            //var text_span= document.createTextNode(str_span);

            //righttable_span.appendChild(text_span);

            //var righttable_subspan = document.createElement("span");

            //righttable_subspan.className = "devinfo";

            //var str_subspan =  lastLocationOn;

            //var text_subspan= document.createTextNode(str_subspan);

            //righttable_subspan.appendChild(text_subspan);            

            //righttable_span.appendChild(righttable_subspan);

            
            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Last Reception of Day: ";// + pLevel;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            var righttable_subspan = document.createElement("span");

            righttable_subspan.className = "content-text";

            var str_subspan =  last_reception;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);
            righttable.appendChild(righttable_li);
            
            //righttable_div.appendChild(righttable_span);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);

            

            var righttable_li = document.createElement("li");

			//righttable_span.className = "devinfo";				            

            var str_span = "Last Battery of Day: ";// + pLevel;         

            var text_span= document.createTextNode(str_span);

            righttable_li.appendChild(text_span);

            var righttable_subspan = document.createElement("span");
            var str1 = pLevel.split('%');
            if (!isNaN(str1[0])){
                if (str1[0] <= 10 && str1[0] >= 6 )
                	righttable_subspan.style.color =  "yellow";
                  else if (str1[0] <= 5)
                	  righttable_subspan.style.color =  "red";
                  else  
                	  righttable_subspan.className = "content-text";
            }else{
                  righttable_subspan.className = "content-text";
		    }

            if (pLevel.length == 0)
            	pLevel = "n/a% ";
		    if (pLevel == "%")
		    	pLevel = "n/a% ";
		    
            if (pLevel.indexOf("%") == -1){
          	  pLevel = pLevel + "% ";
            }  
	    
            var str_subspan =  pLevel;

            var text_subspan= document.createTextNode(str_subspan);

            righttable_subspan.appendChild(text_subspan);            

            righttable_li.appendChild(righttable_subspan);

            

            righttable.appendChild(righttable_li);            

            //var righttable_br = document.createElement("br");

            //righttable_div.appendChild(righttable_br);


          }  

        }



           

        //righttable_column.appendChild(righttable_div);

        //righttable_row.appendChild(righttable_column);

        //righttablebody.appendChild(righttable_row);

        //righttable.appendChild(righttablebody);

       }    

	  }

	  

	  

	  function changeDisplayToLocationHistoryInfoXML(){

		  var righttable = document.getElementById("tablep");

                  var righttableChild = righttable.childNodes;

                  //alert("changeDisplayToLocationHistoryInfoXML righttableChild length = " + righttableChild.length);

                  if (righttable.hasChildNodes()){

                     while ( righttable.childNodes.length >=1){

                        righttable.removeChild(righttable.firstChild);

                     }

		  }

		  //alert(righttable.tBodies[0].outerHtml);

		  var righttablebody = document.createElement("tbody");

		  var locationList = newDocument.getElementsByTagName("locationList");

		  var itemsList = locationList[0].childNodes;

      /////////////////////////////////////////////////////

      

      

      ////////////////////////////////////////////////////

            var righttable_row = document.createElement("tr");

            righttable_row.style.backgroundColor="#F5F5DC";

            righttable_row.style.fontWeight="bold";

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Index");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

            

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Lat");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

 

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Lon");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

              

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Timestamp");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);



            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Speed");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);



            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Duration");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);



            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("address");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

            

            righttablebody.appendChild(righttable_row);  

            //righttable.appendChild(righttable_row); 

		  

		  for(var k=0; k < itemsList.length; k++){ 

				  var eachLocationInfoLIst = itemsList[k].childNodes;

				  var address1 = eachLocationInfoLIst[0].childNodes[0].nodeValue;

				  var address2 = eachLocationInfoLIst[1].childNodes[0].nodeValue;

				  var city = eachLocationInfoLIst[4].childNodes[0].nodeValue;

				  var country = eachLocationInfoLIst[5].childNodes[0].nodeValue;

				  var course = eachLocationInfoLIst[6].childNodes[0].nodeValue;

				  var timestamp = eachLocationInfoLIst[7].childNodes[0].nodeValue;

				  var duration = eachLocationInfoLIst[11].childNodes[0].nodeValue;

				  var index = eachLocationInfoLIst[12].childNodes[0].nodeValue;

				  var landMarkDescriptions = eachLocationInfoLIst[13].childNodes[0].nodeValue;

				  var landMarkName = eachLocationInfoLIst[14].childNodes[0].nodeValue;

				  var landmarkId = eachLocationInfoLIst[15].childNodes[0].nodeValue;

				  var lat = eachLocationInfoLIst[16].childNodes[0].nodeValue;

				  var locationAge = eachLocationInfoLIst[17].childNodes[0].nodeValue;

				  var lon = eachLocationInfoLIst[18].childNodes[0].nodeValue;

				  var speed = eachLocationInfoLIst[19].childNodes[0].nodeValue;

				  var speedUnit = eachLocationInfoLIst[20].childNodes[0].nodeValue;

				  var state = eachLocationInfoLIst[21].childNodes[0].nodeValue;

				  var timeSinceLastReport = eachLocationInfoLIst[22].childNodes[0].nodeValue;

				  var utctimestamp = eachLocationInfoLIst[23].childNodes[0].nodeValue;

				  var zipCode = eachLocationInfoLIst[24].childNodes[0].nodeValue;

				  var address = address1+","+city+","+state+" " + zipCode;

				  

				var righttable_row = document.createElement("tr");

				righttable_row.style.backgroundColor="#F5F5DC";

				var righttable_column = document.createElement("td");

				righttable_column.noWrap=true;

				var text= document.createTextNode(index);

				righttable_column.appendChild(text);

				righttable_row.appendChild(righttable_column);

				

				var righttable_column = document.createElement("td");

				righttable_column.noWrap=true;

				var text= document.createTextNode(lat);

				righttable_column.appendChild(text);

				righttable_row.appendChild(righttable_column);

	 

				var righttable_column = document.createElement("td");

				righttable_column.noWrap=true;

				var text= document.createTextNode(lon);

				righttable_column.appendChild(text);

				righttable_row.appendChild(righttable_column);

				  

				var righttable_column = document.createElement("td");

				righttable_column.noWrap=true;

				var text= document.createTextNode(timestamp);

				righttable_column.appendChild(text);

				righttable_row.appendChild(righttable_column);

	

				var righttable_column = document.createElement("td");

				righttable_column.noWrap=true;

				var text= document.createTextNode(speed+speedUnit);

				righttable_column.appendChild(text);

				righttable_row.appendChild(righttable_column);

	

				var righttable_column = document.createElement("td");

				righttable_column.noWrap=true;

                var text= document.createTextNode(locationAge);

				righttable_column.appendChild(text);

				righttable_row.appendChild(righttable_column);

	

				var righttable_column = document.createElement("td");

				righttable_column.noWrap=true;

				var text= document.createTextNode(address);

				righttable_column.appendChild(text);

				righttable_row.appendChild(righttable_column);

				righttablebody.appendChild(righttable_row);  

		  }

		  righttable.appendChild(righttablebody);  

	  }

	  

    function changeDisplayCurrentInfoForAllDevicesXML(){

      var righttable = document.getElementById("tablep");

      var righttableChild = righttable.childNodes;

      //alert("changeDisplayCurrentInfoForAllDevicesXML righttableChild length = " + righttableChild.length);

      if (righttable.hasChildNodes()){

        while ( righttable.childNodes.length >=1){

          righttable.removeChild(righttable.firstChild);

        }

      }


      //alert(righttable.tBodies[0].outerHtml);

      var righttablebody = document.createElement("tbody");

      //numrows=righttablebody.rows.length;

      //alert("changeDisplayToLocationHistoryInfoXML righttablebody numrows = " + numrows);

      

      

      var locationList = newDocument.getElementsByTagName("locationList");

      var itemsList = locationList[0].childNodes;

      /////////////////////////////////////////////////////

      

      

      ////////////////////////////////////////////////////

            var righttable_row = document.createElement("tr");

            righttable_row.style.backgroundColor="#F5F5DC";

            righttable_row.style.fontWeight="bold";

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Index");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

            

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Device name");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

            

            

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Lat");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

 

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Lon");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

              

            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Timestamp");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);



            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Speed");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);



            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("Duration");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);



            var righttable_column = document.createElement("td");

            righttable_column.noWrap=true;

            var text= document.createTextNode("address");

            righttable_column.appendChild(text);

            righttable_row.appendChild(righttable_column);

            

            righttablebody.appendChild(righttable_row);  

            //righttable.appendChild(righttable_row); 

                  //////////////////////////////////////////////////////////

      var deviceList = newDocument.getElementsByTagName("deviceList");

      //alert("deviceList.length = "+ deviceList.length);

      var deviceInfoSet = deviceList[0].childNodes;

      //alert("deviceInfoSet.length = "+ deviceInfoSet.length);

      for (var e=0; e < deviceInfoSet.length; e++){

         var deviceInfo = deviceInfoSet[e].childNodes;

         var user_d = deviceInfo[22].childNodes[0].nodeValue;

         var dNickname_d = deviceInfo[6].childNodes[0].nodeValue;

         var dId_d = deviceInfo[4].childNodes[0].nodeValue; 

         var index_d =  deviceInfo[7].childNodes[0].nodeValue; 

         var last_reception =  deviceInfo[11].childNodes[0].nodeValue; 

      

      

      ////////////////////////////////////////////////////////

            

          for(var k=0; k < itemsList.length; k++){ 

              var eachLocationInfoLIst = itemsList[k].childNodes;

              var address1 = eachLocationInfoLIst[0].childNodes[0].nodeValue;

              var address2 = eachLocationInfoLIst[1].childNodes[0].nodeValue;

              var city = eachLocationInfoLIst[4].childNodes[0].nodeValue;

              var country = eachLocationInfoLIst[5].childNodes[0].nodeValue;

              var course = eachLocationInfoLIst[6].childNodes[0].nodeValue;

              var timestamp = eachLocationInfoLIst[7].childNodes[0].nodeValue;

              var duration = eachLocationInfoLIst[11].childNodes[0].nodeValue;

              var index = eachLocationInfoLIst[12].childNodes[0].nodeValue;

              var landMarkDescriptions = eachLocationInfoLIst[13].childNodes[0].nodeValue;

              var landMarkName = eachLocationInfoLIst[14].childNodes[0].nodeValue;

              var landmarkId = eachLocationInfoLIst[15].childNodes[0].nodeValue;

              var lat = eachLocationInfoLIst[16].childNodes[0].nodeValue;

              var locationAge = eachLocationInfoLIst[17].childNodes[0].nodeValue;

              var lon = eachLocationInfoLIst[18].childNodes[0].nodeValue;

              var speed = eachLocationInfoLIst[19].childNodes[0].nodeValue;

              var speedUnit = eachLocationInfoLIst[20].childNodes[0].nodeValue;

              var state = eachLocationInfoLIst[21].childNodes[0].nodeValue;

              var timeSinceLastReport = eachLocationInfoLIst[22].childNodes[0].nodeValue;

              var utctimestamp = eachLocationInfoLIst[23].childNodes[0].nodeValue;

              var zipCode = eachLocationInfoLIst[24].childNodes[0].nodeValue;

              var address = address1+","+city+","+state+" " + zipCode;

              if (index_d == index){

                 var righttable_row = document.createElement("tr");

                 righttable_row.style.backgroundColor="#F5F5DC";

                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(index);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);

                 

                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(dNickname_d);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);

                 

            

                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(lat);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);

 

                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(lon);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);

              

                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(timestamp);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);



                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(speed+speedUnit);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);



                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(locationAge);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);



                 var righttable_column = document.createElement("td");

                 righttable_column.noWrap=true;

                 var text= document.createTextNode(address);

                 righttable_column.appendChild(text);

                 righttable_row.appendChild(righttable_column);

                 righttablebody.appendChild(righttable_row); 

                 //righttable.appendChild(righttable_row);  

              

              } 

           }

      }

      righttable.appendChild(righttablebody);  

  }

  

  function insertNewLocBeforeFirstNode(items1){

	  

	  //last Loc Index

	   var itemList1 = items1[0].childNodes;

   //alert("insertNewLocBeforeFirstNode itemList1 = " + itemList1.length);

      if ( itemList1.length >= 1)

      {

	   var deviceLocInfoList1 = itemList1[itemList1.length-1].childNodes;

	   var index1 = deviceLocInfoList1[11].childNodes[0].nodeValue;

	

	   var itemList3 = items1[0].childNodes;

	   var deviceLocInfoList3 = itemList3[itemList3.length-1].childNodes;

	   var index3 = deviceLocInfoList1[11].childNodes[0].nodeValue;

	   

	   //first Loc Index of locationHistoryListDOMObj

	   var itemList2 = locationHistoryListDOMObj[0].childNodes;

	   var deviceLocInfoList2 = itemList2[0].childNodes;

	   var index2 = deviceLocInfoList2[11].childNodes[0].nodeValue;

	   if (index1 != index2){

		 if(index3 == 1){

			 var locListNode = newDocument.getElementsByTagName("locationList")[0];

			 locationHistoryListDOMObj = locListNode.cloneNode(true);    

		 }else{

			//go server to get fresh copy

		 }

	   }else{

		for(var i=0; i < items1.length; i++){

		 var itemList = items1[i].childNodes;

		 for(var k=0; k < itemList.length; k++){ //items

				 var item = itemList[k].cloneNode(true); //clone item node

				 locationHistoryListDOMObj.insertBefore(item,locationHistoryListDOMObj.firstChild);

		 }

		}

	   } 

	  }

  }



  function FindLayer(title)

  {

     var layer = null;

     for (var i = 0; i < map.GetShapeLayerCount(); i++)

      {

        layer = map.GetShapeLayerByIndex(i);

        if (layer.GetTitle() == title) break;

        layer = null; 

      }

    return layer;

  }  

  function LiveMap(){

    document.location.href="dd.action?viewOptions.returnCode=vefull";

  }	

  

  function LiveMapForGoogle(){

    document.location.href="dd.action?viewOptions.returnCode=googlefull";

  }	  

    

  

  function MapAllDevices(){

     document.location.href="dd.action?viewOptions.mapAll=21&viewOptions.returnCode=veform";

  }	  

  function returnToLoginPage(){

     document.location.href="login.jsp";

  } 

  
  var pinInfobox;
  var bingmapLocationsArray = [];
  function createInfoMarker(ui, point, address, index, iconImage) {
	var clickCount = parseInt(index);
	  var imagePath = "images/Markers/iconb" + clickCount + ".png"; //icon.image = "images/Markers/iconb" + clickCount + ".png";
	if (iconImage)
		imagePath = "images/"+ iconImage;
	//alert("createInfoMarker 1 ");
	  greyPlaneBitmap = new H.map.Icon(imagePath);
      var marker = new H.map.Marker(point);
      marker.setIcon(greyPlaneBitmap);
      marker.setData("<div style='color:white'>" + address+"</div>");
      //var bubbleText = "<p style='color:white'>" + address+"</p>";

      marker.addEventListener('tap' ,  function(evt) {
      var bubble =  new H.ui.InfoBubble(evt.target.getPosition(), {
	        // read custom data
	        content: evt.target.getData()
	      });
	      // show info bubble
       ui.addBubble(bubble);
     }, false);
  
	  //alert("createInfoMarker 2 ");
	  return marker;
  }

  function createInfoMarker1(ui,point, address, index, iconImage) {
	    //var icon = new GIcon();
		var clickCount = parseInt(index);
		//icon.image = "http://www.bountynetwork.com/images/marker" + clickCount + ".png";
		//icon.image = "images/Markers/mf" + clickCount + ".png";
		//alert("clickCount = " + clickCount);
		//icon.image = "images/Markers/iconb" + clickCount + ".png";
		
		  //icon.image = "images/Markers/iconb" + clickCount + ".png";
		   var imagePath = "images/Markers/iconb0.png";//icon.image = "images/Markers/iconb0.png";
		if (iconImage)
			imagePath = "images/"+ iconImage; //icon.image = "images/"+ iconImage;
			//alert("createInfoMarker1 1 ");
	  greyPlaneBitmap = new H.map.Icon(imagePath);
      var marker = new H.map.Marker(point);
      marker.setIcon(greyPlaneBitmap);
      marker.setData("<div style='color:white'>" + address+"</div>");
      //var bubbleText = "<p style='color:white'>" + address+"</p>";

      marker.addEventListener('tap' ,  function(evt) {
      var bubble =  new H.ui.InfoBubble(evt.target.getPosition(), {
	        // read custom data
	        content: evt.target.getData()
	      });
	      // show info bubble
       ui.addBubble(bubble);
     }, false);
  
	  //alert("createInfoMarker 2 ");
	  return marker;
 
			  //alert("createInfoMarker1 2 ");
	  }

   function createInfoMarker2(ui,point, address, index, iconImage) {
	    //var icon = new GIcon();
		var clickCount = parseInt(index);
		//icon.image = "http://www.bountynetwork.com/images/marker" + clickCount + ".png";
		//icon.image = "images/Markers/mf" + clickCount + ".png";
		//alert("clickCount = " + clickCount);
		//icon.image = "images/Markers/iconb" + clickCount + ".png";
		
		  //icon.image = "images/Markers/iconb" + clickCount + ".png";
		  
		  var imagePath = "images/Markers/iconb0.png";////icon.image = "images/Markers/iconb0.png";
		if (iconImage)
			imagePath = "images/"+ iconImage; //icon.image = "images/"+ iconImage;
		//	    alert("createInfoMarker2 1 ");
	  greyPlaneBitmap = new H.map.Icon(imagePath);
      var marker = new H.map.Marker(point);
      marker.setIcon(greyPlaneBitmap);
      marker.setData("<div style=\'color:white\'>" + address+"</div>");
      //var bubbleText = "<p style='color:white'>" + address+"</p>";

      marker.addEventListener('tap' ,  function(evt) {
      var bubble =  new H.ui.InfoBubble(evt.target.getPosition(), {
	        // read custom data
	        content: evt.target.getData()
	      });
	      // show info bubble
       ui.addBubble(bubble);
     }, false);
  
	  //alert("createInfoMarker 2 ");
	  return marker;
 		  //alert("createInfoMarker2 2 ");
	  }
 

    function createLastLocInfoMarker(ui,point, address, index, iconImage) {

    //var icon = new GIcon();

	var clickCount = parseInt(index);

	//icon.image = "http://www.bountynetwork.com/images/marker" + clickCount + ".png";

	//icon.image = "images/Markers/mf" + clickCount + ".png";

	//alert("clickCount = " + clickCount);

	    //var imagePath = "images/Markers/iconb" + clickCount + ".png";////icon.image = "images/Markers/iconb" + clickCount + ".png";
	    var imagePath = "http://www.google.com/mapfiles/marker.png"
	    
		if (iconImage != null){
			imagePath = "images/"+ iconImage; //icon.image = "images/"+ iconImage;			
		}

		 //var pushpinOptions = {icon: imagePath, width: 30, height: 30, anchor: new Microsoft.Maps.Point(8,5)};
		 //var pushpin= new Microsoft.Maps.Pushpin(point, pushpinOptions);
		 //pushpin.Title = clickCount;
		 //pushpin.Description = "<p style='color:blue'>"+address+"</p>";
         //alert("createLastLocInfoMarker 1 ");
	  greyPlaneBitmap = new H.map.Icon(imagePath);
      var marker = new H.map.Marker(point);
      marker.setIcon(greyPlaneBitmap);
      marker.setData("<div style=\'color:white\'>" + address+"</div>");
      //var bubbleText = "<p style='color:white'>" + address+"</p>";

      marker.addEventListener('tap' ,  function(evt) {
      var bubble =  new H.ui.InfoBubble(evt.target.getPosition(), {
	        // read custom data
	        content: evt.target.getData()
	      });
	      // show info bubble
       ui.addBubble(bubble);
     }, false);
  
	  //alert("createInfoMarker 2 ");
	  return marker;
 		  //alert("createLastLocInfoMarker 2 ");
  }

    function addPin1(myID,lat,lon,URL,Title,info,iStyle){
    	//var position = new Microsoft.Maps.Location(lat,lon);
    	//		//var pin = new VEPushpin(myID,
    	//		//	new VELatLong(lat,lon),
    	//		//	URL, //image, icon path
    	//		//	Title,
    	//		//	info,
    	//		//	iStyle
    	//		//	);
    	
    	//var pin = new Microsoft.Maps.Pushpin(position, {text: '1'}); 
		// pin.Title = clickCount;
		// pin.Description = info;

        //// Create the info box for the pushpin
        ////pinInfobox = new Microsoft.Maps.Infobox(position, {title: info, visible: true});
        //pinInfobox = new Microsoft.Maps.Infobox(position, {visible: false});
       // // Add a handler for the pushpin click event.
        //Microsoft.Maps.Events.addHandler(pin, 'click', displayInfobox);
    	//		//map.AddPushpin(pin);
       //map.entities.push(pin);
        //map.entities.push(pinInfobox);

    }
        
	//function displayInfobox(e)
    //{
	//    if (e.targetType == 'pushpin'){
	//    	pinInfobox.setLocation(e.target.getLocation());
     //      pinInfobox.setOptions({ visible:true, title: e.target.Title, description: e.target.Description });
	 //   }
    //}


	  function googleMapForCurrentDeviceLocation(){
		  var url = "http://maps.google.com/?q=" + global_googlepoint.lat+","+global_googlepoint.lng;
		  window.open(url);
	  }
		
 //]]>  
</script>
  </body>
  <script type="text/javascript">
   gcalendar = Calendar.setup({
        inputField     :    "f_date_e",     // id of the input field
        ifFormat       :    "%y/%m/%d",     // format of the input field (even if hidden, this format will be honored)
        displayArea    :    "show_e",       // ID of the span where the date is to be shown
        daFormat       :    "%b %d, %Y",// format of the displayed date
        button         :    "f_trigger_e",  // trigger button (well, IMG in our case)
        align          :    "BR",           // alignment (defaults to "Bl")
        singleClick    :    false,
		weekNumbers    : 	false,
		onUpdate    : 	dateChanged,          // our callback function
      dateStatusFunc : ourDateStatusFunc
    });
</script>
</html>
