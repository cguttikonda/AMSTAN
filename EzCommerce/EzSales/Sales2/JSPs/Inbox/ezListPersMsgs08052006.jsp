<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iListPersMsgs.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.FormatDate"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Title>List of Inbox Messages -- Powered By Answerthink India Pvt Ltd.</Title>
<script src="../../Library/JavaScript/Inbox/ezListPersMsgs.js"></script>
<script language="JavaScript">
function ezHref(event)
{
	document.location.href = event;
}
function selectAll()
{
   var len=document.myForm.CheckBox.length;
	if(document.myForm.select.checked)
	{
		document.myForm.CheckBox.checked=true
	}
	else
	{
		document.myForm.CheckBox.checked=false
	}
	for(i=0;i<len;i++)
	{
		if(document.myForm.select.checked)
		{
			document.myForm.CheckBox[i].checked=true
		}
		else
		{
			document.myForm.CheckBox[i].checked=false
		}
	}
}

</script>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="45%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body  onLoad='scrollInit()' onResize='scrollInit()' scroll=no>
<form name=myForm method=post action="ezDelPersMsgs.jsp?type=allmess">

<Table class="displayheaderback" height=28 id="header" width="100%" border="0" align="center">
	<Tr  class="displayheaderback">
		<Td width="100%" class="displayheaderback">
			<Table border="0" cellpadding="0" cellspacing="0" width="100%"  >
				<Tr valign="middle" class=trclass  class="displayheaderback">
					<Td class="displayheaderback" width="60%" valign="middle" align="left">
						
<%
							if(folderID.equals("1000"))
							{
									buttonName = new java.util.ArrayList();
									buttonMethod = new java.util.ArrayList();
									buttonName.add("Inbox");
									buttonMethod.add("ezHref(\"ezListPersMsgs.jsp\")");
									buttonName.add("Compose");
									buttonMethod.add("ezHref(\"ezComposePersMsg.jsp\")");
									buttonName.add("Folders");
									buttonMethod.add("ezHref(\"ezListFolders.jsp\")");
									out.println(getButtonStr(buttonName,buttonMethod));	
	
							}
							else
							{
									buttonName = new java.util.ArrayList();
									buttonMethod = new java.util.ArrayList();
									buttonName.add("Inbox");
									buttonMethod.add("ezHref(\"ezListPersMsgs.jsp\")");
									buttonName.add("Compose");
									buttonMethod.add("ezHref(\"ezComposePersMsg.jsp\")");
									buttonName.add("Folders");
									buttonMethod.add("ezHref(\"ezListFolders.jsp\")");
									out.println(getButtonStr(buttonName,buttonMethod));	
							}
%>
						
					</Td>
				</Tr>
			</Table>
		</Td>
	</Tr>
</Table>


<br>

<input type="hidden" name="FolderID" value=<%=folderID%> >
<input type="hidden" name="FolderName" value=<%=folderName%>>
<input type="hidden" name="DelFlag" value="N">

