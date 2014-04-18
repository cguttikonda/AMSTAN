<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<%!
	public String checkNULL(String str)
	{
		if(str==null || "null".equals(str) || "".equals(str))
			str = "";
		else
		{
			str = str.replaceAll("\"","`");
			str = str.trim();
		}	
			
		return str;	
	}
%>
<%
	ReturnObjFromRetrieve retMfr=null;
	int retMfrCnt = 0;
	String mfrStr = request.getParameter("mfrStr");
	String selSearch = request.getParameter("selSearch");

	if(mfrStr!=null && !"null".equals(mfrStr) && !"".equals(mfrStr))
	{
		String subQuery = "and cds_Vocez.Text like '%"+mfrStr+"%' order by cds_Vocez.Text";
		
		if(selSearch!=null && "manfID".equals(selSearch))
		{
			subQuery = "and cds_Prod.MfID like '%"+mfrStr+"%' order by cds_Vocez.Text";
		}
		
		EzcParams ezcpparams = new EzcParams(false);
		EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
		cnetParams.setStatus("GET_PRDS_MFR");
		cnetParams.setQuery(subQuery);
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);

		retMfr = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(ezcpparams);
		if(retMfr!=null)
			retMfrCnt = retMfr.getRowCount();

		//out.println("retMfr>>>>"+retMfr.toEzcString());
	}
	else
	{
		mfrStr = "";
	}
%>
<Html>
<Head>
<Title>Select Manufacturer</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=80
	var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
	function funSelect()
	{
		var len = document.myForm.rdManfId.length;
		var cnt = 0;
		var chkManf = "";

		if(isNaN(len))
		{
			if(document.myForm.rdManfId.checked)
			{
				chkManf = document.myForm.rdManfId.value
				selManf(chkManf)
				cnt++
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.rdManfId[i].checked)
				{
					chkManf = document.myForm.rdManfId[i].value
					selManf(chkManf)
					cnt++
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please select a Manfacturer");
			return
		}
		else
		{
			parent.opener.document.myForm.action="ezCreateDiscount.jsp"
			parent.opener.document.myForm.submit()
			window.close();
		}
	}
	function selManf(val)
	{
		var parLenObj = parent.opener.document.myForm;
		var manfVal = val;
		
		var manfId = manfVal.split("¤")[0];
		var manfDesc = manfVal.split("¤")[1];
		
		parLenObj.manfId.value=manfId;
		parLenObj.mfr.value=manfDesc;
	}
	function mfrSearch()
	{
		var mfr = document.myForm.mfrStr.value;
		
		if(funTrim(mfr)=='')
		{
			alert("Please enter Manf. Desc.");
			document.myForm.mfrStr.focus();
			return;
		}
		else
		{
			document.myForm.target="_self";
			document.myForm.action="ezSelectManufacture.jsp";
			document.myForm.submit();
		}
	}
</Script>
</head>
<Body  onLoad="scrollInit('10');document.myForm.mfrStr.focus()" onResize="scrollInit('10')" scroll="no">
<Form name=myForm method=post >
<br>
<%
	String chkID = "",chkDesc = "checked";
	
	if(selSearch!=null && "manfID".equals(selSearch))
	{
		chkID = "checked";
		chkDesc = "";
	}
%>
	<Div align=center>
	<Table  width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th width="100%" align="center" colspan=4>Enter Manfacturer Details</Th>
		</Tr>
		<Tr>
			<Th width="25%"><input type="radio" name="selSearch" value="manfID" <%=chkID%>>ID</Th>
			<Th width="25%"><input type="radio" name="selSearch" value="manfDesc" <%=chkDesc%>>Description</Th>
			<Td width="40%"><input type = "text" class = "InputBoxTest" name = "mfrStr" size = 20 value="<%=mfrStr%>"></Td>
			<Td width="10%">
<%
			buttonName.add("Go");
			buttonMethod.add("mfrSearch()");

			out.println(getButtonStr(buttonName,buttonMethod));
%>
			</Td>
		</Tr>
	</Table>
	<br>
<%
	if(retMfrCnt>0)
	{
%>
	<div id="theads">
	<Table width="80%" id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#006666" cellPadding=5 cellSpacing=1>
	<Tr>
		<Th align="center" valign="middle" width="10%">&nbsp;</Th>
		<Th align="center" valign="middle" width="40%">Manufacture ID</Th>
		<Th align="center" valign="middle" width="50%">Manufacture Desc.</Th>
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:45%">
	<Table width="100%" id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
		retMfr.sort(new String[]{"Text"},true);
		for(int i=0;i<retMfrCnt;i++)
		{
			String mfrID 	= checkNULL(retMfr.getFieldValueString(i,"MfID"));
			String mfrDesc	= checkNULL(retMfr.getFieldValueString(i,"Text"));
			String splitStr = mfrID+"¤"+mfrDesc;
%>
		<Tr>
			<Td align="center" valign="top" width="10%"><input type="radio" name="rdManfId" value="<%=splitStr%>"></Td>
			<Td align="center" valign="top" width="40%">&nbsp;<%=mfrID%></Td>
			<Td align="left" valign="top" width="50%">&nbsp;<%=mfrDesc%></Td>
		</Tr>
<%
		}
%>
	</Table>
	</div>
<%
	}
	else if(retMfr!=null && retMfrCnt==0)
	{
%>
	<br><br><br>
	<Table   width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
		<Th>No Manufacture found for given Description</Th>
	</Tr>
	</Table>
<%
	}
	else
	{
%>
	<br><br><br>
	<Table   width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
		<Th>Enter Manufacture Details and Click on Go Button</Th>
	</Tr>
	</Table>
<%
	}
%>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if(retMfrCnt>0)
	{
	buttonName.add("Select");
	buttonMethod.add("funSelect()");
	}
	buttonName.add("Close");
	buttonMethod.add("window.close()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</Div>
</Form>
</Body>
</Html>