<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*,java.util.*" %>

<%
	String busPartner = (String)session.getValue("BussPart");
	String userId = (String)Session.getUserId();

	System.out.println("busPartner>>>"+busPartner+"<<userId>>"+userId);
	
	ReturnObjFromRetrieve retsoldto = null;

	EzcBussPartnerParams bussparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bussNKParams = new EzcBussPartnerNKParams();
	bussparams.setBussPartner(busPartner);
	bussNKParams.setCatalog_Number("0");
	bussNKParams.setLanguage("EN");
	bussparams.createContainer();
	boolean flag = bussparams.setObject(bussNKParams);

	Session.prepareParams(bussparams);

	retsoldto = (ReturnObjFromRetrieve)BPManager.getBussPartnerSoldTo(bussparams);
	//out.println("retsoldto>>>>>>"+retsoldto.toEzcString());
	
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
	
	ReturnObjFromRetrieve retSyskey=null;
	if(session.getValue("CRI_CUST_SAS")!=null)
		retSyskey = (ReturnObjFromRetrieve)session.getValue("CRI_CUST_SAS");
	//out.println("retSyskey>>>>>>"+retSyskey.toEzcString());

	int syskeyCount = retSyskey.getRowCount();
	
	String mySyskeys = "";

	if(syskeyCount>0)
	{
		mySyskeys = retSyskey.getFieldValueString(0,"ESKD_SYS_KEY");
		for (int i=1;i<syskeyCount;i++)
		{
			mySyskeys += ","+retSyskey.getFieldValueString(i,"ESKD_SYS_KEY");
		}	
	}
	
	ReturnObjFromRetrieve partnersRet = null;

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

		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}	
	
	int partnersRetCnt = 0;
	
	if(partnersRet!=null)
	{
		for(int i=partnersRet.getRowCount()-1;i>=0;i--)
		{
			if(userId.equals(partnersRet.getFieldValueString(i,"EU_ID").trim()))
				partnersRet.deleteRow(i);
		}
		partnersRetCnt = partnersRet.getRowCount();
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
	
	if(partnersRetCnt>=subUserLimitCnt)
		subUserCreate = "N";

	/***************** Sub User Authorizations Start ******************/
	
	Hashtable subUserAuthHT = new Hashtable();
	
	subUserAuthHT.put("VONLY","View Orders");
	subUserAuthHT.put("VSAVE","Add New(Cart Items and Orders)");
	subUserAuthHT.put("VEDIT","Submit Order");

	/***************** Sub User Authorizations End ******************/
%>

<html>
<head>
<Script language="JavaScript" src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
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
MValues[1] =new EzMList("userName","User Name");
MValues[2] =new EzMList("email","E Mail");
MValues[3] =new EzMList("InitialPassword"," Password");
MValues[4] =new EzMList("ConfirmPassword"," Confirm Password");

function EzMList(fldname,flddesc)
{
	this.fldname=fldname;
	this.flddesc=flddesc;
}
function checkAll()
{
	
	for(c=0;c<MValues.length;c++)
	{
		if(funTrim(eval("document.myForm."+MValues[c].fldname+".value")) == "")
		{
	
			alert("Please enter"+MValues[c].flddesc);
			eval("document.myForm."+MValues[c].fldname+".focus()")
			return false;
		}
		if(c==4)
		{
			
			if (funTrim(eval("document.myForm."+MValues[3].fldname+".value")) != funTrim(eval("document.myForm."+MValues[4].fldname+".value")))
			{
				alert("Password and Confirm Password are not same. Please re-enter the password");
				eval("document.myForm."+MValues[c].fldname+".focus()")
				return false;
			}
		}
	}
	if(document.myForm.CheckBox !=null)
	{
		var chkbox = document.myForm.CheckBox.length;
		chkcount=0;
		if(isNaN(chkbox))
		{
			if(document.myForm.CheckBox.checked)
			{
				chkcount++;
			}
		}
		else
		{
			for(a=0;a<chkbox;a++)
			{
				if(document.myForm.CheckBox[a].checked)
				{
					chkcount++;
					break;
				}
			}
			if(chkcount == 0)
			{
				alert("Please check atleast one check box");
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
	

function createSubUser()
{
	var suCreate = document.myForm.subUserCreate.value;
	var suLimit = document.myForm.subUserLimit.value;
	
	var y = true;

	if(suCreate=='N')
	{
		alert("You cannot add user as max. limit is "+suLimit);
		y = false;
		return;
	}

	//checkAll('myForm','AddUser');
	//var retValue=document.returnValue;

	if(checkAll() && eval(y))
	{
		var count=0,sacount=0;
		var len=document.myForm.CheckBox.length;
		var slen =document.myForm.subUserAuthDisp.length 
		var obj=document.myForm.CheckBox;
		var emailID=document.myForm.email
		
		if (echeck(emailID.value)==false){
			emailID.value=""
			emailID.focus()
			return
		}
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
			alert("Please select atleast one Sales Area");
			return;
		}
		
		for(a=0;a<slen;a++)
		{
			var suaObj = document.myForm.subUserAuthDisp[a]
			if(suaObj.checked==true)
			{
				sacount++
			}
		}
		if(sacount==0)
		{
			alert("Please select authorization(s)");
			return;
		}
		document.myForm.soldTo.value = document.myForm.userId.value;
		document.myForm.action="ezAddSaveSubUser.jsp";
		document.myForm.submit();
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
	userId = document.myForm.userId.value;
	userId = userId.toUpperCase();
	userId=funTrim(userId);
	if(userId!="")
	{
		for (var i=0;i<userArray.length;i++)
		{
			if (userId==userArray[i])
			{
				alert("User already Exists with "+userId+" name");
				document.forms[0].userId.focus();
			}
		}
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
	}

	else
	{
		for(var i=0;i<len;i++)
		obj[i].checked=chkHeader.checked;
	}
}
function funFocus()
{
	if(document.myForm.userId!=null)
	{
		document.myForm.userId.focus()
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
</script>


<Title>Add User Data</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>

<Script>
	var tabHeadWidth=89
	var tabHeight="45%"
</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body  scroll=auto>
<Script src="../../Library/JavaScript/wz_tooltip.js"></Script> 
<form name=myForm method=post >
<input type=hidden name="UserType" value="3">
<input type=hidden name="BusPartner" value="<%=busPartner%>">
<input type=hidden name="subUserLimit" value="<%=subUserLimitCnt%>">
<input type=hidden name="subUserCreate" value="<%=subUserCreate%>">
<input type=hidden name="subUserAuth" value="VONLY">

<br>
<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	    	<Td class="displayheader">Create User</Td>
	</Tr>
</Table>


<Table id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Th colspan="2" height="23"> Please enter the following information</Th>
	</Tr>
</Table>



<Table id="InnerBox1Tab" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr>
		<input type = "hidden" name = "soldTo" value="">
		<Td width = "25%" align="right">User ID *</Td>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userId" size = 30 maxlength = "10" value="" onBlur="chkUserExists()"></Td>
		<Td width = "25%" align="right">User Name *</Td>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userName" size = 30 maxlength = "60"></Td>	
		<input type="hidden" name = "plant" value="1000">
	</Tr>
	<Tr>
		<Td width = "25%" align="right">Password *</Td>
		<Td width = "25%" ><input  type="password" class=InputBox  name="InitialPassword"  size = 30 maxlength="16" ></Td>
		<Td width = "25%" align = "right">E Mail *</Td>
		<Td width = "25%" ><input type = "text" class = "InputBox" name = "email" size = 30 maxlength = "128"></Td>
	</Tr>
	<Tr>
		<Td width = "25%" align="right">Confirm Password *</Td>
		<Td width = "25%" ><input  type="password" class=InputBox name="ConfirmPassword"  size = 30 maxlength="16"></Td>
		<Td width = "25%" align = "right">&nbsp;</Td>
		<Td width = "25%">&nbsp;

		</Td>
		<input type="hidden" name = "catnum" value="<%=catalogNumber%>">
	</Tr>	
</Table>
	<Div id="theads">
	<Table  width="89%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
     	<Tr align="center">
     		<Th width="3%" align="center"><input type="checkbox" name="CheckBox1" value="" onclick="selectAll()"></Th>
		<Th style="text-align:left">Access Restrictions(Select to allow access)*</Th>
        </Tr>
        </table>
<!--
        </div>
  	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:89%;height:45%;left:2%">
-->
	<Table  width="89%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<%
		int custRows = retsoldto.getRowCount();
		if ( custRows > 0 )
		{
			retsoldto.sort(new String[]{"ECA_NAME"},true);
			for ( int i = 0 ; i < custRows; i++ )
			{
%>
				<Tr>
					<Td nowrap colspan="2">
        				<input type="checkbox" name="CheckBox" value="<%=retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")%>#<%=(retsoldto.getFieldValue(i,"EC_SYS_KEY"))%>">
<%
					String custNum = (String)retsoldto.getFieldValue(i,"EC_ERP_CUST_NO");
					String custName = (String)retsoldto.getFieldValue(i,"ECA_NAME");
					String custSysKey = retsoldto.getFieldValueString(i,"EC_SYS_KEY");
					String custSysKeyDesc = "";
					
					int index=retSyskey.getRowId("ESKD_SYS_KEY",custSysKey);
					if(index!=-1)
						custSysKeyDesc = retSyskey.getFieldValueString(index,"ESKD_SYS_KEY_DESC");
						
					custName = custName.trim()+" - "+custSysKeyDesc+"("+custSysKey.trim()+")";
					if(custName != null)
					{
						out.println(custNum + " " + custName);
					}
					else
					{
						out.println("No Customer Name");
					}
%>

				        </Td>
				</Tr>
<%
			}
%>
			<input type="hidden" name="TotalCount" value=<%=custRows%> >
<%
		}
		else
		{
%>
			<Tr>
			<Td>
				There are no ERP Customers synchronized for this Business Partner
			</Td>
			</Tr>
<%
		}
%>
        </Table>
	<Table  width="89%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
     	<Tr align="center">
		<Th style="text-align:left;width:100%">Authorizations*</Th>
        </Tr>
        </table>
        <Table  width="89%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<Tr>
        	<th width="33%" align="left">Catalog</th>
        	<th width="33%" align="left">Cart And Orders</th>
        	<th width="33%" align="left">Invoices</th>
	
	</Tr>
        <Tr>
        	
        	
        	<td width="33%">
        	<input type="checkbox" checked disabled value="" name="ViewCat">View
        	</td>
        	<td width="33%">
			<input type="checkbox" name="subUserAuthDisp" value="VONLY" checked onClick="funcAuth('0')">View Orders<BR>
			<input type="checkbox" name="subUserAuthDisp" value="VSAVE"  onClick="funcAuth('1')">Add New(Cart Items and Orders)<BR>
			<input type="checkbox" name="subUserAuthDisp" value="VEDIT"  onClick="funcAuth('2')">Submit Order
        	</td>
        	<td width="33%">
        	<input type="checkbox" checked disabled value="" name="ViewInv">View Invoices
        	</td>
        
        
        </table>
    	</div>
    	
    	<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if ( custRows > 0 )
	{
		buttonName.add("Save");
		buttonMethod.add("createSubUser()");
		buttonName.add("Reset");
		buttonMethod.add("document.myForm.reset()");

	}
	
	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
	
	out.println(getButtonStr(buttonName,buttonMethod));


%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
