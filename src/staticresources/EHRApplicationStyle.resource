.apptTime { font-size:0.9em; }
/*
.bPageBlock .pbHeader .pbTitle { width: 70%; }
*/
 
.ui-layout-center .bPageBlock .pbHeader .pbTitle { width: 35%; } 

.ui-corner-all, 
.calendarTemplate,
.fullPreview { 
	-moz-border-radius: 5px; 
	-webkit-border-radius: 5px; 
}

/* some colors here */
.ui-blue-back,
.ui-layout-resizer,
.ui-blue-back .ui-widget-header,
.ui-blue-back .ui-widget-content
{ 
	/* 	background:#E2ECF9 none repeat scroll 0 0;  a bit light */
	background:#acc2cf none repeat scroll 0 0; 
}


.ui-tabs-panel li a,
.ui-tabs-panel .pbBody a, 
.ui-tabs-panel .pbBody h1, 
.ui-tabs-panel li a,
#past-enc li a,
#bodyObservations .ui-layout-west a,
#bodyObservations .ui-layout-west .pbBody td,
#body-sys .ui-widget-content, 
#body-sys .ui-state-default a, 
#body-sys .ui-state-default a:link, 
#body-sys .ui-state-default a:visited {  
	color: SteelBlue; /* #acc2cf; */
}

#bodyObservations .ui-tabs-vertical .ui-tabs-nav { 
	padding: .2em .1em .2em .2em; 
	float: left;
	width: 9em; }


/*.ui-layout-west td, td.ui-blue-bottom */
 .ui-layout-west .ui-blue-bottom td 
{ 
	border-bottom: 1px solid #acc2cf; 
	padding-bottom: 5px; 
}
td.ui-blue-right { 
	border-right: 1px solid #acc2cf; 
}	
.ui-state-active a, 
.ui-state-active a:link, 
.ui-state-active a:visited {
	color:#1B1D1B;
}

.blue-line { border-bottom: 1px; }

/* heights 
 * borders
 */
.ui-tabs .ui-tabs-nav li a {
	float:left;
	padding:0.3em 1em;
	text-decoration:none;
} 
.ui-state-default, .ui-widget-content .ui-state-default {	border: 0;}

#body-sys .ui-tabs .ui-tabs-nav li a {	padding:0.4em 1em; }

.ui-tabs-nav .ui-state-active a, .ui-tabs-nav .ui-state-hover { font-weight: bold; } 


.portlet .ui-widget-header { background : lightBlue none repeat scroll 0 0 ; }

#tabs .ui-tabs { padding: 0;  }
#tabs .ui-tabs-nav { padding-top: 10px; }

/* make widgets more delicate */
.ui-widget { 
	font-size: 1.0em; 
	font-family:'Arial','Helvetica',sans-serif;
}

/* stylish overlay color */
.ui-widget-overlay { 
	position:absolute;
	top:0;left:0;
	-moz-opacity:0.5;
	opacity:.50;
	filter:alpha(opacity=50);
	background: #000000 none repeat scroll 0 0;
	zoom:1;
}
.ui-widget-content a { 
	text-decoration:none;
}


#symptoms .sy-list { padding-left: 15px; padding-bottom: 9px;}
#symptoms .sy-label { line-height: 1.4; }

#subj_symptomslist { 
	height:500px;
	width: 170px;
}

.ui-tabs .ui-tabs-nav li.encounterMenu a { padding-left: 29px; }

.bodySystems ul {
    padding-top: 3px;
}	

.bodySystems ul li {
    margin-left: 0.8em;
    padding-left: 0;
    padding-top: 3px;
    color: SteelBlue;
}

.bodySystems h2 {
    padding-bottom: 8px;
}

.f-rit { float:right;}

/* hide the bottom of the page block div, was showing a curved bottom area 
 * is this still needed ??
 */
.bPageBlock { padding-bottom: 0px; }

.start-tabs-hide {		display:none !important;	}

.addNewSymptom input { 
	width : 12em; 
	font-size: 80%;
}

.encounterDate {
	float:left;
	font-weight:bold;
	padding-left:8px;
	padding-top:8px;
}

/* styles for the main page layout 
.header{
	width:100%;
}
.contentArea{
	width:100%;
}
.leftNav{
	width:14%;
	float:left;
	border:0px solid  #FF9900;
}
.main{
	width:68%;
	float:left;
	padding:0px 00px 0px 10px;
	border: 2px solid #498841;
	margin: 0 0 0 0px;	
}
.rightNav{
	width:15%;
	float:right;
	border:1px solid black;
	font-size: 90%;
	margin:0px 0px 5px 0px;
}
*/
.clearFloats{
	clear:both;
}
.footer{
}


