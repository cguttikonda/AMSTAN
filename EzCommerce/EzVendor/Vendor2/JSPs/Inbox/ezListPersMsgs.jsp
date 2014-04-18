<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/JSPs/Labels/iListPersMsgs_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iListPersMsgs.jsp"%>
<html>
<head>
<script>
	var urUnbDel_L = '<%=urUnbDel_L%>';
	var plzSelMsgDel_L = '<%=plzSelMsgDel_L%>';
	
	var plzSelFolMov_L = '<%=plzSelFolMov_L%>';
	var plzSelMsgMov_L = '<%=plzSelMsgMov_L%>';
	var unbMovNoFile_L = '<%=unbMovNoFile_L%>';
	var curNoFold_L = '<%=curNoFold_L%>';
</script>
<script src="../../Library/JavaScript/Inbox/ezListPersMsgs.js"></script>
<Title></Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script language="JavaScript">
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
function ezHref(param)
{

	if(param=='ezListPersMsgs.jsp')
			param= param+'?FolderID=1000&FolderName=Inbox&type=allmess';
	
	document.myForm.action = param;
	setMessageVisible();
	document.myForm.submit();
	
}


</script>
<Script>
	var tabHeadWidth=95
	var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body  onLoad='scrollInit()' onResize='scrollInit()' scroll=no>
<% String display_header =mailbox_L; %>
<!-- <Table  width=40%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th align="center" >
			Mail Box
		</Th>
	</Tr>
</Table> -->
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br>

<form name=myForm method=post action="ezDelPersMsgs.jsp?type=allmess">
<input type="hidden" name="FolderID" value=<%=folderID%> >
<input type="hidden" name="FolderName" value=<%=folderName%>>
<input type="hidden" name="type" value=<%=type%>>
<input type="hidden" name="DelFlag" value="N">
<%
int count=0;
String field="else";
String tes="yes";
SimpleDateFormat sdf=new SimpleDateFormat("dd.MM.yyyy");

