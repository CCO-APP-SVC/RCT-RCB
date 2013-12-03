<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

Dim sSql As String

sSql = "Select * From tblEvents"

Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Events")
            
If sqlDtSet.Tables("Events").Rows.Count >= 1 Then

   ' Dim MyDoc as New System.Xml.XmlDocument
   ' MyDoc.LoadXml(sqlDtSet.getxml())
   ' Dim Events as String = MyDoc.SelectSingleNode("//NewDataSet").InnerXml
Response.ContentType = "application/xml"
    Response.Write(sqlDtSet.getxml())
Else
    Response.Write("")
End If
%>
