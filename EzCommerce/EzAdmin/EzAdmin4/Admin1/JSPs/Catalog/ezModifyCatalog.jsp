<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iModifyCatalog.jsp"%>
<html>
<head>
	<Title>ezModifyCatalog</Title>
	<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/Catalog/ezModifyCatalog.js"></script>
        <Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<%
	if(retcat!=null && retcat.getRowCount()==0)
	{
%>
		<BODY >
<%
	}
	else
	{
%>
		<BODY onLoad="scrollInit();document.myForm.CatalogNumber.focus()" onResize = "scrollInit()" scroll="no">
<%
	}
%>

<%

      if(retcat.getRowCount()==0 || retsyskey.getRowCount()==0)
       {

         if(retcat.getRowCount()==0) //if no catalogs are available
         {
%>
          <br><br><br><br>
  	    <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	    	<Tr>
	    		<Th>
	    			<div align="center">There are no catalogs to list.</div>
	    		</Th>
	    	</Tr>
           </Table>
           <br>
          <center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

          </center>
<%
         return;
         }
         else  //if no syskeys are available
         {
%>
        <br><br>
   	    <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
 	    	<Tr>
 	    		<Td class = "labelcell">
 	    			<div align="center"><b>There are no sales areas to list.</b></div>
 	    		</Td>
 	    	</Tr>
           </Table>
          <center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

         </center>
<%
           return;
        }

    }
%>
     <form name=myForm method=post onSubmit="return submitForm()">
     <br>
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  	<Tr align="center">
	  	  <Td class="displayheader">Change Catalog</Td>
  	</Tr>
	</Table>

	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
	  <Td width=6% class="labelcell" align = "right">Catalog</Td>
	  <Td width=30%>
      	    <select name="CatalogNumber" style="width:100%" id = FullListBox onChange="funSubmit()">
	    <option value="sel">--Select Catalog--</option>

<%
	 retcat.sort(new String[]{CATALOG_DESC},true);
         for ( int i = 0 ; i < retcat.getRowCount() ; i++ )
       	  {
             if(retcat.getFieldValueString(i,CATALOG_DESC_NUMBER).equals(catalog_number))
       	       {
%>
		  <option value="<%=retcat.getFieldValue(i,CATALOG_DESC_NUMBER)%>" selected><%=retcat.getFieldValueString(i,CATALOG_DESC)%></option>
<%
               }
               else
               {
%>
		<option value="<%=retcat.getFieldValue(i,CATALOG_DESC_NUMBER)%>"><%=retcat.getFieldValueString(i,CATALOG_DESC)%></option>
<%
               }
          }
%>
	 </select>
	 </Td>
    	 <Td class="labelcell" width=10% align = "right">Sales Area</Td>
    	  <Td width=54%>
    	     <select name="SystemKey" style="width:100%" id = FullListBox onChange="funSubmit()">
    	    <option value="sel">--Select Sales Area--</option>

<%
    retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
    for ( int i = 0 ; i <retsyskey.getRowCount(); i++ )
     {

        if(retsyskey.getFieldValueString(i,SYSTEM_KEY).equals(sys_key))
          {
%>
	        <option value="<%=retsyskey.getFieldValueString(i,SYSTEM_KEY)%>" selected><%=retsyskey.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION)%> (<%=retsyskey.getFieldValueString(i,SYSTEM_KEY)%>)</option>
<%
          }
	 else
	 {
%>
            <option value="<%=retsyskey.getFieldValueString(i,SYSTEM_KEY)%>"><%=retsyskey.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION)%> (<%=retsyskey.getFieldValueString(i,SYSTEM_KEY)%>)</option>
<%
          }
      }
