<%--
      Copyright Notice =====================================*
    * This file contains proprietary information of Answerthink Inc.
    * Copying or reproduction without prior written approval is prohibited.
    * Copyright (c) 2005 ===================================*
--%>

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/SessionBean.jsp"%>
<%//@ include file="../../../Includes/JSPs/MaterialSearch/iSearchMaterials.jsp"%>
<%@ include file="iStaticLogin.jsp"%>
<%@ include file="iSearchMaterials.jsp"%>
<Html>
<Head>
<Title>Search Materials ...</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	   var tabHeadWidth=85
 	   var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Misc/ezSalesScroll.js"></Script>
<Script>

	function onChangeClass()
	{
		if(document.myForm.classCharacter!=null)
		{
			document.myForm.classCharacter.options.selectedIndex=0;
			for(var x=document.myForm.classValue.length;x>=0;x--)
			{      
				document.myForm.classValue.options[x]=null;
			}
		}	
		document.myForm.action="ezSearchMaterials.jsp";
		document.myForm.submit();
	}
	
	function buildClassValue()
	{
		if(document.myForm.classCharacter!=null)
		{
		
			for(var x=document.myForm.classValue.length;x>=0;x--)
			{      
				document.myForm.classValue.options[x]=null;
			}
			var count=0; 

			for(var x=0;x<document.myForm.classCharacter.length;x++)
			{
				if(document.myForm.classCharacter.options[x].selected)
				{
					for(var y=0;y<myClassValues.length;y++)
					{
						if((document.myForm.classCharacter.options[x].value == myClassValues[y].character) && (myClassValues[y].value!=''))
						{
							document.myForm.classValue.options[count] = new Option(myClassValues[y].value,myClassValues[y].character+'¥'+myClassValues[y].value)
							count++;
						}	
					}	
				}	
			}
			if(count==0)
			{
				document.myForm.classValue.options[count] = new Option("No Values","");
			}else
			{
				for(var x=0;x<selClassValues.length;x++)
				{
				
					for(var y=0;y<document.myForm.classValue.length;y++)
					{
						if(document.myForm.classValue.options[y].value==selClassValues[x])
						{
							document.myForm.classValue.options[y].selected=true;
						}
					}	
				}
			}
		}
	}
	function funSubmit()
	{
		/*
		if(document.myForm.className.value=='')
		{
			alert("Please Select Product Class")
			return;
		}else if(document.myForm.classCharacter.value=='')
		{
			alert("Please Select Class Character")
			return;
		}
		else if(document.myForm.classValue.value=='')
		{
			alert("Please Select Different Class Character Because No Class Value ")
			return;
		}
		*/	
		document.myForm.action="ezSearchMaterialsList.jsp";
		document.myForm.submit();
		
	}
</Script>

<Head>
<Body onLoad="scrollInit('10');" scroll=no onresize="scrollInit()">
<Form method="post"  name="myForm">
<Div id =titleDiv>
<Table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
	<Tr>
		<Td height="35" class="displayheader" align="center" width="100%"> Materials Search </Td>
	</Tr>
</Table>
</Div>
<%
if(retClassListCount==0)
{
%>
	<BR><BR><BR>
	<Table align=center border="0" cellpadding="0"  cellspacing="0" width="100%">
		<Tr>
			<Td height="35" class="displayalert" align="center" width="100%">No Class Type Available</Td>
		</Tr>
	</Table>

<%
	return;
}
%>

<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="50%">
	<Tr>
		<Th width=50%> Class Type </Th>
		<Td width=50%>
			<Select name="className" onChange="onChangeClass()" style="width:100%">
			<option value='' >--Select the Class Type---</option>
<%
			String classNameTemp ="";
			for(int i=0; i<retClassListCount; i++)
			{
				classNameTemp = retClassList.getFieldValueString(i,"CLASSNAME");
				if(classNameTemp.equals(className))
		 		{
%>		 			<Option value='<%=classNameTemp%>' selected><%=retClassList.getFieldValueString(i,"DESCRIPTION")%></Option>
<% 				}
				else
				{
%>					<Option value='<%=classNameTemp%>'><%=retClassList.getFieldValueString(i,"DESCRIPTION")%></Option>
<%				}
			}
%>
			</Select>
		</Td>
	</Tr>
</Table>	
<%
	//out.println(retClassCharactersCount);
	if(retClassCharactersCount>0)	
	{
	
		//All display columns setting here
		java.util.Hashtable myValues	= new java.util.Hashtable();
		java.util.ArrayList dispColumns	= new ArrayList();
		java.util.ArrayList dispSizes  	= new java.util.ArrayList();
		java.util.ArrayList dispAlign  	= new java.util.ArrayList();
		dispColumns.add("CLASS_CHARACTER");	dispSizes.add("'30%'");		dispAlign.add("Left");	
		dispColumns.add("CLASS_VALUE");		dispSizes.add("'70%'");		dispAlign.add("Left");	


%>
	<Div id="theads">
		<Table  width="85%" align=center id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="30%" >Class Character</th>
			<Th width="70%" >Class Value</th>
		</Tr>	
		</Table>
	</Div> 
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:85%;height:45%;left:8%">
		<Table align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%		String hiddenFields ="";
		String classCharactersTemp="";
		StringBuffer selClassValueBuffer = null;
		String tempNAME1_CHAR="";
		String tempCHAR_VALUE="";
		for(int i=0; i<retClassCharactersCount; i++)
		{
			
			
			classCharactersTemp = retClassCharacters.getFieldValueString(i,"NAME_CHAR");
			
			hiddenFields ="<input type=hidden name='classCharacters' value ='"+classCharactersTemp+"'>";
			
			selClassValueBuffer = new StringBuffer("<Select name='classValue' style='width:100%' size=3 multiple>");
			selClassValueBuffer.append("<Option value=''> </Option>");
			for (int j=0;j<retClassValuesCount;j++)
			{
				tempNAME1_CHAR = retClassValues.getFieldValueString(j,"NAME_CHAR");
				tempCHAR_VALUE = retClassValues.getFieldValueString(j,"CHAR_VALUE");
				if(classCharactersTemp.equals(tempNAME1_CHAR))
				{
					selClassValueBuffer.append("<Option value='"+tempNAME1_CHAR+"¥"+tempCHAR_VALUE+"'>"+tempCHAR_VALUE+"</Option>");
				}
				
			}	
			selClassValueBuffer.append("</Seclect>");
			myValues.put("CLASS_CHARACTER",hiddenFields+retClassCharacters.getFieldValueString(i,"DESCR_CHAR"));
			myValues.put("CLASS_VALUE",selClassValueBuffer);
%>
			
		
		<Tr>
<%
			for(int k=0;k<dispColumns.size();k++)
			{
				out.println("<Td width=" + dispSizes.get(k) + " align=" + dispAlign.get(k) + ">" + myValues.get(dispColumns.get(k)) + "&nbsp;</Td>");
			}
%>
		</Tr>
<%
		}
%>		
		</Table>
	</Div>
	<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
	<Table width="100%" align=center>
	<Tr>
	<Td class="blankcell"  align="center"><a href="JavaScript:funSubmit()"><Img  src="../../Images/Buttons/<%= ButtonDir%>/search.gif" border="none" title="click here To get Materials" alt="click here To get Materials" ></a></Td>	
		</Tr>
	</Table>
	</Div>
<%
	}else
	{
%>
		<Table align=center><Tr>
			<Td class=displayalert>
				Please Select Product Class	
			</Td></Tr>
		</Table>
<%
	}
%>	
</Form>
</Body>
</Html>

