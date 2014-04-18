
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
  <head>
      
  </head>
  <body>
      <form>
	<Table  align=center border=0 cellPadding=0 cellSpacing=0  width=90%>
	<TBODY>
	<Tr>
		<Td>
		 <Table  cellSpacing=0 cellPadding=0 width=100% border=0>
		      <TBODY>
		      <Tr>
			     <Td vAlign=bottom height=45 width=100%  class=blankcell>
			     <Table  cellSpacing=0 cellPadding=0 border=0 >
			     <TBODY>
			     <Tr>
			      <Td class=blankcell width=10 ><IMG height=27  src="Inbox_files/tab_front_left.gif" width=15 border=0></Td>
			      <Td class=blankcell background=Inbox_files/tab_fill_front.gif><a  href="activity.jsp"  title="composing of messages" style="text-decoration:none">Activity</a></Td>
			      <Td class=blankcell width=10><IMG height=27   src="Inbox_files/tab_front_right.gif" width=15 border=0></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back1_left.gif" width=15  border=0></Td>
			      <Td class=blankcell background=Inbox_files/tab_fill_back.gif><a  href="instructions.jsp"  title="composing of messages" style="text-decoration:none">Insturctions</a></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back_right.gif" width=15  border=0></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back2_left.gif" width=15 border=0></Td>
			      <Td class=blankcell background=Inbox_files/tab_fill_back.gif><a href="skills.jsp" title="folders details"  style="text-decoration:none">Skills</a></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back_right.gif" width=15 border=0></Td>
			      <Td class=blankcell width=12><IMG height=27 src="Inbox_files/tab_back_end.gif" width=12 border=0></Td>
			      <Td class=blankcell background=Inbox_files/tab_fill_back.gif><a href="tools.jsp" title="folders details"  style="text-decoration:none">Tools</a></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back_right.gif" width=15 border=0></Td>
			      <Td class=blankcell width=12><IMG height=27 src="Inbox_files/tab_back_end.gif" width=12 border=0></Td>
			      <Td class=blankcell background=Inbox_files/tab_fill_back.gif><a href="labour.jsp" title="folders details"  style="text-decoration:none">Labor</a></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back_right.gif" width=15 border=0></Td>
			      <Td class=blankcell width=12><IMG height=27 src="Inbox_files/tab_back_end.gif" width=12 border=0></Td>
			      <Td class=blankcell background=Inbox_files/tab_fill_back.gif><a href="material.jsp" title="folders details"  style="text-decoration:none">Material</a></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back_right.gif" width=15 border=0></Td>
			      <Td class=blankcell width=12><IMG height=27 src="Inbox_files/tab_back_end.gif" width=12 border=0></Td>
			      <Td class=blankcell background=Inbox_files/tab_fill_back.gif><a href="ezListFolders.jsp" title="folders details"  style="text-decoration:none">Other</a></Td>
			      <Td class=blankcell width=10><IMG height=27 src="Inbox_files/tab_back_right.gif" width=15 border=0></Td>
			      <Td class=blankcell width=12><IMG height=27 src="Inbox_files/tab_back_end.gif" width=12 border=0></Td>


			    </Tr>
			    </TBODY>
			  </Table >
		    </Td>
		    <Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
		 </Tr>
		 </TBODY>
		 </Table >
</Td>
</Tr>
</Table >
   <Table  align=center border=1 cellPadding=0 cellSpacing=0  width=90%>
        <Tr>
           <Th>CheckList :</Th><Td><textarea name='text' rows=5 cols=25></textarea></Td></Tr>
        <Tr><Th>Safety Instructions :</Th><Td><textarea name='text' rows=5 cols=25></textarea></Td></Tr>
        <Tr><Th>Special Instructions :</Th><Td><textarea name='text' rows=5 cols=25></textarea></Td></Tr>
   </Table >
        <div align="center">
    	<input type="image" src="../../Images/Buttons/<%=ButtonDir%>/add.gif">  
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%=ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>

</div>
       </Table >
      </form>
  </body>
</html>