<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">
   

    function toto(fElement) {

        var f = fElement.files[0];

        var reader = new FileReader();
        reader.readAsText(f, "UTF-8");
        alert("1");
        document.getElementById("tFileContent").value = reader.result;
    }



</script>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   
   <input type="file" name="fFile" id="fFile" />

   <input type="button" onclick="toto(document.getElementById('fFile'));" />
   <br />
   <br />
   <form name="frmResultsAddBatch" id="frmResultsAddBatch" enctype="multipart/form-data" method="post" action="functions.aspx?fn=ResultsImport">
   <textarea rows="10" name="tFileContent" id="tFileContent" style="width: 500px;"></textarea><br />
   <input type="submit" value="toto" />
   </form>

</body>
</html>

