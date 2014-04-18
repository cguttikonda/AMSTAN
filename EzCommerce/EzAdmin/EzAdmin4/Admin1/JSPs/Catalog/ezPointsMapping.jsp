<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<Html>
<Head>
<Title>ezCategoryList</Title>

<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>
function selectAll()
{

    len=document.myForm.elements.length
    if(isNaN(len))
    {
	if(document.myForm.checkall.checked)
	{
		document.myForm.elements.checked=true
	}else{
		document.myForm.elements.checked=false
	}
    }
   else
   {	
	for(i=0;i<len;i++)
	{	
	  if(document.myForm.checkall.checked)
	  document.myForm.elements[i].checked=true
	  else
	  document.myForm.elements[i].checked=false
	}
   }
}
function chkSelect()
{
	var chkbox = document.myForm.elements.length;
	chkCount=0
	if(isNaN(chkbox))
	{
		if(document.myForm.elements.checked)
		{
			chkCount++;
		}
	}
	else
	{
		for(a=0;a<chkbox;a++)
		{
			if(document.myForm.elements[a].checked)
			{
				chkCount++;
				break;
			}
		}
	}
	if(chkCount==0)
	{
		alert('Please select atleast one item');
		return false;
	}
	return true;
}
function funUpdate()
{
	if(chkSelect())
	{
		var chkbox = document.myForm.checkone.length;
		
		var ptskey
		var divkey
		var ph1key
		var cgrkey
		var mg1key
		var mg5key
		
		if(isNaN(chkbox))
		{		
			if(document.myForm.checkone.checked)
			{				
				ptskey = document.myForm.pointkey.value
				divkey = document.myForm.divval.value
				ph1key = document.myForm.ph1val.value
				cgrkey = document.myForm.cgrval.value
				mg1key = document.myForm.mg1val.value
				mg5key = document.myForm.mg5val.value
				
				if(ptskey=='') ptskey='-';
				if(divkey=='') divkey='-';
				if(ph1key=='') ph1key='-';
				if(cgrkey=='') cgrkey='-';
				if(mg1key=='') mg1key='-';
				if(mg5key=='') mg5key='-';				
				
				document.myForm.pointsvals.value=ptskey+"§"+divkey+"§"+ph1key+"§"+cgrkey+"§"+mg1key+"§"+mg5key;							
			}
		}
		else
		{		
			for(a=0;a<chkbox;a++)
			{				
				if(document.myForm.checkone[a].checked)
				{						
					ptskey = document.myForm.pointkey[a].value
					divkey = document.myForm.divval[a].value
					ph1key = document.myForm.ph1val[a].value
					cgrkey = document.myForm.cgrval[a].value
					mg1key = document.myForm.mg1val[a].value
					mg5key = document.myForm.mg5val[a].value
					
					if(ptskey=='') ptskey='-';
					if(divkey=='') divkey='-';
					if(ph1key=='') ph1key='-';
					if(cgrkey=='') cgrkey='-';
					if(mg1key=='') mg1key='-';
					if(mg5key=='') mg5key='-';
									
					document.myForm.pointsvals[a].value = ptskey+"§"+divkey+"§"+ph1key+"§"+cgrkey+"§"+mg1key+"§"+mg5key;
				}
			}
		}
		document.myForm.action="ezPointsMappingSave.jsp";
		document.myForm.submit();
	}

}
</Script>


</Head>
	
<%
	/***********cart points value mapping************/
	
	ReturnObjFromRetrieve pointsMapRetObj = null;

	EzcParams mainParams_CVM = new EzcParams(false);
	EziMiscParams miscParams_CVM = new EziMiscParams();
	miscParams_CVM.setIdenKey("MISC_SELECT");
	miscParams_CVM.setQuery("SELECT POINTS_TYPE,VALUE2 POINTS_DESC,DIV_VAL,PH1_VAL,CGR_VAL,MG1_VAL,MG5_VAL FROM EZC_POINTS_MAPPING,EZC_VALUE_MAPPING WHERE POINTS_TYPE=VALUE1 AND MAP_TYPE='POINTSGRP'"); 
	mainParams_CVM.setLocalStore("Y");
	mainParams_CVM.setObject(miscParams_CVM);
	Session.prepareParams(mainParams_CVM);	
	try{	pointsMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_CVM);
	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}
					
	/***********cart points value mapping************/
%>

