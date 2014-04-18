<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="javax.xml.bind.*,java.io.*,ezc.ezadmin.reports.*" %>

<%
JAXBContext jc = JAXBContext.newInstance("ezc.ezadmin.reports");

Unmarshaller u =jc.createUnmarshaller();
ReportType rep=null;
try{
	rep= (ReportType)u.unmarshal(new FileInputStream("Xmls/Reports.xml"));
%>
	<Table>
	<Tr>
		<Th>Name</th><Td><%= rep.getRName() %></td>
		<Th>Report No</th><Td><%=rep.getRNo()%></td>
		<Th>Domain</th><Td><%= rep.getRDomain()%></td>
	</tr>
	<Tr>
		<Th>Status</th><Td><%= rep.getRStatus()%></td>
		<Th>DESC</th><Td><%=rep.getRDesc()%></td>
		<Th>Exetype</th><Td><%= rep.getRExetype() %></td>
	</tr>

	<Tr>
		<Th>Visibility</th><Td><%= rep.getRVisible() %></td>
		<Th>Type</th><Td><%= rep.getRType() %></td>
		<Th>SysNo</th><Td><%= rep.getRSys() %></td>
	</tr>
	<Tr>
		<Th>Lang</th><Td><%= rep.getRLang() %></td>
		<Th>Ext1</th><Td><%= rep.getRExt1() %></td>
		<Th>Ext2</th><Td><%= rep.getRExt2() %></td>

	</tr>
	<Table>
	<Table>

<%
	java.util.List RParams = rep.getRParam();

	for( Iterator iter = RParams.iterator(); iter.hasNext(); )
	{
        	   ReportType.RParamType params = (ReportType.RParamType)iter.next();
		   java.util.List RValues=params.getRValue();
		   String multi="";
		   for(Iterator iter1 = RValues.iterator(); iter1.hasNext();)
		   {
		   	ReportType.RParamType.RValueType values = (ReportType.RParamType.RValueType)iter1.next();
			if( (values.getVNo()).equals(params.getPNo()) )
			{
				 multi +=values.getRVOPT()+"."+values.getRVL()+"."+values.getRVExt2()+"."+values.getRVExt1()+"."+values.getRVMOD()+"."+values.getRVH();
			}

		   }
%>
		<Tr>
			<Td colspan="13"><%=multi%></Td>
		</Tr>

		<Tr>
			<Td><%=params.getRPL()%></Td>
			<Td><%=params.getRPCD()%></Td>
			<Td><%=params.getRPT()%></Td>
			<Td><%=params.getRPMet()%></Td>
			<Td><%=params.getRPM()%></Td>
			<Td><%=params.getRPH()%></Td>
			<Td><%=params.getRPDT()%></Td>
			<Td><%=params.getRPExt1()%></Td>
			<Td><%=params.getRPExt2()%></Td>
			<Td><%=params.getRPN()%></Td>
			<Td><%=params.getRPS()%></Td>
			<Td><%=params.getRPD()%></Td>
			<Td><%=params.getPNo()%></Td>


		</Tr>

<%
	}


}catch(Exception e)
{
	out.println(e);
}

rep.setRName("Zanopt33");
Marshaller m = jc.createMarshaller();
FileOutputStream fos= new  FileOutputStream(new File("Xmls/Reports.xml"));
m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,Boolean.TRUE);
m.marshal(rep,fos);
fos.close();

%>