if((type.equals("all")) && (retMsgList.getRowCount()==0) )
{
%>
<br>
<Table  width="95%" valign=center height=50% border=1 align=center border=0 cellPadding=0 cellSpacing=0 >
<Tr>
<Td align="center" >
<%=noMsgIn_L%><%=folderName%>.  
</Td>
</Tr>
	</Table>
<%
}
else
{
	if((type.equals("newmess")) && (retMsgList.getRowCount()==0))
	{
%>
		<Table  width=95%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td>
				<Table width="100%" border=0 cellPadding=0 cellSpacing=0>
				<Tr>
					<Th valign="top" align="center" colspan=4>
						<font size="2" ><b><%=MsgIn_L%>&nbsp;&nbsp;<%=folderName.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>
					</Th>
			    </Tr>
				<Tr>
					<Td align="center"><a href="ezListPersMsgs.jsp?type=allmess&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  style="text-decoration:none" style="cursor:hand" title="all messages" <%=statusbar%>><b><%=allMsgs_L%> &nbsp;</b></a></Td>
					<Td align="center"><a href="ezListPersMsgs.jsp?type=newmess&msgFlag=1&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  title="new messages" style="text-decoration:none" <%=statusbar%>><b><%=newMsgs_L%></b></a></Td>
				</Tr>
				</Table>
			</Td>
		</Tr>
		</Table>
		<Table  width=95% valign=center height=40% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
		<Tr>
			<Td align=center>
				<%=noNewMsg_L%>
			</Td>
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
						<Th valign="top" align="center" colspan=4>
							<font size="2" ><b><%=MsgIn_L%> &nbsp;&nbsp;<%=folderName.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>
						</Th>
					</Tr>
		                    	<Tr>
						<Td align="center" class="displayheaderback"><a href="ezListPersMsgs.jsp?type=allmess&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  style="text-decoration:none;cursor:hand"  title="all messages" <%=statusbar%>><b><%=allMsgs_L%> &nbsp;</b></a></Td>
		                    	  	<Td align="center" class="displayheaderback"><a href="ezListPersMsgs.jsp?type=newmess&msgFlag=1&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  title="new messages" <%=statusbar%> style="text-decoration:none" class="mailcell"><b><%=newMsgs_L%></b></a></Td>
<%
			if ( retFoldList.find(FOLD_NAME,"Inbox") )
			{
				int rowID = retFoldList.getRowId(FOLD_NAME,"Inbox");
				retFoldList.deleteRow(rowID);
			} //end if
			int foldRows = retFoldList.getRowCount();
			String foldName = null;
			if ( foldRows > 0 )
    			{
%>
  	      			<Td align=right class="displayheaderback">
  	      			<!-- <a style="text-decoration:none"  class=subclass href='Javascript:CheckSelectForMove()'>
  	      			<img src = "../../Images/Buttons/<%= ButtonDir%>/moveto.gif" name="Move"  title="Click here to move this mail to selected folder" border="none" <%=statusbar%>  > </a>-->
  	      			
  	      			<%
						
						buttonName = new java.util.ArrayList();
						buttonMethod = new java.util.ArrayList();
						
						buttonName.add("Move To");
						buttonMethod.add("CheckSelectForMove()");
						
						out.println(getButtonStr(buttonName,buttonMethod));
				%>
  	      			
  	      			</div>
  	      			
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
	      	<Th width="5%">&nbsp;</Th>
	      	<Th width="30%"><%=from_L%> </Th>
	      	<Th width="30%"> <%=subject_L%> </Th>
     	        <Th width="20%"><%=date_L%></Th>
	</Tr>
	</Table>
	</Div>

	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:45%;left:2%">
	<Table  align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
			int mm=0;
			String tem="";
			String msgDate="";

		        if(type.equals("all"))
		        {
				tem="empty";

        			for (int i = 0 ; i < retMsgList.getRowCount(); i++)
				{
					String firstname=retMsgList.getFieldValueString(i,"FIRSTNAME");

					if(firstname==null || "".equals(firstname) || "null".equals(firstname))
						firstname="";
					String middlename=retMsgList.getFieldValueString(i,"MIDDLENAME");

					if(middlename==null || "".equals(middlename) || "null".equals(middlename))
						middlename="";

					String lastname=retMsgList.getFieldValueString(i,"LASTNAME");

					if(lastname==null || "".equals(lastname) || "null".equals(lastname))
						lastname="";
					 String finalname=firstname+" "+middlename+" "+lastname;
					//out.println(firstname+" "+middlename+" "+lastname);



					mm++;
%>
					<Tr align="center">
						<Td width="10%"><input type="checkbox" name= "CheckBox" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>" ></Td>
						<Td width="5%">
<%		
						if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
						{
%>
							<img src = "../../../../EzCommon/Images/Body/new.jpg"  title="new" border=none> 
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
					<Td width="30%" align="left"><a style="text:decoration:none" href="ezPersMsgDetails.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>" <%=statusbar%>><%=finalname%></Td>
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
						<%=FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))+"&nbsp;&nbsp;"+retMsgList.getFieldValueString(i,"EPM_CREATION_TIME")%>
						</Td>
						
					</Tr>
<%
				}//End for
        		}
			if(type.equals("allmess"))
			{
				for (int i = 0 ; i < retMsgList.getRowCount(); i++)
				{
					String firstname=retMsgList.getFieldValueString(i,"FIRSTNAME");

					if(firstname==null || "".equals(firstname) || "null".equals(firstname))
						firstname="";
					String middlename=retMsgList.getFieldValueString(i,"MIDDLENAME");

					if(middlename==null || "".equals(middlename) || "null".equals(middlename))
						middlename="";

					String lastname=retMsgList.getFieldValueString(i,"LASTNAME");

					if(lastname==null || "".equals(lastname) || "null".equals(lastname))
						lastname="";
					 String finalname=firstname+" "+middlename+" "+lastname;
%>
     					<Tr align="center">
						<Td width="10%"><input type="checkbox" name= "CheckBox" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>"></Td>
      						<Td width="5%">
<%
		   			if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
		   			{
%>
						<img src = "../../../../EzCommon/Images/Body/new.jpg"  title="new" border=none>
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
			      	       <Td width="30%" align="left"><a style="text:decoration:none" href="ezPersMsgDetails.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>" <%=statusbar%>><%=finalname%></Td>
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
				 	       <Td width="20%">&nbsp;
				 	       <%if(FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))!=null){%>
					        	<%=FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))+"&nbsp;&nbsp;"+retMsgList.getFieldValueString(i,"EPM_CREATION_TIME")%>
					        <%}%>
					        </Td>
			    		</Tr>
<%	

			}//End for

			}else
			{
				if(type.equals("newmess"))
				{
					field="empty";
					for (int i = 0 ; i < retMsgList.getRowCount(); i++)
					{
					String firstname=retMsgList.getFieldValueString(i,"FIRSTNAME");
					if(firstname==null || "".equals(firstname) || "null".equals(firstname))
						firstname="";
					String middlename=retMsgList.getFieldValueString(i,"MIDDLENAME");
					if(middlename==null || "".equals(middlename) || "null".equals(middlename))
						middlename="";

					String lastname=retMsgList.getFieldValueString(i,"LASTNAME");
					if(lastname==null || "".equals(lastname) || "null".equals(lastname))
						lastname="";
					 String finalname=firstname+" "+middlename+" "+lastname;
					//out.println(firstname+" "+middlename+" "+lastname);



						if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
						{
							count++;
%>
     								<Tr align="center">
									<Td width="10%"><input type="checkbox" name= "CheckBox" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>"></Td>
      									<Td width="5%"><img src = "../../../../EzCommon/Images/Body/new.jpg"  title="new" border=none></Td>
      	        							<Td width="30%" align="left"><a style="text:decoration:none" href="ezPersMsgDetails.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>" <%=statusbar%>><%=finalname%></Td>
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
	       						<Td width="20%">&nbsp;
	       							<%if(FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))!=null){%>
	       								<%=FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))) %></Td>
	       							<%}%>	
    							</Tr>
