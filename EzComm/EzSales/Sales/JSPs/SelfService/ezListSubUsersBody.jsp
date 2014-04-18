<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%
	String loginUserId = (String)Session.getUserId();
	ReturnObjFromRetrieve retcatarea = null;
	ezc.client.EzcUtilManager UtilManagerSA = new ezc.client.EzcUtilManager(Session);

	retcatarea = (ReturnObjFromRetrieve)UtilManagerSA.getUserCatalogAreas();

	String[] sortArr={"ESKD_SYS_KEY"};

	int syskeyCount = retcatarea.getRowCount();

	String mySyskeys = "";
	if(syskeyCount>0)
	{
		mySyskeys = retcatarea.getFieldValueString(0,"ESKD_SYS_KEY");
		for (int i=0;i<syskeyCount;i++)
		{
			if(i==0)
				mySyskeys = retcatarea.getFieldValueString(i,"ESKD_SYS_KEY");		
			else
				mySyskeys =mySyskeys+"','"+retcatarea.getFieldValueString(i,"ESKD_SYS_KEY");
		}
	}

	ReturnObjFromRetrieve partnersRetSU = null;
	String soldTo_SU = (String) session.getValue("AgentCode");
	if(mySyskeys!=null && soldTo_SU!=null)
	{
		/******************** Commented to pick up Sub-Users based on partner of the login user *********/
		/*soldTo_SU = soldTo_SU.trim();

		String mySoldTo = "";
		try{
			soldTo_SU = Long.parseLong(soldTo_SU)+"";
		mySoldTo = "0000000000"+soldTo_SU;
		mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
		}catch(Exception ex){mySoldTo = soldTo_SU;}
	
		
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(mySyskeys);
		adminUtilsParams.setPartnerValueBy(mySoldTo);

		EzcParams mainParams_SU = new EzcParams(false);
		mainParams_SU.setObject(adminUtilsParams);
		Session.prepareParams(mainParams_SU);

		partnersRetSU = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams_SU);*/

		/*********************** Picking Sub-Users based on partner of login user Start **************/
		EzcParams mainParamsSub 	= new EzcParams(false);
		EziMiscParams miscParamsSub	= new EziMiscParams();

		miscParamsSub.setIdenKey("MISC_SELECT");
		String query="SELECT DISTINCT  EU_ID,EU_FIRST_NAME,EU_MIDDLE_INITIAL,EU_LAST_NAME,EU_TYPE,EU_EMAIL,(SELECT EUD_VALUE  FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID=EU_ID AND EUD_KEY='ISSUBUSER') SUBUSER  FROM EZC_USERS, EZC_USER_DEFAULTS WHERE EUD_USER_ID=EU_ID AND EUD_SYS_KEY IN ('"+mySyskeys+"')  AND EU_BUSINESS_PARTNER='"+session.getValue("BussPart")+"' ORDER BY EU_FIRST_NAME";
		miscParamsSub.setQuery(query);

		mainParamsSub.setLocalStore("Y");
		mainParamsSub.setObject(miscParamsSub);
		Session.prepareParams(mainParamsSub);	

		try
		{
			ezc.ezcommon.EzLog4j.log("miscParamsSub.getQuery()::::::::"+miscParamsSub.getQuery() ,"I");
			partnersRetSU = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsSub);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}

		/*********************** Picking Sub-Users based on partner of login user End ****************/
	}

	int partnersRetSUCnt = 0;
	String fullName="";
	String userIds="";

	if(partnersRetSU!=null)
	{
		for(int i=partnersRetSU.getRowCount()-1;i>=0;i--)
		{
			String tempuserId=partnersRetSU.getFieldValueString(i,"EU_ID");
			String isSubUser_S=partnersRetSU.getFieldValueString(i,"SUBUSER");
			if(isSubUser_S!=null && "".equals(isSubUser_S)) isSubUser_S = "N";
			if(loginUserId.equals(partnersRetSU.getFieldValueString(i,"EU_ID").trim()) || !"Y".equals(isSubUser_S))
				partnersRetSU.deleteRow(i);
			else
			{
				if("".equals(userIds))
					userIds=partnersRetSU.getFieldValueString(i,"EU_ID").trim();
				else
					userIds=userIds+"','"+partnersRetSU.getFieldValueString(i,"EU_ID").trim();

				//out.println(">>>>>>>>>>>userIds<<<>>>"+userIds);
			}
		}
		partnersRetSUCnt = partnersRetSU.getRowCount();
	}

	Hashtable statusHt = new Hashtable();
	Hashtable repCodeHt = new Hashtable();

	ReturnObjFromRetrieve subUserStat = null;

	EzcParams mainParamsStat 	= new EzcParams(false);
	EziMiscParams miscParamsStat	= new EziMiscParams();

	miscParamsStat.setIdenKey("MISC_SELECT");
	String queryStat="SELECT EUD_USER_ID,EUD_KEY,EUD_VALUE,(SELECT VALUE2 FROM EZC_VALUE_MAPPING where MAP_TYPE='REPAGENCYCODES' AND VALUE1=EUD_VALUE) REPNAME FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID IN ('"+userIds+"') AND EUD_KEY IN ('STATUS','REPAGECODE')";
	miscParamsStat.setQuery(queryStat);

	mainParamsStat.setLocalStore("Y");
	mainParamsStat.setObject(miscParamsStat);
	Session.prepareParams(mainParamsStat);	

	try
	{
		ezc.ezcommon.EzLog4j.log("miscParamsStat.getQuery()::::::::"+miscParamsStat.getQuery() ,"I");
		subUserStat = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsStat);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}

	if(subUserStat!=null)
	{
		for(int su=0;su<subUserStat.getRowCount();su++)
		{
			String htUserID	 = subUserStat.getFieldValueString(su,"EUD_USER_ID").trim();
			String htKey	 = subUserStat.getFieldValueString(su,"EUD_KEY");
			String htValue	 = subUserStat.getFieldValueString(su,"EUD_VALUE");

			if("STATUS".equals(htKey))
				statusHt.put(htUserID,htValue);
			if("REPAGECODE".equals(htKey))
			{
				String repName = subUserStat.getFieldValueString(su,"REPNAME");
				repCodeHt.put(htUserID,repName+"¥"+htValue);
			}
		}
	}
	//out.println(">>>>>>>>>>>partnersRetSU<<<<<<<<<<<<<<"+partnersRetSU.toEzcString());
