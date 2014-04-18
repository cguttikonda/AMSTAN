<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInbox.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import="java.util.*" %>
<%

        String msgId=request.getParameter("MessageID");
	String fold=request.getParameter("folder");
	System.out.println("the folder value is :"+fold);
	String FolderName= request.getParameter("FolderName");
        int msg1=Integer.parseInt(msgId);
        String subject=request.getParameter("Subject");

        ReturnObjFromRetrieve resDetails=null;
	ReturnObjFromRetrieve retMsgInfo = null;
	ReturnObjFromRetrieve retFoldList = null;

	String language = "EN";
	String client = "200";
        EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();	
		     
     	String folderID = request.getParameter("FolderID");
     	if(folderID == null)
     	{
     		folderID = "1000";
     	}
	     	// Set the Input Parameters
	     	ezcMessageParams.setMsgId(msgId);
	     	ezMessageParams.setClient(client);
	     	ezMessageParams.setLanguage(language);
	     	ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams); 

	     	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	     	retFoldList.check();
	     	
	     	String server = (String)session.getValue("SERVER");
		String protocol = (String)session.getValue("PROTOCOL");
		String mailUser = (String)session.getValue("USERID");
        	String mailPassword = (String)session.getValue("PASSWORD");

               ezc.ezmail.EzMail mail=new ezc.ezmail.EzMail();
               
               ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();

               mailParams.setHost(server);
               mailParams.setProtocol(protocol);
               if("IMAP".equals(protocol))
	               	mailParams.setPort("143");
	       else
	              	mailParams.setPort("110");
        	               
               mailParams.setUserId(mailUser);
               mailParams.setPassword(mailPassword);
               mailParams.setFolderName(fold);
              mailParams.setMessageId(""+msg1);
              

              retMsgInfo=mail.getMailDetails(mailParams);
               	Vector attachments=new Vector();
                       String flag=retMsgInfo.getFieldValueString(0,"ISATTACH");
                       if(flag.equals("Y"))
		       {
                          attachments=(Vector)retMsgInfo.getFieldValue(0,"ATTACHMENTS");
                       }
                       
		       String fileAttach="";
	     	
         		String from= retMsgInfo.getFieldValueString(0, "FROM");  
         		
         		if((from==null) || ("null".equals(from)))
         		{  
         		     from="----";
         		}
         		//String subject=(String)retMsgInfo.getFieldValueString(0, "SUBJECT");
         		
         		if(subject==null || ("null".equals(subject)))
         		{
         		   subject="----";
         		 }

                       Date d=(Date)retMsgInfo.getFieldValue(0,"DATE");
                       String dat="";
                       if(d!=null)
                       {
                           dat=(d.getMonth()+1)+"/"+d.getDate()+"/"+(d.getYear()+1900);
                       }
		     	String msg = (String)retMsgInfo.getFieldValueString(0, "CONTENT");
                        msg=msg.substring(msg.lastIndexOf("*")+1,msg.length());
		     	if(msg!=null)
		     	{
		     	   
		     	}
		     	else
		     	{
		     	      msg="";
		     	}
		     	
                       
%>


<html>
   <head>
        <Title>Inbox: Personal Message Details</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	
	<script src = "../../Library/JavaScript/Inbox/ezPersMsgDetails.js"></script>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="50%"
	</Script>
	<Script src="../../Library/JavaScript/ezSalesScroll.js"></Script>

	<body onLoad='scrollInit()' onResize='scrollInit()' bgcolor="#FFFFF7"  scroll=no>
	
	
<form name=myForm method=post action="ezDelPersMsgs.jsp">

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" width="40%">
<a style="text-decoration:none"  class=subclass href=" ../Misc/ezSBUWelcome.jsp" target="_top"><img src="../../Images/Buttons/<%= ButtonDir%>/home_button.gif" width="54" height="17"  title="Home" border=0  <%=statusbar%>  > </a>&nbsp; <a style="text-decoration:none"  class=subclass href="../Misc/ezLogout.jsp" target="_top"><img src="../../Images/Buttons/<%= ButtonDir%>/logout_butt.gif" width="65" height="17"   title="Logout"  <%=statusbar%> border=0></a></td>
    <td height="35" class="displayheader"  width="60%">Message Details</td>
</tr>
</table>	    
	        <div id="theads">
	        <Table  width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
    	           <Tr align="center" valign="middle" > 
      	               <Td width="25%" class="labelcell" align = right> From: </Td>
	       	       <Td width="75%" align="left"> 
        	           <input type="hidden" name="fromUser" value="<%=from%>"><%=from%>
	      	       </Td>
    	           </Tr>
    	           <Tr align="center" valign="middle"> 
    	  	        <Td width="25%" class="labelcell" align = right> Subject: </Td>
		        <Td width="75%" align="left"> 
	                   <input type="hidden" name="msgSubject"  value="<%=subject%>"><%=subject%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
                      
                     if(attachments.size() > 0)
		       {
		          
                         for(int i=0;i<attachments.size();i++)
                         
	 	         {
%>
                             <b><a href="ezDownLoad.jsp?MessageId=<%=msgId%>&FolderName=<%=fold%>&FileName=<%=attachments.elementAt(i)%>" style="text-decoration:none"><%=attachments.elementAt(i)%></a></b>
<%
                                 
		         }
                       }
                      
%>

                                  
	                   
        	        </Td>
     	           </Tr>
	           <Tr align="center" valign="middle" >
      	                <Td width="25%" class="labelcell" align = right>Date:</Td>
      	                <Td width="75%" align="left"><%=dat%>	</Td>
    	           </Tr>
                </Table>
                </div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:55%;left:2%">
		<table width=100%  id="InnerBox1Tab"><tr><td>
		
		       	            <%=msg%>
            	</td></tr></table>
              	</div>    	
 	   <div id="buttonDiv" align="center" style="position:absolute;top:90%;width:100%;">
		<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/reply.gif" name="Submit" value="Reply"  title="reply" onClick="setActionNew();return document.returnValue">
                <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  title="back" border=none  <%=statusbar%>  ></a>
   </div> 
	 
</form>
<Div id="MenuSol"></Div>
</body>
</html>

