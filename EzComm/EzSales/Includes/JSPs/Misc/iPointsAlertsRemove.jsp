<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%
	String matID  =  request.getParameter("matId_"+lineNo);
	String qtyDel  =  request.getParameter("reqQty_"+lineNo);

	ReturnObjFromRetrieve retAtpLocalDB = null;
	int cntAtpDB=0;
	EzcParams mainParamsAtp = new EzcParams(false);
	EziMiscParams miscParamsAtp = new EziMiscParams();
	miscParamsAtp.setIdenKey("MISC_SELECT");
	String query="SELECT EZP_PRODUCT_CODE,EZP_VOLUME,EPA_ATTR_CODE,EPA_ATTR_VALUE FROM EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE EZP_PRODUCT_CODE=EPA_PRODUCT_CODE AND EZP_PRODUCT_CODE IN ('"+matID+"') AND EPA_ATTR_CODE IN ('PROD_HIERARCHY1','DIVISION','MATERIAL_GROUP1','MATERIAL_GROUP5','SAP_COMM_GROUP')";
	miscParamsAtp.setQuery(query);
	mainParamsAtp.setLocalStore("Y");
	mainParamsAtp.setObject(miscParamsAtp);
	Session.prepareParams(mainParamsAtp);
	try
	{
		retAtpLocalDB = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAtp);
		cntAtpDB=retAtpLocalDB.getRowCount();
	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}

	/***********cart points value mapping************/

	ReturnObjFromRetrieve pointsMapRetObj = (ReturnObjFromRetrieve)session.getValue("pointsMapRetObjSes");

	if(pointsMapRetObj==null)
	{
		EzcParams mainParams_CVM = new EzcParams(false);
		EziMiscParams miscParams_CVM = new EziMiscParams();
		miscParams_CVM.setIdenKey("MISC_SELECT");
		miscParams_CVM.setQuery("SELECT POINTS_TYPE,VALUE2 POINTS_DESC,DIV_VAL,PH1_VAL,CGR_VAL,MG1_VAL,MG5_VAL FROM EZC_POINTS_MAPPING,EZC_VALUE_MAPPING WHERE POINTS_TYPE=VALUE1 AND MAP_TYPE='POINTSGRP'");
		mainParams_CVM.setLocalStore("Y");
		mainParams_CVM.setObject(miscParams_CVM);
		Session.prepareParams(mainParams_CVM);
		try
		{
			pointsMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_CVM);
			session.putValue("pointsMapRetObjSes",pointsMapRetObj);
		}
		catch(Exception e){out.println("Exception in Getting Data"+e);}
	}

	/***********cart points value mapping************/

	String div 	= "";
	String ph1 	= "";
	String mg1 	= "";
	String mg5 	= "";
	String cgr 	= "";
	String volume 	= "";
	String prodQty	= "";
	String points	= "0";
	String classType= "N/A";

	//out.println("retAtpLocalDB:::"+retAtpLocalDB.toEzcString());

	if(retAtpLocalDB != null  && cntAtpDB>0)
	{
		points="0";volume="0";
		volume	  = retAtpLocalDB.getFieldValueString(0,"EZP_VOLUME");

		for(int ad=0;ad<cntAtpDB;ad++)
		{
			if("MATERIAL_GROUP1".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
			{
				mg1 = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
			}
			if("MATERIAL_GROUP5".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
			{
				mg5 = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
			}
			if("SAP_COMM_GROUP".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
			{
				cgr = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
			}
			if("DIVISION".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
			{
				div = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
			}
			if("PROD_HIERARCHY1".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
			{
				String ph1AttrVal = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE"));
				ph1 = ph1AttrVal;
				if(!"N/A".equals(ph1AttrVal))
				{
					ph1 = ph1AttrVal.substring(0,2);

					try
					{
						classType = ph1AttrVal.substring(2,4);
						if("10".equals(classType) || "20".equals(classType))
							classType = "LUX";
						else
							classType = "COM";

						/*else if("50".equals(classType))
							classType = "COM";
						else
							classType = "N/A";*/
					}
					catch(Exception e){classType = "COM";}
				}
			}
		}

		mg1 = nullCheck(mg1);
		mg5 = nullCheck(mg5);
		cgr = nullCheck(cgr);
		div = nullCheck(div);
		ph1 = nullCheck(ph1);

		for(int alr=0;alr<pointsMapRetObj.getRowCount();alr++)
		{
			String pointsType = pointsMapRetObj.getFieldValueString(alr,"POINTS_TYPE");
			String pointsDesc = pointsMapRetObj.getFieldValueString(alr,"POINTS_DESC");
			String divVal 	  = pointsMapRetObj.getFieldValueString(alr,"DIV_VAL");
			String ph1Val 	  = pointsMapRetObj.getFieldValueString(alr,"PH1_VAL");
			String cgrVal 	  = pointsMapRetObj.getFieldValueString(alr,"CGR_VAL");
			String mg1Val 	  = pointsMapRetObj.getFieldValueString(alr,"MG1_VAL");
			String mg5Val 	  = pointsMapRetObj.getFieldValueString(alr,"MG5_VAL");


			if("CHINA".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || ("5N".equals(ph1) && mg5Val.indexOf(mg5)!=-1)))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,true);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("AACRYLUX".equals(pointsType) && ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && mg1Val.indexOf(mg1)==-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,true);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("ACRYLUX".equals(pointsType) && ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && mg1Val.indexOf(mg1)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,true);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("ENAMEL".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,true);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("MARBLE".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,true);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("SHOWSTD".equals(pointsType) && ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && cgrVal.indexOf(cgr)==-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("SHOWCST".equals(pointsType) && ((divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1) && cgrVal.indexOf(cgr)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("WALK".equals(pointsType) && (divVal.indexOf(div)!=-1 ||  ph1Val.indexOf(ph1)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("FAUCETSNL".equals(pointsType) && ((divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1) && mg1Val.indexOf(mg1)==-1))  				     
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("FAUCETSL".equals(pointsType) && ((divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1 || cgrVal.indexOf(cgr)!=-1) && mg1Val.indexOf(mg1)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("DXVREPAIR".equals(pointsType) && (divVal.indexOf(div)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("REPAIR".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
			{
				if("D9".equals(div))
					pointsDesc = "DXV Repair Parts";

				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("JADO".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("FIAT".equals(pointsType) && (divVal.indexOf(div)!=-1 || ph1Val.indexOf(ph1)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("DXVCHINA".equals(pointsType) && (divVal.indexOf(div)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("DXVFAUCETS".equals(pointsType) && (divVal.indexOf(div)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("DXVFURNT".equals(pointsType) && (divVal.indexOf(div)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("DXVTUBS".equals(pointsType) && (divVal.indexOf(div)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
			else if("DXVSINKSNC".equals(pointsType) && (divVal.indexOf(div)!=-1))
			{
				String pointsSes = nullCheck((String)session.getValue(pointsDesc));

				try
				{
					String totPoints = (String)catergoryGroup(qtyDel,volume,pointsSes,false);
					points = totPoints.split("�")[0];
					pointsSes = totPoints.split("�")[1];
					session.putValue(pointsDesc,pointsSes);
					break;
				}
				catch(Exception e){}
			}
		}
	}				 					
%>		
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
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
	public String catergoryGroup(String quantity,String volume,String pointsSes,boolean flag)
	{
		String totPoints = "0";
		String points = "0";
		try
		{
			if(flag)
			{
				points = new java.math.BigDecimal(volume).multiply(new java.math.BigDecimal(quantity)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}
			else
			{
				points = new java.math.BigDecimal(quantity).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}

			if(!"N/A".equals(pointsSes))
			{
				totPoints = new java.math.BigDecimal(pointsSes).subtract(new java.math.BigDecimal(points)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}
		}
		catch(Exception e){}

		return points+"�"+totPoints;
	}
%>