#bodyObservations .content .col1 { width: 50%; }
.col1{
	width:21%;
	float:left;
	margin-top: 6px;
	height: 563px;
	overflow:auto;
}
#bodyObservations .content .col2 { width: 50%; overflow: auto;  }
#bodyObservations .content { height: 545px; }
  
.col2{
	width:23%;
	float:left;
	height: 563px;
	overflow:auto;
}
.col3{
	width:55%;
	float:left;
}
.bPageBlock .pbHeader {
	background-color:#FFFFFF;
	border-bottom:1px solid #FFFFFF;
}
.bPageBlock .pbFooter{
	background-color:#FFFFFF;
	border-bottom:1px solid #FFFFFF;
}

#bodyObservations .content #past-enc .col1 { width: 40%; }
#bodyObservations .content #past-enc .col2 { width: 60%; }


/*	styles for problem and meds lists */
ul, .ui-alert ul {
	list-style-image: none;
	list-style-position: outside;
	list-style-type: none;
	padding: 1px 1px 3px 1px;
	margin-top: 6px;
}
.ui-alert a {
	text-decoration: none;
	color: #555555;
}
.ui-alert li {
	//margin-left: 3px;
	padding: 1px 0px 3px 0px;
}
.ui-alert h3 { 
	padding-left: 4px;
	padding-top: 2px;
}
.ui-alert {
	font-size:92%;
	color: #555555;
}


/* styles used by PatientObsSubjective and PatientObsObjective and EncounterAssess */
#subTabs ul {
	border-top-width: 0px;
	padding-top: 0px;
	padding-bottom: 3px;
}
	
.subPageNav { 
	color:#222222;
}
#subTabs.ui-tabs .ui-tabs-nav {
	padding: 0;
} 
#subTabs { 
	padding-top: 0px; 
	border-top-width: 0px; 
	border-bottom-width: 0px; 
	padding-bottom: 0px; 
	padding-left: 4px; 
	}

#subTabs li { padding: 3px 0px 3px;}

#subTabs li span { padding: 0; }
#subTabs li a {
	padding-top: 0px;
	padding-bottom: 1px;
	padding-right: 3px;
	padding-left: 3px;
}

#subTabs .ui-state-active {
	//background: #8ecda3 none repeat-x scroll 50% 50%;
	//border: 2px solid #8ecda3;
} 

#subTabs .ui-state-active a {
	//color: #222222;
}

.body_system .ui-tabs .ui-tabs-nav li a {
	padding: 0.5em 1em 0.2em;
	width: 5%;
	
}
.ui-tabs .ui-tabs-nav li a {white-space:nowrap;}

.selectable li span {
	padding: 0.2em;
	cursor: pointer;
}
#systemsTabs li a { 
	cursor: pointer;
}

.ui-tabs-panel p {	padding-left: 4px; }


#body-sys .ui-widget-content a,
#body-sys .ui-widget-content .ui-state-default a,
#body-sys .ui-widget-content {
	font-weight:normal;
}

#bodyObservations .ui-widget-content .ui-state-active a {
	color: #1B1D1B;
	font-weight: bold;
}
#addDiagnosisPanel .ui-widget-content .ui-state-active a {
	color: #1B1D1B;
	font-weight: bold;
}

.ui-widget-content {
	background: white none repeat-x scroll 0 0;
	border:0px solid #AAAAAA;
}
#diagnoseFromProblemList li{
	margin-left: 0.5em;
}
.addDiagnosisTable {
	background-color:lightBlue;
	padding:3px;
	width:95%
}
#body-sys { 
	border: 0 solid #DDDDDD; 
	background:	white; 
	height: 575px;	
}
#body-sys table tr { height: 575px; }
#body-sys .ui-widget-content { background: white; }
#body-sys #symptoms .ui-widget-content { border: 0px solid #DDDDDD; }
#body-sys .diagBackground {
	width: 92%;
	padding: 5px;
	//background: #8ecda3 none repeat-x scroll 50% 50%;
	border: 0px solid #FF9900;
	layout: block;
	margin: 3px 3px 8px 3px;
}

#symptomsInner {  overflow: auto ; height:530px; min-width: 150px; } 

#past-enc ul, #symptomsInner ul {	padding-left:2px; }
#past-enc ul { line-height: 1.7; }

