<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.FormatDate"%>

	<script src="../../Library/JavaScript/Inbox/ezListPersMsgs.js"></script>

<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }
</style>

<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 

<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
 


<script type="text/javascript">
	function fnFeaturesInit ()
	{
		/* Not particularly modular this - but does nicely :-) */
		$('ul.limit_length>li').each( function(i) {
			if ( i > 10 ) {
				this.style.display = 'none';
			}
		} );

		$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
		$('ul.limit_length li.css_link').click( function () {
			$('ul.limit_length li').each( function(i) {
				if ( i > 5 ) {
					this.style.display = 'list-item';
				}
			} );
			$('ul.limit_length li.css_link').css( 'display', 'none' );
		} );
	}

	$(document).ready( function() {
		fnFeaturesInit();
		$('#example').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers"
		} );


	} );
</script>


<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("td");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#example").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});

});

</script>

<!-- jQuery for sorting & pagination ENDS here -->	
	
<Script language="JavaScript">
	function selectAll()
	{
		var len=document.myForm.CheckBox1.length;
		if(document.myForm.select.checked)
		{
			document.myForm.CheckBox1.checked=true
		}
		else
		{
			document.myForm.CheckBox1.checked=false
		}
		for(i=0;i<len;i++)
		{
			if(document.myForm.select.checked)
			{
				document.myForm.CheckBox1[i].checked=true
			}
			else
			{
				document.myForm.CheckBox1[i].checked=false
			}
		}
	}	
	function ezHref(event)
	{
		document.location.href = event;
	}
	function ezGetMessages(type,readFlag)
	{
		document.myForm.msgFlag.value=type
		document.myForm.type.value=readFlag
		document.myForm.action="ezListPersMsgsMain.jsp"
		document.myForm.submit()
	
	}
	function setActionDelete() 
	{
	     if(confirm("Do you want to delete?"))
	     {
		document.myForm.DelFlag.value = 'Y';
		document.myForm.type.value='<%=type%>'
		document.myForm.submit()
	     }
	     else
	     {
		  document.returnValue= false;
	     }
	}	
</Script>




<br>
<form name=myForm method=post action="ezDelPersMsgs.jsp">
<input type="hidden" name="FolderID" value=<%=folderID%> >
<input type="hidden" name="FolderName" value=<%=folderName%>>
<input type="hidden" name="type" value=<%=type%>>
<input type="hidden" name="DelFlag" value="N">
<input type="hidden" name="msgFlag">
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main ">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<%
	String displayMsg ="Un-Read"; 
	if("allmess".equals(type))displayMsg = "Read";
%>	
<div class="block" style="padding-left: 0px; width:100%;">
	<div class="block-title">
		<strong>
			<span><%=displayMsg%></span>
		</strong>
	</div>
