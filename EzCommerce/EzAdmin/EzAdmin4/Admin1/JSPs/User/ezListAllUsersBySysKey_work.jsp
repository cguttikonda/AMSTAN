<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsersBySysKey.jsp"%>
<%@ page import="java.util.*" %>
<%
	session.putValue("myUserType",myUserType);
	session.putValue("myWebSyskey",websyskey);
	session.putValue("myAreaFlag",areaFlag);
	session.putValue("mySearchCriteria",searchPartner);
	
	String ButtonDir = (String)session.getValue("userStyle");
	if(ButtonDir==null || "".equals(ButtonDir) || " ".equals(ButtonDir))
		ButtonDir = "LAVENDER";

%>
<html>
<head>
<Title>List Of All Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style type="text/css" media="screen">
@import "../../../../../../EzComm/EzSales/Sales/Library/Styles/demo_table_jui.css";
@import "../../../../../../EzComm/EzSales/Sales/Library/Styles/jquery-ui-1.7.2.custom.css";

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

<script src="../../Library/JavaScript/User/ezListAllUsersBySysKey_Working.js"></script> 
<script type="text/javascript" src="../../../../../../EzComm/EzSales/Sales/Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../../../../../EzComm/EzSales/Sales/Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../../../../../EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<script type="text/javascript" src="../../../../../../EzComm/EzSales/Sales/Library/Script/colResizable-1.3.min.js"></script>

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
	$('#example').dataTable( {
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
		"bStateSave":true,
		"sDom": '<"H"Tfr>t<"F"ip>',
		"oTableTools": {
			"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
			"aButtons": [
			{
			    "sExtends":    "csv",
			    "sButtonText": "Download CSV"
			}
			]
		}

	} );


} );
</script>
 
 
<script type="text/javascript">
$(function(){

var onSampleResized = function(e){
	var columns = $(e.currentTarget).find("th");
	var msg = "columns widths: ";
	columns.each()
};

$("#example").colResizable({
	liveDrag:true,
	gripInnerHtml:"<div class='grip'></div>",
	draggingClass:"dragging",
	onResize:onSampleResized});

});
</script>
<link rel="stylesheet" type="text/css" href="../../../../../../EzComm/EzSales/Sales/Library/Styles/formalize.css"> 
<script type="text/javascript" src="../../../../../../EzComm/EzSales/Sales/Library/Script/jquery.formalize.js"></script>

</head>

<body onLoad='bodyInit()' onresize='scrollInit()' scroll="no">
<form name=myForm method=post>
<input type="hidden" name="myUserType" value = "<%=myUserType%>">
<%
	java.util.Hashtable sysKeyDescs = new java.util.Hashtable(); 
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
	{
		String isSel ="";
		String tabHeader = "<Th width='5%'>&nbsp;</Th><Th width='15%'>UserId</Th><Th width='30%'>User Name</Th><Th width='12%'>Type</Th>";
		if("All".equals(websys)){
			isSel = "selected";
			tabHeader = "<Th>&nbsp;</Th><Th>UserId</Th><Th>User Name</Th><Th>Pur. Grp</Th><Th>Pur. Desc</Th><Th>Type</Th>";
		}
%>
	<br>
	<input type="hidden" name="chkField">
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr  align="center">
	    <Th width="30%"><%=areaLabel.substring(0,areaLabel.length()-1)%></Th>
		<Td width="70%">
  	            <select name="WebSysKey"   style="width:100%;" id = "FullListBox" onChange="funsubmit1('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
	 	        <option value="sel">--Select <%=areaLabel.substring(0,areaLabel.length()-1)%>--</option>
<%
			if ( areaFlag.equals("V") ){
%>			
				<option value="All" <%=isSel%>  >All</option>
<%
			}

				StringBuffer all=new StringBuffer("");
				ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
				for(int i=0;i<ret.getRowCount();i++)
				{

					sysKeyDescs.put(ret.getFieldValueString(i,SYSTEM_KEY),ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION));
					if(websyskey!=null)
					{
						if(!websyskey.equals("sel"))
						{
							if(websyskey.equals(ret.getFieldValueString(i,SYSTEM_KEY)))
							{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%>  selected> <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>

<%							}
							else
							{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%							}
						}
						else
						{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%						}
					}
					else
					{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>

<%
					}
				}
