<%
  if(numCatArea==0 || langRows==0)
   {
     if(numCatArea==0) //if no sales areas to list
      {
%>
	<br><br><br><br>
    	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
        <Tr align="center">
    		    <Td class="displayheader">There are No Sales Areas To List</Td>
       </Tr>
       </Table>
<%
       }
       else //if no languages to list
       {
%>       

       <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
         <Tr align="center">
     	    <Td class="displayheader">There are No Languages To List</Td>
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

  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr bgcolor="#FFFFF7" bordercolor="#999999">
      <Th width="10%" class="labelcell">Sales Area</Th>
      <Td width="55%">
     <select name="SystemKey" style="width:100%" id = FullListBox onChange="funSubmit()">
     <option value="sel" >Select SalesArea</option>

<%
        String val=null,checkFlag=null,syskeyDesc=null;
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
		   <option selected value=<%=val%> > <%=val%> (<%=syskeyDesc %>)
<%
		}
		else
		{
%>
		   <option value=<%=val%>><%=val%> (<%=syskeyDesc %>)
			      		  
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
   <Th width="10%" class="labelcell">Language</Th>
   <Td width="25%">
  <select name="Language" style="width:100%;" id = FullListBox onChange="funSubmit()">
   <option value="sel"  >Select Language </option>
<%
      for ( int i = 0 ; i < langRows ; i++ )
      {
   	  if((retlang.getFieldValueString(i,LANG_ISO).toUpperCase()).equals(lang))
	  {
%>
	    <option selected value=<%=(retlang.getFieldValue(i,LANG_ISO))%> >
	  	<%=retlang.getFieldValue(i,LANG_DESC)%>
	
<%
          }
	 else
	 {
%>
        <option  value=<%=(retlang.getFieldValue(i,LANG_ISO))%> ><%=retlang.getFieldValue(i,LANG_DESC)%>

<%
	 }
      }//end for
%>
   </select>
    </Td>
    <!--<Td width="10%" align="center">
	<input type=image src="../../Images/Buttons/<%= ButtonDir%>/show.gif" onClick="setOption(1)">
    </Td>-->
    </Tr>
  </Table>
