<HTML>
<HEAD>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<style>

   A  {text-decoration: none;
       color: black}
  .folderStyle{
       font-family: Verdana, Arial, sans-serif;
	   	font-size: 11px;
	   	font-weight: bold;
	    color: #336699;
      }
   .docStyle{
	       font-size: 11px;
	  	   font-family: verdana,helvetica;
	  	   text-decoration: none;
	  	   white-space:nowrap;
	       color: blue;
      }
</style>
</Head>
<Body scroll=no>
<Form name="myForm" method="post">
<Div id =titleDiv>
	<Table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<Tr>
			<Td height="35" class="displayheader"  width="100%"><Center>Sales Order Details</Center></Td>
		</Tr>
	</Table>
</Div>
<Div width="100%" >
<Table align=center border="0" cellpadding="0" cellspacing="0"  height="92%" width="100%" >
<Tr>
<Td id='tdTree' width='18%' height='100%' >
	<Table   height='100%' border=1 borderColorDark=#ffffff borderColorLight=#660000 cellPadding=2 cellSpacing=0 >
		<tr height='5%'>
			<th class=displayalert align ="center">Sales Orders</th>
		</tr>
		<tr height='95%' valign=top>	
			<td >
				<IFrame id="treeFrame" name="treeTab" src="ezDrillDownTree.jsp" width='100%' height='100%' frameborder=0 scrolling="no"></IFrame>
			</td>	
		</tr>
	</table >
</Td>
<Td width='82%' id='tdGrid' height='100%'>
	<IFrame id="gridFrame" name="dispTab" src="ezDrillDownDisplay.jsp" width='100%' height='100%' frameborder=0 scrolling="no"></IFrame>
</Td>
</Tr>
</Table>
</Div>	
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>