%>

	</select>
	</Td>
	</Tr>
      </Table>

  <%
       if("sel".equals(catalog_number) || "sel".equals(sys_key))
       {
  %>
           <br><br><br><br>
           <Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
       	   	<Tr>
       	 	<Td class = "labelcell" align="center">Please Select Catalog And Sales Area to modify.</Td>
       	    	</Tr>
           </Table>
           <center>
	    <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

          </center>

<%
      }
 if ( numCatArea > 0 && numCatalogs > 0 && !"sel".equals(catalog_number) && !"sel".equals(sys_key))
 {

	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)ret.getObject("OffsetTable");
	retobj.check();
	int iTotalCells = retobj.getRowCount();

%>

<%

	int Rows = ret.getRowCount();
	if (Rows > 0)
	{
%>
        <div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr>
             	  <Th width="85%" colspan="<%=iTotalCells%>" align="left"> Product Group</Th>
    		  <Th width="15%"> Main Index</Th>
    	</Tr>
    	</Table>
    	</div>

	<DIV id="InnerBox1Div">

	<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

<%

	for ( int i = 0 ; i <  Rows; i++ )
	{

		int level = ((java.math.BigDecimal)ret.getFieldValue(i,PROD_GROUP_LEVEL)).intValue();
		String groupSelected = (String)(ret.getFieldValue(i,CATALOG_GROUP_CHECKED));
		// Get the offset for a particular level
		String stroffset = (String)retobj.getFieldValue((level-1), "OFFSET");
		int offset = (new Integer(stroffset)).intValue();

		String chkname = (String)(ret.getFieldValue(i,PROD_GROUP_NUMBER));
		String chkFullName = chkname;
		if(chkname.length()<18)
			chkname=chkname+ "                                    ";

		chkname = chkname.substring(0, offset);
		String mainIndex = (String)(ret.getFieldValue(i,CATALOG_INDEX_INDICATOR));

%>

		<Tr bgcolor="#E1E1FF">
		<label for="cb_<%=i%>">
<%

		for ( int j = 0 ; j < (level -1); j++ )
		{
			if (level != 1)
			{
%>
				<Td>&nbsp;</Td>
<%
			}
		}


%>

	    	<Td align="left">
<%

		if (groupSelected.equals("Y"))
		{
%>
               	<input type="checkbox" name="CheckBox" id="cb_<%=i%>" value="<%=chkname%>" checked onClick="javascript:SelectChk('<%=i%>',this,(this.value).substring(1,<%=offset+1%>) ,<%=offset%>,<%=level%>)" >
<%
                }
                else
                {
%>
                <input type="checkbox" name="CheckBox" id="cb_<%=i%>" value="<%=chkname%>"  onClick="javascript:SelectChk('<%=i%>',this,(this.value).substring(1,<%=offset+1%>) ,<%=offset%>,<%=level%>)" >
<%
		}

%>

		<%=ret.getFieldValue(i,PROD_GROUP_WEB_DESC)%>
		</Td>

<%
		for ( int k = 0 ; k < (iTotalCells - level)  ; k++ )
		{
%>
			<Td>&nbsp;</Td>
<%
		}
%>

		<Td valign="top" align="center" width = "15%">

<%		if (mainIndex.equals("Y"))
		{
%>
		     <input type="checkbox" name="<%=chkname%>" value="Selected" checked>
<%
		}
		else
		{
%>

		     <input type="checkbox" name="<%=chkname%>" value="Selected" unchecked>
<%
		}

%>
		</Td>
		</label>
      		</Tr>
<%
	}

%>

  </Table>
  </div>

    <div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Update"  onClick="setOption(2)">
    <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
   <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
  </form>
<%

	}
	else
	{
%>
         <br><br><Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  	   <Tr>
  		<Th>
  			 Sales Area is not synchronized. 
  		</Th>
  	  </Tr>
         </Table>
         <br>
         <center>
	  <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

        </center>

<%
	}

}
else
if (numCatalogs ==0 && !"sel".equals(catalog_number))
{
%>

	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  	<Tr align="center">
  		  <Th>There are No Catalogs </Th>
  	</Tr>
	</Table>
	<br>
	<center>
	 <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


        </center>

<%
}
%>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Catalog changed successfully');
		</script>
<%
	} //end if
%>
 </form>
</body>
</html>