.past-enc-dates li, #symptomsInner li {
	list-style-image: none;
	list-style-position: outside;
	list-style-type: none;
	padding: 1px 1px 3px 1px;
	margin-left: 0px;
	/*margin-top: 6px;*/
	line-height: 1.2;
}

.ui-tabs-hide {	display: none;}

.ui-state-active, .ui-widget-content .ui-state-active {
	background: white none repeat-x scroll 50% 50%;
	border:0px solid #2694E8;
	color:#1B1D1B;
	font-weight:bold;
}

#bodyObservations .ui-state-default,
#bodyObservations .ui-widget-content .ui-state-default {
	background: white none repeat-x scroll 50% 50%;
	border:1px solid #FFFFFF;
	color:#1B1D1B;
	font-weight:normal;
	outline-color:-moz-use-text-color;
	outline-style:none;
	outline-width:medium;
}
#bodyObservations #subTabs .ui-tabs-selected,
#bodyObservations #subTabs .ui-tabs-selected a,
#bodyObservations #subTabs .ui-widget-content .ui-tabs-selected {
	background: lightSeaGreen; 
	color: white;
}

#addDiagnosisPanel .ui-state-default,
#addDiagnosisPanel .ui-widget-content .ui-state-default {
	background: white none repeat-x scroll 50% 50%;
	border:1px solid #FFFFFF;
	color:#1B1D1B;
	font-weight:normal;
	outline-color:-moz-use-text-color;
	outline-style:none;
	outline-width:medium;
}
#addDiagnosisPanel #subTabs .ui-tabs-selected,
#addDiagnosisPanel #subTabs .ui-tabs-selected a,
#addDiagnosisPanel #subTabs .ui-widget-content .ui-tabs-selected {
	background: lightSeaGreen; 
	color: white;
}
#addDiagnosisPanel #prob-list {
	height: 563px;
	overflow:auto;
}

#addDiagnosisPanel {
	height: 563px;
}

#addDiagnosisPanel .ui-layout-center{
	height: 563px;
	overflow:auto;
}

#systemsTabs .ui-tabs-nav  { 	background:transparent none repeat scroll 0 0; }

#systemsTabs .ui-state-default, 
#systemsTabs .ui-widget-content .ui-state-default {
	background: transparent;
	border:0px solid #AED0EA;
}
.ui-widget-header { 
	border:0px solid #AED0EA;
	background: white none repeat scroll 0 0;
}
.ui-dialog .ui-widget-header {
	background: white none repeat scroll 0 0;
}
.ui-dialog .ui-widget-content {
	background: #2694E8 none repeat scroll 0 0;
} 
/* 
 * http://layout.jquery-dev.net/
 */

.ui-layout-pane {
	border: 0px solid #BBBBBB;
	overflow: auto;
	padding: 0px;
	height: 600px;
}

.ui-layout-content {
	overflow: auto;
	padding: 10px;
	position: relative;
	z-index: 3;
}


.ui-layout-resizer {	border: 0; }

.ui-layout-resizer-drag { }

/* some resizers will have a hover color */
.ui-layout-resizer-east-hover,
.ui-layout-resizer-dragging , 
#bodyObservations .ui-layout-resizer-west-hover {
	-moz-background-clip: border;
	-moz-background-inline-policy: continuous;
	-moz-background-origin: padding;
	background: #6AACD8 none repeat scroll 0 0;
}


.ui-layout-resizer-dragging {
	border-left: 1px solid #BBBBBB;
	border-right: 1px solid #BBBBBB;
}

.ui-layout-resizer-dragging-limit {
	-moz-background-clip: border;
	-moz-background-inline-policy: continuous;
	-moz-background-origin: padding;
	background: #E1A4A4 none repeat scroll 0 0;
}

.ui-layout-resizer-closed-hover {
	-moz-background-clip: border;
	-moz-background-inline-policy: continuous;
	-moz-background-origin: padding;
	background: #EBD5AA none repeat scroll 0 0;
}

.ui-layout-resizer-sliding {
	opacity: 0.1;
}

.ui-layout-resizer-sliding-hover {	opacity: 1;}

.ui-layout-resizer-north-sliding-hover {	border-bottom-width: 1px;}

.ui-layout-resizer-north-open { height: 5px; 	-moz-border-radius-topleft: 5px; -moz-border-radius-topright: 5px;  }

.ui-layout-resizer-south-sliding-hover {	border-top-width: 1px;}

