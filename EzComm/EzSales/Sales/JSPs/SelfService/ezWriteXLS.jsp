<%@ include file="../../../Includes/JSPs/SelfService/iGetShipCodes.jsp"%>
<%@ page import="jxl.Sheet,jxl.Workbook,jxl.read.biff.BiffException,jxl.write.*,jxl.format.*"%>
<%@ page import="java.awt.image.BufferedImage,java.io.ByteArrayOutputStream,javax.imageio.ImageIO,java.io.*,ezc.ezparam.*,java.util.*,java.io.*"%>
<%
	//out.print("retShipCodes:::"+retShipCodes.toEzcString());
%>
<%
	String fileName = "Ship codes.xls";
	WritableWorkbook workbook = null;
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename="+fileName);	
	
	ReturnObjFromRetrieve myRetERRSesGet = (ReturnObjFromRetrieve)session.getValue("myRetERRSes");

	try
	{
		int row=0;

		workbook = Workbook.createWorkbook(response.getOutputStream());
		WritableSheet ws = workbook.createSheet("Sheet0", 0);

		WritableFont custHeadFont = new WritableFont(jxl.write.WritableFont.TIMES, 12 , jxl.write.WritableFont.BOLD);
		WritableCellFormat custHeadCellFormat = new WritableCellFormat(custHeadFont);
		custHeadCellFormat.setBackground(jxl.format.Colour.ORANGE);

		ws.addCell(new Label(0, row, "Ship To Code", custHeadCellFormat));

		WritableFont custDetFont = new WritableFont(jxl.write.WritableFont.TIMES, 11);
		WritableCellFormat custDetCellFormat = new WritableCellFormat(custDetFont);
		//custDetCellFormat.setBackground(jxl.format.Colour.WHITE);
		
		for(int i=0;i<retShipCodes.getRowCount();i++)
		{
			ws.addCell(new Label(0, row+1, retShipCodes.getFieldValueString(i,"EUD_VALUE"), custDetCellFormat));
			row++;
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception in result set"+e);
	}
	finally
	{
		try{
			workbook.write();
			workbook.close();
		}catch(Exception ex){}
	}
%>