<Body scrollInit()" onResize = 'scrollInit()' scroll="no">
<Form name=myForm method=post>

   	<Br><Br>
 	<!--<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width="60%">
		<Tr>
		    <Th width="30%" class="labelcell" bordercolor="#CCCCCC">Points Type</Th>
		    
		    <Td width="70%" bordercolor="#CCCCCC">
		    		  
			<Select name="pointsMap" id = "FullListBox" style="width:100%" onChange="funSelect()">
			   
<%			    
			    for (int i=0;i<pointsMapRetObj.getRowCount();i++ )
			    {			      
%>			      
			      <option   value='<%=pointsMapRetObj.getFieldValueString(i,"POINTS_TYPE")%>' ><%=pointsMapRetObj.getFieldValueString(i,"POINTS_DESC")%></option>			      	
<%			         
			    }
			     		     
%>	
			</Select>
		     </Td>
		</Tr>
        </Table>-->

	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="90%">
	 <Tr >
	 	<Td valign="middle" align="center" width="5%" style="font-family: verdana, arial;font-size: 11px;font-style: normal;font-weight: bold;color: #000066;text-decoration: none;background-color: #9BB3EA" rowspan=2>
	 	<input type=checkbox name=checkall onClick="selectAll()"/>
	 	</Td>
		<Td valign="middle" align="center" width="25%" style="font-family: verdana, arial;font-size: 11px;font-style: normal;font-weight: bold;color: #000066;text-decoration: none;background-color: #9BB3EA" rowspan=2>PointTypes</Td>
		<Td valign="middle" align="center" width="25%" style="font-family: verdana, arial;font-size: 11px;font-style: normal;font-weight: bold;color: #000066;text-decoration: none;background-color: #9BB3EA" colspan=5>AttributeTypes</Td>		
	 </Tr>
	 <Tr>
		<Th valign="middle" align="center" width="25%">Division</Th>
		<Th valign="middle" align="center" width="25%">Product Hierarchy</Th>
		<Th valign="middle" align="center" width="25%">Common Group</Th>
		<Th valign="middle" align="center" width="25%">Material Group1</Th>
		<Th valign="middle" align="center" width="25%">Material Group5</Th>		
	 </Tr>
<%			    
	for (int j=0;j<pointsMapRetObj.getRowCount();j++ )
	{			      
%>			
	<tr>
		<td><input type="checkbox"  name="checkone" id="checkone"></td>
		<Td valign="middle" align="center" width="25%"><%=nullCheck(pointsMapRetObj.getFieldValueString(j,"POINTS_DESC"))%></Td>
		<input type=hidden name='pointkey' value='<%=nullCheck(pointsMapRetObj.getFieldValueString(j,"POINTS_TYPE"))%>'>
		<Td valign="middle" align="center" width="25%"><input type=text class = "InputBox" size=40 name='divval' value='<%=nullCheck(pointsMapRetObj.getFieldValueString(j,"DIV_VAL"))%>'></Td>
		<Td valign="middle" align="center" width="25%"><input type=text class = "InputBox" size=40 name='ph1val' value='<%=nullCheck(pointsMapRetObj.getFieldValueString(j,"PH1_VAL"))%>'></Td>
		<Td valign="middle" align="center" width="25%"><input type=text class = "InputBox" name='cgrval' value='<%=nullCheck(pointsMapRetObj.getFieldValueString(j,"CGR_VAL"))%>'></Td>
		<Td valign="middle" align="center" width="25%"><input type=text class = "InputBox" name='mg1val' value='<%=nullCheck(pointsMapRetObj.getFieldValueString(j,"MG1_VAL"))%>'></Td>
		<Td valign="middle" align="center" width="25%"><input type=text class = "InputBox" name='mg5val' value='<%=nullCheck(pointsMapRetObj.getFieldValueString(j,"MG5_VAL"))%>'></Td>
		<input type=hidden name='pointsvals' value=''>
	</tr>

<%			         
	}		     		     
%>	

	</Table>
	<Br><Br>
	<Center>
		
		<img src = "../../Images/Buttons/<%= ButtonDir%>/update.gif" style = "cursor:hand" onClick = "funUpdate()">		
	</Center>
	
</Form>
<%
	String saved = request.getParameter("saved");
	
	if ( saved != null && saved.equals("Y") )
	{		
%>
		<script language="JavaScript">
			alert('Points values updated successfully');
		</script>
<%
	} 
%>
</Body>
</Html>



<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "-";
		return ret;
	}
	
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>