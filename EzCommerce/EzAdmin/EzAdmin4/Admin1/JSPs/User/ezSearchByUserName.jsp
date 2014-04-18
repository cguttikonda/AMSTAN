<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsersBySysKey.jsp"%>
<%@ page import="java.util.*" %>
<%
	//String searchPartner=request.getParameter("searchcriteria");
	session.putValue("myAreaFlag",areaFlag);
%>
<html>
<head>
<Title>List Users</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script>
function funSearch()
{
	if(document.myForm.WebSysKey.selectedIndex==0)
	{
		alert("Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%>")
		document.myForm.WebSysKey.focus();
	}
	else if(document.myForm.searchcriteria.value == "")
	{
		alert("Please enter Search Criteria")
		document.myForm.searchcriteria.focus()
	}
	else
	{
		myCriteria = document.myForm.searchcriteria.value;
		myVal="SW"
		for(i=0;i<document.myForm.chk1.length;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				myVal=document.myForm.chk1[i].value
				break;
			}
		}
		if(myVal=="SW")
		{
			document.myForm.searchcriteria.value = myCriteria+"*";
		}
		if(myVal=="EW")
		{
			document.myForm.searchcriteria.value="*"+myCriteria;
		}
		document.myForm.action = "ezSearchByUserName.jsp";
		document.myForm.submit();
	}
}
function funFocus()
{
	document.myForm.searchcriteria.focus()
}
</Script>
</head>
<body onLoad="scrollInit()" onResize = "scrollInit()" scroll=no>
<form name=myForm method=post action="">
<input type="hidden" name="Area" value="<%=areaFlag%>">
<input type="hidden" name="partnerValue" value="">
<%
if(ret.getRowCount()==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Td class="displayheader" align="center">No <%=areaLabel%> To List Users.</Td>
	</Tr>
	</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%
	return;
}

	java.util.Hashtable sysKeyDescs = new java.util.Hashtable(); 
	String isSel ="";
	String tabHeader = "<Th width='15%' align = 'center'>UserId</Th><Th width='30%' align = 'center'>User Name</Th><Th width='12%' align = 'center'>Type</Th>";
	if("All".equals(websys)){
		isSel = "selected";
		tabHeader = "<Th width='15%' align = 'center'>UserId</Th><Th width='30%' align = 'center'>User Name</Th><Th width='15%' align = 'center'>Pur. Grp</Th><Th width='23%' align = 'center'>Pur. Desc</Th><Th width='12%' align = 'center'>Type</Th>";
	}
%>
	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr align="center">
		<Th width="35%" class="labelcell"><%=areaLabel.substring(0,areaLabel.length()-1)%>
      	</Th>
      	<Td width="65%" class="blankcell">
        	<select name="WebSysKey" style="width:100%" id=FullListBox>
		<option value="sel">--Select <%=areaLabel.substring(0,areaLabel.length()-1)%>--</option>
<%
			if ( areaFlag.equals("V") ){
%>			
				<option value="All" <%=isSel%>  >All</option>
<%
			}
			ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for(int i=0;i<ret.getRowCount();i++)
			{
				sysKeyDescs.put(ret.getFieldValueString(i,SYSTEM_KEY),ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION));
				if(websyskey!=null)
				{
					if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
					{
%>
						<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>' selected><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
					}
					else
					{
%>
						<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
					}
				}
				else
				{
%>
					<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
				}
			}
%>
	</select>
	</Td>
	</Tr>
	</Table>
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th><input type=radio name=chk1 value="SW" onClick = funFocus() checked>Starts With</Td>
		<Th><input type=radio name=chk1 value="EW" onClick = funFocus()>Ends With</Td>
		<Th><input type=radio name=chk1 value="EQ" onClick = funFocus()>Equals To</Td>
		<Th>User Name</Th>
		<Td><input type=text class = "InputBox" size=15 name="searchcriteria"></Td>
		<Td align = "center"><img src="../../Images/Buttons/<%= ButtonDir%>/search.gif" border=none onClick="funSearch()" style = "cursor:hand"></Td>
	</Tr>
	</Table>
<%
	if(searchPartner==null || "null".equals(searchPartner))
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Th>Please select Search Pattern and click on Search.</Td>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	return;
	}
	if(retUsers!=null )
	{
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
		{
	          mySearch.search(retUsers,"EU_FIRST_NAME",searchPartner.toUpperCase());
		}

		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && retUsers.getRowCount()==0)
		{
			if(searchPartner.indexOf("*")==-1)
				searchPartner = "Equals to "+searchPartner;
			else if(searchPartner.indexOf("*")==0)
				searchPartner = "Ends with "+searchPartner.substring(searchPartner.indexOf("*")+1,searchPartner.length());
			else
				searchPartner = "Starts with "+searchPartner.substring(0,searchPartner.indexOf("*"));
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			    	<Td class="displayheader" align = "center"><nobr>
					There are no Users to list with User Name <%=searchPartner%>.
				</nobr>
		    		</Td>
		  	</Tr>
		  	</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
			return;
		}
	}
%>
<%
	if(retUsers!=null && !"sel".equals(websyskey))
	{
		if(retUsers.getRowCount()>0)
		{
%>
<%

	int rCount = retUsers.getRowCount();
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
	<Tr align="center">
		<Td class="displayheader">List Of Users</Td>
	</Tr>
	</Table>
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr align="left">
		<%=tabHeader%>
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div">
	<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
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
		<Td width="15%">
			<a href=<%=userUrl%> ><%=(String)vuserId.elementAt(i)%></a>
		</Td>
		<Td width="30%">
			<%=((String)Name).toUpperCase()%>
		</Td>
<%
		if("All".equals(websys)){
%>
			<Td width="15%"><%=pGroup%></Td>
			<Td width="23%"><%=pDesc%></Td>
<%
		}
%>

		
		<Td width="12%">
			<%=userType%>
			<input type="hidden" name="utype" value="<%=(String)vuserType.elementAt(i)%>" >
		</Td>
		</Tr>
<%
	}
%>
	</Table>
</div>			<div id="ButtonDiv" align="center" style="position:absolute;top:92%;width:100%">
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</div>
<%		}
		else
		{
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
		    	<Td class="displayheader" align="center">No Users To List In This <%=areaLabel.substring(0,areaLabel.length()-1)%></Td>
			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%			
		}
	}	
	}
%>
</form>	
</body>
</html>