%>
<Script src="../../Library/JavaScript/Misc/Trim.js"></Script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>

<Script type="text/javascript">

var req;
var userId;
var userStatus;
var rowIndex;


function Initialize()
{
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
	if(! req&&typeof XMLHttpRequest != "undefined")
	{
		req = new XMLHttpRequest();
	}

}

function SendQuery()
{


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
	url="../SelfService/ezUpdateSubUserStatus.jsp?UserID="+userId.value+"&Status="+userStatus.value+"&mydate="+new Date();
	//alert(url)
	if(req!=null)
	{
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);
	}


} 
function Process() 
{
	if (req.readyState == 4)
	{
	 
		var resText     = req.responseText;	
		resText = resText.replace(/[\n\r\t]/g,'')		

		if (req.status == 200)
		{
			if(resText=='A')
			{
				eval("document.getElementById('userStatusImg_'+rowIndex.value)").src = '../../Library/images/active.png'; 
				userStatus.value = 'A';
			}	
			else if(resText=='I'){
				eval("document.getElementById('userStatusImg_'+rowIndex.value)").src = '../../Library/images/inactive.png';  
				userStatus.value = 'I';
			}
			Popup.showModal('modal1');
			document.myForm.submit();
		}
		else
		{
			if(req.status == 500)	 
			alert("Error");
		}
	}
}
function changeStatus(objNumber)
{
	var status=confirm("Are you sure to change the status ?");
	if(status==true)
	{
		userId	    = eval("document.myForm.userId_"+objNumber);
		userStatus  = eval("document.myForm.userStatus_"+objNumber);
   		rowIndex    = eval("document.myForm.rowIndex_"+objNumber);
		SendQuery();
	}
}
function modifyDetails()
{
	var count=0;
	var len=document.myForm.BusinessUser.length;
	var obj=document.myForm.BusinessUser;

	if(isNaN(len))
	{
		if(obj.checked)
		count++;
	}

	else
	{
		for(var i=0;i<len;i++)
		{
			if(obj[i].checked)
			count++;
		}	
	}
	if(count==0)
	{
		$( "#dialog-modifyAlert" ).dialog('open');
		//alert("Please select a user to modify");
			//return;
	}
	else
	{
		document.myForm.action="ezChangeUserData.jsp";
		document.myForm.submit();
	}	
}
function getUserDetails(userId,repCode)
{
	document.myForm.UserID.value=userId;
	document.myForm.RepAgency.value=repCode;
	document.myForm.action="ezSubUserDetails.jsp";
	document.myForm.submit();
}
function changePwd()
{
	var count=0;
	var len=document.myForm.BusinessUser.length;
	var obj=document.myForm.BusinessUser;

	if(isNaN(len))
	{
		if(obj.checked)
		{

			count++;
		}
	}

	else
	{
		for(var i=0;i<len;i++)
		{
			if(obj[i].checked)
			count++;
		}	
	}
	if(count==0)
	{
		$( "#dialog-passAlert" ).dialog('open');
		//alert("Please select a user to change password");
			//return;
	}
	else
	{

		document.myForm.action="ezChangePasswordBySysKey.jsp";
		document.myForm.submit();
	}	
}
function funDelete()
{
	var count=0;
	var len=document.myForm.BusinessUser.length;
	var obj=document.myForm.BusinessUser;

	if(isNaN(len))
	{
		if(obj.checked)
		{
			count++;
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(obj[i].checked)
				count++;
		}	
	}
	if(count==0)
	{
		$( "#dialog-delAlert" ).dialog('open');
		//alert("Please select a user to delete");
		//return;
	}
	else
	{
		var y = confirm("Are you sure to Delete?");

		if(eval(y))
		{
			document.myForm.action="ezDeleteSubUser.jsp";
			document.myForm.submit();
		}
	}
}
$(function() {
	
		
	$( "#dialog-modifyAlert" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});
	$( "#dialog-delAlert" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});	
	$( "#dialog-passAlert" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});		
});
</Script>
<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";

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


