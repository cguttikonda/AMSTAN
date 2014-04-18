<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>

<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*,java.util.*" %>

<%!
	public ReturnObjFromRetrieve getListOfShipTos(String custNO,String busPartner,ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String query="Select A.*, B.* from EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B where  A.EC_PARTNER_FUNCTION in ('WE') and A.EC_ERP_CUST_NO = '"+custNO+"' AND A.EC_BUSINESS_PARTNER = '"+busPartner+"' and B.ECA_LANG = 'EN' and A.EC_NO = B.ECA_NO";

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
	String busPartner = (String)session.getValue("BussPart");
	String userId = (String)Session.getUserId();

	System.out.println("busPartner>>>"+busPartner+"<<userId>>"+userId);
	ezc.client.EzcUtilManager UtilManagerSA = new ezc.client.EzcUtilManager(Session);
	
	ReturnObjFromRetrieve retsoldtoSU = null;
	ReturnObjFromRetrieve retcatarea = null;
	
	//Get all catalog areas
	retcatarea = (ReturnObjFromRetrieve)UtilManagerSA.getUserCatalogAreas();	

	EzcUserParams auparams= new EzcUserParams();
	Session.prepareParams(auparams);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	auparams.createContainer();
	auparams.setObject(ezcUserNKParams);
	ReturnObjFromRetrieve allUsersRet = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(auparams);
	//out.println("allUsersRet>>>>>>"+allUsersRet.toEzcString());
	
	
	EzcUserParams uparams= new EzcUserParams();
	uparams.setUserId(userId);
	ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	uparams.createContainer();
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	
	ReturnObjFromRetrieve retcat = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparams);
	String catalogNumber = retcat.getFieldValueString(0,"EPC_NO");
	String catalogName = retcat.getFieldValueString(0,"EPC_NAME");
	
	
	/********** Login user Syskeys call **********/
	
	//out.println("retcatarea>>>>>>"+retcatarea.toEzcString());

	int syskeyCount = retcatarea.getRowCount();
	
	String mySyskeys = "";

	if(syskeyCount>0)
	{
		mySyskeys = retcatarea.getFieldValueString(0,"ESKD_SYS_KEY");
		for (int i=1;i<syskeyCount;i++)
		{
			mySyskeys += ","+retcatarea.getFieldValueString(i,"ESKD_SYS_KEY");
		}	
	}
	
	ReturnObjFromRetrieve partnersRetSU = null;

	if(mySyskeys!=null && userId!=null)
	{
		userId = userId.trim();
	
		String mySoldTo = "";
		try
		{
			userId = Long.parseLong(userId)+"";
			mySoldTo = "0000000000"+userId;
			mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
		}
		catch(Exception ex)
		{
			mySoldTo = userId;
		}
	
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(mySyskeys);
		adminUtilsParams.setPartnerValueBy(mySoldTo);

		EzcParams mainParamsSU = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParamsSU);

		partnersRetSU = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParamsSU);
	}	
	
	int partnersRetSUCnt = 0;
	
	if(partnersRetSU!=null)
	{
		for(int i=partnersRetSU.getRowCount()-1;i>=0;i--)
		{
			if(userId.equals(partnersRetSU.getFieldValueString(i,"EU_ID").trim()))
				partnersRetSU.deleteRow(i);
		}
		partnersRetSUCnt = partnersRetSU.getRowCount();
	}
	
	int subUserLimitCnt = 4;
	String subUserLimit = (String)session.getValue("SUBUSERLIMIT");

	if(subUserLimit!=null)
	{
		try
		{
			subUserLimitCnt = Integer.parseInt(subUserLimit);
		}
		catch(Exception ex){}
	}
	
	String subUserCreate = "Y";
	
	if(partnersRetSUCnt>=subUserLimitCnt)
		subUserCreate = "N";

	/***************** Sub User Authorizations Start ******************/
	
	Hashtable subUserAuthHT = new Hashtable();
	
	subUserAuthHT.put("VONLY","View Orders");
	subUserAuthHT.put("VSAVE","Add New(Cart Items and Orders)");
	subUserAuthHT.put("VEDIT","Submit Order");

	/***************** Sub User Authorizations End ******************/
