<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import = "ezc.ezparam.*,java.sql.*" %>
<%
	String loginUserId = (String)Session.getUserId();
	ReturnObjFromRetrieve ret = null;

	if(session.getValue("CRI_CUST_SAS")!=null)
		ret = (ReturnObjFromRetrieve)session.getValue("CRI_CUST_SAS");
	
		
	String[] sortArr={"ESKD_SYS_KEY"};
	
	int syskeyCount = ret.getRowCount();
	
	String mySyskeys = "";
	if(syskeyCount>0)
	{
		mySyskeys = ret.getFieldValueString(0,"ESKD_SYS_KEY");
		for (int i=1;i<syskeyCount;i++)
		{
			mySyskeys += ","+ret.getFieldValueString(i,"ESKD_SYS_KEY");
		}	
	}
	
	ReturnObjFromRetrieve partnersRet = null;
	String soldTo = (String) session.getValue("AgentCode");
	if(mySyskeys!=null && soldTo!=null)
	{
		soldTo = soldTo.trim();
	
		String mySoldTo = "";
		try{
			soldTo = Long.parseLong(soldTo)+"";
		mySoldTo = "0000000000"+soldTo;
		mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
		}catch(Exception ex){mySoldTo = soldTo;}
	
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(mySyskeys);
		adminUtilsParams.setPartnerValueBy(mySoldTo);

		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}
	
		

	int partnersRetCnt = 0;
	String fullName="";
	String userIds="";
	
	if(partnersRet!=null)
	{
		for(int i=partnersRet.getRowCount()-1;i>=0;i--)
		{
			String tempuserId=partnersRet.getFieldValueString(i,"EU_ID");
			if(loginUserId.equals(partnersRet.getFieldValueString(i,"EU_ID").trim()))
				partnersRet.deleteRow(i);
			else
			{
			
				if("".equals(userIds))
				{
				userIds=partnersRet.getFieldValueString(i,"EU_ID");
				}
				else
				userIds=userIds+"','"+partnersRet.getFieldValueString(i,"EU_ID");
				//out.println(">>>>>>>>>>>userIds<<<>>>"+userIds);
			}	
		}
		
		partnersRetCnt = partnersRet.getRowCount();
	}
	
	
	String ConnGroup = (String)session.getValue("Site");
	Connection con=null;
	java.sql.Statement st = null;
	ResultSet rs = null;
	Hashtable statusHt = new Hashtable();

		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	try
	{	
	
		con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
		st=con.createStatement();
		
		rs=st.executeQuery("SELECT * FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID in ('"+userIds+"') AND EUD_KEY='STATUS'");
		while(rs.next())
		{
			String htKey=rs.getString(1).trim();
			String htValue=rs.getString(5).trim();
			statusHt.put(htKey,htValue);
		}	
	}
	catch(Exception e){}
	finally
	{
		if(st!=null)
			st.close();
		if(rs!=null)
			rs.close();
		if(con!=null)
			con.close();
	}

	
	//out.println(">>>>>>>>>>>partnersRet<<<<<<<<<<<<<<"+partnersRet.toEzcString());
%>
<html>
<Title>Users By Partner Value</Title>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
String divHgt = "50";
%>

<Script>
	var tabHeadWidth = 50;
	var tabHeight="50%";
	if(screen.width==800)
	{
		tabHeight="50%";
	}

</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
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
	url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Misc/ezUpdateSubUserStatus.jsp?UserID="+userId.value+"&Status="+userStatus.value+"&mydate="+new Date();
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
				eval("document.getElementById('userStatusImg_'+rowIndex.value)").src = '../../Images/Others/greenball.gif'; 
				userStatus.value = 'A';
			}	
			else if(resText=='I'){
				eval("document.getElementById('userStatusImg_'+rowIndex.value)").src = '../../Images/Others/redball.gif';  
				userStatus.value = 'I';
			}
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
		alert("Please select a user to modify");
			return;
	}
	else
	{
		document.myForm.action="ezChangeUserData.jsp";
		document.myForm.submit();
	}	
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
		alert("Please select a user to change password");
			return;
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
		alert("Please select a user to delete");
		return;
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
</Script>
</head>
 
<body onLoad="scrollInit()" onResize="scrollInit()" style="overflow-y:no;overflow-x:no;overflow:hidden" scroll=no>
<form name=myForm method=post>
<input type="hidden" name="Area" value="C">


<%
	String display_header	= "List of Sub Users";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>

<br>
<%
		if(partnersRetCnt>0)
		{

%>
			<Div id="theads">
			<Table id="tabHead" width="50%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
			<Tr>
				<Th width="10%">&nbsp;</Th>
			      	<Th width="25%">User Id</Th>
			      	<Th width="55%">User Name</Th>
			      	<Th width="10%">Status</Th>
			      
			</Tr>
			</Table>
			</Div>
			
			<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:50%;left:12.5%">
			<Table  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
			
<%
			String userStatus = "A";
			
			partnersRet.sort(new String[]{"EU_ID"},true);
			
			for(int i=0;i<partnersRet.getRowCount();i++)
			{
				fullName=partnersRet.getFieldValueString(i,"EU_FIRST_NAME")+partnersRet.getFieldValueString(i,"EU_LAST_NAME");
				String userId=partnersRet.getFieldValueString(i,"EU_ID");
				String key=userId+"¥"+fullName;
%>
				<Tr>
					<Td width="10%" align=center><input type="radio" name="BusinessUser"  value="<%=key%>" ></Td>
					<Td width="25%" align="left">&nbsp;<a href = "ezSubUserDetails.jsp?UserID=<%=partnersRet.getFieldValueString(i,"EU_ID")%>"><%=partnersRet.getFieldValueString(i,"EU_ID")%></a></Td>
					<Td width="55%" align="left">&nbsp;<%=fullName%></Td>
					<Td width="10%" align="center">&nbsp;
<%

					if("I".equals(statusHt.get(userId.trim())))
					{
						userStatus ="A";
%>					
						<img id="userStatusImg_<%=i%>" src="../../Images/Others/redball.gif" style="cursor:hand"  alt="Click Here To Change The Status" border=no onClick="changeStatus(<%=i%>)">
						
<%
					}
					else
					{
						userStatus ="I";
%>						
						<img id="userStatusImg_<%=i%>" src="../../Images/Others/greenball.gif" style="cursor:hand"  alt="Click Here To Change The Status" border=no onClick="changeStatus(<%=i%>)"> 
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
			</Table>
			</Div>

<%
		}else{
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="40%">
				<Tr align="center">
					<Th>There are no Users to List.</Th>
				</Tr>
			</Table>
			<br>
<%
		}
%>

	<Div  style="position:absolute;top:85%;width:100%" align="center">
	<Table>
	<Tr>
		<Td class='blankcell'><img src='../../Images/Others/greenball.gif' border=0>&nbsp;&nbsp;Active</Td>
		<Td class='blankcell'><img src='../../Images/Others/redball.gif' border=0>&nbsp;&nbsp;Blocked</Td>
	</Tr>
	</Table>
<Br>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	if(partnersRetCnt>0)
	{
		buttonName.add("Modify");
		buttonMethod.add("modifyDetails()");
		
		buttonName.add("Change&nbsp;&nbsp;Password");
		buttonMethod.add("changePwd()");

		buttonName.add("Delete");
		buttonMethod.add("funDelete()");
	}
	
	//buttonName.add("Back");
	//buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>

	</Div>
<Div id="MenuSol"></Div>
</body>
</html>