<%
	int count=0;
	String field="else";
	String tes="yes";
	SimpleDateFormat sdf=new SimpleDateFormat("dd.MM.yyyy hh:mm a");
	if((type.equals("all")) && (retMsgList.getRowCount()==0) )
	{
%>
		<br>
		<Table  width="95%" valign=center height=50%  align=center border=0 cellPadding=0 cellSpacing=0 >
			<Tr>
				<Td align="center" >No Messages in <%=folderName%>.</Td>
			</Tr>
		</Table>
<%
	}
	else
	{
		//The follwing is for showing message when click on New Messaes in Inbox list.
		if((type.equals("newmess")) && (retMsgList.getRowCount()==0))
		{
%>
			<Table  width=95%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
					<Td>
						<Table width="100%" border=0 cellPadding=0 cellSpacing=0>
				<Tr>
					<Th valign="top" align="center" colspan=4>
						<font size="2" ><b><%= getLabel("MSGS_IN") %> &nbsp;&nbsp;<%=folderName.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>
					</Th>
				</Tr>
				<Tr>
					<Td align="center"><a href="ezListPersMsgs.jsp?type=allmess&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  style="text-decoration:none" style="cursor:hand" title="all messages" <%=statusbar%>><b><%= getLabel("A_MESS")%> &nbsp;</b></a></Td>
					<Td align="center"><a href="ezListPersMsgs.jsp?type=newmess&msgFlag=1&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  title="new messages" style="text-decoration:none" <%=statusbar%>><b><%= getLabel("NEW_MSGS")%></b></a></Td>
				</Tr>
			</Table>
		</Td>
		</Tr>
		</Table>
		<Table  width=95% valign=center height=40% align=center  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
			<Tr>
				<Td align=center>No New Messages</Td>
			</Tr>
		</Table>
<%

        	}
		else
       		{
			if((retMsgList.getRowCount() > 0))
			{
%>			
				<Table  width=95%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
					<Td>
						<Table width="100%" border=0 cellPadding=0 cellSpacing=0>
						<Tr>
							<Th valign="top" align="center" colspan=5>
								<font size="2" ><b><%= getLabel("MSGS_IN") %> &nbsp;&nbsp;<%=folderName.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>
							</Th>
						</Tr>
						<Tr>
							<Td class="displayheaderback">
<%
							buttonName = new java.util.ArrayList();
							buttonMethod = new java.util.ArrayList();
							buttonName.add("Delete");
							buttonMethod.add("CheckSelectNew()");
							out.println(getButtonStr(buttonName,buttonMethod));	
%>
							</Td>
							<Td align="center" class="displayheaderback"><a href="ezListPersMsgs.jsp?type=allmess&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  style="text-decoration:none;cursor:hand"  title="all messages" <%=statusbar%>><b><%= getLabel("A_MESS")%> &nbsp;</b></a></Td>
							<Td align="center" class="displayheaderback"><a href="ezListPersMsgs.jsp?type=newmess&msgFlag=1&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  title="new messages" <%=statusbar%> style="text-decoration:none" class="mailcell"><b><%= getLabel("NEW_MSGS")%></b></a></Td>
<%
							if ( retFoldList.find(FOLD_NAME,"Inbox") )
							{
								int rowID = retFoldList.getRowId(FOLD_NAME,"Inbox");
								retFoldList.deleteRow(rowID);
							} //end if
							
							//The following is for getting Folder Names in select box.
							int foldRows = retFoldList.getRowCount();
							String foldName = null;
							if ( foldRows > 0 )
							{
%>
								<Td align=right class="displayheaderback">
								<%
									buttonName = new java.util.ArrayList();
									buttonMethod = new java.util.ArrayList();
									buttonName.add("Move To");
									buttonMethod.add("CheckSelectForMove()");
									out.println(getButtonStr(buttonName,buttonMethod));	
								%>
								</td><Td width=5% align=right class="displayheaderback">
									<select name="ToFolder">
										<option value="select" >--Select--</option>
<%
									for ( int i = 0 ; i < foldRows ; i++ )
									{
										foldName = (String) retFoldList.getFieldValue(i,FOLD_NAME);

										if(!(foldName.equals(folderName)))
										{
%>
    			 	     							<option  value=<%=retFoldList.getFieldValue(i,FOLD_ID)%> >
<%

    										}
										if (foldName != null)
										{
%>
    											<%= foldName%>
<%
    										}
%>
    		      								</option>
<%
    									}//End for
%>
                							</select>
							</Td>
<%
							}
							else
							{
%>

                     						<Td class="displayheaderback" >&nbsp;</Td>
<%
                					}
%>

						</Tr>
						</Table>
					</Td>
				</Tr>
      				</Table>
	<Div id="theads">
	<Table  width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
    	<Tr align="center">
	      	<Th width="10%" align='center'><input type="checkbox" name="select" onClick="selectAll()"></Th>
	      	<Th width="5%"><%= getLabel("NEW") %></Th>
	      	<Th width="30%"><%= getLabel("FROM") %> </Th>
	      	<Th width="30%"> <%= getLabel("SUBJ") %> </Th>
     	        <Th width="20%"><%= getLabel("DAT") %></Th>
	</Tr>
	</Table>
	</Div>
	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:45%;left:2%">
	<Table  align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
			int mm=0;
			String tem="";
			String msgDate="";
			String SubjectStr = "",qcfNo = "",firstName = "",middleName= "",lastName = "",finalName = "";
			
			//The follwing is for showing messages in Folders. It is executed when click on Folder Name in Folders list.
		        if(type.equals("all"))
		        {
				tem="empty";

        			for (int i = 0 ; i < retMsgList.getRowCount(); i++)
				{
					 SubjectStr = retMsgList.getFieldValueString(i,MSG_SUBJECT);
					 firstName=retMsgList.getFieldValueString(i,"FIRSTNAME");
					 middleName=retMsgList.getFieldValueString(i,"MIDDLENAME");
					 lastName=retMsgList.getFieldValueString(i,"LASTNAME");
					
					//if(SubjectStr.indexOf("QCF No :")!=-1)
						//qcfNo = SubjectStr.substring(9,(SubjectStr.indexOf("has"))-1);

					if(firstName==null || "".equals(firstName) || "null".equals(firstName))
						firstName="";

					if(middleName==null || "".equals(middleName) || "null".equals(middleName))
						middleName="";
					

					if(lastName==null || "".equals(lastName) || "null".equals(lastName))
						lastName="";
						
					 finalName = firstName+" "+middleName+" "+lastName;
					 
					 mm++;
%>
					<Tr align="center">
						<Td width="10%"><input type="checkbox" name= "CheckBox" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>" ></Td>
						<Td width="5%">
<%		
						if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
						{
%>
							<img src = "../../Images/Buttons/<%= ButtonDir%>/new.gif"  title="new" border=none>
<%	
						}
						else
						{
%>
							&nbsp;
<%
						}
%>
						</Td>
						<Td width="30%" align="left"><a style="text:decoration:none" href="ezPersMsgDetails.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>&qcfNumber=<%=qcfNo%>" <%=statusbar%>><%=finalName%></Td>
						<Td width="30%" align="left">&nbsp;
<%
						String sub=retMsgList.getFieldValueString(i,MSG_SUBJECT);
						if(sub==null || "null".equals(sub) || "".equals(sub.trim()))
						{
%>
							[No Subject]
<%
						}
						else
						{
%>
						     	<%=sub%>
<%
		        			}
%>
  						</Td>
						<Td width="20%">
							<%=sdf.format((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE))%>
						</Td>
					</Tr>
<%
				}//End for
        		}
        		
        		//The follwing is for showing messages when click on All Messaes in Inbox list. It default when click on E-Mail in the menu.
			if(type.equals("allmess"))
			{
				for (int i = 0 ; i < retMsgList.getRowCount(); i++)
				{
					 SubjectStr = retMsgList.getFieldValueString(i,MSG_SUBJECT);
					 firstName=retMsgList.getFieldValueString(i,"FIRSTNAME");
					 middleName=retMsgList.getFieldValueString(i,"MIDDLENAME");
					 lastName=retMsgList.getFieldValueString(i,"LASTNAME");

					
					//if(SubjectStr.indexOf("QCF No :")!=-1)
						//qcfNo = SubjectStr.substring(9,(SubjectStr.indexOf("has"))-1);

					if(firstName==null || "".equals(firstName) || "null".equals(firstName))
						firstName="";

					if(middleName==null || "".equals(middleName) || "null".equals(middleName))
						middleName="";

					if(lastName==null || "".equals(lastName) || "null".equals(lastName))
						lastName="";
						
					 finalName = firstName+" "+middleName+" "+lastName;
%>
     					<Tr align="center">
						<Td width="10%"><input type="checkbox" name= "CheckBox" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>"></Td>
      						<Td width="5%">
<%
						if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
						{
%>
							<img src = "../../Images/Buttons/<%= ButtonDir%>/new.gif"  title="new" border=none>
<%
						}
						else
						{
%>
							&nbsp;
<%
		   				}
%>
					       </Td>
					       <Td width="30%" align="left"><a style="text:decoration:none" href="ezPersMsgDetails.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>&qcfNumber=<%=qcfNo%>" <%=statusbar%>><%=finalName%></Td>
					       <Td width="30%" align="left">&nbsp;
<%
	     					String sub=retMsgList.getFieldValueString(i,MSG_SUBJECT);

						if(sub==null || "null".equals(sub) || "".equals(sub.trim()))
						{
%>
							[No Subject]
<%
						}
						else
						{
%>
					     		<%=sub%>
<%
     						}

%>
				 	 	</Td>
				 	       <Td width="20%">
					     	   <%=sdf.format((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE))%>
					       </Td>
			    		</Tr>
<%	

				}//End for

			}
			else
			{
				//The follwing is for showing messages when click on New Messaes in Inbox list.
				if(type.equals("newmess"))
				{
					field="empty";
					for (int i = 0 ; i < retMsgList.getRowCount(); i++)
					{
						 SubjectStr = retMsgList.getFieldValueString(i,MSG_SUBJECT);
						 firstName=retMsgList.getFieldValueString(i,"FIRSTNAME");
						 middleName=retMsgList.getFieldValueString(i,"MIDDLENAME");
						 lastName=retMsgList.getFieldValueString(i,"LASTNAME");
						
						//if(SubjectStr.indexOf("QCF No :")!=-1)
							//qcfNo = SubjectStr.substring(9,(SubjectStr.indexOf("has"))-1);
					
						if(firstName==null || "".equals(firstName) || "null".equals(firstName))
							firstName="";

						if(middleName==null || "".equals(middleName) || "null".equals(middleName))
							middleName="";


						if(lastName==null || "".equals(lastName) || "null".equals(lastName))
							lastName="";
							
						 finalName=firstName+" "+middleName+" "+lastName;

						if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
						{
							count++;
%>
     								<Tr align="center">
									<Td width="10%"><input type="checkbox" name= "CheckBox" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>"></Td>
      									<Td width="5%"><img src = "../../Images/Buttons/<%= ButtonDir%>/new.gif"  title="new" border=none></Td>
      	        							<Td width="30%" align="left"><a style="text:decoration:none" href="ezPersMsgDetails.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>&qcfNumber=<%=qcfNo%>" <%=statusbar%>><%=finalName%></Td>
               								<Td width="30%" align="left">&nbsp;
<%	
	    								String sub=retMsgList.getFieldValueString(i,MSG_SUBJECT);
									if(sub==null || "null".equals(sub) || "".equals(sub))
									{
%>
										[No Subject]
<%
									}
									else
									{
%>
										<%=sub%>
<%
	        							}
%>
	       								</Td>
									<Td width="20%">
										<%=sdf.format((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE))%>
									</Td>
    								</Tr>
<%
      						}
      					} //for close
				}//if close
		  	}//else close
%>
	</Table>
</Div>

<%
		
		}
		else
		{
			if((retMsgList.getRowCount()==0) && (!type.equals("newmess"))&& (!type.equals("all")))
			{
%>
				<br>
				<Table  width=95% height="60%"   align=center cellPadding=0 cellSpacing=0 border=0>
				<Tr>
					<Td align=center >No Messages in <%=folderName.toUpperCase()%>.</Td>
				</Tr>
				</Table>
<%
			}
		}
	}
}
%>
</form>
<Div id="MenuSol"></Div>
<Div id="buttonDiv"></Div>
</body>
</html>
