<form name="ordLMenuForm" id="ordLMenuForm" method="post">
<Script src="../../Library/Script/popup.js"></Script>
<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
<%
		String pageNmae = request.getServletPath();
		String rTypeLMenu = request.getParameter("rType");
		if (rTypeLMenu == null){
			rTypeLMenu = "CR";
		} else if (rTypeLMenu.indexOf("RGA")!=-1){
			rTypeLMenu = "RGA";
		} else {
			rTypeLMenu = "CR";
		}	
		
		if(pageNmae!=null)
		{
			pageNmae = pageNmae.substring((pageNmae.lastIndexOf('/'))+1,pageNmae.length());

		}
		//out.println("pageNmae:::::"+pageNmae);
		//out.println("negotiateType::::::"+request.getParameter("negotiateType"));
		
		/****************** Individual DOC COUNTS FROM iWelcomeAlerts.jsp *************/
		String focCnt = "";
		//String focAccCnt = "";
		String negoCnt_CM="";
		String negoCnt_CU="";
		String saveCnt = "";
		String cancelCnt_CM = "";
		String cancelCnt_CU = "";
		String RejectCnt_CU = "";
		String RgaCnt_CM = "";
		String RgaCnt_CU = "";
		String RgaRejectCnt_CU = "";
		String RgaCntASB_CU = "";
		String RgaCntCust_CM = "";
		String canCnt_CM = "";
		String inqCnt_CU = "";
		
		//out.println(session.getValue("SAVEDCNT"));
		if(!"null".equals((String)session.getValue("FOCAPPRCNT")) && session.getValue("FOCAPPRCNT")!=null)
			focCnt = " ["+(String)session.getValue("FOCAPPRCNT")+"]";
		if(!"null".equals((String)session.getValue("SAVEDCNT")) && session.getValue("SAVEDCNT")!=null)
			saveCnt = " ["+(String)session.getValue("SAVEDCNT")+"]";		

		/*if(!"null".equals((String)session.getValue("FOCACCCNT")) && session.getValue("FOCACCCNT")!=null)
			focAccCnt = " ["+(String)session.getValue("FOCACCCNT")+"]";*/	
		if(!"null".equals((String)session.getValue("ASBINQCNTCU")) && session.getValue("ASBINQCNTCU")!=null)
			negoCnt_CU = " ["+(String)session.getValue("ASBINQCNTCU")+"]";
		if(!"null".equals((String)session.getValue("CANCELREQ_CU")) && session.getValue("CANCELREQ_CU")!=null)
			cancelCnt_CU = " ["+(String)session.getValue("CANCELREQ_CU")+"]";
		if(!"null".equals((String)session.getValue("REJECTREQ_CU")) && session.getValue("REJECTREQ_CU")!=null)
			RejectCnt_CU = " ["+(String)session.getValue("REJECTREQ_CU")+"]";
		if(!"null".equals((String)session.getValue("RGAREQ_CU")) && session.getValue("RGAREQ_CU")!=null)
			RgaCnt_CU = " ["+(String)session.getValue("RGAREQ_CU")+"]";
		if(!"null".equals((String)session.getValue("REJECTRGAREQ_CU")) && session.getValue("REJECTRGAREQ_CU")!=null)
			RgaRejectCnt_CU = " ["+(String)session.getValue("REJECTRGAREQ_CU")+"]";	
		if(!"null".equals((String)session.getValue("RGAREQASB_CU")) && session.getValue("RGAREQASB_CU")!=null)
			RgaCntASB_CU = " ["+(String)session.getValue("RGAREQASB_CU")+"]";
		if(!"null".equals((String)session.getValue("INQCNTCU")) && session.getValue("INQCNTCU")!=null)
			inqCnt_CU = " ["+(String)session.getValue("INQCNTCU")+"]";
			
		if(!"null".equals((String)session.getValue("NEGCNT_CM")) && session.getValue("NEGCNT_CM")!=null)
			negoCnt_CM = " ["+(String)session.getValue("NEGCNT_CM")+"]";
		if(!"null".equals((String)session.getValue("CANCELREQ_CM")) && session.getValue("CANCELREQ_CM")!=null)
			cancelCnt_CM = " ["+(String)session.getValue("CANCELREQ_CM")+"]";				
		if(!"null".equals((String)session.getValue("RGAREQ_CM")) && session.getValue("RGAREQ_CM")!=null)
			RgaCnt_CM = " ["+(String)session.getValue("RGAREQ_CM")+"]";				
		if(!"null".equals((String)session.getValue("RGAREQCNT_CM")) && session.getValue("RGAREQCNT_CM")!=null)
			RgaCntCust_CM = " ["+(String)session.getValue("RGAREQCNT_CM")+"]";
		if(!"null".equals((String)session.getValue("CANCELREQAP_CM")) && session.getValue("CANCELREQAP_CM")!=null)
			canCnt_CM = " ["+(String)session.getValue("CANCELREQAP_CM")+"]";

		/****************** Individual DOC COUNTS FROM iWelcomeAlerts.jsp *************/			
		ezc.record.util.EzOrderedDictionary userAuth_Menu = Session.getUserAuth();
		
		if(!"CU".equals(userRole) || userAuth_Menu.containsKey("FOC_ORDER") )
		{
%>
		<div class="block-title">
			<strong><span>FD and Ops Mgr</span></strong>
		</div>
		<ul>
<%
			if("ezOrdersForApproval.jsp".equals(pageNmae) && "FORAPPROVAL".equals(request.getParameter("negotiateType")))
			{
%>			
				<div class="orderDBleftMenu">
					<strong><span>For Approval<%=focCnt%></span></strong>
				</div>
<%
			}else{
%>			
				<li><a href="javascript:funClick('../Sales/ezOrdersForApproval.jsp?negotiateType=FORAPPROVAL&ORDERTYPE=A')">For Approval<%=focCnt%></a></li>
				
<%
			}if("ezOrdersForApproval.jsp".equals(pageNmae) && ("ALL".equals(request.getParameter("negotiateType")) || "FOCAPPROVED".equals(request.getParameter("negotiateType")) ||"FOCREJECTED".equals(request.getParameter("negotiateType")) ))
			{
%>			
				<div class="orderDBleftMenu">
					<strong><span>Approved/ Rejected </span></strong>
				</div>
<%
			}else{
%>			
				<li><a href="javascript:funClick('../Sales/ezOrdersForApproval.jsp?negotiateType=ALL&ORDERTYPE=A')">Approved/ Rejected</a></li>
<%
			}
%>			
		</ul>	
		<br>
<%		
		}
		if("CU".equals(userRole))
		{
%>
			<div class="block-title">
				<strong><span>Inquiries</span></strong>
			</div>
			<ul>
<%
			if("ezNegotiatedOrders.jsp".equals(pageNmae) && "INPROCESS".equals(request.getParameter("negotiateType")))
			{
%>
				<div class="orderDBleftMenu">
					<strong><span>In ASB Queue<%=negoCnt_CU%></span></strong>
				</div>
<%
			}else{
%>				
				<li><a href="javascript:funClick('ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N')">ASB Queue<%=negoCnt_CU%></a></li>
<%
			}
			if("ezNegotiatedOrders.jsp".equals(pageNmae) && "ACCEPTED".equals(request.getParameter("negotiateType")))	
			{
%>
				<div class="orderDBleftMenu">
					<strong><span>Customer Queue <%=inqCnt_CU%></span></strong>
				</div>
<%
			}else{	
%>	
				<li><a href="javascript:funClick('ezNegotiatedOrders.jsp?negotiateType=ACCEPTED&ORDERTYPE=N')">Customer Queue <%=inqCnt_CU%></a></li>
<%
			}
			if("ezNegotiatedOrders.jsp".equals(pageNmae) && "CLOSED".equals(request.getParameter("negotiateType")))
			{
%>
				<div class="orderDBleftMenu">
					<strong><span>Closed </span></strong>
				</div>
<%
			}else{
%>
				<li><a href="javascript:funClick('ezNegotiatedOrders.jsp?negotiateType=CLOSED&ORDERTYPE=N')">Closed </a></li>
<%
			}
%>
			</ul>	
			<br>
			
			<div class="block-title">
				<strong><span>Submitted Orders</span></strong>
			</div>	
			<ul>
<%
			if("ezSalesOrders.jsp".equals(pageNmae))	
			{
%>	
				<div class="orderDBleftMenu">
					<strong><span>Open </span></strong>
				</div>	
<%
			}else{
%>
				<li><a href="javascript:funClick('ezSalesOrders.jsp')">Open</a></li>
<%
			}if("ezClosedSalesOrders.jsp".equals(pageNmae))		
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Closed </span></strong>
				</div>		
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezClosedSalesOrders.jsp')">Closed </a></li>
<%
			}
