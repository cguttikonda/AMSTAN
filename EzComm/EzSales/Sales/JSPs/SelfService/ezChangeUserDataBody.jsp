<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*" %>
<%!
	public ReturnObjFromRetrieve getListOfShipTos(String custNO,String busPartner,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);

		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String query="Select A.*, B.* from EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B where  A.EC_PARTNER_FUNCTION in ('WE') and A.EC_ERP_CUST_NO = '"+custNO+"' and A.EC_BUSINESS_PARTNER = '"+busPartner+"' and B.ECA_LANG = 'EN' and A.EC_NO = B.ECA_NO";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}		
		return retObjMisc;
	}
	public ReturnObjFromRetrieve getValueMapByKey(String mapType,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc = null;

		if(mapType!=null && !"null".equalsIgnoreCase(mapType) && !"".equals(mapType))
		{
			ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
			ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();

			ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
			miscParams.setIdenKey("MISC_SELECT");
			String query="SELECT * FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='"+mapType+"'";

			miscParams.setQuery(query);
			mainParamsMisc.setLocalStore("Y");
			mainParamsMisc.setObject(miscParams);
			Session.prepareParams(mainParamsMisc);	

			try
			{		
				ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
				retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
			}
		}
		return retObjMisc;
	}
%>
<%
	String values[] 	= request.getParameter("BusinessUser").split("¥");
	String user_id		= "";
	String repAgenCode 	= "";

	try
	{
		user_id		= values[0];
		repAgenCode 	= values[2];
	}
	catch(Exception e){}
%>
<%@ include file="../../../Includes/JSPs/Misc/iSubUserDetails.jsp"%>
<%
	String userId	= ret.getFieldValueString(0,"EU_ID");
	String firstName= ret.getFieldValueString(0,"EU_FIRST_NAME");
	String lastName = ret.getFieldValueString(0,"EU_LAST_NAME");
	String email	= ret.getFieldValueString(0,"EU_EMAIL");
	String password	= ret.getFieldValueString(0,"EU_PASSWORD");
	
	session.putValue("UserId",userId);	

	if(email==null || "null".equals(email)) email="";
	if(firstName==null || "null".equals(firstName)) firstName="";
	if(lastName==null || "null".equals(lastName)) lastName="";

	/***************** Sub User Authorizations Start ******************/

	Hashtable subUserAuthHT = new Hashtable();

	subUserAuthHT.put("VONLY","View Orders");
	subUserAuthHT.put("VSAVE","Add New(Cart Items and Orders)");
	subUserAuthHT.put("VEDIT","Submit Order");

	/***************** Sub User Authorizations End ******************/

	int retObjCnt	= 0;
	Vector selShips = new Vector();
	Vector selSolds = new Vector();
	ReturnObjFromRetrieve retObjShip = null;
	mainParamsMisc	= new ezc.ezparam.EzcParams(false);

	miscParams = new ezc.ezmisc.params.EziMiscParams();
	miscParams.setIdenKey("MISC_SELECT");
	String query="SELECT DISTINCT(EUD_VALUE) VALUE,EUD_KEY FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID = '"+user_id+"'  and EUD_KEY IN ('SHIPTOPARTY','SOLDTOPARTY')";

	miscParams.setQuery(query);
	mainParamsMisc.setLocalStore("Y");
	mainParamsMisc.setObject(miscParams);
	Session.prepareParams(mainParamsMisc);

	try
	{
		ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
		retObjShip = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
	}
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
	}
	if(retObjShip!=null && retObjShip.getRowCount()>0)
	{
		retObjCnt = retObjShip.getRowCount();
		for(int r=0;r<retObjCnt;r++)
		{
			if("SHIPTOPARTY".equals(retObjShip.getFieldValueString(r,"EUD_KEY")))
				selShips.add(retObjShip.getFieldValueString(r,"VALUE"));
			if("SOLDTOPARTY".equals(retObjShip.getFieldValueString(r,"EUD_KEY")))
				selSolds.add(retObjShip.getFieldValueString(r,"VALUE"));
		}
	}
	//out.println(selShips);
%>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>


<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<!-- Style for New Header -->
<!-- end of style for new header -->

<Script src="../../Library/Script/popup.js"></Script> 

<script type="text/javascript">
$(document).ready( function() 
{		
	$(".fancybox").fancybox(
	{
		closeBtn:true	
	});
});
</Script>