%>

<Script language="JavaScript" src="../../Library/JavaScript/Misc/Trim.js"></Script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<Script src="../../Library/Script/popup.js"></Script> 

<script language = "Javascript">
/**
 * DHTML email validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

function ValidateForm(){
	var emailID=document.frmSample.txtEmail
	
	if ((emailID.value==null)||(emailID.value=="")){
		alert("Please Enter your Email ID")
		emailID.focus()
		return false
	}
	if (echeck(emailID.value)==false){
		emailID.value=""
		emailID.focus()
		return false
	}
	return true
 }
var MValues = new Array();
MValues[0] =new EzMList("userId","User ID");
MValues[1] =new EzMList("email","E Mail");
MValues[2] =new EzMList("userName","First Name");
MValues[3] =new EzMList("lastName","Last Name");
MValues[4] =new EzMList("InitialPassword"," Password");
MValues[5] =new EzMList("ConfirmPassword"," Confirm Password");

function EzMList(fldname,flddesc)
{
	this.fldname=fldname;
	this.flddesc=flddesc;
}
function checkAll()
{
	for(c=0;c<MValues.length;c++)
	{
		if(funTrim(eval("document.subUserFrom."+MValues[c].fldname+".value")) == "")
		{
	
			alert("Please enter "+MValues[c].flddesc);
			eval("document.subUserFrom."+MValues[c].fldname+".focus()")
			return false;
		}
		if(c==5)
		{
			
			if (funTrim(eval("document.subUserFrom."+MValues[4].fldname+".value")) != funTrim(eval("document.subUserFrom."+MValues[5].fldname+".value")))
			{
				alert("Password and Confirm Password are not same. Please re-enter the password");
				eval("document.subUserFrom."+MValues[c].fldname+".focus()")
				return false;
			}
		}
	}
	if(document.subUserFrom.CheckBox !=null)
	{
		var chkbox = document.subUserFrom.CheckBox.length;
		chkcount=0;
		if(isNaN(chkbox))
		{
			if(document.subUserFrom.CheckBox.checked)
			{
				chkcount++;
			}
		}
		else
		{
			for(a=0;a<chkbox;a++)
			{
				if(document.subUserFrom.CheckBox[a].checked)
				{
					chkcount++;
					break;
				}
			}
			if(chkcount <0)
			{
				alert("Please check at least one check box");
				return false;
			}
		}
	}
	return true;
}
function echeck(str) 
{

	var at="@"
	var dot="."
	var lat=str.indexOf(at)
	var lstr=str.length
	var ldot=str.indexOf(dot)
	if (str.indexOf(at)==-1){
	   $( "#dialog-invalidEmail" ).dialog('open');
	   return false;
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
	   $( "#dialog-invalidEmail" ).dialog('open');
	   return false;
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
	   $( "#dialog-invalidEmail" ).dialog('open');
	   return false;
	}

	 if (str.indexOf(at,(lat+1))!=-1){
	    $( "#dialog-invalidEmail" ).dialog('open');
	    return false;
	 }

	 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
	    $( "#dialog-invalidEmail" ).dialog('open');
	    return false;
	 }

	 if (str.indexOf(dot,(lat+2))==-1){
	    $( "#dialog-invalidEmail" ).dialog('open');
	    return false;
	 }

	 if (str.indexOf(" ")!=-1){
	   $( "#dialog-invalidEmail" ).dialog('open');
	   return false;
	 }

	 return true					
}	
	

function createSubUser()
{
	var inPass	= document.subUserFrom.InitialPassword.value;
	var conPass	= document.subUserFrom.ConfirmPassword.value;

	if(funTrim(conPass) != funTrim(inPass)){
		$( "#dialog-Match" ).dialog('open');	
		return ;
	}
	else
	{
		var isRep = document.subUserFrom.isRepAgency.value;

		if(isRep=="Y")
		{
			var sacount=0;
			var slen =document.subUserFrom.subUserAuthDisp.length;
			for(a=0;a<slen;a++)
			{
				var suaObj = document.subUserFrom.subUserAuthDisp[a]
				if(suaObj.checked==true)
				{
					sacount++
				}
			}
			if(sacount==0)
			{
				$( "#dialog-authAlert" ).dialog('open');
				return false;
			}
			else
			{
				Popup.showModal('modal1');
				document.subUserFrom.soldTo.value = document.subUserFrom.userId.value;
				document.subUserFrom.action="ezAddRepUser.jsp";
				document.subUserFrom.submit();
			}
		}
		else
		{

			var suCreate = document.subUserFrom.subUserCreate.value;
			var suLimit = document.subUserFrom.subUserLimit.value;
			var y = true;


			var userId = document.subUserFrom.userId;
			var email = document.subUserFrom.email;
			var userName = document.subUserFrom.userName;
			var lastName = document.subUserFrom.lastName;
			var InitialPassword = document.subUserFrom.InitialPassword;
			var ConfirmPassword = document.subUserFrom.ConfirmPassword;


			if(suCreate=='N')
			{
				alert("You cannot add user as max. limit is "+suLimit);
				y = false;
				return false;
			}

			if(userId.value == "")
			{
				$( "#dialog-userId" ).dialog('open');
				return false;
			}		
			if(email.value == "")
			{
				$( "#dialog-email" ).dialog('open');
				return false;
			}		
			if(userName.value == "")
			{
				$( "#dialog-userName" ).dialog('open');
				return false;
			}		
			if(lastName.value == "")
			{
				$( "#dialog-lastName" ).dialog('open');
				return false;
			}		
			if(InitialPassword.value == "")
			{
				$( "#dialog-InitialPassword" ).dialog('open');
				return false;
			}		
			if(ConfirmPassword.value == "")
			{
				$( "#dialog-ConfirmPassword" ).dialog('open');
				return false;
			}		



			if(eval(y))//checkAll() && 
			{
				var count=0,sacount=0;
				var len=document.subUserFrom.CheckBox.length;
				var slen =document.subUserFrom.subUserAuthDisp.length 
				var obj=document.subUserFrom.CheckBox;
				var emailID=document.subUserFrom.email
				var selshiplen=eval("document.subUserFrom.ShipCount").value
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
					$( "#dialog-saleAreaAlert" ).dialog('open');
					return false;
				}

				for(a=0;a<slen;a++)
				{
					var suaObj = document.subUserFrom.subUserAuthDisp[a]
					if(suaObj.checked==true)
					{
						sacount++
					}
				}
				if(sacount==0)
				{
					$( "#dialog-authAlert" ).dialog('open');
					return false;
				}

				var count1=0
				var count2=0
				var count3=0
				if(selshiplen==1)
				{
					var shipObj = document.subUserFrom.SelShipTo;
					if(shipObj.checked)
					{
						document.subUserFrom.hiddenShip.value = shipObj.value;
						count3++;
					}
				}
				else
				{
					for(i=0;i<selshiplen;i++)
					{
						var shipObj = document.subUserFrom.SelShipTo[count1]
						if(shipObj.checked)
						{
							document.subUserFrom.hiddenShip[count1].value = shipObj.value;
							count3++
						}
						count1++;

					}
				}
				if(count3==0)
				{
					$( "#dialog-shipAlert" ).dialog('open');
					return false;
				}		
				if(isNaN(len))
				{
					var soldObj = document.subUserFrom.CheckBox
					if(soldObj.checked)
						document.subUserFrom.CheckBox.value = soldObj.value;	
				}
				else
				{
					for(i=0;i<len;i++)
					{
						var soldObj = document.subUserFrom.CheckBox[count2]
						if(soldObj.checked)
						{
							document.subUserFrom.CheckBox[count2].value = soldObj.value;
						}
						count2++;

					}			
				}
				Popup.showModal('modal1');
				document.subUserFrom.soldTo.value = document.subUserFrom.userId.value;
				document.subUserFrom.action="ezAddSaveSubUser.jsp";
				document.subUserFrom.submit();
			}
		}
	}
}

userArray = new Array();
<%
	int allUserCount = allUsersRet.getRowCount();
	for(int i=0;i<allUserCount;i++)
	{
%>
		userArray[<%=i%>] = '<%=(allUsersRet.getFieldValueString(i,"EU_ID")).trim()%>'
<%
	}
%>
function chkUserExists()
{
	userId = document.subUserFrom.userId.value;
	userId = userId.toUpperCase();
	userId=funTrim(userId);
	if(userId!="")
	{
		for (var i=0;i<userArray.length;i++)
		{
			if (userId==userArray[i])
			{
				$( "#dialog-userExist" ).dialog('open');
			}
		}
	}
}
function selectAll()
{
	var chkHeader=document.subUserFrom.CheckBox1;
	var len=document.subUserFrom.CheckBox.length;
	var obj=document.subUserFrom.CheckBox;
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
	var SelShipToLen=eval("document.subUserFrom.ShipCount").value
	var selSoldTo=chkObj.value;
	var obj1=document.subUserFrom.SelShipTo;
	var len=document.subUserFrom.CheckBox.length;
	var count =0;
	selSoldTo = selSoldTo.split("¥")[0] 
	if(SelShipToLen==1)
	{
		shipObj = document.subUserFrom.SelShipTo;
		if(shipObj!='undefined')
		{
			alert("111")
			var shipVal = shipObj.value;	
			soldFromShip = 	shipVal.split("##")[2]
			if(selSoldTo==soldFromShip.split("¥")[0])
			if(chked)
			{
				alert("222")
				document.subUserFrom.SelShipTo.checked=true;
				document.subUserFrom.SelShipTo.disabled=false;
			}
			else	
			{
				alert("333")
				document.subUserFrom.SelShipTo.checked=false;
				document.subUserFrom.SelShipTo.disabled=true;
			}	
		}	
	}
	else
	{
		for(j=0;j<SelShipToLen;j++)
		{
			shipObj = document.subUserFrom.SelShipTo[j]
			if(shipObj!='undefined')
			{
				var shipVal = shipObj.value;	
				soldFromShip = 	shipVal.split("##")[2]
				if(selSoldTo==soldFromShip.split("¥")[0])
					if(chked)
					{
						document.subUserFrom.SelShipTo[j].checked=true;
						document.subUserFrom.SelShipTo[j].disabled=false;
					}
					else	
					{
						document.subUserFrom.SelShipTo[j].checked=false;
						document.subUserFrom.SelShipTo[j].disabled=true;
					}	
			}	
		}
	}
}
function funFocus()
{
	if(document.subUserFrom.userId!=null)
	{
		document.subUserFrom.userId.focus()
	}
}
function funcAuth(idx)
{
	var obj = eval("document.subUserFrom.subUserAuthDisp["+idx+"]")
	var len = document.subUserFrom.subUserAuthDisp.length
	
	if(obj.checked == true)
	{
		document.subUserFrom.subUserAuth.value = obj.value
		if(obj.value == 'VSAVE')
		{
			for(a=0;a<len;a++)
			{
				var suaObj = document.subUserFrom.subUserAuthDisp[a]
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
				var suaObj = document.subUserFrom.subUserAuthDisp[a]
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
				var suaObj = document.subUserFrom.subUserAuthDisp[a]
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
				var suaObj = document.subUserFrom.subUserAuthDisp[a]
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
function funChkPassword()
{
	var inPass	= document.subUserFrom.InitialPassword.value;
	var conPass	= document.subUserFrom.ConfirmPassword.value;
	
	if(funTrim(conPass) != funTrim(inPass)){
		$( "#dialog-Match" ).dialog('open');	
		return ;
	}
}
function alpha(e)
{
	var keycode;
	keycode=event.keyCode?event.keyCode:event.which;
	if ((keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
		return true;
	}
	else {
		$( "#dialog-valid" ).dialog('open');
		return false;
	}
	return true;
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
			//Popup.showModal('modal1');
			if(resText=='Y')
			{
				//alert("resText::::"+resText)
				$( "#dialog-emailAlert" ).dialog('open');
				
				document.subUserFrom.email.value="";
			}
			
		}
		else
		{
			if(req.status == 500)	 
			alert("Error");
		}
	}
}
function doClear()
{
	document.getElementById("subUserFrom").reset()
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
	$( "#dialog-userExist" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" );
			document.subUserFrom.userId.focus();
		}
	}
	});	
	$( "#dialog-invalidEmail" ).dialog({
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
	$( "#dialog-authAlert" ).dialog({
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
	
	$( "#dialog-valid" ).dialog({
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

 	$( "#dialog-Match" ).dialog({
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


	$( "#dialog-userId" ).dialog({
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
	$( "#dialog-email" ).dialog({
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
	$( "#dialog-userName" ).dialog({
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
	$( "#dialog-lastName" ).dialog({
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
	$( "#dialog-InitialPassword" ).dialog({
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
	$( "#dialog-ConfirmPassword" ).dialog({
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
	
	
	
	
	
	$( "#dialog-saleAreaAlert" ).dialog({
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
</script>

<!--<form name="subUserFrom" id="subUserFrom" method=post onSubmit="return createSubUser()">-->
<form name="subUserFrom" id="subUserFrom" method=post>
<input type=hidden name="UserType" value="3">
<input type=hidden name="BusPartner" value="<%=busPartner%>">
<input type=hidden name="subUserLimit" value="<%=subUserLimitCnt%>">
<input type=hidden name="subUserCreate" value="<%=subUserCreate%>">
<input type=hidden name="subUserAuth" value="">

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

<div id="dialog-invalidEmail" title="InvalidEmail" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Invalid E-mail ID</p>
</div>	

<div id="dialog-userExist" title="UserExists" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>User already Exists with this user id.</p>
</div>	

<div id="dialog-authAlert" title="AuthAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please select authorization(s).</p>
</div>	

<div id="dialog-shipAlert" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please select atleast one Ship To.</p>
</div>
<div id="dialog-valid" title="Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span><p>Sorry You can not insert Special Characters like</p><p>! @ # $ % ^ & * ( ) - _ + ' " ; : / ? < ></p></p>
</div>
<div id="dialog-Match" title="Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Your password entries did not match.Please try again.</p>
</div>


<div id="dialog-userId" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter User ID.</p>
</div>
<div id="dialog-email" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter Email-ID.</p>
</div>
<div id="dialog-userName" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter First Name.</p>
</div>
<div id="dialog-lastName" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter Last Name.</p>
</div>
<div id="dialog-InitialPassword" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter Password.</p>
</div>
<div id="dialog-ConfirmPassword" title="ShipAlert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter Confirm Password.</p>
</div>



<div id="dialog-saleAreaAlert" title="Sales Area Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please select atleast one Sales Area.</p>
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
		<div class="block-title">
		<strong>
			<span>Add Sub User</span>
		</strong>
		</div>
	 
	</div>
	
	<table class="data-table">
	<thead>
		<th colspan=4 align ="center" style="background-color:#000000; color:#66CC33; font-size:15px;"><h1> User Information </h1></th>
	</thead>
	<tbody>
	<Tr>
		<input type="hidden" name="soldTo" value="">
		<Td nowrap><strong>User ID <em style="color:red">*</em></strong></Td>
		<Td><input type="text" name="userId" size=30 maxlength="20" value="" onBlur="chkUserExists()" required></Td>
		<Td nowrap><strong>E Mail <em style="color:red">*</em></strong></Td>
		<Td><input type="text" name="email" size=30 maxlength="40" <%=emailChk_S%> required></Td>
		<input type="hidden" name="plant" value="1000">
	</Tr>	
	<Tr>
		<Td nowrap><strong>First Name <em style="color:red">*</em></strong></Td>
		<Td><input type="text" name="userName" size=30 maxlength="60" required></Td>
		<Td nowrap><strong>Last Name <em style="color:red">*</em></strong></Td>
		<Td><input type="text" name="lastName" size=30 maxlength="60" required></Td>
	</Tr>
	<Tr>
		<Td nowrap><strong>Password <em style="color:red">*</em></strong></Td>
		<Td><input type="password" name="InitialPassword" size=30 maxlength="20"  onkeypress="return alpha(event)" required></Td>
		<Td nowrap><strong>Confirm Password <em style="color:red">*</em></strong></Td>
		<Td><input type="password" name="ConfirmPassword" id="ConfirmPassword" size=30 maxlength="20" onFocusOut="funChkPassword()"></Td>
		<input type="hidden" name="catnum" value="<%=catalogNumber%>">
	</Tr>
	</tbody>
	</table>
	
	<table class="data-table">
	<thead>
		<Th colspan=4 align ="center" style="background-color:#000000; color:#66CC33; font-size:15px;">
			<h1> Accounts Accessibility </h1>
		</Th>
	</thead>	
	<tbody>
<%
	if(!repAgen_B)
	{
%>
		<Tr>
		<Td colspan=4>
		<Table class="data-table" style=" height:300px; overflow:auto; display:block;">
		<Tr>
			<Th class="a-center" width="10%">Select All
				<br><input type="checkbox" name="CheckBox1" value="" onclick="selectAll()">
			</Th>
			<Th nowrap width="40%">
				<strong> Allowed Sold To Account(s) <em style="color:red">*</em></strong>
			</th>
			<Th nowrap width="50%">
				<strong> Allowed Ship To Account(s) <em style="color:red">*</em></strong>
			</th>
		</Tr>
<%
	retsoldtoSU = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	int custRows = retsoldtoSU.getRowCount();
	ReturnObjFromRetrieve  listShipTosSU = null;
	int loopCnt =0;
	Vector custDel = new Vector();
	Vector custDelete = new Vector();
	Vector shipDel = new Vector();
	Vector shipDelete = new Vector();
	Hashtable soldSys = new Hashtable();
	Hashtable shipSys = new Hashtable();
	if ( custRows > 0 )
	{
		retsoldtoSU.sort(new String[]{"ECA_NAME"},true);
		for ( int s = 0 ; s < custRows; s++ )
		{
			String custNum_S = (String)retsoldtoSU.getFieldValue(s,"EC_ERP_CUST_NO");
			String custSysKey_S = retsoldtoSU.getFieldValueString(s,"EC_SYS_KEY");
			if(custDelete.contains(custNum_S))
			{
				String tempSys = (String)soldSys.get(custNum_S);
				tempSys = tempSys+"¤¤"+retsoldtoSU.getFieldValue(s,"EC_SYS_KEY");
				soldSys.put(custNum_S,tempSys);
			}else{
				custDelete.add(custNum_S);
				soldSys.put(custNum_S,custSysKey_S);
			}				
		}
		String custNum ="";
		for ( int i = 0 ; i < custRows; i++ )
		{
			String blockCode_A 	= retsoldtoSU.getFieldValueString(i,"ECA_EXT1");
			if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

			if(!"BL".equalsIgnoreCase(blockCode_A))
			{
			custNum = (String)retsoldtoSU.getFieldValue(i,"EC_ERP_CUST_NO");
			String custName = (String)retsoldtoSU.getFieldValue(i,"ECA_NAME");
			String custSysKey = retsoldtoSU.getFieldValueString(i,"EC_SYS_KEY");
			String custSysKeyDesc = "";	
%>
			<input type="hidden" name="soldSyskey" value="<%=retsoldtoSU.getFieldValueString(i,"EC_ERP_CUST_NO")%>#<%=(retsoldtoSU.getFieldValue(i,"EC_SYS_KEY"))%>">
<%
			if(custDel.contains(custNum))
				continue;
			else
				custDel.add(custNum);

			listShipTosSU = (ReturnObjFromRetrieve)getListOfShipTos(custNum,busPartner,Session);
%>
			<Tr>
			<Td class="a-center" width="10%">
				<input type="checkbox" name="CheckBox" value="<%=retsoldtoSU.getFieldValueString(i,"EC_ERP_CUST_NO")%>¥<%=soldSys.get(retsoldtoSU.getFieldValueString(i,"EC_ERP_CUST_NO"))%>"  onClick="enableShipTos(this,this.checked)"> <!--onClick="enableShipTos(this.length)"-->
			</Td>
			<Td nowrap width="40%">
				<Table>
				<Tr>
				<input type="hidden" name="hiddenSoldTo">
<%
				int index_S=retcatarea.getRowId("ESKD_SYS_KEY",custSysKey);
				if(index_S!=-1)
					custSysKeyDesc = retcatarea.getFieldValueString(index_S,"ESKD_SYS_KEY_DESC");

				//custName = custName.trim()+" - "+custSysKeyDesc+"("+custSysKey.trim()+")";
				String custBuff = nullCheck(retsoldtoSU.getFieldValueString(i,"ECA_COMPANY_NAME"))+",<br>"+nullCheck(retsoldtoSU.getFieldValueString(i,"ECA_ADDR_1"))+","+nullCheck(retsoldtoSU.getFieldValueString(i,"ECA_ADDR_2"))+",<br>"+nullCheck(retsoldtoSU.getFieldValueString(i,"ECA_CITY"))+","+nullCheck(retsoldtoSU.getFieldValueString(i,"ECA_STATE"))+","+nullCheck(retsoldtoSU.getFieldValueString(i,"ECA_PHONE"));
				custName = custName.trim();
				if(custName != null)
				{
%>
					<Td style="border:0px"><%=custNum%><br><%=custBuff%></Td>
<%
				}
				else
				{
%>
					<Td style="border:0px">No Customer Name</Td>
<%
				}
%>
				</Table>
			</Td>
			<Td nowrap width="50%">
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

					String addBuff = nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_COMPANY_NAME"))+",<br>"+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_ADDR_1"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_ADDR_2"))+",<br>"+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_CITY"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_STATE"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_PHONE"));

					if("CPDA".equals(accountGrp)) addBuff = "Drop Ship";
%>
					<Tr>
						<Td style="border:0px"><input type="checkbox" name="SelShipTo"  cursor:"hand" value="<%=listShipTosSU.getFieldValueString(ship,"EC_PARTNER_NO")%>##<%=(listShipTosSU.getFieldValue(ship,"EC_SYS_KEY"))%>##<%=retsoldtoSU.getFieldValue(i,"EC_ERP_CUST_NO")%>¥<%=shipSys.get(listShipTosSU.getFieldValueString(ship,"EC_PARTNER_NO"))%>" disabled>
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
%>
					</Tr>
<%
					}
				}
%>
				</Table>
			</Td>
			</Tr>
<%
			}
		}
%>
			<input type="hidden" name="TotalCount" value=<%=custRows%> >
			<input type="hidden" name="ShipCount" value=<%=shipDelete.size()%> >
<%
	}
	else
	{
%>
		<Tr>
		<Td nowrap colspan="4">
			There are no ERP Customers synchronized for this Business Partner
		</Td>
		</Tr>
<%
	}
%>
	</Table>
	</Td>
	</Tr>
<%
	}
	else
	{
%>
		<input type="hidden" name="soldSyskey" value="999001">
<%
	}
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

	String ordStatus_Auth = "EZC_CUSTOMER_COR";
	String chkFoc = "";
	if(repAgen_B)
	{
		chkFoc = "checked";
		ordStatus_Auth = "EZC_REPAGE_CORE";

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
%>
				<option value="<%=repCode%>"><%=repName%> (<%=repCode%>)</option>
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
			<input type="radio" name="exclMat" value="Y" checked>Yes &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="exclMat" value="N">No
		</Td>
		</Tr>
<%
	}
%>
	<Tr>
		<Th colspan=4 align ="center" style="background-color:#000000; color:#66CC33; font-size:15px;">
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
		if(userAuth_R.containsKey("ORDER_STATUS"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="<%=ordStatus_Auth%>" checked="" onclick="funcAuth(&#39;0&#39;)"> &nbsp;Check Order Status<br>
<%		
		}
		if(userAuth_R.containsKey("SO_TEMPLATE"))//SO_CREATE
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_ENT"  onclick="funcAuth(&#39;0&#39;)"> &nbsp;Create as Template<br>
<% 		
		}
		if(userAuth_R.containsKey("SUBMIT_ORDER"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_SUB" onclick="funcAuth(&#39;1&#39;)"> &nbsp;Submit to American Standard<br>
<% 		
		}
		if(userAuth_R.containsKey("SO_CANCEL"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_CAN" onclick="funcAuth(&#39;2&#39;)"> &nbsp;Cancel to Cancellation<br>
<% 		
		}
		if(userAuth_R.containsKey("SO_RETURN_CREATE"))
		{ 
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_ORD_RGA" onclick="funcAuth(&#39;2&#39;)"> &nbsp;RGA/Return<br>
<% 		
		}
		if(userAuth_R.containsKey("FOC_ORDER"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_INTSLS_FOCRE" <%=chkFoc%> onclick="funcAuth(&#39;0&#39;)"> &nbsp;FOC Creation<br>
<% 		
		}
		if(userAuth_R.containsKey("DISP_ORDER"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_DISP_PROGRAM" onclick="funcAuth(&#39;0&#39;)"> &nbsp;Display Program<br>
<% 		
		} 
		if(userAuth_R.containsKey("ASK_QUESTION"))
		{ 
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_QUERY" > &nbsp;Ask Questions<br>
<% 		
		} 
%>
	</td>
	<td colspan="2">
<%		
		if(userAuth_R.containsKey("SO_PAY_DTL"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_FIN" > &nbsp;Invoices<br>
<% 		
		}
%>
	</td>
	</tr>
	<tr>
		<th colspan="2">News/Announcements</th>
		<th colspan="2">Pricing</th>
	</tr>
	<tr>
	<td colspan="2">
<%		
		if(userAuth_R.containsKey("VIEW_PL_NEWS"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PLNEWS" checked="" onclick="funcAuth(&#39;0&#39;)"> &nbsp;Products List Price<br>
<% 		
		}
		if(userAuth_R.containsKey("VIEW_PS_NEWS"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PS_NEWS" checked="" onclick="funcAuth(&#39;0&#39;)"> &nbsp;Periodic Statement<br>
<% 		
		}
		if(userAuth_R.containsKey("VIEW_PSPEC_NEWS"))
		{ 
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PSPEC_N" checked="" onclick="funcAuth(&#39;1&#39;)"> &nbsp;Market Area Net Price <br>
			<!-- Was Product Specifications before Ticket nr 428 -->
<% 		
		}
		if(userAuth_R.containsKey("VIEW_NPROD_NEWS"))
		{ 
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_NP_NEWS" checked="" onclick="funcAuth(&#39;2&#39;)"> &nbsp;New Products<br>
<% 		
		}
		if(userAuth_R.containsKey("VIEW_DC_NEWS"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_DC_NEWS" checked="" onclick="funcAuth(&#39;2&#39;)"> &nbsp;Discontinued Products <br>
<% 		
		}
		if(userAuth_R.containsKey("VIEW_PCHNG_NEWS"))
		{
%>
			<!--<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PCH_NEW" checked="" onclick="funcAuth(&#39;2&#39;)"> &nbsp;New Pricing Net Sheet <br>-->
<% 		
		}
		if(userAuth_R.containsKey("VIEW_PROMO_NEWS"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PRO_NEW" checked="" onclick="funcAuth(&#39;2&#39;)"> &nbsp;Promotions <br>
<% 		
		}
		if(userAuth_R.containsKey("VIEW_SLOB_NEWS"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_SL_NEWS" checked="" onclick="funcAuth(&#39;2&#39;)"> &nbsp;Products On Clearance<br>
<% 		
		}
		if(userAuth_R.containsKey("VIEW_GA_NEWS"))
		{
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_GA_NEWS" checked="" onclick="funcAuth(&#39;2&#39;)"> &nbsp;General Announcements<br>
<% 		
		}
%>
	</td>
	<td colspan="2">
<%		if(userAuth_R.containsKey("VIEW_PRICES"))
		{ 
%>
			<input type="checkbox" name="subUserAuthDisp" value="EZC_CUST_PRICING" > &nbsp;Best Pricing, Net Pricing & Net Multiplier<br>
<% 		
		} 
%>
	</td>
	</tr>
	</tbody>
	</table>
	<br>
	
	<div class="buttons-set form-buttons">
		<button type="button" class="button" title="Clear" value='Clear' onClick="doClear()" /><span>Clear</span></button>
		<button type="button" class="button" value="Save" onClick="createSubUser()" title="Save" /><span>Save</span></button>
	</div>	
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
			<div style="color:#50B4B6;">
					<strong><span>Add Sub User</span></strong>
			</div>							
			<li><a href="../SelfService/ezListSubUsers.jsp">List Sub Users</a></li>
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
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "";

		return ret;
	}
%>