%>		
			</ul>
			<br>
			
			<div class="block-title">
				<strong><span>Cancellations</span></strong>
			</div>
			<ul>
<%
			if("ezCancellationRequestsMain.jsp".equals(pageNmae) && !rTypeLMenu.equals("RGA"))	
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>ASB Queue<%=cancelCnt_CM%></span></strong>
				</div>	
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezCancellationRequestsMain.jsp?rType=PCR')">ASB Queue<%=cancelCnt_CM%></a></li>
<%
			}if("ezProcessedRequestsMain.jsp".equals(pageNmae) && !rTypeLMenu.equals("RGA"))
			{
%>
				<div class="orderDBleftMenu">
					<strong><span>Approved</span></strong>
					<!--<strong><span>Approved<%=cancelCnt_CU%></span></strong>-->
				</div>
<%
			}else{	
%>		
				<li><a href="javascript:funClick('ezProcessedRequestsMain.jsp?rType=ACR')">Approved</a></li>
				<!--<li><a href="javascript:funClick('ezProcessedRequestsMain.jsp?rType=ACR')">Approved<%=cancelCnt_CU%></a></li>-->
<%
			}
			if("ezRejectedRequestsMain.jsp".equals(pageNmae) && !rTypeLMenu.equals("RGA"))
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Rejected</span></strong>
				</div>
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezRejectedRequestsMain.jsp?rType=RCR')">Rejected</a></li>
<%
			}
