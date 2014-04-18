<%@ include file="../../../Includes/JSPs/News/iListNewsDash.jsp"%>
<html>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners" style="width:665px;">
<div class="my-account">
<div class="dashboard">

<script src="../../Library/Script/jquery.js" type="text/javascript"></script>
<head>
    <title>News</title>
<style>
a {color:#5D87A1; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}
</style>
<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }

</style>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 

<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
<Script src="../../Library/Script/popup.js"></Script>  

<script type="text/javascript">
	function fnFeaturesInit ()
	{
		/* Not particularly modular this - but does nicely :-) */
		$('ul.limit_length>li').each( function(i) {
			if ( i > 10 ) {
				this.style.display = 'none';
			}
		} );

		$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
		$('ul.limit_length li.css_link').click( function () {
			$('ul.limit_length li').each( function(i) {
				if ( i > 5 ) {
					this.style.display = 'list-item';
				}
			} );
			$('ul.limit_length li.css_link').css( 'display', 'none' );
		} );
	}

	$(document).ready( function() {
		fnFeaturesInit();
		/*jQuery.extend( jQuery.fn.dataTableExt.oSort, {
		    "date-uk-pre": function ( a ) {
			var ukDatea = a.split('/');
			return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
		    },

		    "date-uk-asc": function ( a, b ) {
			return ((a < b) ? -1 : ((a > b) ? 1 : 0));
		    },

		    "date-uk-desc": function ( a, b ) {
			return ((a < b) ? 1 : ((a > b) ? -1 : 0));
		    }
		} );*/				
		var oTable = $('#newsDisp').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"bStateSave":true,
			"bSort" : true,
			"aoColumnDefs": [ 
			{ "bVisible": false, "aTargets": [ 1 ] },
			{ "bVisible": false, "aTargets": [ 2 ] },
			{ "bVisible": false, "aTargets": [ 3 ] },
			{ "iDataSort": 2, "aTargets": [ 0 ] }
		      	 ]
			
			
		} );
		
		chkSort(oTable)
						
		
		//oTable.fnSortListener( document.getElementById('sorter1'), 2 );
 				


	} );
	function chkSort(oTable)
	{
		//alert(oTable)	
		$('#sorter').live('click', function () {
			oTable.fnFilter( 'Y' );
		} );
		
		$('#sorter1').live('click', function () {
			oTable.fnFilter( 'UN' );
		} );
		
		$('#Rsorter').live('click', function () {
			oTable.fnFilter( '~' );
		} );		
		
		$('#Usorter').live('click', function () {
			oTable.fnFilter( '^' );
		} );
		
		
		$('#ALL').live('click', function () {
			oTable.fnFilter( '' );
			
		} );		
		
			
	}
</script>


<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#newsDisp").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized
		
		
		});
	
	
});
</script>

<!-- jQuery for sorting & pagination ENDS here -->
  
<script type="text/javascript">
function viewDocs(id,sysKey)
{
	
	
	url = "../../../../../EzCommerce/EzAdmin/EzAdmin4/Admin1/JSPs/User/ezViewDocs.jsp?newsId="+id+"&sysKey="+sysKey;
	var hWnd	=	window.open(url,"UserWindow","width=300,height=200,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;	

}
function ezViewNews(newsText,newsSub,newsId,sysKey,readFlag,newsType,newsFilter,readStat,readDate,ackStat,createdOn,newsCat)
{
	if(newsText!="")
	{
		document.myForm.hiddenText.value=newsText
		document.myForm.hiddenSub.value=newsSub
		document.myForm.newsId.value=newsId
		document.myForm.sysKey.value=sysKey
		document.myForm.readFlag_N.value=readFlag
		document.myForm.newsType.value=newsType
		document.myForm.newsFilter.value=newsFilter
		document.myForm.readStats.value=readStat
		document.myForm.readDates.value=readDate
		document.myForm.ackStats.value=ackStat
		document.myForm.createdOns.value=createdOn
		document.myForm.newsCats.value=newsCat
		document.myForm.action="ezViewNewsMain.jsp"
		document.myForm.submit();
		
		//document.myForm.target="PopUp"
		//var newWindow = window.open("","PopUp","width=1200,height=500,left=100,right=100,top=100")
		//document.myForm.onsubmit= newWindow
		//window.open('ezViewNewsMain.jsp','View News','width=350','height=250')
	}
}

function delNews(id)
{
	var status=confirm("Are you sure to delete News ?");
	if(status==true)
	{
		newsId = id;
		//Popup.showModal('modal1');
		SendQuery();
	}
}

function SendQuery()
{//alert(newsId)
	try
	{
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req = null;
		}
	}
	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req = new XMLHttpRequest();
	}

	var url="";
	url="../News/ezDelNews.jsp?newsId="+newsId;
	//alert(url)
	if(req!=null)
	{
		req.onreadystatechange = Process;
		req.open("POST", url, true);
		req.send(null);
	}
} 
function Process() 
{//alert("req.readyState:::"+req.readyState)
	if (req.readyState == 4)
	{

		var resText     = req.responseText;	
		resText = resText.replace(/[\n\r\t]/g,'')		
		//alert(resText+":::::"+req.status)
		if (req.status == 200)
		{
			//alert(resText)
			if(resText=='Y')
			{
				Popup.showModal('modal1');
				document.myForm.submit()	
			}
			else
				alert("Error in deleting the News")

		}
		else
		{
			if(req.status == 500)	 
			alert("Error");
		}
	}
}
function funGetSelType()
{
	document.myForm.action="ezListNewsDash.jsp?readFlag="+'<%=readFlag%>'
	document.myForm.submit()
	
}
function ezGetSelected(type)
{
	document.myForm.newsFilter.value = type
	document.myForm.action="ezListNewsDash.jsp"
	document.myForm.submit()	

}
function getNewsType(filter,type)
{
	document.myForm.newsFilter.value = filter
	document.myForm.action="ezListNewsDash.jsp"
	document.myForm.submit()	
}

