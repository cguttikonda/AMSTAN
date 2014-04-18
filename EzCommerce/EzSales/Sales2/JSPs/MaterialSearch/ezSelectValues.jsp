<%--
      Copyright Notice =====================================*
    * This file contains proprietary information of Answerthink Inc.
    * Copying or reproduction without prior written approval is prohibited.
    * Copyright (c) 2005 ===================================*
--%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%//@ include file="../../../Includes/JSPs/MaterialSearch/iSearchMaterials.jsp"%>
<%
	String classChar	= request.getParameter("classChar");
	String rowNum 		= request.getParameter("rowNum");
	String selValue 	= request.getParameter("selValue");
	
	int retClassValuesCount = 0;
	ezc.ezparam.ReturnObjFromRetrieve retClassValues =(ezc.ezparam.ReturnObjFromRetrieve)session.getValue("retClassValues");
	if(retClassValues!=null) retClassValuesCount =retClassValues.getRowCount();
	//out.println(retClassValuesCount);
	java.util.Vector selVector = new java.util.Vector();
	if(selValue!=null)
	{
	 	StringTokenizer  st =new StringTokenizer(selValue,"¥");
	 	while(st.hasMoreElements())
	 	{
	 		selVector.addElement((String)st.nextToken());
	 	}
	}
%>
<Html>
<Head>
<Title>Select Values ...</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	   var tabHeadWidth=85
 	   var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Head>
<Script>
function checkAll(myChkObj)
{
	var myObj=document.myForm.classValue;
	var len=myObj.length;
	var stat=myChkObj.checked;
	if(isNaN(len)){
		myObj.checked=stat;
	}else{
		for(i=0;i<len;i++)
		myObj[i].checked=stat;
	}
	
}
function funSubmit()
{
		var selectedString = '';
		if(document.myForm.classValue)
		{
			if(document.myForm.classValue.length>0)
			{
				var chkFlag = false;
				for(var i=0;i<document.myForm.classValue.length;i++)
				{
					if(document.myForm.classValue[i].checked)
					{
						selectedString	+= document.myForm.classValue[i].value+'¥';
						chkFlag = true;
					}
					
				}
				if(chkFlag) selectedString = selectedString.substring(0,selectedString.length-1);
			}else
			{
				if(document.myForm.classValue.checked)
				{
					selectedString	+= document.myForm.classValue.value;
					chkFlag = true;
				}
			}
		}
		var textareaObj = parent.opener.document.myForm.classValueArea
		var hiddenObj   = parent.opener.document.myForm.selectedValues
		if(hiddenObj!=null)
		{
			if(hiddenObj.length>0)
			{
				hiddenObj[<%=rowNum%>].value=selectedString;
				selectedString = selectedString.replace('¥','\n')
				splitStr =    selectedString.split("¥");
				var retString ='';
				for(var i=0; i<splitStr.length; i++)
				{
					retString += splitStr[i]+'\n';
				}
				textareaObj[<%=rowNum%>].value=retString;
			}else
			{
				hiddenObj.value=selectedString;
				selectedString = selectedString.replace('¥','\n')
				textareaObj.value=selectedString;
			}
		
		}
		if(chkFlag)
		{
			window.close();
		}else
		{
			var a= confirm("Charactor Values Not selected");
			if(a) window.close();
		}
}

</Script>

<Body onLoad="scrollInit('10');" scroll=no onresize="scrollInit()">
<Form method="post"  name="myForm">
<% 
	String tempNAME1_CHAR="";
	String tempCHAR_VALUE="";
%>	
	<input type=hidden Name= classCharacter value='<%=classChar%>'>
	
<%	
if((classChar != null) && (retClassValuesCount>0))
{

%>

	<Div id="theads">
		<Table  width="85%" align=center id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="25%" ><input type="checkbox" name="chkAll" onClick="checkAll(this);"></th>
			<Th width="75%" >Class Values</th>
		</Tr>	

<%
		String checkString="";
		for(int i=0; i<retClassValuesCount; i++)
		{
			checkString ="";
			tempNAME1_CHAR = retClassValues.getFieldValueString(i,"NAME_CHAR");
			tempCHAR_VALUE = retClassValues.getFieldValueString(i,"CHAR_VALUE");
			//out.println(tempNAME1_CHAR+":"+tempCHAR_VALUE+"@");
			if(selVector.contains(tempCHAR_VALUE)) checkString="Checked=true";
			//if("".equals(tempCHAR_VALUE)) tempCHAR_VALUE = "&nbsp;";
			if(classChar.equals(tempNAME1_CHAR))
			{
%>				<Tr>
					<Td width=25% align = center><input type =checkbox name ='classValue' value ='<%=tempCHAR_VALUE %>' <%=checkString%>></Td>
					<Td width=75% ><%=tempCHAR_VALUE %> &nbsp;<Td>
				</Tr>
<%			
			}
		}
%>
		</Table>
		</Div>
<%
}else{
%>
		<Table align=center>
			<Tr>
				<Td class=displayalert>
					No Class Values Exists
				</Td>
			</Tr>	
		</Table>
<%
}	
%>		
	<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
<!--	<Table width="100%" align="center">
	<Tr>
	<Td class="blankcell"  align="center"><a href="JavaScript:funSubmit()"><Img  src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border="none" title="click here To get Materials" alt="click here To get Materials" ></a></Td>	
		</Tr>
	</Table> -->
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Ok");
	buttonMethod.add("funSubmit()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>	
	</Div>
</Form>
</Body>
</Html>

