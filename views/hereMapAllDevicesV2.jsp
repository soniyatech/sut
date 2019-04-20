<html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/soniyatech.tld" prefix="soniyatech" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.soniyatech.framework.IFrameworkConstants" %>
<%@ page import="com.soniyatech.common.Config" %>
<%@ page import="com.soniyatech.server.safone.common.SafoneApplication" %>
<%@ page import="com.soniyatech.server.core.engine.Engine" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ page import="com.soniyatech.server.safone.common.*" %>

<% 
    SafoneApplication _safoneApplication1 = (SafoneApplication) Engine.getInstance().getApplication("SAFONE");
   //String language = _safoneApplication.getContext().getAttribute("LANGUAGE");
   String companyName = _safoneApplication1.getAttribute("COMPANY_NAME");
   System.out.println("companyName1 = " + companyName);
   //String gmapkey = Config.get("gmapkey");
   //WeiMeng v3.0: Now reading Google Map key from SafoneConfig.xml instead of app.properties
   String gmapkey = _safoneApplication1.getAttribute("GOOGLE_MAPKEY");
   String ZeroSpeed = _safoneApplication1.getAttribute("ZERO_SPEED");
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
    <!-- Custom styles for this template -->
    <link href="stylesheets/soniya.css" rel="stylesheet">
    <link href="stylesheets/soniyamap.css" rel="stylesheet">
    <link rel="SHORTCUT ICON" href="images/icon-ecceed.gif" type="image/x-icon" />
    <!-- link rel="stylesheet" type="text/css" media="all" href="js/veAll.css"/ -->
    <script type="text/javascript" src="js/generalV2.js"></script>
    <!-- link rel="stylesheet" type="text/css" media="all" href="stylesheets/style2.css"/ -->
    <link rel="stylesheet" type="text/css" href="http://js.api.here.com/v3/3.0/mapsjs-ui.css" />
    <script type="text/javascript" src="js/general2.js"></script>
  	      <script src="http://js.api.here.com/v3/3.0/mapsjs-core.js"></script>
          <!--  script src="http://js.api.here.com/v3/3.0/mapsjs-pano.js"></script -->
          <script src="http://js.api.here.com/v3/3.0/mapsjs-service.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-mapevents.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-ui.js"></script>
          <script src="http://js.api.here.com/v3/3.0/mapsjs-data.js"></script>
   
  </head>
  <body onload="initOnLoad()">
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
            <li class="hidden-sm active"><a href="#" onClick="GoToGoogleMapAllDevicesTab();return false;"><span class="glyphicon glyphicon-flash"></span> Live</a></li>
            <li class="hidden-sm"><a href="#" onClick="GoToLiveMapForGoogleTab();return false;"><span class="glyphicon glyphicon-record"></span> Summary</a></li>
            <li class="hidden-sm"><a href="#" onClick="GotoDeviceHistoryInfoTab();return false;"><span class="glyphicon glyphicon-stats"></span> History</a></li>
            <li class="hidden-sm"><a href="#" onClick="GotoDeviceSetupTab();return false;"><span class="glyphicon glyphicon-phone"></span> Device</a></li>
            <li class="hidden-sm"><a href="#" onClick="GoToAlertTab();return false;"><span class="glyphicon glyphicon-bell"></span> Alert</a></li>
            <li class="dropdown visible-sm active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span class=""><span class="glyphicon glyphicon-cog"></span> more<b class="caret"></b></span>
                </a>
                <ul class="dropdown-menu">
                    <li class="active"><a href="#" onClick="GoToGoogleMapAllDevicesTab();return false;"><span class="glyphicon glyphicon-flash"></span> Live</a></li>
                    <li><a href="#" onClick="GoToLiveMapForGoogleTab();return false;"><span class="glyphicon glyphicon-record"></span> Summary</a></li>
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

    <div class="panel-container hight-full">
      <div id="side_panel_div" class="side-panel">
        <div class="btn-group btn-group-justified">
          <div class="btn-group">
            <button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#poll_div" onclick="javascript:if(newDocument){startPolling(1);}">
              <span class="glyphicon glyphicon-screenshot"></span>&nbsp;Poll Now
            </button>
          </div>
          <div class="btn-group">
            <button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#interval_div" onclick="javascript:if(newDocument){saveDeviceIntervalSetting(1);}">
              <span class="glyphicon glyphicon-sort"></span>&nbsp;Interval
            </button>
          </div>
        </div>
        <!--  div class="checkbox center-chkbox">
          <label -->
            <input type="checkbox" name="drawPolyline" id="drawPolyline" value="checkbox" style="display:none" checked>
            <!--  Draw Trace Line
          </label>
        </div -->
        <p>
          <a href="javascript:googleMapForCurrentDeviceLocation()" class="btn btn-primary btn-md width-full">
            <img src="images/icon-street-view.png" class="img-rounded img-responsive glyphicon btn-icon">&nbsp;
            What's nearby
          </a>
        </p>
        <div class="panel panel-default">
          <div class="panel-heading padding-sm-vertical"><h3 class="panel-title"><strong>Tracking Information</strong></h3></div>
          <div class="panel-body padding-sm-vertical">
            <ul class="list-unstyled margin-zero">
              <li>Last Signal: <span class="content-text" id="dInfo6">loading...</span><span class="content-text" id="dInfo4"></span></li>
              <li>Aging: <span class="content-text" id="dInfo1">loading...</span></li>
              <li>Last Speed: <span class="content-text" id="dInfo2">loading...</span></li>
              <li>Interval: <span class="content-text" id="dInfo3">loading...</span></li>
            </ul>
          </div>
        </div>
        <div class="panel panel-default margin-bottom-zero">
          <div class="panel-heading padding-sm-vertical"><h3 class="panel-title"><strong>Tracker List</strong></h3></div>
          <div class="panel-body padding-sm-vertical">
            <ul class="list-unstyled margin-zero">
            <table id="tablep">
              <!-- li class="in-service selected"><a href="#">USAPOV: </a><span class="content-text">14 Min 27 Sec</span></li -->
              <!-- li class="out-service"><a href="#">BitchN: </a><span class="content-text">3 Days 5 Hr</span></li -->
            </table>
            </ul>
          </div>
        </div>
      </div><!-- side-panel -->

      <a id="button_toggle_panel" class="control-button" href="#"><span id="button_toggle_icon" class="glyphicon glyphicon-chevron-right icon"></span></a>
    </div>

    <div id="poll_div" class="modal fade">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">Send a Poll</h4>
          </div>
          <div class="modal-body">
            <div class="radio">
              <label>
                <input type="radio" name="pollingType" id="pollingType" value="1" checked>
                Send a Poll Request <br>(Supported models: GL4, CT5, BH6, XT2)
              </label>
            </div>
			<br><br>
            <div class="radio">
              <label>
                <input type="radio" name="pollingType" id="pollingType" value="2" align="top">
                Send a Raw Request <br>(Admin use only)
              </label>
            <textarea class="form-control" id="pollMessage" rows="2" placeholder="Please type in a raw code..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            <button type="button" class="btn btn-primary"  onclick="startPolling(2)" data-dismiss="modal">Send</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div id="interval_div" class="modal fade" >
    <!--  div id="intervalPanel" class="modal fade"-->
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">Send an interval to device</h4>
          </div>
          <div class="modal-body">
            <form>
            <h4>Select an interval:</h4>
            <span id="intervalSelect">
            <select name="ListBox1" class="form-control" id="intervalSelectBox">
              <option>Every 30 sec</option>
              <option>Every 1 minute</option>
              <option>Every 2 minutes</option>
              <option>Every 3 minutes</option>
              <option>Every 5 minutes</option>
              <option>Every 10 minutes</option>
              <option>Every 1 hour</option>
            </select>
            </span><br>
            <span id="intervalCount"></span><br>
            <span id="serverfeedback" style="font-size:10px; color:#CC0000"></span><br>
            
            <h4>Last Sent:</h4><p class="color-red" id="IntervalSetupTime"></p>
            <h4>Acknowledgement:</h4><p class="color-red"  id="DeviceIntervalStatusFromServer"></p>
            <div class="alert alert-info">
              <strong>Note:</strong>&nbsp;
                <br>Interval here means to device in motion status only.
                <br>When standing-still (sleep), it automatically changes to 1-hour.
				<br>The transition of interval is handled automatically from time to time.
            </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="Javascript:saveDeviceIntervalSetting(2);">Send</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="mapfooter">
      <small> &copy; 2005-2016 SONIYA TECHNOLOGY INTERNATIONAL INC.</small>
    </div>

    <div id="myMap" class="bing-map">
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/soniyamap.js"></script>
   <script type="text/javascript">
    
  var globalPageRefreshInterval = 15;
  var ID = null;
  