function checkRadio()
{
	var chkRd	= $("#newsDisp_filter input:text").val();
	if(chkRd=="~")
	{	
		document.getElementById("Rsorter").checked=true;
	}
	else if(chkRd=="^")
	{
		document.getElementById("Usorter").checked=true;
	}
	else if(chkRd=="Y")
	{
		document.getElementById("sorter").checked=true;
	}
	else if(chkRd=="UN")
	{
		document.getElementById("sorter1").checked=true;
	}
	else
	{
		document.getElementById("ALL").checked=true;
	}
}

$( document ).ready(function() {
	checkRadio();
});

</script>

</head>

<%
	java.util.HashMap hashCat= new java.util.HashMap();
	
	/*hashCat.put("PL","Price list downloads");
	hashCat.put("PS","Periodic Statement");
	hashCat.put("PRODSPEC","Product Specification");
	hashCat.put("NP","New products/Product line");
	hashCat.put("DP","Discontinued Products");
	hashCat.put("PCA","Price change Announcements");
	hashCat.put("PA","Promotion Announcements");
	hashCat.put("SLOB","SLOB/Specials");	
	hashCat.put("OM","Others/Miscellaneous");*/
	//out.print("COUNT;;;;;;;;;;;;"+newsValMapRetObj.getRowCount());
	for(int n=0;n<newsValMapRetObj.getRowCount();n++)
	{
		hashCat.put(newsValMapRetObj.getFieldValueString(n,"VALUE1"),newsValMapRetObj.getFieldValueString(n,"VALUE2"));
	}	
		
	String dispHeader = (String)hashCat.get(newsType_F);
	if("null".equals(dispHeader) || dispHeader==null)dispHeader = "News List";
	String newsSubject = (String)hashCat.get(newsType_F);
	if("null".equals(newsSubject) || newsSubject==null)
		newsSubject= "ALL News";
	
%>
<div class="block" style="padding: 0px !important;">
	<div class="block-title">
		<strong><span><%=dispHeader%></span></strong>
	</div>
</div>

<form name="myForm" method="post">
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div class="col1-set">
<div class="info-box"><br>

<td>
	<input style="margin-bottom:2px;" type="radio" name="readFlag" id ="Rsorter" onClick="chkSort()" > &nbsp;UnRead &nbsp; | &nbsp; 
	<input style="margin-bottom:2px;" type="radio" name="readFlag" id ="Usorter" onClick="chkSort()"> &nbsp;Read &nbsp; | &nbsp; 	
	<input style="margin-bottom:2px;" type="radio" name="readFlag" id ="sorter" onClick="chkSort()" > &nbsp;Acknowledged &nbsp; | &nbsp; 
	<input style="margin-bottom:2px;" type="radio" name="readFlag" id ="sorter1" onClick="chkSort()"> &nbsp;Unacknowledged &nbsp; | &nbsp; 
	<input style="margin-bottom:2px;" type="radio" name="readFlag" id ="ALL" checked onClick="chkSort"> &nbsp; ALL </td>