.ui-layout-resizer-west-sliding-hover {	border-right-width: 1px;}

.ui-layout-resizer-east-sliding-hover {	border-left-width: 1px;}

.ui-layout-toggler {
	background-color: #BBBBBB;
	border: 0px solid #BBBBBB;
}

.ui-layout-resizer-hover .ui-layout-toggler {	opacity: 0.6;}

.ui-layout-resizer-hover .ui-layout-toggler-hover {
	background-color: #FFCC66;
	opacity: 1;
}

.ui-layout-toggler-north,.ui-layout-toggler-south {	border-width: 0 1px;}

.ui-layout-toggler-west,.ui-layout-toggler-east {	border-width: 1px 0;}

.ui-layout-resizer-sliding ui-layout-toggler {	display: none;}

.ui-layout-toggler .content {
	color: #666666;
	font-size: 12px;
	font-weight: bold;
	padding-bottom: 0.35ex;
}

/* remove padding and scrolling from elements that contain an Accordion OR a content-div */
.ui-layout-center, /* has content-div */ 
.ui-layout-west,	/* has Accordion */ 
.ui-layout-east, /* has content-div ... */
.ui-layout-east .ui-layout-content { /* content-div has Accordion */
	padding: 0;
	overflow: auto;
}
.ui-layout-north { /* has encounter title */
	padding: 0;
	overflow: hidden;
}

.ui-layout-east h4 { /* Footer in East-pane */
	font-size: 0.9em;
	font-weight: normal;
	border-width: 1px 0 0;
}


/* portlets on the east panel */
	.column { width: 190px; float: left; padding-bottom: 10px; padding-top: 10px; padding-left:5px; }
	.portlet { margin: 0 1em 1em 0; }
	.portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
	.portlet-header .ui-icon { float: right; }
	.portlet-content { padding: 0.4em; }
	.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
	.ui-sortable-placeholder * { visibility: hidden; }



/* Vertical Tabs in the west panel
----------------------------------
.ui-tabs-vertical { height:95%; }
*/
.ui-tabs-vertical .ui-tabs-nav { 
	padding: .2em .1em .2em .2em; 
	float: left; 
	width: 10em; 
}
.ui-tabs-vertical .ui-tabs-nav li { 
	clear: left; 
	width: 100%; 
	border-bottom-width: 0px !important; 
	border-right-width: 0 !important; margin: 0 -1px .2em 0; }
	
.ui-tabs-vertical .ui-tabs-nav li a { display:block; }
.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-selected { 
	font-weight: bold; padding-bottom: 0; padding-right: .1em; 
	border-right-width: 1px; border-right-width: 1px; 
}
.ui-tabs-vertical .ui-tabs-panel { 
	padding: 1em; float: right; width: 40em;
}

.ui-layout-west { 
	padding-top: 0px; 
	overflow:hidden;
	}
ul.ui-tabs-nav {
	height: 100%;
	}
	
ul.ui-tabs-nav {  line-height: 1.4; }
#bodyObservations ul.ui-tabs-nav { line-height: 1.0; }
div.ui-tabs-hide  { display:none; } 

/* 
 * these wipe out the normal pageblock style for a clean, aloha look 
 * remove after aloha is working and tested in this app
 TODO
.Custom39Tab .secondaryPalette,
.individualPalette .Custom39Block .secondaryPalette{
    background-color: transparent;
    border-color: transparent;
    background: none;
}
 .Custom338Tab .secondaryPalette,
.individualPalette .Custom338Block .secondaryPalette{
    background-color: transparent;
    border-color: transparent;
    background: none;
}
 .Custom43Tab .secondaryPalette,
.individualPalette .Custom43Block .secondaryPalette{
    background-color: transparent;
    border-color: transparent;
    background: none;
}
.Custom46Tab .secondaryPalette, .individualPalette .Custom46Block .secondaryPalette {
	background-color: transparent;
    border-color: transparent;
    background: none;
}

.bPageBlock .pbBody {
    background-color: #FFFFFF;
    margin-right: 2px;
    padding: 3px 4px 3px;
}
.bPageBlock .pbBottomButtons {
	background-color: #FFFFFF;
	margin:1px 2px 0 0;
}
.bPageBlock .pbHeader {
	background-color:#FFFFFF;
	border-bottom:1px solid #FFFFFF;
}
*/
.Custom46Tab .secondaryPalette, .individualPalette .Custom46Block .secondaryPalette {

    border-color: transparent;
 
}
.ui-patientDetails {
	color:#555555;
	font-size: 92%;
}
.ui-patientDetails a {
	color:#555555;
	text-decoration:none;
}
.ui-patientDetails a:hover {
	background-color: #EBD5AA;
}