%>
			</select>

		</Td>
		<!--<Td width="20%">
			<a href="javascript:funsubmit1('<%=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src = "../../Images/Buttons/<%= ButtonDir%>/show.gif" border=none></a>
		</Td>-->
	</Tr>
	</Table>
	<input type="hidden" name="searchcriteria" value="$">
<%

	if(websyskey!=null )
	{
		if(!websyskey.equals("sel"))
		{
%>
<%

	if(retUsers!=null && alphaTree.size()>0)
	{
		String from = request.getParameter("from");
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		/*if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=3)
		{
	          mySearch.search(retUsers,USER_FIRST_NAME,searchPartner.toUpperCase());
		}
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && retUsers.getRowCount()==0 && from!=null)
		{
			if(searchPartner.indexOf("*")==-1)
				searchPartner = "Equals to "+searchPartner;
			else if(searchPartner.indexOf("*")==0)
				searchPartner = "Ends with "+searchPartner.substring(searchPartner.indexOf("*")+1,searchPartner.length());
			else
				searchPartner = "Starts with "+searchPartner.substring(0,searchPartner.indexOf("*"));*/
%>
			
<%
			//return;
		//}
	}
%>


<%

	int rCount = retUsers.getRowCount();
	out.print("rCount:::"+rCount);
	//out.print("retUsers:::::"+retUsers.toEzcString());
	/*Vector vuserId=new Vector();
	Vector vfirstName=new Vector();
	Vector vmiddleIntial=new Vector();
	Vector vlastName=new Vector();
	Vector vuserType=new Vector();
	Vector vpurGrp	= new Vector();
	Vector vSearchKey = new Vector();
	retUsers.sort(new String[]{USER_FIRST_NAME},true);*/
	for(int i=0;i<rCount;i++)
	{
			
			//if(!vuserId.contains((String) retUsers.getFieldValue(i,USER_ID)))
			/*if(!vSearchKey.contains((String) retUsers.getFieldValue(i,USER_ID)+(String)retUsers.getFieldValueString(i,"EUD_SYS_KEY")))
			{
				vuserId.addElement((String) retUsers.getFieldValue(i,USER_ID));
				vfirstName.addElement((String) retUsers.getFieldValue(i,USER_FIRST_NAME));
				vmiddleIntial.addElement((String)retUsers.getFieldValue(i,USER_MIDDLE_INIT));
				vlastName.addElement((String) retUsers.getFieldValue(i,USER_LAST_NAME));
				vuserType.addElement((String)retUsers.getFieldValueString(i,"EU_TYPE"));
				vpurGrp.addElement((String)retUsers.getFieldValueString(i,"EUD_SYS_KEY"));
				vSearchKey.addElement((String) retUsers.getFieldValue(i,USER_ID)+(String)retUsers.getFieldValueString(i,"EUD_SYS_KEY"));

			}*/
	}
%>
	<div class="main-container col2-left-layout middle account-pages">
	<div class="hly-perftop"></div>
	<div class="main">
	<div class="col-main roundedCorners">
	<div class="my-account">
	<div class="dashboard">
	<div class="col1-set" style="position:relative;width:70%;left:16%">
 	<div class="info-box"><br>

	<table class="data-table" id="example">
	<thead>
	<Tr>
		<%=tabHeader%>
	</Tr>
	</thead>
	<tbody>
<%
	String Name = "";  
	for (int i = 0 ; i < rCount; i++)
	{
		String userId	= retUsers.getFieldValueString(i,"EU_ID");
		String fname	= retUsers.getFieldValueString(i,"EU_FIRST_NAME");
		String mname	= retUsers.getFieldValueString(i,"EU_MIDDLE_INITIAL");
		String lname	= retUsers.getFieldValueString(i,"EU_LAST_NAME");
		String type 	= retUsers.getFieldValueString(i,"EU_TYPE");
		String sysKey	= retUsers.getFieldValueString(i,"EUD_SYS_KEY");


		//String uType = (String)vuserType.elementAt(i);
		String userUrl = "ezUserDetails.jsp?UserID="+userId;
		String userType = "Business";
		if ( type.equals("2") )
		{
			userUrl = "ezViewIntranetUserData.jsp?UserID="+userId+"&Show=Yes";
			userType="Intranet";
		}

 		/*fname = (String) vfirstName.elementAt(i);
		if(fname != null) fname = fname.trim(); else fname="";
 		mname = (String) vmiddleIntial.elementAt(i);
		if(mname !=null) mname = mname.trim(); else  mname = " ";
 		lname = (String) vlastName.elementAt(i);
		if(lname!=null) lname=lname.trim(); else lname = " ";
		Name  = fname +" "+ mname +" "+  lname;
		String pGroup = (String)vpurGrp.elementAt(i);*/
		String pDesc = (String)sysKeyDescs.get((String)sysKey);
		
		if(fname != null) fname = fname.trim(); else fname="";
		if(mname !=null) mname = mname.trim(); else  mname = " ";
		if(lname!=null) lname=lname.trim(); else lname = " ";
		Name  = fname +" "+ mname +" "+  lname;
		
	
%>
		<Tr align="left">
			<label for="cb_<%=i%>"></label>
			<Td width="5%" align=center><input type="radio" name="chk1" id="cb_<%=i%>" value="<%=userId%>/<%=sysKey%>" ></Td>
			<Td width="15%"><a href=<%=userUrl%> ><%=userId%></a></Td>
			<Td width="30%" id="myUserName"><%=((String)Name).toUpperCase()%></Td>
<%
		if("All".equals(websys)){
%>
			<Td width="15%"><%=sysKey%></Td>
			<Td width="23%"><%=pDesc%></Td>
<%
		}
%>
			<Td width="12%"><%=userType%></Td>
			<input type="hidden" name="utype" value="<%=type%>" >
		</Tr>
<%
	}
%>
	</tbody>
	</Table>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	<div style="position:absolute;top:95%;left:5%;visibility:visible">
	<Table>
	<Tr>
		<Td class="search"><a href="JavaScript:ezSearch()">Search the User By Name</a></Td>
	</Tr>
	</Table>
	</div>

	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<a href="javascript:funCheckBoxSingleModify('<%=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/modify.gif" border=none></a>
	<!--<a href="javascript:funCheckBoxSingleDelete('<%//=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src="../../Images/Buttons/<%//= ButtonDir%>/delete.gif" border=none></a>-->
	<a href="javascript:funCheckBoxSingleCopyUser('<%=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/copyuser.gif" border=none></a>
<%
	//if ( "3".equals(myUserType) )
	{
%>
	<a href="javascript:funCheckBoxSingleResetPassword('<%=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/resetpassword.gif" border=none></a>
<%
	}
%>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</div>

<%
		}
		}

	else
		{
%>
		<br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>

      <Td class = "labelcell">
        <div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%>
          to continue.</b></div>
    </Td>
		</Tr>
		</Table><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
	<%
		}
%>


<%
	String saved = request.getParameter("saved");
	String uid = request.getParameter("uid");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Password is reset for <%=uid%>');
		</script>
<%
	}
%>
<%
		}
	else
		{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "displayheader">
					<div align="center">No <%=areaLabel%> To List</div>
				</Td>
			</Tr>
		</Table><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
		}
%>
<input type="hidden" name="Area" value=<%=areaFlag%> >
<input type="hidden" name="BusinessUser" value="" >
<input type="hidden" name="userName" value = "">
<input type="hidden" name="BPsyskey" >
</form>
</body>
</html>