</div>
</div>
<input type="hidden" name="newsFilter">
<%
	//if(myNewsRetCnt>0)
	{
%>
<div class="col1-set">
<div class="info-box"><br>							

<table class="data-table" id="newsDisp">
<thead>
<input type="hidden" name="hiddenText">

<input type="hidden" name="hiddenSub">
<input type="hidden" name="newsId">
<input type="hidden" name="sysKey">
<input type="hidden" name="readFlag_N">
<input type="hidden" name="newsType">

<tr>
	<th align="a-justify" colspan=2> <%=newsSubject%> </th>
	

</tr>
</thead>
										
<tbody>
<%
		//out.println(myNewsRet.toEzcString());
		if(myNewsRetCnt>0)
		{
			Vector types= new Vector();
			types.addElement("date");
			types.addElement("date");
			types.addElement("date");

			Vector cols= new Vector();
			cols.addElement("EZN_CREATED_DATE");
			cols.addElement("EZN_START_DATE");
			cols.addElement("EZN_END_DATE");
			global.setColTypes(types);
			global.setColNames(cols);
			GlobObj = global.getGlobal(myNewsRet);
		}
		//myNewsRet.sort(new String[]{"EZN_ID"},false);
		for(int i=0;i<myNewsRetCnt;i++)								      
		{												      
														      
														      
			String newsId		= myNewsRet.getFieldValueString(i,"EZN_ID");
			String newsSyskey	= myNewsRet.getFieldValueString(i,"EZN_SYSKEY");
			String assiSoldTo	= myNewsRet.getFieldValueString(i,"EZN_SOLDTO");
			String assiShipTo	= myNewsRet.getFieldValueString(i,"EZN_SHIPTO");
			String createdOn	= GlobObj.getFieldValueString(i,"EZN_CREATED_DATE");
			String createdBy	= myNewsRet.getFieldValueString(i,"EZN_CREATED_BY");
			String startDate_N	= GlobObj.getFieldValueString(i,"EZN_START_DATE");	//myNewsRet.getFieldValueString(i,"EZN_START_DATE");
			String endDate_N	= GlobObj.getFieldValueString(i,"EZN_END_DATE");	//myNewsRet.getFieldValueString(i,"EZN_END_DATE"); 
			String newsCat		= myNewsRet.getFieldValueString(i,"EZN_CATEGORY");
			String newsType		= myNewsRet.getFieldValueString(i,"EZN_NEWS_TYPE");
			String newsText		= myNewsRet.getFieldValueString(i,"EZN_NEWS_TEXT");
			String newsSub		= myNewsRet.getFieldValueString(i,"EZN_SUBJECT");
			String newsAuth		= myNewsRet.getFieldValueString(i,"EZN_AUTH");
			String attachFlag	= myNewsRet.getFieldValueString(i,"EZN_ATTACHMENTS");
					
			if(attachFlag!=null && !"".equals(attachFlag))
				attachFlag="Y";
			
			if(newsText.length()>80)
				newsText		= newsText.substring(0,80);
				
			String tempText		= myNewsRet.getFieldValueString(i,"EZN_NEWS_TEXT");
			tempText	=	tempText.replaceAll("\'","`");
			tempText	=	tempText.replaceAll("\"","``");
			String fontColor  	= "";
			String readStat  	= "Read";
			String readDate 	= "";
			String ackStat 	= "";
			String acknDate 	= "UN";
			String newsRFlag 	= "^";
			//out.println("createdOn:::::::::::::::::::::"+createdOn);
			//out.println("newsId:::::::::::::::::::::"+newsId.trim());
			if(!(readMap.containsKey(newsId.trim())))
			{
				fontColor = "red";
				readStat = "Un-Read";
				newsRFlag = "~";
			}else
			{
				readDate =(String)readMap.get(newsId.trim());
				readDate = "&nbsp;On &nbsp;"+readDate; 
				//out.println("readDate:::::::::::::::::::::"+readDate);
			}
			//if("TA".equals(newsType) && !(ackMap.containsKey(newsId.trim())))
				//ackStat = "NO";	
			if("TA".equals(newsType) && (ackMap.containsKey(newsId.trim())))
			{
				ackStat = "&nbsp;|&nbsp; Ack On:&nbsp;"+(String)ackMap.get(newsId.trim());	
				acknDate = "Y";
			}	
			else if("TA".equals(newsType) && (!ackMap.containsKey(newsId.trim()))){
				ackStat = "&nbsp;|&nbsp; Ack On:&nbsp;N/A";
				acknDate = "UN";
			}
			else{
				ackStat = "&nbsp;|&nbsp; Ack On:&nbsp;N/A";
				acknDate = "!";			
			}
%>
			<tr>
			<td width=5%><a href="javascript:delNews('<%=newsId%>')"><img style="valign:bottom" src="../../Images/Common/delete_icon.gif" height="20" width="20" border=0  style='cursor:hand' title="Delete News"></a>
			<a style="font-weight:bold;" href="javascript:ezViewNews('<%=tempText%>','<%=newsSub%>','<%=newsId%>','<%=newsSyskey%>','<%=readFlag%>','<%=newsType%>','<%=newsType_F%>','<%=readStat%>','<%=readDate%>','<%=ackStat%>','<%=createdOn%>','<%=newsCat%>')" style="color:<%=fontColor%>">
				  <%=newsSub%></a><p><small style="font-size: 10px !important;font-style: italic;color: #a0a0a0;text-transform: capitalize;">published on <%=createdOn%></small></p>
				
				<p><small style="font-size: 10px !important;font-style: italic;color: #a0a0a0;text-transform: capitalize;"><%=readStat%><%=readDate%><%=ackStat%></small></p>
			</td>
			<td><%=newsId%></td>
			<td><%=acknDate%></td>
			<td><%=newsRFlag%></td>
			</tr>
<%		
		}
%>
	</tbody>
	</table>
</div>
</div>

<%
	}
	//else
	{
%>
		<!--<div class="col1-set">
		<div class="info-box"><br>
		<table class="data-table" >
			<Tr>
<%
			
			String noNewsDisplay ="";
			if("OM".equals(newsType_F))
				noNewsDisplay = "Miscellaneous";
			else
				noNewsDisplay = (String)hashCat.get(newsType_F);
%>				
			
			<Td align="center"><H1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No <%//=noNewsDisplay%> to display</H1></td>
			</Tr>
		</table>	
		</div>
		</div>-->
<%
	}
