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
	//out.println("retUsers:::::::::::::::"+retUsers.toEzcString());
%>
<html>
<head>
<Title>List Of All Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="../../Library/JavaScript/User/ezListAllUsersBySysKey.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<Script src="List_nav.js"></script>
<link rel="stylesheet" href="List_nav.css" type="text/css" media="screen" charset="utf-8" />
</head>
<body onLoad='bodyInit()' onresize='scrollInit()' scroll="no">
<form name=myForm method=post>
<input type="hidden" name="myUserType" value = "<%=myUserType%>">
<%
	java.util.Hashtable sysKeyDescs = new java.util.Hashtable(); 
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
	{
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
		
		<div class="wrapper">
		        <div class="alphabet">
		            <a class="first" href="#">A</a>
		            <a href="#">B</a>
		            <a href="#">C</a>
		            <a href="#">D</a>
		            <a href="#">E</a>
		            <a href="#">F</a>
		            <a href="#">G</a>
		            <a href="#">H</a>
		            <a href="#">I</a>
		            <a href="#">J</a>
		            <a href="#">K</a>
		            <a href="#">L</a>
		            <a href="#">M</a>
		            <a href="#">N</a>
		            <a href="#">O</a>
		            <a href="#">P</a>
		            <a href="#">Q</a>
		            <a href="#">R</a>
		            <a href="#">S</a>
		            <a href="#">T</a>
		            <a href="#">U</a>
		            <a href="#">V</a>
		            <a href="#">W</a>
		            <a href="#">X</a>
		            <a href="#">Y</a>
		            <a class="last" href="#">Z</a>
		        </div>
		        <div id="conutries">
		            <table id="countries-table" border='1' width="100%">
		                <thead>
		                    <tr>
		                        <th>User Id</th>
		                        <th>User Name</th>
		                        <!--<th>Type</th>-->
		                    </tr>
		                </thead>
		                <tbody>
<%
			if(websyskey!=null )
			{
				if(!websyskey.equals("sel"))
				{
				int rCount = retUsers.getRowCount();
				for(int i=0;i<rCount;i++)
				{
					String userId 	 = (String)retUsers.getFieldValue(i,USER_ID);
					String userFname = (String)retUsers.getFieldValue(i,USER_FIRST_NAME);
					String userMname = (String)retUsers.getFieldValue(i,USER_MIDDLE_INIT);
					String userLname = (String)retUsers.getFieldValue(i,USER_LAST_NAME);
					//String userType = (String)retUsers.getFieldValue(i,EU_TYPE);
					
					if(userFname != null) userFname = userFname.trim(); else userFname="";
					if(userMname != null) userMname = userMname.trim(); else userMname="";
					if(userLname != null) userLname = userLname.trim(); else userLname="";
					String Name  = userFname +" "+ userMname +" "+  userLname;
%>
					<tr>
						<td align='left'><%=userId%></td>
						<td align='left'><%=Name%></td>
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

