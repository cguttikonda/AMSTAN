<%
  if(numCatArea==0)
   {
     if(numCatArea==0) //if no sales areas to list
      {
%>
	<br><br><br><br>
    	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
        <Tr align="center">
    		    <Td class="displayheader">There are No Sales Areas To List</Td>
       </Tr>
       </Table>
<%
       }
%>       
     <center>
      <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

    </center> 
<%
     return;
   }
%>   

  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    <Tr bgcolor="#FFFFF7" bordercolor="#999999">
      <Th width="25%" class="labelcell"><nobr>Sales Area</nobr></Th>
      <Td width="75%">
     <select name="SystemKey" style="width:100%" id = FullListBox onChange="funSubmit()">
     <option value="sel" >--Select Sales Area--</option>

<%
        String val=null,checkFlag=null,syskeyDesc=null;
	retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
	for (int i = 0 ; i < numCatArea ; i++ )
	{ 
	   val = retsyskey.getFieldValueString(i,SYSTEM_KEY);
 	   checkFlag = retsyskey.getFieldValueString(i,"ESKD_SYNC_FLAG");
	   checkFlag = checkFlag.trim();
	   syskeyDesc = retsyskey.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
	   if(checkFlag.equals("Y"))
	   {
		val = val.toUpperCase();
		val = val.trim();
		if(val.equals(sys_key))
		{
%>
		   <option selected value=<%=val%> > <%=syskeyDesc%> (<%=val %>)
<%
		}
		else
		{
%>
		   <option value=<%=val%>><%=syskeyDesc%> (<%=val %>)
			      		  
<%
	        }
        }//end if checkFlag
	 else
	 {
	 // retsyskey.deleteRow(i);
	 }    
	}//for close
%>

 </select>
  </Td>
    <!--<Td width="10%" align="center">
	<input type=image src="../../Images/Buttons/<%= ButtonDir%>/show.gif" onClick="setOption(1)">
    </Td>-->
    </Tr>
  </Table>