%>	
		
</div>
</div>
</div>
<input type="hidden" name="readStats" >
<input type="hidden" name="readDates" >
<input type="hidden" name="ackStats">
<input type="hidden" name="createdOns">
<input type="hidden" name="newsCats">


<div class="col-left sidebar roundedCorners" style="width:223px !important">
	<div class="block">
		<div class="block-title">
			<strong><span>News</span></strong>
		</div>
		<div class="block-content">
			<ul>
<%
			if("".equals(newsType_F))
			{
%>
				<li class="current"><Strong>ALL</Strong></li>
<%
			}else{
%>
				<li><Strong><a href="javascript:ezGetSelected('')">ALL</Strong></li>
<%
			}
			
			for(int n=0;n<newsValMapRetObj.getRowCount();n++)
			{
				String catCnt = "0";
				String colorChange = "";
				if(newsCatCnt.get(newsValMapRetObj.getFieldValueString(n,"VALUE1"))!=null && !"null".equals(newsCatCnt.get(newsValMapRetObj.getFieldValueString(n,"VALUE1"))))
					catCnt = (String)newsCatCnt.get(newsValMapRetObj.getFieldValueString(n,"VALUE1"));

				boolean showMenu = false;
				if("PL".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PL_NEWS"))
					showMenu = true;
				if("PRODSPEC".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PSPEC_NEWS"))
					showMenu = true;
				if("PS".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PS_NEWS"))
					showMenu = false;//true;											
				if("NP".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_NPROD_NEWS"))
					showMenu = true;				
				if("DP".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_DC_NEWS"))		
					showMenu = true;				
				if("PCA".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PCHNG_NEWS"))
					showMenu = true;				
				if("PA".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_PROMO_NEWS"))
					showMenu = true;			
				if("SLOB".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_SLOB_NEWS"))							
					showMenu = true;
				if("GA".equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")) && userAuth_R.containsKey("VIEW_GA_NEWS"))							
					showMenu = true;
				
				if(newsType_F.equals(newsValMapRetObj.getFieldValueString(n,"VALUE1")))
					colorChange = "class=\"current\"";

				if(showMenu)
				{
%>			
				<li <%=colorChange%>><Strong><a href="javascript:ezGetSelected('<%=newsValMapRetObj.getFieldValueString(n,"VALUE1")%>')"> <%=newsValMapRetObj.getFieldValueString(n,"VALUE2")%>&nbsp;[<%=catCnt%>]</a></strong></li>
<%
				}
			}
%>
			
			</ul>
		</div>
	</div>
</div>
</div>
</div>
</form>

<script>
var rObj = document.myForm.readFlag
var rdFlag = '<%=readFlag%>'
if(rdFlag=='Y')
	rObj[1].checked=true; 
else if(rdFlag=='N')	
	rObj[0].checked=true;
else if(rdFlag=='A')
	rObj[4].checked=true;
</script>