//calendar
  var lineColor2 = new Array("0099FF","FF0099","00FF00","330099","CC00FF","993300","0099FF","FF0099","00FF00","330099",
                             "0099FF","FF0099","00FF00","330099","CC00FF","993300","0099FF","FF0099","00FF00","330099",
                             "0099FF","FF0099","00FF00","330099","CC00FF","993300","0099FF","FF0099","00FF00","330099");                      
        arrowImages = new Array(200);
        for(s=0;s<lineColor2.length;s++){
		   var j = 0;
		   for (i=0;i<18;i++){
		     var idnx = "a"+lineColor2[s]+"-"+j;
			 arrowImages[idnx] = new Image(30,30);
			 arrowImages[idnx].src = "images/adarrow/" + idnx + ".gif";
			 j+=20;
		   }        
		}
		arrowImages[360] = new Image();
		//arrowImages[360].src = "images/Markers/circle5.gif";
		arrowImages[360].src = "images/last.gif";
  var deviceList; // = new Array(device);
  var devicekeys = new Array(0);
  var lineColor = new Array("#0099FF","#FF0099","#00FF00","#330099","#CC00FF","#993300","#0099FF","#FF0099","#00FF00","#330099",
                            "#0099FF","#FF0099","#00FF00","#330099","#CC00FF","#993300","#0099FF","#FF0099","#00FF00","#330099",
                            "#0099FF","#FF0099","#00FF00","#330099","#CC00FF","#993300","#0099FF","#FF0099","#00FF00","#330099");
      
    /*var lineColor = new Array(new Microsoft.Maps.Color(100,0,153,255),
                            new Microsoft.Maps.Color(100,255,0,153),
                            new Microsoft.Maps.Color(100,0,255,0),
                            new Microsoft.Maps.Color(100,51,0,153),
                            new Microsoft.Maps.Color(100,204,0,255),
                            new Microsoft.Maps.Color(100,153,51,0),
                            new Microsoft.Maps.Color(100,102,0,204),
                            new Microsoft.Maps.Color(100,0,153,204),
                            new Microsoft.Maps.Color(100,0,51,51),
                            new Microsoft.Maps.Color(100,51,0,0), 
                            new Microsoft.Maps.Color(100,0,153,255),
                            new Microsoft.Maps.Color(100,255,0,153),
                            new Microsoft.Maps.Color(100,0,255,0),
                            new Microsoft.Maps.Color(100,51,0,153),
                            new Microsoft.Maps.Color(100,204,0,255),
                            new Microsoft.Maps.Color(100,153,51,0),
                            new Microsoft.Maps.Color(100,102,0,204),
                            new Microsoft.Maps.Color(100,0,153,204),
                            new Microsoft.Maps.Color(100,0,51,51),
                            new Microsoft.Maps.Color(100,51,0,0),
                            new Microsoft.Maps.Color(100,0,153,255),
                            new Microsoft.Maps.Color(100,255,0,153),
                            new Microsoft.Maps.Color(100,0,255,0),
                            new Microsoft.Maps.Color(100,51,0,153),
                            new Microsoft.Maps.Color(100,204,0,255),
                            new Microsoft.Maps.Color(100,153,51,0),
                            new Microsoft.Maps.Color(100,102,0,204),
                            new Microsoft.Maps.Color(100,0,153,204),
                            new Microsoft.Maps.Color(100,0,51,51),
                            new Microsoft.Maps.Color(100,51,0,0)); 
     */                    
  /* lineColor = new Array(new Microsoft.Maps.Color(0,153,255,0.8),
                            new Microsoft.Maps.Color(255,0,153,0.8),
                            new Microsoft.Maps.Color(0,255,0,0.8),
                            new Microsoft.Maps.Color(51,0,153,0.8),
                            new Microsoft.Maps.Color(204,0,255,0.8),
                            new Microsoft.Maps.Color(153,51,0,0.8),
                            new Microsoft.Maps.Color(102,0,204,0.8),
                            new Microsoft.Maps.Color(0,153,204,0.8),
                            new Microsoft.Maps.Color(0,51,51,0.8),
                            new Microsoft.Maps.Color(51,0,0,0.8), 
                            new Microsoft.Maps.Color(0,153,255,0.8),
                            new Microsoft.Maps.Color(255,0,153,0.8),
                            new Microsoft.Maps.Color(0,255,0,0.8),
                            new Microsoft.Maps.Color(51,0,153,0.8),
                            new Microsoft.Maps.Color(204,0,255,0.8),
                            new Microsoft.Maps.Color(153,51,0,0.8),
                            new Microsoft.Maps.Color(102,0,204,0.8),
                            new Microsoft.Maps.Color(0,153,204,0.8),
                            new Microsoft.Maps.Color(0,51,51,0.8),
                            new Microsoft.Maps.Color(51,0,0,0.8),
                            new Microsoft.Maps.Color(0,153,255,0.8),
                            new Microsoft.Maps.Color(255,0,153,0.8),
                            new Microsoft.Maps.Color(0,255,0,0.8),
                            new Microsoft.Maps.Color(51,0,153,0.8),
                            new Microsoft.Maps.Color(204,0,255,0.8),
                            new Microsoft.Maps.Color(153,51,0,0.8),
                            new Microsoft.Maps.Color(102,0,204,0.8),
                            new Microsoft.Maps.Color(0,153,204,0.8),
                            new Microsoft.Maps.Color(0,51,51,0.8),
                            new Microsoft.Maps.Color(51,0,0,0.8)); 
      */                    //255,0,0red;0,0,255blue;141,56,210Violet;106,40,126Medium Orchid4;56,124,68Sea Green4;198,142,23Goldenrod3
  
  var haveNewLocation = 0;
  var xmlDoc;
  var newDocument;
  var j = 1;
  var lastLocTimestamp;
  var lastLocIndex;
  var global_deviceId;
  var locationHistoryListDOMObj = null;
  var deviceListDOMObj;
  var deviceAllUpdateNew = false;
  var map = null;
  var myLatlng;
  	  var serverfbAlert = "Select a Device and click on map to pick a new center. Name it and define Radius.";
  	  
  function createInfoMarker(point, address, index, iconImage) {

  		var clickCount = parseInt(index);
		  var imagePath = "images/Markers/iconb" + clickCount + ".png"; //icon.image = "images/Markers/iconb" + clickCount + ".png";
  		if (iconImage)
  			imagePath = iconImage;
		  greyPlaneBitmap = new H.map.Icon(imagePath,{size:{ w: 30, h: 30 },anchor: { x: 15, y: 15}});
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
 		 return marker;
 }
  	  
  	    function createLastLocInfoMarker(point, address, index, iconImage) {
  	    //var icon = new GIcon();
  		var clickCount = parseInt(index);
  		//icon.image = "http://www.bountynetwork.com/images/marker" + clickCount + ".png";
  		//icon.image = "images/Markers/mf" + clickCount + ".png";
  		//alert("clickCount = " + clickCount);
  		  var imagePath = "images/Markers/iconb" + clickCount + ".png";
  		//alert("iconImage = " + iconImage);
  		
  		if (iconImage != null){
  			imagePath = iconImage;
   		}else{
   		}
  		  //alert("icon.image = " + icon.image);
		  greyPlaneBitmap = new H.map.Icon(imagePath,{size: { w: 30, h: 30 },anchor: { x: 15, y: 15}});
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
	      
     	  return marker;
  	  }
  	  