<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
 
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
		/*"sDom": '<"H"Tfr>t<"F"ip>',
		"oTableTools": {
			"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
			"aButtons": [
			{
			    "sExtends":    "csv",
			    "sButtonText": " Download CSV "
			}
			]
		}*/
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

<form name=myForm method=post>
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>

<div id="dialog-passAlert" title="Password Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please select a user to change password</p>
</div>

<div id="dialog-delAlert" title="Delete Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please select a user to delete</p>
</div>

<div id="dialog-modifyAlert" title="Modify Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please select a user to modify</p>
</div>

<input type="hidden" name="Area" value="C">
<input type="hidden" name="UserID">
<input type="hidden" name="RepAgency">

<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main roundedCorners containerds">
<%
	if(partnersRetSUCnt>0)
	{
		String repAgency = (String)session.getValue("REPAGENCY");
%>
		<div class="block" style="padding-left:0px">
			<div class="block-title"><strong><span>Sub-User List</span></strong></div>
		</div>
		
		<Div class="info_box" align ="center">
			<Table>
			<Tr>
				<Td><h3>Status :</h3></Ttd>
				<Td><img src='../../Library/images/active.png' border=0>&nbsp;&nbsp;Active</Td>
				<Td><img src='../../Library/images/inactive.png' border=0>&nbsp;&nbsp;Blocked</Td>
			</Tr>
			</Table>
		</div>
		
		<table class="data-table" id="example">
		<thead>
		<Tr>
			<Th width=10%>&nbsp;</Th>
			<Th width=25%>User Id</Th>
			<Th width=25%>User Name</Th>
<%
		if(repAgency!=null && "Y".equals(repAgency))
		{
%>
			<Th width=30%>Rep Agency Code</Th>
<%
		}
%>
			<Th width=10%>Status</Th>
		</Tr>
		</thead>
		<tbody>
<%
		String userStatus = "A";

		partnersRetSU.sort(new String[]{"EU_ID"},true);

		for(int i=0;i<partnersRetSUCnt;i++)
		{
			fullName	= partnersRetSU.getFieldValueString(i,"EU_FIRST_NAME")+" "+partnersRetSU.getFieldValueString(i,"EU_LAST_NAME");
			String userId	= partnersRetSU.getFieldValueString(i,"EU_ID").trim();
			String repAgenCode = (String)repCodeHt.get(userId);
			if(repAgenCode==null || "null".equalsIgnoreCase(repAgenCode) || "".equals(repAgenCode)) repAgenCode = "N/A";

			String repName_R = "";
			String repCode_R = "";

			try
			{
				repName_R = repAgenCode.split("¥")[0];
				repCode_R = repAgenCode.split("¥")[1];
				repAgenCode = repName_R+" ("+repCode_R+")";
			}
			catch(Exception e){}

			String key	= userId+"¥"+fullName+"¥"+repCode_R;
%>
			<Tr>
				<Td class="a-center" width=10%><input type="radio" name="BusinessUser" value="<%=key%>"></Td>
				<Td width=25%>&nbsp;<a href="javascript:getUserDetails('<%=userId%>','<%=repAgenCode%>')"><%=userId%></a></Td>
				<Td width=25%>&nbsp;<%=fullName%></Td>
<%
				if(repAgency!=null && "Y".equals(repAgency))
				{
%>
					<Td width=30%>&nbsp;<%=repAgenCode%></Td>
<%
				}
%>
				<Td width=10%>&nbsp;
<%
				if("I".equals((String)statusHt.get(userId)))
				{
					userStatus ="A";
%>
					<img id="userStatusImg_<%=i%>" src="../../Library/images/inactive.png" style="cursor:pointer"  Title ="Click Here To Change The Status" border=no onClick="changeStatus(<%=i%>)">
<%
				}
				else
				{
					userStatus ="I";
%>
					<img id="userStatusImg_<%=i%>" src="../../Library/images/active.png" style="cursor:pointer"  Title ="Click Here To Change The Status" border=no onClick="changeStatus(<%=i%>)">
<%
				}
%>
				<input type="hidden" name= "userStatus_<%=i%>" value="<%=userStatus%>">
				<input type="hidden" name="rowIndex_<%=i%>" value="<%=i%>">
				<input type="hidden" name="userId_<%=i%>" value="<%=userId%>">
				</Td>
			</Tr>
<%
		}
%>
		</tbody>
		</table>
	<br>

	<div class="buttons-set form-buttons">
		<p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go back</a></p>
		<button type="button" class="button" title="Modify" onClick="modifyDetails()"><span><span>Modify</span></span></button>
		<button type="button" class="button" title="Change Password" onClick="changePwd()"><span><span>Change Password</span></span></button>
		<button type="button" class="button" title="Delete" onClick="funDelete()"><span><span>Delete</span></span></button>
	</div>
<%
	}else{
%>
		<br><br><br><br>
		<table class="data-table" id="example">
			<Tr align="center">
				<Th>There are no Users to List.</Th>
			</Tr>
		</table>
		<br>
<%
	}
%>
</div>
<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
		<div class="block-title"><strong><span>My Account</span></strong></div>
		<div class="block-content">
		<ul>
		<li><a href="../SelfService/ezChangeAcctInfo.jsp">Account Profile</a></li>
		<li ><a href="../SelfService/ezChangePassword.jsp">Change Password</a></li>
<%
		if (!"CM".equals(userRole) && !"Y".equals((String)session.getValue("IsSubUser")))
		{
%>
			<li><a href="../SelfService/ezAddSubUser.jsp">Add Sub User</a></li>
			<div style="color:#66cc33;"><strong><span>List Sub Users</span></strong></div>
<%
		}
%>
		</ul>
		</div>
	</div>
</div>
</div>
</div>
</form>