%>		
			</ul>
			<br>
			<div class="block-title">
				<strong><span>RGA Requests</span></strong>
			</div>
			<ul>
<%
			if("ezCancellationRequestsMain.jsp".equals(pageNmae) && rTypeLMenu.equals("RGA"))	
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>ASB Queue<%=RgaCntASB_CU%></span></strong>				
				</div>	
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezCancellationRequestsMain.jsp?rType=RGA')">ASB Queue<%=RgaCntASB_CU%></a></li>
<%		
			}
			if("ezProcessedRequestsMain.jsp".equals(pageNmae) && rTypeLMenu.equals("RGA"))
			{
%>
				<div class="orderDBleftMenu">
					<strong><span>Customer Queue<%=RgaCnt_CU%></span></strong>
				</div>
<%
			}else{	
%>		
				<li><a href="javascript:funClick('ezProcessedRequestsMain.jsp?rType=RGA')">Customer Queue<%=RgaCnt_CU%></a></li>
<%
			}
			if("ezRejectedRequestsMain.jsp".equals(pageNmae) && rTypeLMenu.equals("RGA"))
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Closed</span></strong>
				</div>
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezRejectedRequestsMain.jsp?rType=RGA')">Closed</a></li>
<%
			}
%>
			</ul>
			<br>
			<div class="block-title">
				<strong><span>Saved Orders</span></strong>
			</div>
			<ul>
<%
			if("ezSavedOrders.jsp".equals(pageNmae))	
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Saved Orders<%=saveCnt%></span></strong>
				</div>	
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezSavedOrders.jsp')">Saved Orders<%=saveCnt%></a></li>
<%
			}
%>
			</ul>	
			<br>
<%
		}
		else
		{
%>
			<div class="block-title">
				<strong><span>Inquiries</span></strong>
			</div>
			<ul>
<%
				if("ezNegotiatedOrders.jsp".equals(pageNmae) && "INPROCESS".equals(request.getParameter("negotiateType")))
				{
%>
					<div class="orderDBleftMenu">
						<strong><span>In ASB Queue<%=negoCnt_CM%></span></strong>
					</div>
<%
				}else{
%>	
					<li><a href="javascript:funClick('ezNegotiatedOrders.jsp?negotiateType=INPROCESS&ORDERTYPE=N')">ASB Queue<%=negoCnt_CM%></a></li>
<%
				}
				if("ezNegotiatedOrders.jsp".equals(pageNmae) && "ACCEPTED".equals(request.getParameter("negotiateType")))	
				{
%>
					<div class="orderDBleftMenu">
						<strong><span>Customer Queue</span></strong>
					</div>
<%
				}else{	
%>
					<li><a href="javascript:funClick('ezNegotiatedOrders.jsp?negotiateType=ACCEPTED&ORDERTYPE=N')">Customer Queue</a></li>
<%
				}
				if("ezNegotiatedOrders.jsp".equals(pageNmae) && "CLOSED".equals(request.getParameter("negotiateType")))
				{
%>
					<div class="orderDBleftMenu">
						<strong><span>Closed </span></strong>
					</div>
<%
				}else{
%>
					<li><a href="javascript:funClick('ezNegotiatedOrders.jsp?negotiateType=CLOSED&ORDERTYPE=N')">Closed </a></li>
<%
				}
%>
			</ul>	
			<br>
		
			<div class="block-title">
				<strong><span>Submitted Orders</span></strong>
			</div>	
			<ul>
<%
			if("ezSalesOrders.jsp".equals(pageNmae))	
			{
%>	
				<div class="orderDBleftMenu">
					<strong><span>Open </span></strong>
				</div>	
<%
			}else{
%>
				<li><a href="javascript:funClick('ezSalesOrders.jsp')">Open</a></li>
<%
			}if("ezClosedSalesOrders.jsp".equals(pageNmae))		
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Closed </span></strong>
				</div>		
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezClosedSalesOrders.jsp')">Closed </a></li>
<%
			}
