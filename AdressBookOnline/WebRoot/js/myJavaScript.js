function checkForm(){

       
        
        var tel = document.myForm.tel.value;
        alert(tel);
        if (isNaN(tel)) {
            document.getElementById("tipun1").innerHTML = "有非数字字符，请输入纯数字号码！";
            document.myForm.jiage.focus();
            return false;
        }
		
		else  if(tel==""){
				document.getElementById('tipun1').innerHTML = '不能为空';
				document.myForm.tel.focus();
				return false;
			}
		else
		{
		document.getElementById('tipun1').innerHTML = '';
		}
		
       
}