 
<%--
      Copyright Notice =====================================*
    * This file contains proprietary information of Answerthink Inc.
    * Copying or reproduction without prior written approval is prohibited.
    * Copyright (c) 2005 ===================================*
--%>    

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../MaterialSearch/iSearchMaterials.jsp"%>                       
<Html>
<Head>
<Title>Search Materials ...</Title> 
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	   var tabHeadWidth=85
 	   var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
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
		document.myForm.action="ezSearchMaterialsList.jsp";
		document.myForm.submit();
		
	}
	function funSelectValue(cVal, Num)
	{
		//alert(cVal)
		var selValue='';
		if(document.myForm.selectedValues!=null)
		{
			if(document.myForm.selectedValues.length>0)
			{	
				selValue= document.myForm.selectedValues[Num].value
				
			}else
			{
				selValue= document.myForm.selectedValues.value 
				
			}
		}
		window.open("ezSelectValues.jsp?classChar="+cVal+"&rowNum="+Num+"&selValue="+selValue,"multi","resizable=no,left=150,top=150,height=400,width=400,status=no,toolbar=no,menubar=no,location=no")
	}
	function funClearValue(Num)
	{
		if(document.myForm.selectedValues!=null)
		{
			if(document.myForm.selectedValues.length>0)
			{	
				document.myForm.selectedValues[Num].value=''
				document.myForm.classValueArea[Num].value=''
			}else
			{
				document.myForm.selectedValues.value=''
				document.myForm.classValueArea.value=''
			}
		}
		
	}
	
	function funGoBack()
	{
		var onetimeuser="OTU";
		if("SEARCH"=="<%=(String)session.getValue("GoTo")%>")
		{
					document.myForm.target = "_top";
					document.myForm.action = "../../../../../../../ezLogin.htm";	
					document.myForm.submit();
		}else if(onetimeuser=="<%=(String)session.getValue("UserRoleOld")%>")
		{
			document.myForm.target = "_top";
			document.myForm.action = "../Misc/ezMain.jsp";
			document.myForm.submit();
		}else{
			history.go(-1);
		}
		
		
	}
	
			
</Script>

</Head>
<Body onLoad="scrollInit();" scroll=no onresize="scrollInit()">
<Form method="post"  name="myForm">
<% int flagValue=0; %>
<Div id =titleDiv>
<Table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
	<Tr>
		<Td height="35" class="displayheader" align="center" width="100%">Materials Search</Td>
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
			<Td height="35" class="displayalert" align="center" width="100%">No Product Type Available</Td>
		</Tr>
	</Table>

<%
	return;   
}
%>

<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="50%">
	<Tr>
		<Th width=50%> Product Type </Th>
		<Td width=50%>
			<Select name="className" onChange="onChangeClass()" id="ListBoxDiv" style="width:100%">
			<option value=" ">--Select the Product Type---</option>
<%
			String classNameTemp ="";
			for(int i=0; i<retClassListCount; i++)
			{
				//out.println("retClassListCount::"+retClassListCount);
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
	//out.println("className----->"+className);
	if(retClassCharactersCount>0)	
	{
		session.putValue("retClassValues",retClassValues);
		//All display columns setting here
		java.util.Hashtable myValues	= new java.util.Hashtable();
		java.util.ArrayList dispColumns	= new ArrayList();
		java.util.ArrayList dispSizes  	= new java.util.ArrayList();
		java.util.ArrayList dispAlign  	= new java.util.ArrayList();
		dispColumns.add("CLASS_CHARACTER");	dispSizes.add("'30%'");		dispAlign.add("Left");	
		dispColumns.add("CLASS_VALUE");		dispSizes.add("'70%'");		dispAlign.add("Left");	
%>
	<br>
	<Div id="theads">
		<Table  width="85%" align=center id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="30%" >Class Character</th>
			<Th width="20%" >Options</th>
			<Th width="50%" >Values</th>
		</Tr>	
		</Table>
	</Div> 
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:85%;height:45%;left:2%">
		<Table align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%		String hiddenFields ="";
		String classCharactersTemp="";
		StringBuffer selClassValueBuffer = null;
		String tempNAME1_CHAR="";
		String tempCHAR_VALUE="";
		boolean valueFlag = false; 
		for(int i=0; i<retClassCharactersCount; i++)
		{
			
			classCharactersTemp = retClassCharacters.getFieldValueString(i,"NAME_CHAR");
			hiddenFields ="";
			myValues.put("CLASS_CHARACTER",hiddenFields+retClassCharacters.getFieldValueString(i,"DESCR_CHAR"));
			myValues.put("CLASS_VALUE","");
			valueFlag=false;
			for (int j=0;j<retClassValuesCount;j++)
			{
				tempNAME1_CHAR = retClassValues.getFieldValueString(j,"NAME_CHAR");
				if(classCharactersTemp.equals(tempNAME1_CHAR))
				{
					valueFlag=true;
					break;
				}
			}
				
%>
			<Tr>
				<Td width="30%" ><%=retClassCharacters.getFieldValueString(i,"DESCR_CHAR")%></Td>
				
				<Td width="20%" align=center><input type=hidden name=selectedClassCharacter value="<%=classCharactersTemp%>"><input type=hidden name=selectedValues value="">
<%					if(valueFlag)
					{
%>
						<Table>
								<Tr><Td><a href="javaScript:funSelectValue('<%=classCharactersTemp%>',<%=i%>)">Select Values</a></Td></Tr>
								<Tr><td><a href="javaScript:funClearValue(<%=i%>)">Clear Value</a></Td></Tr>
						</Table>
<%					}else{
%>
						No Class Values
<%					}
%>
					
				</Td>
				<Td width="50%"><textarea name=classValueArea class=txareablank rows="4" style="width:100%;cursor:pointer"></textarea></Td>
			</Tr>
<%
		}
%>		
		</Table>
	</Div>
	<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
		<!-- <a href="JavaScript:funSubmit()" ><Img  src="../../Images/Buttons/<%= ButtonDir%>/search.gif" border="none" title="click here To get Materials" alt="click here To get Materials" onclick='<% flagValue=1;%>'></a>	
		<a href="JavaScript:funGoBack()" ><Img  src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border="none" title="click here To get Materials" alt="click here To go Back" ></a> -->
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Search");
			buttonMethod.add("funSubmit()");
			buttonName.add("Back");
			buttonMethod.add("funGoBack()");
			
			out.println(getButtonStr(buttonName,buttonMethod));
%>
		
	</Div>
<%
	}else if("".equals(className))    
	{
%>
		<br><br><br><br><br>
		<Table align=center><Tr>
			<Td class=displayalert>
				Please Select Product Type	
			</Td></Tr>
		</Table>
		<BR><BR><BR><center>
		<!-- <a href="JavaScript:funGoBack()" ><Img  src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border="none" title="click here To get Materials" alt="click here To go Back" ></a> -->
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Back");
			buttonMethod.add("funGoBack()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>				
		
		</center>
		
	
<%
	}else{
%>
		<br><br><br><br><br>
		<Table align=center><Tr>
			<Td class=displayalert>
				No Class Character for Selected Product Class	
			</Td></Tr>
		</Table>
		<BR><BR><BR><center>
			<!-- <a href="JavaScript:funGoBack()" ><Img  src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border="none" title="click here To get Materials" alt="click here To go Back" ></a>-->
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Back");
			buttonMethod.add("funGoBack()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>				
		</center>

<%
	}
%>
<Div style="position:absolute; Top:90%; Left:55%">
	
		
	
</Div>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>

