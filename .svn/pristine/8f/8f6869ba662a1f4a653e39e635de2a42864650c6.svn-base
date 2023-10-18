<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="/resources/sneat/assets/vendor/css/core.css" class="template-customizer-core-css" />
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
<title>웹 메일 보내기</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/mail/sendMailProcess" method="post">
<div>
<input type="text" id="from" name="from" 
placeholder="보내는 사람" value="hyokee5115@naver.com" 
 readonly="readonly" />
</div>
<div>
<input type="text" id="to" name="to" 
placeholder="받는 사람" required="required" />
</div>
<div>
<input type="text" id="subject" name="subject"
placeholder="제목" required="required" />
<textarea rows="5" cols="5" id="text" name="text"></textarea>
</div>
<button type="submit">메일 전송하기</button>
</form>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
CKEDITOR.replace("text");
</script>