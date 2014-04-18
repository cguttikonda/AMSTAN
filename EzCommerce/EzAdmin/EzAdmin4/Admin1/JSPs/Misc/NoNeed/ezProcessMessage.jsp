<%@ include file="../../../Includes/JSPs/Misc/iProcessMessage.jsp"%>
<%
	String client = null;
	String msgId = null;
	String checkIfSelected = null;
	String totCount = request.getParameter ("TotalCount");
	if ( totCount != null ){
	int iCount = Integer.parseInt (totCount);

		for ( int i = 0 ; i < iCount ; i++ ){  
			client = request.getParameter ("ClientID_" + i);
			msgId = request.getParameter ("MessageID_" + i);
			checkIfSelected = request.getParameter ("ToBeProcessMsg_" + i);
			if(checkIfSelected!=null)
			{
				// Process the Message	

				ezRmi.processMessage(null,client,msgId);
			}
		}
	}else{
		out.println ("Please select the Messages for Processing ..... ");
	}
	response.sendRedirect("../TransMsg/ezListToBeTransMsgs.jsp");	
%>