<%
      						}
      					} //for close


%>
	</Tr>
<%
				}
		  }
%>
</Table>
</Div>

<%
		}else
		{
			if((retMsgList.getRowCount()==0) && (!type.equals("newmess"))&& (!type.equals("all")))
			{
%>
			<br>
			<Table  width=95% height="60%"  border=1 align=center cellPadding=0 cellSpacing=0 border=0>
			<Tr>
				<Td align=center ><%=noMsgIn_L%> <%=folderName.toUpperCase()%>.</Td>
			</Tr>
			</Table>
<%
			}
		}
	}
}
%>

<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
	if(retMsgList.getRowCount() > 0)
	{
		

		buttonName.add("Delete");
		buttonMethod.add("CheckSelectNew()");
	}
%>
	<!-- <a   class=subclass href="ezComposePersMsg.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/compose.gif"    title="Click here to compose a mail" <%=statusbar%>  border=0></a>
	<a  class=subclass href="ezListFolders.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/folders.gif"     title="Click here to see folders" <%=statusbar%>  border=0></a> -->
	<%
			
			//buttonName = new java.util.ArrayList();
			//buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Compose");
			buttonMethod.add("ezHref(\"ezComposePersMsg.jsp\")");
			
			buttonName.add("Folders");
			buttonMethod.add("ezHref(\"ezListFolders.jsp\")");
			
	%>
<%
	if(!folderID.equals("1000"))
	{
%>
		<!-- <a style="text-decoration:none"  class=subclass href='ezListPersMsgs.jsp'> <img src = "../../Images/Buttons/<%= ButtonDir%>/inbox.gif"  title="Click here to go to Inbox"  <%=statusbar%>   border=none></a> -->
		<%
				
							
				buttonName.add("Inbox");
				buttonMethod.add("ezHref(\"ezListPersMsgs.jsp\")");
				
				
		%>
<%
	}
	out.println(getButtonStr(buttonName,buttonMethod));
	
%>

</Div>
<%@ include file="../Misc/AddMessage.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