%>		
			</ul>
			<br>

			<div class="block-title">
				<strong><span>Cancellations</span></strong>
			</div>
			<ul>
<%
			if("ezCancellationRequestsMain.jsp".equals(pageNmae) && !rTypeLMenu.equals("RGA"))	
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>ASB Queue<%=cancelCnt_CM%></span></strong>
				</div>	
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezCancellationRequestsMain.jsp?rType=PCR')">ASB Queue<%=cancelCnt_CM%></a></li>
<%
			}if("ezProcessedRequestsMain.jsp".equals(pageNmae) && !rTypeLMenu.equals("RGA"))
			{
%>
				<div class="orderDBleftMenu">
					<strong><span>Approved</span></strong>
					<!--<strong><span>Approved<%=canCnt_CM%></span></strong>-->
				</div>
<%
			}else{	
%>		
				<li><a href="javascript:funClick('ezProcessedRequestsMain.jsp?rType=ACR')">Approved</a></li>
				<!--<li><a href="javascript:funClick('ezProcessedRequestsMain.jsp?rType=ACR')">Approved<%=canCnt_CM%></a></li>-->
<%
			}if("ezRejectedRequestsMain.jsp".equals(pageNmae) && !rTypeLMenu.equals("RGA"))
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Rejected<%=RejectCnt_CU%></span></strong>
				</div>
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezRejectedRequestsMain.jsp?rType=RCR')">Rejected<%=RejectCnt_CU%></a></li>
<%
			}
%>		
			</ul>
			<br>

			<div class="block-title">
				<strong><span>RGA Requests</span></strong>
			</div>
			<ul>
<%
			if("ezCancellationRequestsMain.jsp".equals(pageNmae) && rTypeLMenu.equals("RGA"))	
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>ASB Queue<%=RgaCntCust_CM%></span></strong>
				</div>	
<%
			}else{
%>
				<li><a href="javascript:funClick('ezCancellationRequestsMain.jsp?rType=RGA')">ASB Queue<%=RgaCntCust_CM%></a></li>
<%
			}if("ezProcessedRequestsMain.jsp".equals(pageNmae) && rTypeLMenu.equals("RGA"))
			{
%>
				<div class="orderDBleftMenu">
					<strong><span>Customer Queue<%=RgaCnt_CM%></span></strong>
				</div>
<%
			}else{	
%>
				<li><a href="javascript:funClick('ezProcessedRequestsMain.jsp?rType=RGA')">Customer Queue<%=RgaCnt_CM%></a></li>
<%
			}if("ezRejectedRequestsMain.jsp".equals(pageNmae) && rTypeLMenu.equals("RGA"))
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Closed<%=RgaRejectCnt_CU%></span></strong>
				</div>
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezRejectedRequestsMain.jsp?rType=RGA')">Closed<%=RgaRejectCnt_CU%></a></li>
<%
			}
%>
			</ul>
			<br>
			<div class="block-title">
				<strong><span>Saved Orders</span></strong>
			</div>
			<ul>
<%
			if("ezSavedOrders.jsp".equals(pageNmae))	
			{
%>		
				<div class="orderDBleftMenu">
					<strong><span>Saved Orders<%=saveCnt%></span></strong>
				</div>	
<%
			}else{
%>		
				<li><a href="javascript:funClick('ezSavedOrders.jsp')">Saved Orders<%=saveCnt%></a></li>
<%		
			}
%>
			</ul>	
			<br>
<%
		}
%>
</div>	
</div>	
</form>
<script>
function funClick(actionPage){
	Popup.showModal('headermodal');
	document.ordLMenuForm.action = actionPage;
	document.ordLMenuForm.submit();
}
</script>
<%
	request.getSession().removeAttribute("FOCAPPRCNT"); 
	request.getSession().removeAttribute("SAVEDCNT"); 
	request.getSession().removeAttribute("FOCACCCNT"); 
	request.getSession().removeAttribute("ASBINQCNTCU"); 
	request.getSession().removeAttribute("CANCELREQ_CU"); 
	request.getSession().removeAttribute("REJECTREQ_CU"); 
	request.getSession().removeAttribute("RGAREQ_CU"); 
	request.getSession().removeAttribute("REJECTRGAREQ_CU"); 
	request.getSession().removeAttribute("RGAREQASB_CU"); 
	request.getSession().removeAttribute("INQCNTCU"); 
	request.getSession().removeAttribute("NEGCNT_CM"); 
	request.getSession().removeAttribute("CANCELREQ_CM"); 
	request.getSession().removeAttribute("RGAREQ_CM"); 
	request.getSession().removeAttribute("RGAREQCNT_CM"); 
	request.getSession().removeAttribute("CANCELREQAP_CM"); 
%>