<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListBlockedPO_Labels.jsp"%>
<%
	boolean hasReleaseAuth = false;
	if(session.getValue("USERAUTHS") != null)
	{
		java.util.Vector authVector = (java.util.Vector)session.getValue("USERAUTHS");
		if(authVector.contains("RELEASE_PO"))
		{
			hasReleaseAuth = true;
		}
		else
		{
			hasReleaseAuth = false;
		}
	}	
	else
	{
		hasReleaseAuth = false;
	}
	
	String userRole	= (String) session.getValue("USERROLE");	
%>
<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>


<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<Script>
	
	function doOnLoad()
	{
		
		var selAllChk;
		var headerFlds;
		
		var widths  = "10,30,25,25,10";
		var colTyps = "ro,ro,ro,ro,ro,ro";
		var aligns  = "center,center,center,center,center";
		var colSort = "str,str,date,date,str";
	
		selAllChk = "<input style='cursor:hand' type=checkbox name=checkAll onclick='selectCheckAll()'  alt='Select/Deselect All'>";
		headerFlds = selAllChk+",<%=poNo_L%>,Created on,<%=bloDate_L%>,<%=vend_L%>";
		
<%
		if("PH".equals(userRole) && "ALL".equals(request.getParameter("SHOW")) ){
%>
			headerFlds = selAllChk+",<%=poNo_L%>,Created on,Pur. Group,Comp.Code,<%=bloDate_L%>,<%=vend_L%>";		
			widths  = "10,20,15,15,15,15,10";
			aligns  = "center,center,center,center,center,center,center";
			colTyps = "ro,ro,ro,ro,ro,ro,ro";
			colSort = "str,str,date,str,str,date,str"
<%
		}
%>
	
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		//mygrid.setHeader("&nbsp,<%=poNo_L%>,<%=ordDate_L%>,<%=bloDate_L%>,<%=vend_L%>");
		mygrid.setHeader(headerFlds);
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP(widths)
		mygrid.setColAlign(aligns)
		mygrid.setColTypes(colTyps);
		mygrid.setColSorting(colSort)
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(50);
		mygrid.init();
		mygrid.loadXML("ezBlockedPosGrid.jsp?SHOW=<%=request.getParameter("SHOW")%>");
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>

<Script>
	var selBlockedPo_L = '<%=selBlockedPo_L%>'; 
	var releaseAuth = <%=hasReleaseAuth%>;
	function checkVal()
	{
		if(releaseAuth)
		{
			var reqData = "";
			var selectedLength = 0
			var checkObj = document.myForm.chk1
			if(checkObj != null)
			{
				var checkLength = checkObj.length;
				if(isNaN(checkLength))
				{
					if(document.myForm.chk1.checked)
					{
						reqData += document.myForm.chk1.value;
						selectedLength++;
					}
				}
				else
				{
					for(i=0;i<checkLength;i++)
					{
						if(document.myForm.chk1[i].checked)
						{
							reqData += document.myForm.chk1[i].value+"µ";
							selectedLength++;
						}
					}
				}	
			}
			if(selectedLength == 0)
			{
				alert(selBlockedPo_L)	
			}
			else
			{
				document.myForm.poData.value = reqData;
				setMessageVisible();
				document.myForm.action="ezReleasePurchaseOrder.jsp";
				document.myForm.submit();	
			}
		}	
		else
		{
			alert("You are not authorized for releasing the Purchase Order to the Vendor");
		}
	}
</Script>

</head>
<Body onLoad="doOnLoad();" scroll=no>
<Form name="myForm">
<input type="hidden" name ="chk1">
<input type="hidden" name=selAllImg value="0">
<%
	String display_header	= blockPo_L;
	String noDataStatement	= noBlockPoExist_L;
	if("ALL".equals(request.getParameter("SHOW")))
		display_header	= blockPo_L+" For All Vendors";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<%@ include file="../Misc/ezDisplayGrid.jsp" %>

	
	<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:hidden">
	<Center>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Back");
		buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

		buttonName.add("Release Order");
		buttonMethod.add("checkVal()");

		out.println(getButtonStr(buttonName,buttonMethod));	
	%>
	</Center>
	</Div>
	
	<%@ include file="../Misc/AddMessage.jsp" %>
<%@ include file="../Misc/backButton.jsp" %>
<input type=hidden name='poData'>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
