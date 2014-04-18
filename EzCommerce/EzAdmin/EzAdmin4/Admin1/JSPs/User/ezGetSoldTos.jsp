<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsersBySysKey.jsp"%>
<%

	String selSysKey	= request.getParameter("WebSysKey");
	String selSolds 	= request.getParameter("selSolds");
	//out.println("selSysKey:::::::::::::::::::::"+selSolds);
	//out.println("retUsers::::::::::::::::::::::"+retUsers.toEzcString());
	int rCount = retUsers.getRowCount();
	java.util.Hashtable sysKeyDescs = new java.util.Hashtable(); 
	ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
	for(int i=0;i<ret.getRowCount();i++)
	{

		sysKeyDescs.put(ret.getFieldValueString(i,SYSTEM_KEY),ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION));
	}	
	
%>
<html>
<head>
<Title>List Of Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTrim.js"></script>

<Script>
/*funOnLoadSelect()
{
	var selectedSolds= <%=selSolds%>;
	if(selectedSolds!='')
	{
		var chkLen = document.myForm.chk.length
		selectedSolds = selectedSolds.split('*');
		alert(selectedSolds.length)
		for(i=0;i<chkLen;i++)
		{
		
		
		}
	
	}
}*/

function funSelectedSolto()
{
	var chkLen = document.myForm.chk.length
	var count=0
	var chkObj  ="";
	for(i=0;i<chkLen;i++)
	{
		
		if(document.myForm.chk[i].checked)
		{
			//alert(chkObj.length)	
			/*if(i==0)
				chkObj=
			else
				chkObj	= chkObj+","+funTrim(document.getElementById("cb_"+i).value)*/
			chkObj = (chkObj +(chkObj.length > 0 ? "*" : "") +funTrim(document.getElementById("cb_"+i).value));	
			
			count++;
		}	
	}
	if(count==0)
	{
		alert("No details are selected ")
		return;
	}	
	else
	{
		//alert(chkObj)
		opener.document.myForm.selectedSol.value=chkObj
		//alert(eval("opener.document.myForm.selectedSol"))
		self.close()
	}
	
	
	

}
function funClose()
{
	self.close()
}
	
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
    <form name=myForm method=post>
	<input type="hidden" name="myUserType" value = "<%=myUserType%>">
<%
	
	Vector vuserId=new Vector();
	Vector vfirstName=new Vector();
	Vector vmiddleIntial=new Vector();
	Vector vlastName=new Vector();
	Vector vuserType=new Vector();
	Vector vpurGrp	= new Vector();
	Vector vSearchKey = new Vector();
	retUsers.sort(new String[]{USER_FIRST_NAME},true);
	for(int i=0;i<rCount;i++)
	{
			//if(!vuserId.contains((String) retUsers.getFieldValue(i,USER_ID)))
			if(!vSearchKey.contains((String) retUsers.getFieldValue(i,USER_ID)+websyskey))	//(String)retUsers.getFieldValueString(i,"EUD_SYS_KEY")
			{
				vuserId.addElement((String) retUsers.getFieldValue(i,USER_ID));
				vfirstName.addElement((String) retUsers.getFieldValue(i,USER_FIRST_NAME));
				vmiddleIntial.addElement((String)retUsers.getFieldValue(i,USER_MIDDLE_INIT));
				vlastName.addElement((String) retUsers.getFieldValue(i,USER_LAST_NAME));
				vuserType.addElement((String)retUsers.getFieldValueString(i,"EU_TYPE"));
				vpurGrp.addElement(websyskey);	//(String)retUsers.getFieldValueString(i,"EUD_SYS_KEY")
				vSearchKey.addElement((String) retUsers.getFieldValue(i,USER_ID)+websyskey);	//(String)retUsers.getFieldValueString(i,"EUD_SYS_KEY")

			}
	}

	if ( vuserId.size() > 0 )
	{
%>	
	
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center" bgcolor="#AAAAAA">
		<font color='red' size='2' >Select Sold To's to restrict the visibilty to particular ids</font>
	
	</Tr>
	</Table>	
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<Td class="displayheader">List Of Users </Td>
	</Tr>
	</Table>
	<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr align="left">
			<Th width="5%">&nbsp;</Td>
			<Th width="15%" align = "center">Partner Id</Th>
			<Th width="15%" align = "center">Sold To</Th>
			<Th width="15%" align = "center">UserId</Th>
			<Th width="50%" align = "center">User Name</Th>
			
			
		</Tr>
		</Table>
	</div>
	<div id="InnerBox1Div">
	<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
	String fname = "",mname = "",lname = "",Name = "";  
	for (int i = 0 ; i < vuserId.size(); i++)
	{

		String uType = (String)vuserType.elementAt(i);
		String userUrl = "ezUserDetails.jsp?UserID="+(String)vuserId.elementAt(i);
		String userType = "Business";
		if ( uType.equals("2") )
		{
			userUrl = "ezViewIntranetUserData.jsp?UserID="+(String)vuserId.elementAt(i)+"&Show=Yes";
			userType="Intranet";
		}

 		fname = (String) vfirstName.elementAt(i);
		if(fname != null) fname = fname.trim(); else fname="";
 		mname = (String) vmiddleIntial.elementAt(i);
		if(mname !=null) mname = mname.trim(); else  mname = " ";
 		lname = (String) vlastName.elementAt(i);
		if(lname!=null) lname=lname.trim(); else lname = " ";
		Name  = fname +" "+ mname +" "+  lname;
		String pGroup = (String)vpurGrp.elementAt(i);
		String pDesc = (String)sysKeyDescs.get((String)pGroup);
%>
		<Tr align="left">
		
			<Td width="5%" align=center>
				<input type="checkbox" name="chk" id="cb_<%=i%>" value="<%=(String)vuserId.elementAt(i)%>" >
			</Td>
			<Td width="15%">
				<%=retUsers.getFieldValueString(i,"EU_BUSINESS_PARTNER")%>
			</Td>
			<Td width="15%">
				<%=retUsers.getFieldValueString(i,"EUD_VALUE")%>
			</Td>
			<Td width="15%">
				<a href=<%=userUrl%> ><%=(String)vuserId.elementAt(i)%></a>
			</Td>
			<Td width="50%" id="myUserName">
				<%=((String)Name).toUpperCase()+"("+pGroup+"\t"+pDesc+")"%>
			</Td>
	
		
		</Tr>
<%
	}
%>
	</Table>
	</div>	
	
	<div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%">
		<a href="javascript:funSelectedSolto()"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
		<a href="javascript:funClose()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
		
	</div>	
<%
	}
	else
	{
%>
		<Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
			<Td class="displayheader">No Users to list</Td>
		</Tr>
		</Table>
		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="javascript:funClose()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
		
		</div>		
<%
	}
%>	
	
</form>
</body>
</html>