/* hide the bottom of the page block div */
.apexp .bPageBlock { 
	padding-bottom: 0px;
	border-top: 0px; 
	}



.patientCard{
	font-size:2.0em;
	padding: 1em;
	margin-left: 30px;
	font-weight: bold;
	background-color: black;
}

.patientMiniCard {
}

.patientName {
	color:#015BA7;
	padding-right: 15px;
	padding-left: 6px;
}

/*.patientField { color: #555555; } */

.ui-layout-north .bPageTitle { 
	float: left; 
	background:white none repeat scroll 0 0;
	width: 98%;
	padding: 5px;
	margin: 7px;
}

.signedText {
	color: #555555;
	border: 1px solid #E1A4A4;
	padding: 2px;
}
body .bPageTitle .ptBody .pageDescription2 {
	font-size:1.5em;
	font-weight:normal;
	line-height:1.1em;
}

/* button styles */
.fg-button { outline: 0; margin:0 4px 0 0; padding: .4em 1em; text-decoration:none !important; cursor:pointer; position: relative; text-align: center; zoom: 1; }
.fg-button .ui-icon { position: absolute; top: 50%; margin-top: -8px; left: 50%; margin-left: -8px; }

a.fg-button { float:left; }

/* remove extra button width in IE */
button.fg-button { width:auto; overflow:visible; }

.fg-button-icon-left { padding-left: 2.1em; }
.fg-button-icon-right { padding-right: 2.1em; }
.fg-button-icon-left .ui-icon { right: auto; left: .2em; margin-left: 0; }
.fg-button-icon-right .ui-icon { left: auto; right: .2em; margin-left: 0; }

.fg-button-icon-solo { display:block; width:8px; text-indent: -9999px; }	 /* solo icon buttons must have block properties for the text-indent to work */	

.fg-buttonset { float:left; }
.fg-buttonset .fg-button { float: left; }
.fg-buttonset-single .fg-button, 
.fg-buttonset-multi .fg-button { margin-right: -1px;}

.fg-toolbar { padding: .5em; margin: 0;  }
.fg-toolbar .fg-buttonset { margin-right:1.5em; padding-left: 1px; }
.fg-toolbar .fg-button { font-size: 1em;  }



/* 
 * why do we need absolute position to make the dialog work on IE 7 ??
use zfix from jquery?
 */
.ui-dialog {	position:absolute !important;	} 


#bodyObservations {  height:600px; overflow: hidden; }
#bodyObservations .ui-layout-center { height: 603px; }

#bodyObservations td { valign: top;}
#bodyObservations .ui-tabs .ui-tabs-panel {padding:0.1em 0.1em;}
#bodyObservations input.addNewSymptomInput { font-size: 0.9em; }

.selectable .indent {	padding-left: 8px;	}


	/*NEW SLIDER STYLES FOR SCALE, ETC*/
/* slider widget */
.ui-slider  {
	text-decoration: none !important;
}
.ui-slider-tooltip {
	display: none;
}
.ui-slider-handle-active .ui-slider-tooltip {
	display: block;
	position: relative;
	top: -25px;
	text-align: center;
	padding: .2em;
	font-size: .9em;
	width: 8em;
	margin-left: -4em;
	text-decoration: none !important;
}
.ui-slider ol, .ui-slider li, .ui-slider dl, .ui-slider dd, .ui-slider dt {
	list-style: none;
	margin: 0;
	padding: 0;
}
.ui-slider ol, .ui-slider dl {
	position: relative;
	top: 1.3em;
	width: 100%;
}
.ui-slider dt {
	top: 1.5em;
	position: absolute;
	padding-top: .2em;
	text-align: center;
	border-bottom: 1px dotted #ddd;
	height: .7em;
	color: #999;
}
.ui-slider dt span {
	background: #fff;
	padding: 0 .5em;
}
.ui-slider li, .ui-slider dd {
	position: absolute;
	overflow: visible;
	color: #666;
}
.ui-slider li span.ui-slider-label, .ui-slider dd span.ui-slider-label {
	display: none;
}
.ui-slider li span.ui-slider-label-show, .ui-slider dd span.ui-slider-label-show {
	display: block;
}
.ui-slider span.ui-slider-tic {
	position: absolute;
	left: 0;
	height: .8em;
	top: -1.3em;
}
.ui-slider li span.ui-component-content, .ui-slider dd span.ui-component-content {
	border-right: 0;
	border-left-width: 1px;
	border-left-style: dotted;
	border-top: 0;
	border-bottom: 0;
}
.ui-slider .first .ui-slider-tic, .ui-slider .last .ui-slider-tic {
	display: none;
}
.mainGridContainer {
	width:78%; 
	float:left; 
	display:block;
	vertical-align:center;
}