function toggleShapeLayers()
{
	if (document.getElementById("showall").checked)
	{
		if (map != null)
			;
			//map.ShowAllShapeLayers();
	}
	else 
	{
		getDeviceLocinfo2(global_deviceId);
	}
}
  
    function getDeviceLocinfo1(key){
        //alert("deviceID = " + key);
        locationHistoryListDOMObj = null;
        HideIntervalWindow();
        global_deviceId = key;
        //changeDisplayInfoXML(); //display device list
        retrieveDeviceLoc(key);	
        return false;				
  }

    function changeDisplayInfoForm(){
        
        var righttable = document.getElementById("tablep");
        var righttableChild = righttable.childNodes;
        //alert("changeDisplayToLocationHistoryInfoXML righttableChild length = " + righttableChild.length);
        if (righttable.hasChildNodes()){
          while ( righttable.childNodes.length >=1){
            righttable.removeChild(righttable.firstChild);
          }
        }
        var righttablebody = document.createElement("tbody");
        //var deviceListXML = newDocument.getElementsByTagName("deviceList");
        //alert("deviceListXML.length = "+ deviceListXML.length);
        //var deviceInfoSet = deviceListXML[0].childNodes;
        var accountStatus;
        var user;
        var dNickname;
        var dId;
        var deviceID;
         <s:iterator value="locationList" status="rr1">
              <s:if test="#rr1.index == 0">
              deviceID = '<s:property value="deviceid"/>' ;
            </s:if>
          </s:iterator>
              
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
    ///////////////////////////////////////////////          
        var righttable_row = document.createElement("tr");
        var righttable_column = document.createElement("td");
        var righttable_div = document.createElement("div");
        righttable_div.className = "decontents";
        righttable_div.style.height = "175px";
        
        <s:iterator value="deviceList" status="rr">
       //alert("items11[i].nodeName = "+items11[i].nodeName+ " and nodeTypa = " + items11[i].nodeType);
            accountStatus = "<s:property value='accountStatus'/>";
            user = "<s:property value='user'/>"; 
            dNickname = "<s:property value='deviceNickname'/>"; 
            dId =  "<s:property value='deviceId'/>";
            commuAge = "<s:property value='lastKnownLocationAgoValue'/>";
            pLevel =  "<s:property value='lastKnownPowerLevel'/>";
  				var righttable_span = document.createElement("span");
  				//righttable_span.className = "devinfo";				
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
              
              //righttable_span.onclick = new Function("evt", "getDeviceLocinfo2("+dId+");");
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
          </s:iterator>
         
          
          righttable_column.appendChild(righttable_div);
          righttable_row.appendChild(righttable_column);
          righttablebody.appendChild(righttable_row);
          righttable.appendChild(righttablebody);   
    } 
    
    var bm_layer_locations;
    var bm_layer_polyLines = [];
    var bingmapLocationsArray = [];
	 var group;
	 var ui;
	 var behavior;
    
  function initOnLoad(){    
    //setTopLevelTabImage('bt1','images/button_map_all_click.gif');
 
    var dataTime_1;var dataTime2;var lon_1;var lat_1;var speed_1;var speedUnit_1;
    var age_1; var address_1; var j=0;
    var user;var dNickName;var dId;
    bingmapLocationsArray = [];
	var platform = new H.service.Platform({
		app_id: '<%=heremapid%>',
		app_code: '<%=heremapcode%>',
		useCIT: false
		});
    var defaultLayers = platform.createDefaultLayers();
    //platform.configure(H.map.render.panorama.RenderEngine);
    map = new H.Map(document.getElementById("myMap"), defaultLayers.normal.map);
    behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

    ui = H.ui.UI.createDefault(map, defaultLayers);
    var mapSettings = ui.getControl('mapsettings');
    var zoom = ui.getControl('zoom');
    //var scalebar = ui.getControl('scalebar');
    //var panorama = ui.getControl('panorama');
    //panorama.setAlignment('bottom-left');
    mapSettings.setAlignment('top-left');
    zoom.setAlignment('top-left');
    //scalebar.setAlignment('top-left');
                
    var greyPlaneBitmap;
    group = new H.map.Group();
     map.addObject(group);

     var kk = 0;
        var i = 0;
        <s:iterator value="deviceList" status="rr">
        kk++;
        </s:iterator>
        deviceList = new Array(kk);
        devicekeys = new Array(kk);
     <s:iterator value="deviceList" status="rr">
     dNickname = "<s:property value='deviceNickname'/>"; 
     dId =  "<s:property value='deviceId'/>";

       <s:if test="#rr.index == 0">  
            user = "<s:property value='user'/>"; 
            //dNickname = "<s:property value='deviceNickname'/>"; 
            //dId =  "<s:property value='deviceId'/>";
            global_deviceId = dId;
            lastReception = "<s:property value='lastKnownGpsStatus'/>";
            pLevel =  "<s:property value='lastKnownPowerLevel'/>";
            dataTime2 =  "<s:property value='lastLocationOn'/>";
            if(user)
              document.getElementById("userName").innerHTML =  user;
            //if(dNickname)
            //  document.getElementById("Label2").innerHTML =  dNickname;
              
        <s:iterator value="locationList" status="rr1">
          <s:if test="#rr1.index == 0">
            dataTime_1='<s:property value="dateTime"/>';
            lon_1='<s:property value="longitude"/>';
            lat_1='<s:property value="latitude"/>';
            speed_1='<s:property value="speed"/>' ;
            speedUnit_1='<s:property value="speedUnit"/>';
            age_1='<s:property value="locationAge"/>';
            address_1='<s:property value="address1"/> <s:property value="city"/> <s:property value="state"/> <s:property value="zipCode"/>';            
          </s:if>
        </s:iterator>
       </s:if>
       //myLatlng = new google.maps.LatLng(lat_1,lon_1);
       //mapOptions = {
       //  zoom: 15,
       //  center: myLatlng,
       //  mapTypeId: google.maps.MapTypeId.ROADMAP
       //}
       //map = new google.maps.Map(document.getElementById("myMap"), mapOptions);
       
       var layer = null; //new Array(); //new VEShapeLayer();
       var layer_polyLine = new Array();  //new VEShapeLayer();
       bm_layer_polyLine = new Array();
       var device = new Array(8);
       device[0] = dId;
       device[1] = dNickname;
       device[2] = layer;
       device[3] = lineColor[i];
       device[6] = layer_polyLine;
       device[7] = lineColor2[i];
       deviceList[dId] = device;  
       devicekeys[i] = dId;      
       i++;
     </s:iterator>       
    var timestamp;var lon;var lat;var speed;var speedUnit;
    var age; var address; var index;  
    var address1; var address2; var addressId; var addressString; var city; var county; var dateTime;  var deviceNickname;
    var deviceid; var displaytime; var duration; var landMarkDescriptions;  var landMarkName; var landmarkId;
    var state; var timeSinceLastReport; var timestamp; var zipCode; var utcTimestamp; var course; var alert;
    //locationHistoryListDOMObj = document.createElement("locationList"); 
    var k = 0;
        <s:iterator value="locationList" status="rr3">
            address1 = '<s:property value="address1"/>';
            address2 = '<s:property value="address2"/>';
            addressId = '<s:property value="addressId"/>';
            addressString = '<s:property value="addressString"/>';
            city = '<s:property value="city"/>';
            county = '<s:property value="county"/>';  
            course = '<s:property value="course"/>';          
            dateTime='<s:property value="dateTime"/>';
            deviceNickname='<s:property value="deviceNickname"/>';
            deviceid='<s:property value="deviceid"/>';
            displaytime='<s:property value="displaytime"/>';
            duration='<s:property value="duration"/>';
            index = '<s:property value="index"/>';
            landMarkDescriptions = '<s:property value="landMarkDescriptions"/>';
            landMarkName = '<s:property value="landMarkName"/>';
            landmarkId = '<s:property value="landmarkId"/>';
            lat='<s:property value="latitude"/>';
            locationAge='<s:property value="locationAge"/>';            
            lon='<s:property value="longitude"/>';
            speed='<s:property value="speed"/>'; 
            speedUnit='<s:property value="speedUnit"/>';
            state = '<s:property value="state"/>';
            timeSinceLastReport = '<s:property value="timeSinceLastReport"/>';
            timestamp = '<s:property value="timestamp"/>';
            zipCode = '<s:property value="zipCode"/>';
            alert = '<s:property value="zkAlert"/>';
            deviceInterval = '<s:property value="zkDeviceinterval"/>';
            address='<s:property value="address1"/> <s:property value="city"/> <s:property value="state"/> <s:property value="zipCode"/>';            
            utctimestamp = <s:property value="timestamp"/>;
            did = deviceid;
            var address = "";
			  if (address1 != "null")
			    address = address1;
			  if (city != "null")
			    address = address +", "+city;
			  if (state != "null")
			    address = address +", "+state;
			  if (zipCode != "null")
			    address = address +" " + zipCode;
        
               if (k == 0){
                 lastLocTimestamp = utctimestamp;
                 //global_deviceId = did;

                  document.getElementById("dInfo1").innerHTML =  locationAge +" nearby " + address;
                  document.getElementById("dInfo2").innerHTML =  speed + " " +speedUnit;
                  document.getElementById("dInfo3").innerHTML =  deviceInterval;
                  var str1 = pLevel.split('%');
                  if (!isNaN(str1[0])){
                      if (str1[0] <= 10 && str1[0] >= 6 )
                          document.getElementById("dInfo4").style.color =  "yellow";
                        else if (str1[0] <= 5)
                      	  document.getElementById("dInfo4").style.color =  "red";
                        else  
                      	  document.getElementById("dInfo4").style.color =  "";
                  }
                  if (pLevel.length == 0)
                  	  pLevel = "n/a% ";
      		      if (pLevel == "%")
      		    	  pLevel = "n/a% ";
                  
                  if (pLevel.indexOf("%") == -1){
                	  pLevel = pLevel + "% ";
                  }  
                  document.getElementById("dInfo4").innerHTML =  pLevel + " at " + dataTime2;
                  //document.getElementById("dInfo5").innerHTML =  address;
                  document.getElementById("dInfo6").innerHTML =  lastReception + " satellite, power ";
                  var deviceIntervalArray = deviceInterval.split(" ");
                  if (!isNaN(deviceIntervalArray[0])&& (deviceIntervalArray[0]>0)){     
                     if ( globalPageRefreshInterval != deviceIntervalArray[0]) {
                        if (deviceIntervalArray[0] < 5)
                             globalPageRefreshInterval = 5;
                        else     
                             globalPageRefreshInterval = deviceIntervalArray[0];
                        //ID=setTimeout("reFreshfunc();",globalPageRefreshInterval * 1000);
                     }
                  }
                }
              //alert("allDeviceCurrentLocInit did = " + did);
               var device1 = deviceList[did];
               var currentPoint = new H.geo.Point(parseFloat(lat), parseFloat(lon)); //new Microsoft.Maps.Location(parseFloat(lat), parseFloat(lon)); //new VELatLong(parseFloat(lat), parseFloat(lon));
               //bounds.extend(new Microsoft.Maps.Location(parseFloat(lat), parseFloat(lon)));
               bingmapLocationsArray.push(new H.geo.Point(parseFloat(lat), parseFloat(lon)));
               //alert("currentPoint = " + currentPoint);
               //alert("currentPoint = " + currentPoint.lat()+";"+ currentPoint.lng());
               if (k == 0){
                  //map.setCenter(currentPoint);
                  // map.setView({center:currentPoint});
                  var point2 = new H.geo.Point(parseFloat(lat), parseFloat(lon));
                  map.setCenter(point2);
               }
               //var currentShapePoint = new VEShape(VEShapeType.Pushpin, currentPoint);
               //currentShapePoint.SetTitle(device1[1]);
               var str = device1[1]+':'+timestamp+'<br>Speed:&nbsp;'+speed+'<br>address:&nbsp;'+address;
               //currentShapePoint.SetDescription(str);
               var course1 = course;
               if (course1 == 'null'){
                  course1 = 360; 
               }
               if (speed <= <%=ZeroSpeed%>){
                  course1 = 360;
               }
                //alert("course1 = " + course1);
               if (course1 == 360)
	               {
	                 marker = createLastLocInfoMarker(currentPoint, str, index, arrowImages[course1].src);
	               }
	             else
	               {
	                 var idx = "a"+device1[7]+"-"+course1;
	                 marker = createLastLocInfoMarker(currentPoint, str, index, arrowImages[idx].src);
	               }    
               map.addObject(marker);
              device1[2] = marker;
              //bm_layer_locations.push(marker);
               //device1[2].AddShape(currentShapePoint);
               device1[4] = currentPoint; //currentShapePoint;
               device1[5] = 0;
               deviceList[did] = device1;
            
            <s:if test="#rr3.index == 0">
 
              
            </s:if>
            <s:if test="#rr3.index != 0">
             
            </s:if>
          j++; 
          k++; 
        </s:iterator>
	      //if (map.getZoom() <= 4 || map.getZoom() >= 18){
	    	  if (map.getZoom() <= 4 || map.getZoom() >= 18){
	    		  map.setZoom(14);
		      }     
        changeDisplayInfoForm();
        deviceAllUpdateNew = true;
        getDeviceLocinfo1(global_deviceId);
            //}
    
    } 
    
     function retrieveDeviceLoc(did){
           //document.forms[0].selectType[2].checked = true;
           selectType = 3;

        var date = new Date().getTime();
     if (deviceAllUpdateNew)
       url = url = "dd.action?viewOptions.mapAll=21&timestamp="+lastLocTimestamp+"&viewOptions.returnCode=xml&d="+date;
     else  
       url = url = "dd.action?viewOptions.mapAll=21&viewOptions.returnCode=xml&d="+date;
       
       //alert(url);
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
      	req.open("GET", url, true); //was get
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
        req.onreadystatechange = processResponseRetrieveDeviceDataXML;
        req.open("GET", url, true);
        req.send();
      }
    }    
  } 
  
     function retrieveDeviceLocForAllDevices(){
 
           //document.forms[0].selectType[2].checked = true;
           selectType = 3;

        var date = new Date().getTime();
     if (deviceAllUpdateNew)
       url = url = "dd.action?viewOptions.mapAll=21&timestamp="+lastLocTimestamp+"&viewOptions.returnCode=xml&d="+date;
     else  
       url = url = "dd.action?viewOptions.mapAll=21&viewOptions.returnCode=xml&d="+date;
     //alert("retrieveDeviceLocForAllDevices url = " + url);
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
      	req.open("GET", url, true); //was get
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
        req.onreadystatechange = processResponseRetrieveDeviceDataXML;
        req.open("GET", url, true);
        req.send();
      }
    }    
  }
  
  function processResponseRetrieveDeviceDataXML() {
      HideProgressBar();
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
        if(deviceAllUpdateNew){
           allDeviceCurrentLocUpdateNew();
        }else{
           allDeviceCurrentLocInit();
           deviceAllUpdateNew = true;
        }
        haveNewLocation++;
       } else {
        alert("Internet connection interrupted:\n " + req.statusText);
        returnToLoginPage();
       }
      //}catch(e){
      //  alert("Internet connection interrupted:\n " + e);
      //  returnToLoginPage();       
      //}
    }
  }
  
  function allDeviceCurrentLocInit(){
  //alert("go allDeviceCurrentLocInit()");
       j=0;
     haveNewLocation = 0;
     //alert("allDeviceCurrentLocInit = " + map +"; "+myLatlng);
     bingmapLocationsArray = [];
     if (!map){
			var platform = new H.service.Platform({
				app_id: '<%=heremapid%>',
				app_code: '<%=heremapcode%>',
				useCIT: false
				});
            var defaultLayers = platform.createDefaultLayers();
            //platform.configure(H.map.render.panorama.RenderEngine);
            map = new H.Map(document.getElementById("myMap"), defaultLayers.normal.map);
            behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

            ui = H.ui.UI.createDefault(map, defaultLayers);
            var mapSettings = ui.getControl('mapsettings');
            var zoom = ui.getControl('zoom');
            //var scalebar = ui.getControl('scalebar');
            //var panorama = ui.getControl('panorama');
            //panorama.setAlignment('bottom-left');
            mapSettings.setAlignment('top-left');
            zoom.setAlignment('top-left');
            //scalebar.setAlignment('bottom-left');
                        
            var greyPlaneBitmap;
            group = new H.map.Group();
             map.addObject(group);
   } 
        var deviceListXML = newDocument.getElementsByTagName("deviceList");
      //alert("deviceListXML.length = "+ deviceListXML.length);
      //deviceList = new Array(deviceListXML.length);
      //alert("deviceList.length = "+ deviceList.length);
      var deviceInfoSet = deviceListXML[0].childNodes;
      //alert("deviceInfoSet.length = "+ deviceInfoSet.length);
      deviceList = new Array(deviceInfoSet.length);
      devicekeys = new Array(deviceInfoSet.length);
      //alert("deviceList.length = "+ deviceList.length);
      var user;
      var dNickname;
      var dId;
      var deviceID;
      var pLevel;
      var lastReception;
      var dateTime1;
      for( var i=0; i < deviceInfoSet.length; i++){
            var itemList11 = deviceInfoSet[i].childNodes;
            user = itemList11[22].childNodes[0].nodeValue; 
            dNickname = itemList11[6].childNodes[0].nodeValue;
            dId =  itemList11[4].childNodes[0].nodeValue;
            //alert("dId i = " + dId  + "," + i);
            if (dId == global_deviceId){
              lastReception = itemList11[11].childNodes[0].nodeValue;
              pLevel =  itemList11[14].childNodes[0].nodeValue;
              dateTime1 =  itemList11[15].childNodes[0].nodeValue;
              //pLevel = pLevel+" "+dateTime1;
            }
            
            var layer = null; //new Array(); //new VEShapeLayer();
            var layer_polyLine = new Array();  //new VEShapeLayer();
            //bm_layer_locations = new Microsoft.Maps.EntityCollection();
            //var bm_layer_locations_opt = new Microsoft.Maps.EntityCollectionOptions(); 
            //bm_layer_locations_opt.zIndex = "2";
            //bm_layer_locations.setOptions(bm_layer_locations_opt);
            bm_layer_polyLine = new Array();
            //bm_layer_polyLines = new Microsoft.Maps.EntityCollection();
            //bm_layer_polyLines.setOptions({zIndex:'6'});
            //map.entities.push(bm_layer_locations);
            //map.entities.push(bm_layer_polyLines);
                 
            //map.AddShapeLayer(layer);
            //map.AddShapeLayer(layer_polyLine);
            var device = new Array(8);
            device[0] = dId;
            device[1] = dNickname;
            device[2] = layer;
            device[3] = lineColor[i];
            device[6] = layer_polyLine;
            device[7] = lineColor2[i];
            deviceList[dId] = device;
            devicekeys[i] = dId;        
      }
     
      //changeDisplayInfoXML();
        
     //}
     if (newDocument){
         changeDisplayInfoXML();
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
           
     
       //var xmlString = new XMLSerializer().serializeToString(newDocument);
      //document.writeln("newDocument.toString() = " + xmlString);
      var deviceListXML = newDocument.getElementsByTagName("deviceList");
      //alert("deviceList.length = "+ deviceListXML.length);
      var deviceInfoSet = deviceListXML[0].childNodes;
      //alert("deviceInfoSet.length = "+ deviceInfoSet.length);
          
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
           //if(index == index_d){
           //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);
              var address1 = deviceLocInfoList[0].childNodes[0].nodeValue;
              var address2 = deviceLocInfoList[1].childNodes[0].nodeValue;
              var city = deviceLocInfoList[4].childNodes[0].nodeValue;
              var country = deviceLocInfoList[5].childNodes[0].nodeValue;
              var course = deviceLocInfoList[6].childNodes[0].nodeValue;
              var timestamp = deviceLocInfoList[7].childNodes[0].nodeValue;
              var dName = deviceLocInfoList[8].childNodes[0].nodeValue;
              var did = deviceLocInfoList[9].childNodes[0].nodeValue;
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
              var deviceInterval = deviceLocInfoList[26].childNodes[0].nodeValue;
              //alert("deviceInterval = " + deviceInterval);
              
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
              
                     if (k == 0){
                       lastLocTimestamp = utctimestamp;
                       global_deviceId = did;

                        document.getElementById("dInfo1").innerHTML =  locationAge + " nearby " + address;
                        document.getElementById("dInfo2").innerHTML =  speed + " " +speedUnit;
                        document.getElementById("dInfo3").innerHTML =  deviceInterval;
                        if (pLevel.length == 0)
                        	pLevel = "n/a% ";
            		    if (pLevel == "%")
            		    	pLevel = "n/a% ";
                                    
                        if (pLevel.indexOf("%") == -1){
                      	  pLevel = pLevel + "% ";
                        }  
                        document.getElementById("dInfo4").innerHTML =  pLevel + " at " + dateTime1;
                        //document.getElementById("dInfo5").innerHTML =  address;
                        document.getElementById("dInfo6").innerHTML =  lastReception + " satellite, power ";
                        var deviceIntervalArray = deviceInterval.split(" ");
                        if (!isNaN(deviceIntervalArray[0])&& (deviceIntervalArray[0]>0)){     
                           if ( globalPageRefreshInterval != deviceIntervalArray[0]) {
                              if (deviceIntervalArray[0] < 5)
                                   globalPageRefreshInterval = 5;
                              else     
                                   globalPageRefreshInterval = deviceIntervalArray[0];
                              //ID=setTimeout("reFreshfunc();",globalPageRefreshInterval * 1000);
                           }
                        }
                      }
                     //alert("allDeviceCurrentLocInit did = " + did);
                     var device1 = deviceList[did];
                     var currentPoint = new H.geo.Point(parseFloat(lat), parseFloat(lon)); //new Microsoft.Maps.Location(parseFloat(lat), parseFloat(lon)); //new VELatLong(parseFloat(lat), parseFloat(lon));
                     //bounds.extend(new google.maps.LatLng(parseFloat(lat), parseFloat(lon)));
                     bingmapLocationsArray.push(new H.geo.Point(parseFloat(lat), parseFloat(lon)));                     
                     //alert("currentPoint = " + currentPoint);
                     //alert("currentPoint = " + currentPoint.lat()+";"+ currentPoint.lng());
                     if (k == 0){
                       // map.setCenter(currentPoint);
                        //map.setView({center:currentPoint});
                       var point2 = new H.geo.Point(parseFloat(lat), parseFloat(lon));
                       map.setCenter(point2);
                     }
                     //var currentShapePoint = new VEShape(VEShapeType.Pushpin, currentPoint);
                     //currentShapePoint.SetTitle(device1[1]);
                     var str = device1[1]+':'+timestamp+'<br>Speed:&nbsp;'+speed+'<br>address:&nbsp;'+address;
                     //currentShapePoint.SetDescription(str);
                     var course1 = course;
                     if (course1 == 'null'){
                        course1 = 360; 
                     }
                     if (speed <= <%=ZeroSpeed%>){
                        course1 = 360;
                     }
                      //alert("course1 = " + course1);
                     if (course1 == 360)
		               {
		                 marker = createLastLocInfoMarker(currentPoint, str, index, arrowImages[course1].src);
		               }
		             else
		               {
		                 var idx = "a"+device1[7]+"-"+course1;
		                 marker = createLastLocInfoMarker(currentPoint, str, index, arrowImages[idx].src);
		               } 
                     map.addObject(marker);
                    device1[2] = marker;
                    //bm_layer_locations.push(marker);
                     //device1[2].AddShape(currentShapePoint);
                     device1[4] = currentPoint; //currentShapePoint;
                     device1[5] = 0;
                     deviceList[did] = device1;
                     j++;
            }  
          } //end of for(var k=0; k < itemList.length; k++)
	      if (map.getZoom() <= 4 || map.getZoom() >= 18){
		        // Get the existing options.
		        map.setZoom(14);
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
         //if(user)
         //     document.getElementById("Label1").innerHTML =  user;
         //if(dNickname)
         //     document.getElementById("Label2").innerHTML =  "";                
      }
      
    changeDisplayInfoXML();
	//adjust map view
	getDeviceLocinfo2(global_deviceId);
	
  }
  
    function allDeviceCurrentLocUpdateNew(){
  //alert("go allDeviceCurrentLocUpdateNew()");
       j=0;
     haveNewLocation = 0;
      var deviceListXML = newDocument.getElementsByTagName("deviceList");
      //alert("deviceListXML.length = "+ deviceListXML.length);
      var deviceInfoSet = deviceListXML[0].childNodes;
      var user = deviceInfoSet[0].childNodes[22].childNodes[0].nodeValue;
      var dNickname;
      var dId;
      var deviceID;
      var pLevel;
      var lastReception;
      var dateTime1;
      
        for( var i=0; i < deviceInfoSet.length; i++){
            var itemList11 = deviceInfoSet[i].childNodes;
            user = itemList11[22].childNodes[0].nodeValue; 
            dId =  itemList11[4].childNodes[0].nodeValue;
            if (dId == global_deviceId){
              dNickname = itemList11[6].childNodes[0].nodeValue;
              lastReception = itemList11[11].childNodes[0].nodeValue;
              pLevel =  itemList11[14].childNodes[0].nodeValue;
              dateTime1 =  itemList11[15].childNodes[0].nodeValue;
              //pLevel = pLevel + " " + dateTime;
            }
        }
      
      //delete all polylines if uncheck drawPolyline box
      if (!document.getElementById("drawPolyline").checked){      
        for( var i=0; i < deviceInfoSet.length; i++){
            var itemList11 = deviceInfoSet[i].childNodes;
            user = itemList11[22].childNodes[0].nodeValue; 
            dNickname = itemList11[6].childNodes[0].nodeValue;
            dId =  itemList11[4].childNodes[0].nodeValue;
            //pLevel =  itemList11[14].childNodes[0].nodeValue;
            var device2 = deviceList[dId]; 
            var shape;
            //for(var ii = 0; ii < device2[6].GetShapeCount(); ii++){
            //   shape = device2[6].GetShapeByIndex(ii);
            //   device2[6].DeleteShape(shape);
            //}
            for(var ii = 0; ii < device2[6].length; ii++){
                //shape = device2[6].GetShapeByIndex(ii);
                device2[6][ii] = null;
                device2[6][ii] = [];
             }
            device2[6] = [];
             
        }
        //bm_layer_polyLines = null;
        //bm_layer_polyLines = new Microsoft.Maps.EntityCollection();
        //bm_layer_polyLines.setOptions({zIndex:'6'});
        //map.entities.push(bm_layer_locations);
        //map.entities.push(bm_layer_polyLines);
            
      }
      
     //alert("allDeviceCurrentLocUpdateNew = " + map +"; "+myLatlng);
     //if (map == null){
     if (!map){
         //alert("allDeviceCurrentLocUpdateNew map is null");
 			var platform = new H.service.Platform({
 				app_id: '<%=heremapid%>',
 				app_code: '<%=heremapcode%>',
				useCIT: false
				});
            var defaultLayers = platform.createDefaultLayers();
            //platform.configure(H.map.render.panorama.RenderEngine);
            map = new H.Map(document.getElementById("myMap"), defaultLayers.normal.map);
            behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));

            ui = H.ui.UI.createDefault(map, defaultLayers);
            var mapSettings = ui.getControl('mapsettings');
            var zoom = ui.getControl('zoom');
            //var scalebar = ui.getControl('scalebar');
            //var panorama = ui.getControl('panorama');
            //panorama.setAlignment('bottom-left');
            mapSettings.setAlignment('top-left');
            zoom.setAlignment('top-left');
            //scalebar.setAlignment('bottom-left');
                        
            var greyPlaneBitmap;
            group = new H.map.Group();
             map.addObject(group);
      //alert("deviceInfoSet.length = "+ deviceInfoSet.length);
      deviceList = new Array(deviceInfoSet.length);
      for( var i=0; i < deviceInfoSet.length; i++){
            var itemList11 = deviceInfoSet[i].childNodes;
            user = itemList11[22].childNodes[0].nodeValue; 
            dNickname = itemList11[6].childNodes[0].nodeValue;
            dId =  itemList11[4].childNodes[0].nodeValue;
            var layer = new Array(); //new VEShapeLayer();
            //map.AddShapLayer(layer);
            var device = new Array();
            device[0] = dId;
            device[1] = dNickname;
            device[2] = layer;
            device[7] = lineColor2[i];
            deviceList[dId] = device;        
      }
      //alert(  "deviceList size = " + deviceList.length);     
     }else{       
     //alert("allDeviceCurrentLocUpdateNew map is NOT null");
     }
     if (newDocument){
         changeDisplayInfoXML();
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
           //if(index == index_d){
           //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);
              var address1 = deviceLocInfoList[0].childNodes[0].nodeValue;
              var address2 = deviceLocInfoList[1].childNodes[0].nodeValue;
              var city = deviceLocInfoList[4].childNodes[0].nodeValue;
              var country = deviceLocInfoList[5].childNodes[0].nodeValue;
              var course = deviceLocInfoList[6].childNodes[0].nodeValue;
              var timestamp = deviceLocInfoList[7].childNodes[0].nodeValue;
              var dName = deviceLocInfoList[8].childNodes[0].nodeValue;
              var did = deviceLocInfoList[9].childNodes[0].nodeValue;
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
              var deviceInterval = deviceLocInfoList[26].childNodes[0].nodeValue;
              //alert("deviceInterval = " + deviceInterval);
              
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
              
                 var device1 = deviceList[did];
                 
                 if (did == device1[0]){
                   var veShapePoint_last = device1[4]; //last point
                   var vePoint = veShapePoint_last; //veShapePoint_last.GetPoints();
                   var currentPoint =   new H.geo.Point(parseFloat(lat), parseFloat(lon)); //new Microsoft.Maps.Location(parseFloat(lat), parseFloat(lon));  //new VELatLong(parseFloat(lat), parseFloat(lon));
                   //alert("lat and vePoint.Latitude = " + currentPoint.lat + ", " + vePoint.lat + " ;;; " +"lon and vePoint.Longitude = " + currentPoint.lng + ", " + vePoint.lng );
                   //alert("lon and vePoint.Longitude = " + currentPoint.Longitude + ", " + vePoint[0].Longitude);
                   //if(currentPoint.latitude != vePoint.latitude || currentPoint.longitude != vePoint.longitude){
                   if(currentPoint.lat != vePoint.lat || currentPoint.lng != vePoint.lng){
                     if (k == 0){
                       lastLocTimestamp = utctimestamp;
                     }
                     var lat_old = vePoint.lat;
                     var lon_old = vePoint.lng;
                     //device1[2] = currentPoint; //.DeleteShape(veShapePoint_last);
                     var lastPoint = veShapePoint_last; //new VELatLong(lat_old, lon_old);
                    //var currentPoint = new VELatLong(lat, lon);
                     //var currentShapePoint = new VEShape(VEShapeType.Pushpin, currentPoint);
                     //currentShapePoint.SetTitle(device1[1]);
                     var str = device1[1]+':'+timestamp+'<br>Speed:&nbsp;'+speed+'<br>address:&nbsp;'+address;
                     //currentShapePoint.SetDescription(str);
                     var course1 = course;
                     //alert("course = " + course);
                     if (course1 == 'null'){
                        course1 = 360; 
                     }
                     if (speed <= <%=ZeroSpeed%>){
                        course1 = 360;
                     }
                     //map.removeOverlay(device1[2]); //remove old marker overlay
                     //device1[2].setMap(null);
                     //map.entities.remove(device1[2]);
                     map.removeObject(device1[2]);
                     if (course1 == '360' || course1 == 360)
		               {
		                 //currentShapePoint.SetCustomIcon("<div style='color:Red; border:none; font-size: 9px; font-weight: bold; LEFT: -2px; TOP: 0px; POSITION: relative; text-decoration:none;'><img style = 'LEFT: 0px; TOP: 0px; POSITION: relative;' src = '" + arrowImages[course1].src + "' />" + device1[1] + "</div>");
		                 marker = createInfoMarker(currentPoint, str, index, arrowImages[course1].src);
		                 
		               }
		             else
		               {
		                 var idx = "a"+device1[7]+"-"+course1;
		                 //currentShapePoint.SetCustomIcon("<div style='color:Red; border:none; font-size: 9px; font-weight:bold; LEFT: -2px; TOP: 0px; POSITION: relative; text-decoration:none;'><img style = 'LEFT: 0px; TOP: 0px; POSITION: relative;' src = '" + arrowImages[idx].src + "' /> " + device1[1] + "</div>");
		                 marker = createInfoMarker(currentPoint, str, index, arrowImages[idx].src);
		                 		                 
		               }    
                     map.addObject(marker); 
                     //map.addOverlay( marker); 
                     //marker.setMap(map);     	 
                     if (global_deviceId == did){
                        //map.setCenter(currentPoint);
                        //map.setView({center:currentPoint});
                        map.setCenter(currentPoint);
                     }
                     //map.removeOverlay(device1[2]);
                     //device1[2].setMap(null);
                     //map.entities.remove(device1[2]);
                     //map.removeObject(device1[2]);
                     device1[2] = marker;  //.AddShape(currentShapePoint);
                     //var lastPoint = device1[4];
                     var l = device1[5];
                     var strip;
                     if (document.getElementById("drawPolyline").checked == true){

                       strip = new H.geo.Strip();
                       strip.pushPoint(lastPoint);
                       strip.pushPoint(currentPoint);
                        //pointArr.push(new H.geo.Point(sell.options[y].point.latitude, sell.options[y].point.longitude));
     				
     				
     				var polyline = new H.map.Polyline(strip, {
     					style:{strokeColor: device1[3],lineWidth: 3}
     				});
     				
     				map.addObject(polyline);
                       // Add the polyline to the map
                       //map.entities.push(polyline); 
                       bm_layer_polyLines.push(polyline);                 
                       device1[6] = polyline; //.AddShape(polyline);
                     }
                     device1[4] = currentPoint;
                     device1[5] = l++;
                     deviceList[did] = device1;
                     j++;
                   
                   }
                   
                   if (global_deviceId == did){
                        document.getElementById("dInfo1").innerHTML =  locationAge + " nearby " + address ;
                        document.getElementById("dInfo2").innerHTML =  speed + " " +speedUnit;
                        document.getElementById("dInfo3").innerHTML =  deviceInterval;
                        var str1 = pLevel.split('%');
                        if (!isNaN(str1[0])){
                            if (str1[0] <= 10 && str1[0] >= 6 )
                                document.getElementById("dInfo4").style.color =  "yellow";
                              else if (str1[0] <= 5)
                            	  document.getElementById("dInfo4").style.color =  "red";
                              else  
                            	  document.getElementById("dInfo4").style.color =  "";
                        } 
                        if (pLevel.length == 0)
                        	pLevel = "n/a% ";
            		    if (pLevel == "%")
            		    	pLevel = "n/a% ";
                                    
                        if (pLevel.indexOf("%") == -1){
                      	  pLevel = pLevel + "% ";
                        }                                               
                        document.getElementById("dInfo4").innerHTML =  pLevel + " at " + dateTime1;
                        //document.getElementById("dInfo5").innerHTML =  address;
                        document.getElementById("dInfo6").innerHTML =  lastReception + " satellite, power ";
                        var deviceIntervalArray = deviceInterval.split(" ");
                        if (!isNaN(deviceIntervalArray[0])&& (deviceIntervalArray[0]>0)){                           
                           if ( globalPageRefreshInterval != deviceIntervalArray[0]) {
                              if (deviceIntervalArray[0] < 5)
                                   globalPageRefreshInterval = 5;
                              else      
                                   globalPageRefreshInterval = deviceIntervalArray[0];
                              //ID=setTimeout("reFreshfuncDoNothing();",globalPageRefreshInterval * 1000);
                           }
                        }                        
                   }
                   
                 
                 }
              
  
            }  
          } //end of for(var k=0; k < itemList.length; k++)
        
         /////////////////////////////////////////
         
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
         //if(user)
         //     document.getElementById("Label1").innerHTML =  user;
         //if(dNickname)
         //     document.getElementById("Label2").innerHTML =  "";                
      }
      
    //if (map != null && document.getElementById("showall").checked)
		//map.ShowAllShapeLayers();
    //gcalendar.refresh();
    //changeDisplayInfo();  
  }
 
    function ChangeToSelectedDeviceCurrentLocInfo(){
  //alert("go allDeviceCurrentLocUpdateNew()");
       j=0;
     haveNewLocation = 0;
      var deviceListXML = newDocument.getElementsByTagName("deviceList");
      //alert("deviceListXML.length = "+ deviceListXML.length);
      var deviceInfoSet = deviceListXML[0].childNodes;
      var user = deviceInfoSet[0].childNodes[22].childNodes[0].nodeValue;
      var dNickname;
      var dId;
      var deviceID;
      var pLevel;
      var lastReception;
      var dateTime1;
        for( var i=0; i < deviceInfoSet.length; i++){
            var itemList11 = deviceInfoSet[i].childNodes;
            user = itemList11[22].childNodes[0].nodeValue; 
            dId =  itemList11[4].childNodes[0].nodeValue;
            if (dId == global_deviceId){
              dNickname = itemList11[6].childNodes[0].nodeValue;
              lastReception = itemList11[11].childNodes[0].nodeValue;             
              pLevel =  itemList11[14].childNodes[0].nodeValue;
              dateTime1 =  itemList11[15].childNodes[0].nodeValue;
            }
        }      
     
     if (newDocument){
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
           //if(index == index_d){
           //alert("deviceLocInfoList.length = "+ deviceLocInfoList.length);
              var address1 = deviceLocInfoList[0].childNodes[0].nodeValue;
              var address2 = deviceLocInfoList[1].childNodes[0].nodeValue;
              var city = deviceLocInfoList[4].childNodes[0].nodeValue;
              var country = deviceLocInfoList[5].childNodes[0].nodeValue;
              var course = deviceLocInfoList[6].childNodes[0].nodeValue;
              var timestamp = deviceLocInfoList[7].childNodes[0].nodeValue;
              var dName = deviceLocInfoList[8].childNodes[0].nodeValue;
              var did = deviceLocInfoList[9].childNodes[0].nodeValue;
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
              var deviceInterval = deviceLocInfoList[26].childNodes[0].nodeValue;
              //alert("deviceInterval = " + deviceInterval);
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
                   if (global_deviceId == did){
                        document.getElementById("dInfo1").innerHTML =  locationAge + " nearby " + address;
                        document.getElementById("dInfo2").innerHTML =  speed + " " +speedUnit;
                        document.getElementById("dInfo3").innerHTML =  deviceInterval;
                        var str1 = pLevel.split('%');
                        if (!isNaN(str1[0])){
                            if (str1[0] <= 10 && str1[0] >= 6 )
                                document.getElementById("dInfo4").style.color =  "yellow";
                              else if (str1[0] <= 5)
                            	  document.getElementById("dInfo4").style.color =  "red";
                              else  
                            	  document.getElementById("dInfo4").style.color =  "";
                        } 
                        if (pLevel.length == 0)
                        	pLevel = "n/a% ";
            		    if (pLevel == "%")
            		    	pLevel = "n/a% ";
                                     
                        if (pLevel.indexOf("%") == -1){
                      	  pLevel = pLevel + "% ";
                        }                                                    
                        document.getElementById("dInfo4").innerHTML =  pLevel + " at " + dateTime1;
                        //document.getElementById("dInfo5").innerHTML =  address;
                        document.getElementById("dInfo6").innerHTML =  lastReception + " satellite, power ";
                        var deviceIntervalArray = deviceInterval.split(" ");
                        if (!isNaN(deviceIntervalArray[0])&& (deviceIntervalArray[0]>0)){                           
                           if ( globalPageRefreshInterval != deviceIntervalArray[0]) { 
                              if (deviceIntervalArray[0] < 5)
                                   globalPageRefreshInterval = 5;
                              else 
                                   globalPageRefreshInterval = deviceIntervalArray[0];
                              clearTimeout(ID); 
                              ID=setTimeout("reFreshfunc();",globalPageRefreshInterval * 1000);
                           }
                        }
                   }                
            }  
           }  
          } //end of for(var k=0; k < itemList.length; k++)         
      }
    
  function getDeviceLocinfo2(key){
        //alert("deviceID = " + key);
        locationHistoryListDOMObj = null;
        
        global_deviceId = key;
        try{
        var device1 = deviceList[global_deviceId];
        var veShapePoint_last = device1[4];
        var vePoint = veShapePoint_last; //.GetPoints();
        //map.setCenter(vePoint);
        //map.setView({center:vePoint});
        map.setCenter(vePoint);
	      //if ( map.getZoom() >= 18){
		        // Get the existing options.
	            //var options = map.getOptions();
	            // Set the zoom level of the map
	            //options.zoom = 14;
	            //map.setView(options);	 
		 //     }     
      
		//map.ShowAllShapeLayers();
		//{
			document.getElementById("showall").checked= false;
		//    map.PanToLatLong(vePoint[0]);
		//	map.SetMapView(vePoint);
		//	var zoomLevel = map.GetZoomLevel();
	    //	var realZoom = zoomLevel-6;
		//	if (realZoom < 1)
		//	realZoom = 1;
	    //	map.SetZoomLevel(realZoom);
		//}
        }catch(e){}
        HideIntervalWindow();
        HidePollingWindow();
        //HideGeofenceWindow();        
        changeDisplayInfoXML(); //display device list
        ChangeToSelectedDeviceCurrentLocInfo();			
  }
  
  function changeDisplayInfoXML(){
      
      var righttable = document.getElementById("tablep");
      var righttableChild = righttable.childNodes;
      //alert("changeDisplayToLocationHistoryInfoXML righttableChild length = " + righttableChild.length);
      if (righttable.hasChildNodes()){
        while ( righttable.childNodes.length >=1){
          righttable.removeChild(righttable.firstChild);
        }
      }
      var righttablebody = document.createElement("tbody");
      var deviceListXML = newDocument.getElementsByTagName("deviceList");
      //alert("deviceListXML.length = "+ deviceListXML.length);
      var deviceInfoSet = deviceListXML[0].childNodes;
      var accountStatus;
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
      righttable_div.className = "decontents";
      righttable_div.style.height = "175px";
      
      for(var i=0; i < deviceInfoSet.length; i++){
     //alert("items11[i].nodeName = "+items11[i].nodeName+ " and nodeTypa = " + items11[i].nodeType);
            var itemList11 = deviceInfoSet[i].childNodes;
            accountStatus = itemList11[0].childNodes[0].nodeValue;;//accountStatus
            user = itemList11[22].childNodes[0].nodeValue; 
            dNickname = itemList11[6].childNodes[0].nodeValue;
            dId =  itemList11[4].childNodes[0].nodeValue;
            commuAge =  itemList11[12].childNodes[0].nodeValue;//lastKnownLocationAgoValue
            pLevel =  itemList11[14].childNodes[0].nodeValue; //13
            //var righttable_row = document.createElement("tr");
				//if (deviceID == dId){
				
				var righttable_span = document.createElement("span");
				//righttable_span.className = "devinfo";				
				
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
            
            righttable_span.onclick = new Function("evt", "getDeviceLocinfo2("+dId+");");
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
  
  function DeleteAllPolyline(){
      //delete all polylines if uncheck drawPolyline box
      var deviceListXML = newDocument.getElementsByTagName("deviceList");
      //alert("deviceListXML.length = "+ deviceListXML.length);
      var deviceInfoSet = deviceListXML[0].childNodes;
      var dId;
      //alert("delete all lines 1");
      if (!document.getElementById("drawPolyline").checked){ 
    	  //alert("delete all lines 2"); 
          //map.clearOverlays();
          //for(var aa = 0; aa < devicekeys.length; aa++){
          //  var key = devicekeys[aa];
          //  device6 = deviceList[key];  
          //  for(var ii = 0; ii < device6[6].length; ii++){
          //    //shape = device2[6].GetShapeByIndex(ii);
           //   device6[6][ii].setMap(null);
          //  }
          //}  
          for( var i=0; i < deviceInfoSet.length; i++){
              var itemList11 = deviceInfoSet[i].childNodes;
              user = itemList11[22].childNodes[0].nodeValue; 
              dNickname = itemList11[6].childNodes[0].nodeValue;
              dId =  itemList11[4].childNodes[0].nodeValue;
              pLevel =  itemList11[14].childNodes[0].nodeValue;
              var device6 = deviceList[dId];
              //device6 = deviceList[key];  
              for(var ii = 0; ii < device6[6].length; ii++){
                //shape = device2[6].GetShapeByIndex(ii);
                //device6[6][ii].setMap(null);
            	  bm_layer_polyLines.remove(device6[6][ii]);
            	  map.removeObject(device6[6][ii]);
              }
              device6[6] = [];
          }
            
        for( var i=0; i < deviceInfoSet.length; i++){
            var itemList11 = deviceInfoSet[i].childNodes;
            user = itemList11[22].childNodes[0].nodeValue; 
            dNickname = itemList11[6].childNodes[0].nodeValue;
            dId =  itemList11[4].childNodes[0].nodeValue;
            pLevel =  itemList11[14].childNodes[0].nodeValue;
            var device2 = deviceList[dId];
            if (global_deviceId == dId)
                //map.setCenter(device2[4]);
                //map.setView({center:device2[4]});
                map.setCenter(device2[4]);
             //map.addOverlay(device2[2]);
             //device2[2].setMap(map);
             map.addObject(device2[2]);
      //      var shape;
      //      for(var ii = 0; ii < device2[6].GetShapeCount(); ii++){
      //         shape = device2[6].GetShapeByIndex(ii);
      //         device2[6].DeleteShape(shape);
      //      }
        }
            
      }  
  }
  
	function displayInfobox(e)
    {
	    if (e.targetType == 'pushpin'){
	    	pinInfobox.setLocation(e.target.getLocation());
           pinInfobox.setOptions({ visible:true, title: e.target.Title, description: e.target.Description });
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

  function googleMapForCurrentDeviceLocation(){
	  var device_c = deviceList[global_deviceId];
	  var c_loc = device_c[4];
	  var url = "http://maps.google.com/?q=" + c_loc.lat+","+c_loc.lng;
	  window.open(url);
  }

 //function DeleteShape()
//      {
//         if(newShape != null)
//         {
//            map.DeleteShape(newShape);
//            newShape = null;
//         }
 //     }
 
 //function showBoundry(marker, point) {
//		var zoom = map.getZoom();
		
//		{
//		if (point == null)
//		   return;
		//check if genfence window is open
//		var visibility = document.getElementById('toolpanel').style.visibility;
//		if (visibility != 'visible')
//			return;
//		document.getElementById("inputlat").value = roundFloat(point.lat().toString())+"/"+roundFloat(point.lng().toString());        
		//document.getElementById("inputlon").value = point.lng();
	    //document.getElementById("inputaddress").value = "";
//		if (centerMarker != null)
			//map.removeOverlay(centerMarker);
//		    centerMarker.setMap(null);
		//centerMarker = new GMarker(point,customIcon);
//	    centerMarker = new google.maps.Marker({
//	        position: point,
//	        map: map,
	        //shadow: shadow,
//	        icon: customIcon,
//	        shape: shape
	        //title: beach[0],
	        //zIndex: beach[3]
//	    });	
		//centerMarker = createMarker(point,'Start','', 1)
		//map.addOverlay(centerMarker);
//		centerMarker.setMap(map);
//		radius = parseFloat(document.getElementById("inputradius").value) * 1.609347;
//		document.getElementById("serverfbAlert").innerHTML=serverfbAlert;
//		draw(point);

//		}
		
//	}
// function ShowLocationWithRadius() {
	    //var lat = parseFloat(document.getElementById("inputlat").value); 
//	    var latlon = document.getElementById("inputlat").value;  
//	    var latlon1 = latlon.toString().split("/");
//	    var lat = parseFloat(latlon1[0]);
//		var lon = parseFloat(latlon1[1]);      
	           
	    //var lon = parseFloat(document.getElementById("inputlon").value);
//		radius = parseFloat(document.getElementById("inputradius").value) * 1.609347;

//	    if (!isNaN(lat) && !isNaN(lon) && lat>=-90 && lat<=90 && lon>=-180 && lon<=180) {
	       //alert( "ShowLocationWithRadius = " + lat+"/"+lon);
//	        showBoundry(null, new Microsoft.Maps.Location(lat, lon));
//	    }else
//	    {
//	        alert("Not valid decimal degrees");
//	    }
//	}
</script>
  </body>
  <SCRIPT type=text/javascript>
			ID=window.setTimeout("reFreshfunc();",globalPageRefreshInterval * 1000 + 5000);
			function reFreshfunc(){
			    //alert(globalPageRefreshInterval);
                retrieveDeviceLocForAllDevices();
			  ID=setTimeout("reFreshfunc();",globalPageRefreshInterval * 1000 + 5000)
			}
</SCRIPT>
  
</html>
