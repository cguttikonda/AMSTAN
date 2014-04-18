<%@ page import="javax.xml.bind.*,java.io.*,ezc.ezadmin.ordertypes.*" %>

<%
java.util.List prdgroups=null;
java.util.List ordNatures = null;
ezc.ezadmin.ordertypes.OrdNatures ordNat=null;
SalesAreaListType.SalesAreasType salesareas=null;

JAXBContext jc = JAXBContext.newInstance("ezc.ezadmin.ordertypes");
ObjectFactory objFactory = new ObjectFactory();

Unmarshaller u =jc.createUnmarshaller();
SalesAreaList salesareaList = (SalesAreaList)u.unmarshal(new FileInputStream("xmls/suresh.xml"));

java.util.List salesAreas = salesareaList.getSalesAreas();

for( Iterator iter = salesAreas.iterator(); iter.hasNext(); )
{
	salesareas= (SalesAreaListType.SalesAreasType)iter.next();

	prdgroups =salesareas.getPrdGroups();
	for( Iterator iter1 = prdgroups.iterator(); iter1.hasNext(); )
	{
		SalesAreaListType.SalesAreasType.PrdGroupsType pgt =(SalesAreaListType.SalesAreasType.PrdGroupsType)iter1.next();
		ordNatures = pgt.getOrdNatures();
		for( Iterator iter2 = ordNatures.iterator(); iter2.hasNext(); )
		{
			ordNat =(ezc.ezadmin.ordertypes.OrdNatures)iter2.next();
		}
	}
}


salesareas=objFactory.createSalesAreaListTypeSalesAreasType();
java.util.List sales =salesareas.getPrdGroups();
salesareas.setSalesArea("ssss");
salesareas.setSalesOrg("100");
salesareas.setDivision("100");
salesareas.setDC("100");

SalesAreaListType.SalesAreasType.PrdGroupsType pgt =objFactory.createSalesAreaListTypeSalesAreasTypePrdGroupsType();
pgt.setPrdGroup("abcd");
java.util.List ordNatures1= pgt.getOrdNatures();
ordNat=  objFactory.createOrdNatures();

ordNat.setOrdNature("ORD");
ordNat.setListType("ZORD");
ordNat.setCreationType("ZORF");
ordNatures1.add(ordNat);

ordNat=  objFactory.createOrdNatures();
ordNat.setOrdNature("RET");
ordNat.setListType("ZORD");
ordNat.setCreationType("ZORF");
ordNatures1.add(ordNat);

ordNat=  objFactory.createOrdNatures();
ordNat.setOrdNature("FRS");
ordNat.setListType("ZORD");
ordNat.setCreationType("ZORF");
ordNatures1.add(ordNat);

//prdgroups.add(pgt);
sales.add(pgt);

//sales.add(prdgroups);
salesAreas.add(salesareas);


Marshaller m = jc.createMarshaller();
FileOutputStream fos= new  FileOutputStream(new File("Xmls/suresh10.xml"));
m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,Boolean.TRUE);
m.marshal(salesareaList,fos);
fos.close();

%>