</div>
<%
	int count=0;
	String field="else";
	String tes="yes";
	SimpleDateFormat sdf=new SimpleDateFormat("dd.MM.yyyy");
	String statusbar =  "onMouseover=\";window.status=\' \'; return true\" onClick=\";window.status=\' \'; return true\"";

	if((type.equals("all")) && (retMsgList.getRowCount()==0))
	{
%>
		<h2>No Messages in <%=folderName%>.</h2>

<%
	}
	else
	{
		if((type.equals("newmess")) && (retMsgList.getRowCount()==0))
		{
%>			
			<h2>No Messages in <%=folderName%>.</h2>
			<!--<Table  width=95%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Td>
					<Table width="100%" border=0 cellPadding=0 cellSpacing=0>
					<Tr>
						<Th valign="top" align="center" colspan=4>
							<font size="2" ><b>MESSAGES IN &nbsp;&nbsp;<%=folderName.toUpperCase()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>
						</Th>
					    </Tr>
					<Tr>
						<Td align="center"><a href="ezListPersMsgs.jsp?type=allmess&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  style="text-decoration:none" style="cursor:hand" title="all messages" <%=statusbar%>><b>All Messages &nbsp;</b></a></Td>
						<Td align="center"><a href="ezListPersMsgs.jsp?type=newmess&msgFlag=1&FolderName=<%=folderName%>&FolderID=<%=folderID%>"  title="new messages" style="text-decoration:none" <%=statusbar%>><b>New Messages</b></a></Td>
					</Tr>
					</Table>
				</Td>
			</Tr>
			</Table>
			<Table  width=95% valign=center height=40% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
			<Tr>
				<Td align=center>
					No New Messages
				</Td>
				
			</Tr>
			</Table>-->
<%	        }
		else
        	{
			if((retMsgList.getRowCount()>0))
			{
%>				
				<div class="col1-set">
				<div class="info-box"><br>
				<!--<p>
					<a href="javascript:void(0)"><span>Back </span></a>
					&nbsp;&nbsp;&nbsp;<a href="javascript:setActionDelete()"><span>Delete</span></a>
						
				</p>-->
				<table class="data-table" id="example">
				<thead>
    				<Tr align="center">
				      	<Th width="5%" align='center'><input type="checkbox" name="select" onClick="selectAll()"></Th>
	      				<Th width="5%">&nbsp;</Th>
	      				<Th width="20%">From </Th>
	      				<Th width="60%"> Subject </Th>
     	        			<Th width="10%">Date</Th>
				</Tr>
				</thead>
			
				<tbody>
<%				int mm=0;
				String tem="";
				String msgDate="";
			        if(type.equals("all"))
			        {
					tem="empty";
					for(int i = 0;i < retMsgList.getRowCount();i++)
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
						<Td width="10%" align="center"><input type="checkbox" name= "CheckBox1" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>" ></Td>
						<Td width="5%">
<%		
						if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
						{
%>
							<img src = "../../Images/Body/new.jpg" title="new" border=none> 
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
					<Td width="30%" align="left"><a style="text:decoration:none" href="ezPersMsgDetailsMain.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>" <%=statusbar%>><%=finalname%></Td>
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
						&nbsp;<%=FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))) %>&nbsp;&nbsp;<%=retMsgList.getFieldValue(i,"EPM_CREATION_TIME")%>
						</Td>
						
					</Tr>
<%
				}//End for
        		}
			if(type.equals("allmess"))
			{
				for (int i = 0 ; i < retMsgList.getRowCount(); i++)
				{
					if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
					{
						continue;
					}
					else
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
%>
						<Tr align="center">
							<Td width="5%"><input type="checkbox" name= "CheckBox1" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>"></Td>
							<Td width="5%">
<%
						if((retMsgList.getFieldValueString(i,NEW_MSG_FLAG)).equals("N"))
						{
%>
							<img src = "../../Images/Body/new.jpg"  title="new" border=none>
						
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
			      	       		<Td width="20%" align="left"><a style="text:decoration:none" href="ezPersMsgDetailsMain.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>&msgType=allmess" <%=statusbar%>><%=finalname%></Td>
			              		<Td width="60%" align="left">&nbsp;
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
				 	       <Td width="10%">&nbsp;
				 	       <%if(FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))!=null){%>
					        	<%=FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))) %>&nbsp;&nbsp;<%=retMsgList.getFieldValue(i,"EPM_CREATION_TIME")%>
					        <%}%>
					        </Td>
			    			</Tr>
<%	
					}
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
									<Td width="5%" align="center"><input type="checkbox" name= "CheckBox1" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>"></Td>
      									<Td width="5%"><img src = "../../Images/Body/new.jpg"  title="new" border=none></Td>
      	        							<Td width="20%" align="left"><a style="text:decoration:none" href="ezPersMsgDetailsMain.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>&msgType=newmess" <%=statusbar%>><%=finalname%></Td>
               								<Td width="60%" align="left">&nbsp;
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
	       						<Td width="10%">&nbsp;
	       							<%if(FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))!=null){%>
					        			<%=FormatDate.getStringFromDate((Date)retMsgList.getFieldValue(i,MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))) %>&nbsp;&nbsp;<%=retMsgList.getFieldValue(i,"EPM_CREATION_TIME")%>
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
		</tbody>
	</table>
	<!--<p>
			<a href="javascript:void(0)"><span>Back </span></a>
			&nbsp;&nbsp;&nbsp;<a href="javascript:setActionDelete()"><span>Delete</span></a>
			
				
	</p>-->
	<br>
	<div id="divAction" style="display:block">
		
		<button type="button" title="Delete Template" class="button" onclick="javascript:setActionDelete()">
		<span>Delete</span></button>			
	</div>	
</div>
</div>

<%
		}else
		{
			if((retMsgList.getRowCount()==0) && (!type.equals("newmess"))&& (!type.equals("all")))
			{
%>
			<!--<div class="col1-set">
			<div class="info-box"><br>
				<table class="data-table" >
			<Tr>
				<Td align=center >No Messages in <%=folderName.toUpperCase()%>.</Td>
			</Tr>
			</table>
			<p><a href="javascript:void(0)"><span>Back </span></a></p>
			</div>
			</div>-->
			<h2>No Messages in <%=folderName%>.</h2>
<%
			}
		}
	}
%>
	</div>
	</div>
</div>
<%
}
%>

<%@ include file="../Misc/ezAddMessage.jsp" %>

<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
		<div class="block-title">
			<strong><span>Messages</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<li><a href="javascript:ezGetMessages('1','newmess')">Un-Read</a></li>
			<li><a href="javascript:ezGetMessages('0','allmess')">Read</a></li>
			
			</ul>
		</div>
	</div>
</div>
</div>
</div>
</form>