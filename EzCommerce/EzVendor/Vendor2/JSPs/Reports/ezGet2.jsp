<%@ page import="javax.xml.bind.*,java.io.*,ezc.ezadmin.reports.*" %>

<%
JAXBContext jc = JAXBContext.newInstance("ezc.ezadmin.reports");
ObjectFactory objFactory = new ObjectFactory();
ReportType rep = objFactory.createReportType();
java.util.List RParam = rep.getRParam();


rep.setRName("Stupid");
rep.setRNo("111");
rep.setRDomain("S");
rep.setRStatus("A");
rep.setRDesc("SSSSSSS");
rep.setRExetype("A");
rep.setRVisible("A");
rep.setRType("B");
rep.setRSys("999");
rep.setRLang("EN");
rep.setRExt1(" ");
rep.setRExt2(" ");

ezc.ezadmin.reports.ReportType.RParamType params =objFactory.createReportTypeRParamType();
params.setRPL("111");
params.setRPCD("222");
params.setRPT("333");
params.setRPMet("444");
params.setRPM("555");
params.setRPH("666");
params.setRPDT("777");
params.setRPExt1(" ");
params.setRPExt2(" ");
params.setRPN("1");
params.setRPS("888");
params.setRPD("999");
params.setPNo("1010");
java.util.List RValues = params.getRValue();
ezc.ezadmin.reports.ReportType.RParamType.RValueType values=  objFactory.createReportTypeRParamTypeRValueType();
values.setRVOPT("11");
values.setRVL("aa");
values.setRVExt2(" ");
values.setRVExt1(" ");
values.setRVMOD("bbb");
values.setRVH(" bb");
values.setVNo("1010");

RValues.add(values);
RParam.add(params);

Marshaller m = jc.createMarshaller();
FileOutputStream fos= new  FileOutputStream(new File("Xmls/ccc1.xml"));
m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,Boolean.TRUE);
m.marshal(rep,fos);
fos.close();

%>