<script type="text/javascript">
function echeck(str) 
{
	var at="@"
	var dot="."
	var lat=str.indexOf(at)
	var lstr=str.length
	var ldot=str.indexOf(dot)
	if (str.indexOf(at)==-1){
	   alert("Invalid E-mail ID")
	   return false
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
	   alert("Invalid E-mail ID")
	   return false
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
	    alert("Invalid E-mail ID")
	    return false
	}

	 if (str.indexOf(at,(lat+1))!=-1){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 if (str.indexOf(dot,(lat+2))==-1){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 if (str.indexOf(" ")!=-1){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 return true					
}
	
function updateSubVndr()
{
	
	var emailID=document.myForm.email;
	var sacount=0;
	var slen =document.myForm.subUserAuthDisp.length;

	if(document.myForm.userName.value=="")
	{
		alert("Please enter First Name")
		document.myForm.userName.focus();
		return;
	}
	if(document.myForm.lastName.value=="")
	{
		alert("Please enter Last Name")
		document.myForm.lastName.focus();
		return;
	}
	if(document.myForm.email.value=="")
	{
		alert("Please enter  email")
		document.myForm.email.focus();
		return;
	}
	if (echeck(emailID.value)==false){
		emailID.value="";
		emailID.focus();
		return;
	}
	for(a=0;a<slen;a++)
	{
		var suaObj = document.myForm.subUserAuthDisp[a];
		if(suaObj.checked==true)
		{
			sacount++;
		}
	}
	if(sacount==0)
	{
		alert("Please select authorization(s)");
		return;
	}

	var isRep = document.myForm.isRepAgency.value;

	if(isRep=="Y")
	{
		Popup.showModal('modal1');
		document.myForm.action="ezChangeRepUser.jsp";
		document.myForm.submit();
	}
	else
	{
		var count=0;
		var len=document.myForm.CheckBox.length;
		var obj=document.myForm.CheckBox;
		var selshiplen=document.myForm.SelShipTo.length;

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
			alert("Please select atleast one ERP customer");
			return;
		}
		var count1=0
		var count2=0
		var count3=0
		for(i=0;i<selshiplen;i++)
		{
			var shipObj = document.myForm.SelShipTo[count1]
			//alert("shipObj:::::::"+shipObj)
			if(shipObj.checked)
			{
				document.myForm.hiddenShip[count1].value = shipObj.value;
				//alert("document.myForm.hiddenShip[count1].value::::::::"+document.myForm.hiddenShip[count1].value)
				count3++
			}
			count1++;

		}
		if(count3==0)
		{
			$( "#dialog-shipAlert" ).dialog('open');
			return;
		}

		for(i=0;i<len;i++)
		{
			var soldObj = document.myForm.CheckBox[count2]
			//alert("soldObj:::::::"+soldObj)
			if(soldObj.checked)
			{
				//alert("Hiiii")
				document.myForm.CheckBox[count2].value = soldObj.value;
				//alert("document.myForm.CheckBox[count2].value::::::::"+document.myForm.CheckBox[count2].value)
			}
			count2++;

		}	
		Popup.showModal('modal1');
		document.myForm.action="ezSaveChangeSubUserDetails.jsp";
		document.myForm.submit();
	}
}
function selectAll()
{
	var chkHeader=document.myForm.CheckBox1;
	var len=document.myForm.CheckBox.length;
	var obj=document.myForm.CheckBox;

	if(isNaN(len))
	{
		obj.checked=chkHeader.checked;
		enableShipTos(obj,obj.checked)
	}

	else
	{
		for(var i=0;i<len;i++){
			obj[i].checked=chkHeader.checked;
			enableShipTos(obj[i],obj[i].checked)
		}	
	}
}
function enableShipTos(chkObj,chked)
{
	var SelShipToLen=eval("document.myForm.ShipCount").value
	var selSoldTo=chkObj.value;
	var obj1=document.myForm.SelShipTo;
	var len=document.myForm.CheckBox.length;
	var count =0;
	selSoldTo = selSoldTo.split("¥")[0] 
	for(j=0;j<SelShipToLen;j++)
	{
		shipObj = document.myForm.SelShipTo[j]
		if(shipObj!='undefined')
		{
			var shipVal = shipObj.value;	
			soldFromShip = 	shipVal.split("##")[2]
			if(selSoldTo==soldFromShip.split("¥")[0])
			if(chked)
			{
				document.myForm.SelShipTo[j].checked=true;
				document.myForm.SelShipTo[j].disabled=false;
			}
			else
			{
				document.myForm.SelShipTo[j].checked=false;
				document.myForm.SelShipTo[j].disabled=true;
			}
		}
	}
}
function funcAuth(idx)
{
	var obj = eval("document.myForm.subUserAuthDisp["+idx+"]")
	var len = document.myForm.subUserAuthDisp.length
	
	if(obj.checked == true)
	{
		document.myForm.subUserAuth.value = obj.value
		if(obj.value == 'VSAVE')
		{
			for(a=0;a<len;a++)
			{
				var suaObj = document.myForm.subUserAuthDisp[a]
				if(suaObj.value=='VONLY')
				{
					suaObj.checked = true
					suaObj.disabled = true
					break
				}
			}
		
		}
		if(obj.value == 'VEDIT')
		{
			for(a=0;a<len;a++)
			{
				var suaObj = document.myForm.subUserAuthDisp[a]
				if(suaObj.value=='VONLY')
				{
					suaObj.checked = true
					suaObj.disabled = true
				}
				if(suaObj.value=='VSAVE')
				{
					suaObj.checked = true
					suaObj.disabled = true
				}

			}
		
		}
	
	}
	else
	{
		if(obj.value == 'VSAVE')
		{
			for(a=0;a<len;a++)
			{
				var suaObj = document.myForm.subUserAuthDisp[a]
				if(suaObj.value=='VONLY')
				{
					suaObj.checked = false
					suaObj.disabled = false
					break
				}
			}
		
		}
		if(obj.value == 'VEDIT')
		{
			for(a=0;a<len;a++)
			{
				var suaObj = document.myForm.subUserAuthDisp[a]
				if(suaObj.value=='VONLY')
				{
					suaObj.checked = false
					suaObj.disabled = false
				}
				if(suaObj.value=='VSAVE')
				{
					suaObj.checked = false
					suaObj.disabled = false
				}
			}
		
		}
	
	
	}
}
function funChkEmail(email)
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
	url="../SelfService/ezCheckEmail.jsp?entEmail="+email;
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
			if(resText=='Y')
			{
				//alert("resText::::"+resText)
				$( "#dialog-emailAlert" ).dialog('open');
				
				document.myForm.email.value="";
			}
			
		}
		else
		{
			if(req.status == 500)	 
			alert("Error");
		}
	}
}
$(function() {
	

	$( "#dialog-emailAlert" ).dialog({
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
	$( "#dialog-shipAlert" ).dialog({
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

<form name=myForm method="post">
<input type=hidden name="subUserAuth" value="<%=suAuth%>">

<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>

<div id="dialog-emailAlert" title="EmailAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>This Email Id already exist in portal</p>
</div>

<div id="dialog-shipAlert" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please select atleast one Ship To.</p>
</div>

<%
	String repAgency = (String)session.getValue("REPAGENCY");
	String emailChk_S = "onFocusOut='funChkEmail(this.value)'";

	boolean repAgen_B = false;
	String isRepAgency = "N";
	if(repAgency!=null && "Y".equals(repAgency))
	{
		repAgen_B = true;
		emailChk_S = "";
		isRepAgency = "Y";
	}
%>

<input type=hidden name="isRepAgency" value="<%=isRepAgency%>">

<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main roundedCorners containerds">

<div class="block" style="padding-left:0px">
	<div class="block-title"><strong><span>Change User Information</span></strong></div>	
</div>
	<table class="data-table" id="quickatp">
		<Th colspan=4 align ="center" style="background-color:#000000; color:#50B4B6; font-size:15px;">
			<h1>Please go through the following information to change</h1>
		</Th>
	<tbody>
	      <Tr>
			<input type = "hidden" name = "soldTo" value="">
			<Td align="right">User ID *</Td>
			<Td><%=userId %></Td>
			  <input type="hidden" name="UserID" value="<%=userId%>" >
			<Td align = "right">E Mail *</Td>
			<Td> <input type=text class = "InputBox" name="email"  size=20 maxlength=40 value="<%=email%>" <%=emailChk_S%> ></Td>
	      	</Tr>
		<Tr>
			<Td align="right"> First Name *</Td >
			<Td>
				<input type=text class = "InputBox" name="userName"  size=20 maxlength=60 value="<%=firstName%>">
				<input type="hidden" name="Password"  value="<%=password%>">
			</Td>	
			<Td align="right"> Last Name *</Td >
			<Td>
				<input type=text class = "InputBox" name="lastName"  size=20 maxlength=60 value="<%=lastName%>">
			</Td>	
			
			<input type="hidden" name = "catnum" value="<%=catalogNumber%>">
		</Tr>
	</tbody>	
	<Tr>
		<Th colspan=4 align ="center" style="background-color:#000000; color:#50B4B6; font-size:15px;">
			<h1> Accounts Accessibility </h1>
		</Th
	</Tr>
<%
	if(!repAgen_B)
	{
%>
	<Tr>
	<Td colspan=4>
	<Table class="data-table" style=" height:300px; overflow:auto; display:block;">
	<Tr>
		<Th align="center" width="10%">
			<input type="checkbox" name="CheckBox1" value="" onclick="selectAll()">
		</Th>
		<Th width="40%">
			<h1> Allowed Sold To Account(s)* </h1>
		</th>
		<Th colspan=2 width="50%">
			<h1> Allowed Ship To Account(s)* </h1>
		</Th>
	</Tr>
<%
	retsoldtoSU = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	int syskeyCount = 0;
	int custRows 	= retsoldtoSU.getRowCount(); 
	if(retSyskey!=null)
		syskeyCount = retSyskey.getRowCount(); 
	
	String defSysKey = null;
	ReturnObjFromRetrieve  listShipTosSU = null;
	Vector addedSoldTo = new Vector();
	Vector custDel = new Vector();
	Vector custDelete = new Vector();
	Vector shipDel = new Vector();
	Vector shipDelete = new Vector();
	Hashtable shipSys = new Hashtable();
	Hashtable soldSys = new Hashtable();
	if ( syskeyCount > 0 )
	{
		//for ( int i = 0 ; i < syskeyCount; i++ )
		{
			
			for ( int s = 0 ; s < custRows; s++ )
			{
				String custNum_S = (String)retsoldtoSU.getFieldValue(s,"EC_ERP_CUST_NO");
				String custSysKey_S = retsoldtoSU.getFieldValueString(s,"EC_SYS_KEY");
				if(custDelete.contains(custNum_S))
				{
					String tempSys = (String)soldSys.get(custNum_S);
					tempSys = tempSys+"¤¤"+retsoldtoSU.getFieldValue(s,"EC_SYS_KEY");
					soldSys.put(custNum_S,tempSys);
				}	
				else{
					custDelete.add(custNum_S);
					soldSys.put(custNum_S,custSysKey_S);
				}				
				
			}			
			for(int j=0;j<custRows;j++)
			{
				String blockCode_A 	= retsoldtoSU.getFieldValueString(j,"ECA_EXT1");
				if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

				if(!"BL".equalsIgnoreCase(blockCode_A))
				{
				String custNum = (String)retsoldtoSU.getFieldValue(j,"EC_ERP_CUST_NO");
				String custName = (String)retsoldtoSU.getFieldValue(j,"ECA_NAME");
				String soldToSyskey = retsoldtoSU.getFieldValueString(j,"EC_SYS_KEY");
				String Checked ="";
								
				if(addedSoldTo.contains(retsoldtoSU.getFieldValueString(j,"EC_ERP_CUST_NO")))
					continue;
				else
					addedSoldTo.add(retsoldtoSU.getFieldValueString(j,"EC_ERP_CUST_NO"));
					
				listShipTosSU = (ReturnObjFromRetrieve)getListOfShipTos(retsoldtoSU.getFieldValueString(j,"EC_ERP_CUST_NO"),busPartner,Session);	
				if(selSolds.contains(custNum))
				{
					Checked = "checked";
				}				
								
%>
					<Tr>
						<Td nowrap colspan="2">
							<input type="checkbox" name="CheckBox" value="<%=retsoldtoSU.getFieldValueString(j,"EC_ERP_CUST_NO")%>¥<%=soldSys.get(retsoldtoSU.getFieldValueString(j,"EC_ERP_CUST_NO"))%>" onClick="enableShipTos(this,this.checked)" <%=Checked%>>
							<%=retsoldtoSU.getFieldValue(j,"ECA_NAME")%>&nbsp;
							(<%=retsoldtoSU.getFieldValue(j,"EC_ERP_CUST_NO")%>)&nbsp;
							 
						</Td> 
 						<Td nowrap colspan="2">
 						<Table>
<%
						for(int m =0;m<listShipTosSU.getRowCount();m++)
						{
							String shipToName = listShipTosSU.getFieldValueString(m,"ECA_COMPANY_NAME");
							String shipToNum = listShipTosSU.getFieldValueString(m,"EC_PARTNER_NO");						
							if(shipDel.contains(shipToNum))
							{
								String tempSys = (String)shipSys.get(shipToNum);
								tempSys = tempSys+"¤¤"+listShipTosSU.getFieldValue(m,"EC_SYS_KEY");
								shipSys.put(shipToNum,tempSys);
							}	
							else{
								shipDel.add(shipToNum);
								shipSys.put(shipToNum,listShipTosSU.getFieldValue(m,"EC_SYS_KEY"));
							}						
					
						}						
						
						for(int ship=0;ship<listShipTosSU.getRowCount();ship++)
						{
							blockCode_A 	= listShipTosSU.getFieldValueString(ship,"ECA_EXT1");
							if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

							if(!"BL".equalsIgnoreCase(blockCode_A))
							{
							String shipToName = listShipTosSU.getFieldValueString(ship,"ECA_COMPANY_NAME");
							String shipToNum = listShipTosSU.getFieldValueString(ship,"EC_PARTNER_NO");
							String accountGrp = listShipTosSU.getFieldValueString(ship,"ECA_ACCOUNT_GROUP");

							if(shipDelete.contains(shipToNum))
								continue;
							else
								shipDelete.add(shipToNum);
							String Checked1 ="";
							String disable="";//"disabled";
							if(selShips.contains(shipToNum))
							{
								Checked1 = "checked";
								disable  = "";
							}
							String addBuff = nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_COMPANY_NAME"))+",<br>"+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_ADDR_1"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_ADDR_2"))+",<br>"+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_CITY"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_STATE"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_PHONE"));

							if("CPDA".equals(accountGrp)) addBuff = "Drop Ship";
%>
							<Tr>
							<Td style="border:0px"><input type="checkbox" name="SelShipTo" value="<%=listShipTosSU.getFieldValueString(ship,"EC_PARTNER_NO")%>##<%=(listShipTosSU.getFieldValue(ship,"EC_SYS_KEY"))%>##<%=retsoldtoSU.getFieldValue(j,"EC_ERP_CUST_NO")%>¥<%=shipSys.get(listShipTosSU.getFieldValueString(ship,"EC_PARTNER_NO"))%>" <%=Checked1%> <%=disable%>>
							<input type="hidden" name="hiddenShip"></Td>
<%
							shipToName = shipToName.trim();
							if(shipToName != null)
							{
%>
								<Td style="border:0px"><%=shipToNum%><br><%=addBuff%></Td>
<%
							}
							else
							{
%>
								<Td style="border:0px">No ShipTo Name</Td>
<%
							}
							}
						}
%>
						</Table>
						</Td>
					</Tr>
<%
				}
			} 
		}
%>
			<input type="hidden" name="TotalCount" value=<%=custRows%> >
			<input type="hidden" name="ShipCount" value=<%=shipDel.size()%> >
<%			
		  		
	}
	else
	{
%>
	<Tr>
		<Td>No ERP Customers To List</Td>
	</Tr>
<%
	}
%>
	</Table>
	</Td>
	</Tr>
<%
	}
%>
	<input type=hidden name="SysNum" value="999">
<%
	String ordStatus_Auth = "EZC_CUSTOMER_COR";
	if(repAgen_B)
	{
		String checkedY = "";
		String checkedN = "";
		ordStatus_Auth = "EZC_REPAGE_CORE";

		if("Y".equals(exclMat))
			checkedY = "checked";
		else if("N".equals(exclMat))
			checkedN = "checked";

		ReturnObjFromRetrieve repAgencyList = (ReturnObjFromRetrieve)getValueMapByKey("REPAGENCYCODES",Session);
%>
		<Tr>
		<Th class="a-right" colspan="2">Rep Agency <em style="color:red">*</em></Th>
		<Td class="a-left" colspan="2">
		<select name="repAgencyCode" id="repAgencyCode" style="width:100%" required>
			<option value="">------Select------</option>
<%
		if(repAgencyList!=null && repAgencyList.getRowCount()>0)
		{
			for(int ra=0;ra<repAgencyList.getRowCount();ra++)
			{
				String repCode = repAgencyList.getFieldValueString(ra,"VALUE1");
				String repName = repAgencyList.getFieldValueString(ra,"VALUE2");

				String selected = "";
				if(repAgenCode!=null && repAgenCode.equals(repCode)) selected = "selected";
%>
				<option value="<%=repCode%>" <%=selected%>><%=repName%> (<%=repCode%>)</option>
<%
			}
		}
%>
		</select>
		</Td>
		</Tr>
		<Tr>
		<Th class="a-right" colspan="2">Allow Exclusive Materials <em style="color:red">*</em></Th>
		<Td class="a-left" colspan="2">
			<input type="radio" name="exclMat" value="Y" <%=checkedY%>>Yes &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="exclMat" value="N" <%=checkedN%>>No
		</Td>
		</Tr>
		<Tr>
		<Th class="a-right" colspan="2">Upload Ship To codes <em style="color:red">*</em></Th>
		<Td class="a-left" colspan="2">
		<a class="fancybox" href="#SHIPTOCODES">
			<button type="button" class="button" title="Upload"><span><span>Upload</span></span></button>
		</a>
		</Td>
		</Tr>
		<div id="SHIPTOCODES" style="width: 50%; display:none">
			<iframe id="AttachFiles" src="ezUploadShips.jsp" width="500" height="270" scrolling="no"></iframe>
		</div>
<%
	}
%>
		<Tr>
			<Th colspan=4 align ="center" style="background-color:#000000; color:#50B4B6; font-size:15px;">
			<h1> User Authorization </h1>
			</Th>
		</Tr>
		<tr>
			<th colspan="2">Order Accessibility</th>
			<th colspan="2">Financial Accessibility </th>
		</tr>
		<tr>
		<td colspan="2">
<%	
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
	
	if(userAuth_R.containsKey("ORDER_STATUS"))
	{ 
%>
		<input type="checkbox" name="subUserAuthDisp" value="<%=ordStatus_Auth%>#Super Admin Insert#R" <%=checkKey(ordStatus_Auth,suAuthRolesHT)%> >&nbsp;Check Order Status<br>
<%	}
	if(userAuth_R.containsKey("SO_TEMPLATE"))//SO_CREATE
	{ 
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_ENT#Super Admin Insert#R" <%=checkKey("EZC_CUST_ORD_ENT",suAuthRolesHT)%>  >&nbsp;Save Order as Template<br>
<%
	}
	if(userAuth_R.containsKey("SUBMIT_ORDER"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_SUB#Super Admin Insert#R" <%=checkKey("EZC_CUST_ORD_SUB",suAuthRolesHT)%> >&nbsp;Submit to American Standard<br>
<%
	}
	if(userAuth_R.containsKey("SO_CANCEL"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_CAN#Super Admin Insert#R" <%=checkKey("EZC_CUST_ORD_CAN",suAuthRolesHT)%> >&nbsp;Cancel to Cancellation<br>
<%	
	}
	if(userAuth_R.containsKey("SO_RETURN_CREATE"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_RGA#Super Admin Insert#R" <%=checkKey("EZC_CUST_ORD_RGA",suAuthRolesHT)%> >&nbsp;RGA/Return<br>
<% 
	}
	if(userAuth_R.containsKey("FOC_ORDER"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_INTSLS_FOCRE#Super Admin Insert#R" <%=checkKey("EZC_INTSLS_FOCRE",suAuthRolesHT)%> >&nbsp;FOC Creation<br>
<%
	}
	if(userAuth_R.containsKey("DISP_ORDER"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_DISP_PROGRAM#Super Admin Insert#R" <%=checkKey("EZC_DISP_PROGRAM",suAuthRolesHT)%> >&nbsp;Display Program<br>
<%
	}
	if(userAuth_R.containsKey("ASK_QUESTION"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" <%=checkKey("EZC_CUST_QUERY",suAuthRolesHT)%> value="EZC_CUST_QUERY#Super Admin Insert#R">&nbsp;Ask Questions<br>
<%
	}
%>		
		</td>
		<td colspan="2">
<%		
	if(userAuth_R.containsKey("SO_PAY_DTL"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" <%=checkKey("EZC_CUST_FIN",suAuthRolesHT)%> value="EZC_CUST_FIN#Super Admin Insert#R">&nbsp;Invoices<br>
<% 
	}
%>
	</td>			
		</tr>
		<tr>
				<th colspan="2">News/Announcements</th>
				<th colspan="2">Others</th>
		</tr>
		<tr>
			<td colspan="2">
<%	
	if(userAuth_R.containsKey("VIEW_PL_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PLNEWS#Super Admin Insert#R" <%=checkKey("EZC_CUST_PLNEWS",suAuthRolesHT)%> ">&nbsp;Products List Price<br>

<%
	}
	if(userAuth_R.containsKey("VIEW_PS_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PS_NEWS#Super Admin Insert#R" <%=checkKey("EZC_CUST_PS_NEWS",suAuthRolesHT)%> ">&nbsp;Periodic Statement<br>
<%
	}
	if(userAuth_R.containsKey("VIEW_PSPEC_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PSPEC_N#Super Admin Insert#R" <%=checkKey("EZC_CUST_PSPEC_N",suAuthRolesHT)%> ">&nbsp;Market Area Net Price<br>
<% 
	}
	if(userAuth_R.containsKey("VIEW_NPROD_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_NP_NEWS#Super Admin Insert#R" <%=checkKey("EZC_CUST_NP_NEWS",suAuthRolesHT)%> ">&nbsp;New Products<br>
<%
	}
	if(userAuth_R.containsKey("VIEW_DC_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_DC_NEWS#Super Admin Insert#R" <%=checkKey("EZC_CUST_DC_NEWS",suAuthRolesHT)%> ">&nbsp;Discontinued. Products<br>
<%
	}
	if(userAuth_R.containsKey("VIEW_PCHNG_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PCH_NEW#Super Admin Insert#R" <%=checkKey("EZC_CUST_PCH_NEW",suAuthRolesHT)%> ">&nbsp;New Pricing Net Sheet<br>
<% 
	}
	if(userAuth_R.containsKey("VIEW_PROMO_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PRO_NEW#Super Admin Insert#R" <%=checkKey("EZC_CUST_PRO_NEW",suAuthRolesHT)%> ">&nbsp;Promotions<br>
<% 
	}
	if(userAuth_R.containsKey("VIEW_SLOB_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_SL_NEWS#Super Admin Insert#R" <%=checkKey("EZC_CUST_SL_NEWS",suAuthRolesHT)%> ">&nbsp;Products On Clearance<br>
<%
	}
	if(userAuth_R.containsKey("VIEW_GA_NEWS"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_GA_NEWS#Super Admin Insert#R" <%=checkKey("EZC_CUST_GA_NEWS",suAuthRolesHT)%> ">&nbsp;General Announcements<br>
<%
	}
%>
		</td>
		<td colspan="2">
<%
	if(userAuth_R.containsKey("VIEW_PRICES"))
	{
%>
		<input type="checkbox" name="subUserAuthDisp" <%=checkKey("EZC_CUST_PRICING",suAuthRolesHT)%> value="EZC_CUST_PRICING#Super Admin Insert#R">&nbsp;Best Pricing, Net Pricing & Net Multiplier<br>
<% 
	}
%>			
	</td>
	</tr>
	</tbody>
	</table>
	<br>

	<div class="buttons-set form-buttons">
		<p class="back-link"><a href="javascript:history.go(-1)"><small>&laquo;</small>Go back</a></p>
		<button type="button" class="button" title="Save" onClick="updateSubVndr()"><span><span>Save</span></span></button>
	</div>

<script language = "javascript">
	document.myForm.userName.focus();
</script>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('User Information updated successfully');
		</script>
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
	if (!"CM".equals(userRole))
	{
%>			
		<li><a href="../SelfService/ezAddSubUser.jsp">Add Sub User</a></li>
		<div style="color:#50B4B6;"><strong><span>List Sub Users</span></strong></div>
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
<%!
	public String checkKey(String myStr, Hashtable suAuthRolesHT)
	{
		
		if (suAuthRolesHT.containsKey(myStr.trim())){
			return "checked";
		} else {
			return "";
		}	
	}
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "";

		return ret;
	}
%>