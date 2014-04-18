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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<Title>List Of All Users</Title>

	<link rel="stylesheet" href="http://cdn.ihwy.net/ihwy-com/assets/css/reset-min.css" type="text/css" media="screen" charset="utf-8" />
	<link rel="stylesheet" href="http://cdn.ihwy.net/ihwy-com/assets/css/ihwy-2012.css" type="text/css" media="screen" charset="utf-8" />
	<link rel="stylesheet" href="http://cdn.ihwy.net/ihwy-com/labs/jquery-listnav/2.1/jquery.listnav-2.1.css" type="text/css" media="screen" charset="utf-8" />

	<style type="text/css" media="screen" charset="utf-8">
		body { background:none; }
		.demoWrapper { margin:15px; }
		pre.chili { margin-bottom:2em; }
		#btnDemo2 { margin-bottom:1em; }
	</style>

	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/jquery-1.3.2.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/jquery.cookie.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/jquery.idTabs.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/labs/jquery-listnav/2.1/jquery.listnav-2.1.js" charset="utf-8"></script>


	<script type="text/javascript" charset="utf-8">
		$(function(){
			if(top.location.href.toLowerCase() == self.location.href.toLowerCase()) $('#docLink').show();

			$("#tabNav ul").idTabs("tab1"); 
			$('#demoOne').listnav();

		});
	</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezListAllUsersBySysKey.js">
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
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
		String tabHeader = "<Th width='5%'>&nbsp;</Th><Th width='15%' align = 'center'>UserId</Th><Th width='30%' align = 'center'>User Name</Th><Th width='12%' align = 'center'>Type</Th>";
		if("All".equals(websys)){
			isSel = "selected";
			tabHeader = "<Th width='5%'>&nbsp;</Th><Th width='15%' align = 'center'>UserId</Th><Th width='30%' align = 'center'>User Name</Th><Th width='15%' align = 'center'>Pur. Grp</Th><Th width='23%' align = 'center'>Pur. Desc</Th><Th width='12%' align = 'center'>Type</Th>";
		}
%>
	<br>
	<input type=hidden name="Area" value=<%=areaFlag%>>
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
	</Tr>
	</Table>
	<input type="hidden" name="searchcriteria" value="$">
<%

	if(websyskey!=null )
	{
		if(!websyskey.equals("sel"))
		{

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
					//if(!vuserId.contains((String) retUsers.getFieldValue(i,USER_ID)))
					if(!vSearchKey.contains((String) retUsers.getFieldValue(i,USER_ID)+(String)retUsers.getFieldValueString(i,"EUD_SYS_KEY")))
					{
						vuserId.addElement((String) retUsers.getFieldValue(i,USER_ID));
						vfirstName.addElement((String) retUsers.getFieldValue(i,USER_FIRST_NAME));
						vmiddleIntial.addElement((String)retUsers.getFieldValue(i,USER_MIDDLE_INIT));
						vlastName.addElement((String) retUsers.getFieldValue(i,USER_LAST_NAME));
						vuserType.addElement((String)retUsers.getFieldValueString(i,"EU_TYPE"));
						vpurGrp.addElement((String)retUsers.getFieldValueString(i,"EUD_SYS_KEY"));
						vSearchKey.addElement((String) retUsers.getFieldValue(i,USER_ID)+(String)retUsers.getFieldValueString(i,"EUD_SYS_KEY"));

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
			<div class="demoWrapper">
			<div class="clr"></div>
			<div id="tabNav">
				<ul> 
					<li><a href="#tab1">Demo 1</a></li>
				</ul>
				<div class="clr"></div>
			</div>
			<div id="tabs">
				<div id="tab1" class="tab">
					<div id="demo1">
			<div id="demoOne-nav" class="listNav"></div>
			
			<Table id="demoOne" class="demo">
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
				<label for="cb_<%=i%>">
				<Td width="5%" align=center>
					<input type="radio" name="chk1" id="cb_<%=i%>" value="<%=(String)vuserId.elementAt(i)%>/<%=(String)vpurGrp.elementAt(i)%>" >
				</Td>
				<Td width="15%">
					<a href=<%=userUrl%> ><%=(String)vuserId.elementAt(i)%></a>
				</Td>
				<Td width="30%" id="myUserName">
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
				</label>
				</Tr>
<%
			}
%>
			</Table>
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
				<a href="javascript:funCheckBoxSingleCopyUser('<%=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/copyuser.gif" border=none></a>
				<a href="javascript:funCheckBoxSingleResetPassword('<%=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/resetpassword.gif" border=none></a>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</div>
<%
			}
			else
			{
%>
				<br><br><br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr align="center">
					<Td class="displayheader">There are no users to list</Td>
				</Tr>
				</Table><br>
				<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></center>
<%
			}

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
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></center>
<%
	}
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
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></center>
<%
	}
	}
%>
<input type="hidden" name="Area" value=<%=areaFlag%> >
<input type="hidden" name="BusinessUser" value="" >
<input type="hidden" name="userName" value = "">
<input type="hidden" name="BPsyskey" >
</form>
</body>
</html>