.filterGridContainer {
	width:20%;
	float:right;
	cursor:pointer;
	margin-left: 10px;
}


/* Simple Modal & Overlay */
#simplemodal-overlay {	background-color:#000; cursor:wait;}

.modalCloseImg { 
	background:url(/resource/0/jquery/css/images/x.png) no-repeat; 
	width:25px; 
	height:29px; 
	display:inline; 
	z-index:3200; 
	position:absolute; 
	top:-15px; right:-16px; 
	cursor:pointer;
	}

#simplemodal-container{
	background-color:#FFFFFF; 
	border:4px solid #444; 
	padding:12px;
	height:500px; 
	width:650px; 
}

#simplemodal-data{
	height:100%;
}

/* cute cloud is now commented out
#bodyObservations .ui-layout-pane-center { 
	background:url(/resource/0/jquery/css/images/feedbg.png) repeat-x; }
#bodyObservations .bPageBlock .pbHeader { background-color:transparent;	border-bottom: 0px;}
#bodyObservations .bPageBlock .pbBody {
	background:transparent url(/resource/0/jquery/css/images/cloud.png) no-repeat scroll right top;
	border:0 none;	margin-bottom:0;	min-height:90px; }
end cute cloud */

.ui-jqgrid .ui-jqgrid-titlebar {
	font-size: 1.3em;
	font-weight: bold;
	color:#6AACD8;
}
.ui-jqgrid-view .ui-jqgrid-hdiv{
	background: #FFFFFF url(/resource/0/jquery/css/images/feedbg.png) repeat-x;
	color:#1B1D1B;
	font-weight:bold;
	outline-color:-moz-use-text-color;
	outline-style:none;
	outline-width:medium;
	text-align:left;
	border: 2px solid #FFFFFF;
}
.ui-th-column, .ui-jqgrid .ui-jqgrid-htable th.ui-th-column {
	background: #FFFFFF url(/resource/0/jquery/css/images/feedbg.png) repeat-x;
	color:#1B1D1B;
	font-weight:bold;
	outline-color:-moz-use-text-color;
	outline-style:none;
	outline-width:medium;
	border-right: 2px solid #FFFFFF;
}

.ui-jqgrid .ui-jqgrid-pager {
	background: #FFFFFF url(/resource/0/jquery/css/images/feedbg.png) repeat-x;
	color:#1B1D1B;
	font-weight:bold;
	outline-color:-moz-use-text-color;
	outline-style:none;
	outline-width:medium;
}
.ui-jqgrid .ui-jqgrid-bdiv {
	overflow:hidden;
}
.ui-jqgrid tr.ui-row-ltr td {
	text-align:left;
	border-right: none;
}
.ui-jqgrid tr.jqgrow td {
	border-bottom:1px solid #D4DADC; 
}
.ui-th-column, .ui-jqgrid .ui-jqgrid-htable th.ui-th-column {
	text-align: left;
}
.ui-jqgrid tr.ui-state-hover {
	background:  #E0FFFF;
	
}

.messageTabs ul {
	border-top-width: 0px;
	padding-top: 0px;
	padding-bottom: 3px;
	background: #FFFFFF;
}

.messageTabs.ui-tabs .ui-tabs-nav {
	padding: 0;
} 
.messageTabs { 
	padding-top: 0px; 
	border-top-width: 0px; 
	border-bottom-width: 0px; 
	padding-bottom: 0px; 
	padding-left: 4px; 
	}

.messageTabs li { padding: 3px 0px 3px;  background: #FFFFFF;}

.messageTabs li span { padding: 0;}
.messageTabs li a {
	padding-top: 0px;
	padding-bottom: 1px;
	padding-right: 3px;
	padding-left: 3px;
}

.messageTabs .ui-tabs-selected a,
.messageTabs .ui-widget-content .ui-tabs-selected {
	background: #6699cc; 
	color: white;
}
.innerTabs .ui-widget-content a {
	text-decoration: underline;
}
