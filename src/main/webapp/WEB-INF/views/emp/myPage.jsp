<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../assets/css/demo.css">
<title>myPage</title>
<script>
// 파일 업로드
$("#productImage").on("change", handleImg);

function handleImg(e) {
    let files = e.target.files;
    let fileArr = Array.prototype.slice.call(files);

    fileArr.forEach(function(f) {
        if (!f.type.match("image.*")) {
            alert("이미지 확장자만 가능");
            return;
        }
        reader.readAsDataURL(f);

    })
}
</script>

</head>
<style>
.form-control {
    display: block;
    width: 100%;
    padding: 0.4375rem 0.875rem;
    font-size: 0.9375rem;
    font-weight: 400;
    line-height: 1.3;
    color: #697a8d;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #d9dee3;
    appearance: none;
    border-radius: 0.375rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.card {
    --bs-card-spacer-y: 1.5rem;
    --bs-card-spacer-x: 1.5rem;
    --bs-card-title-spacer-y: 0.875rem;
    --bs-card-border-width: 0;
    --bs-card-border-color: #d9dee3;
    --bs-card-border-radius: 0.5rem;
    --bs-card-box-shadow: 0 2px 6px 0 rgba(67, 89, 113, 0.12);
    --bs-card-inner-border-radius: 0.5rem;
    --bs-card-cap-padding-y: 1.5rem;
    --bs-card-cap-padding-x: 1.5rem;
    --bs-card-cap-bg: transparent;
    --bs-card-cap-color: ;
    --bs-card-height: ;
    --bs-card-color: ;
    --bs-card-bg: #fff;
    --bs-card-img-overlay-padding: 1.5rem;
    --bs-card-group-margin: 0.8125rem;
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    height: var(--bs-card-height);
    word-wrap: break-word;
    background-color: var(--bs-card-bg);
    background-clip: border-box;
    border: var(--bs-card-border-width) solid var(--bs-card-border-color);
    border-radius: var(--bs-card-border-radius);
}
.btn-label-secondary {
    color: #8592a3;
    border-color: rgba(0,0,0,0);
    background: #ebeef0;
}
.card-header {
    padding: var(--bs-card-cap-padding-y) var(--bs-card-cap-padding-x);
    margin-bottom: 0;
    color: var(--bs-card-cap-color);
    background-color: var(--bs-card-cap-bg);
    border-bottom: var(--bs-card-border-width) solid var(--bs-card-border-color);
}
h5{
font-weight: bold;
}

<style type="text/css">
.layout-menu-fixed .layout-navbar-full .layout-menu,
.layout-menu-fixed-offcanvas .layout-navbar-full .layout-menu {
  top: 62px !important;
}
.layout-page {
  padding-top: 62px !important;
}
.content-wrapper {
  padding-bottom: 46.9375px !important;
}

</style>
<body>
<sec:authentication property="principal.employee" var="empVO"/>
<%-- <div>경민체킁: ${empVO }</div> --%>
<div class="card mb-4">
      <h5 class="card-header">마이페이지</h5>
      <!-- Account -->
      <div class="card-body">
        <div class="d-flex align-items-start align-items-sm-center gap-4">
        <img src="/resources/images/${empVO.empSignImgPath}" alt="${empVO.empSignImgPath}" class="d-block rounded" height="200px" width="160px" id="uploadedAvatar">
		<input type="file" id="productImage">
          <div class="button-wrapper">
            <label for="upload" class="btn btn-primary me-2 mb-4" tabindex="0">
              <span class="d-none d-sm-block" id="uploadImgBtn">Upload new photo</span>
              <i class="bx bx-upload d-block d-sm-none"></i>
              <input type="file" id="uploadImg" class="account-file-input" hidden="" accept="images/png, images/jpeg">
            </label>
            <button type="button" class="btn btn-label-secondary account-image-reset mb-4">
              <i class="bx bx-reset d-block d-sm-none"></i>
              <span class="d-none d-sm-block">Reset</span>
              
            </button>

          </div>
        </div>
      </div>
      <div class="card-body">
        <form id="formAccountSettings" method="POST" onsubmit="return false" class="fv-plugins-bootstrap5 fv-plugins-framework" novalidate="novalidate">
          <div class="row" style="width:auto;">
          
          <div style="display:flex;  margin-bottom: 15px;">
	          <div class="mb-3 col-md-6" style="width: 49%;">
	            <label for="empNo" class="form-label">사번</label>
	            <input class="form-control" type="text" id="empNo" name="empNo" value="${empVO.empNo}" autofocus="" readonly>
	          </div>
	            
	            <div class="mb-3 col-md-6" style="width: 49%; margin-left: 20px;">
	              <label for="empNm" class="form-label">사원명</label>
	              <input class="form-control" type="text" name="empNm" id="empNm" value="${empVO.empNm }" readonly>
	            </div>
            </div>
            
            <div style="display:flex; margin-bottom: 15px;">
	            <div class="mb-3 col-md-6" style="width: 49%;">
	              <label for="empTelno" class="form-label">연락처</label>
	              <input type="text" class="form-control" id="empTelno" name="empTelno" value="${empVO.empTelno }">
	            </div>
	            <div class="mb-3 col-md-6" style="width: 49%; margin-left: 20px;">
	              <label for="empBrthdy" class="form-label">생년월일</label>
	              <input type="text" class="form-control" id="empBrthdy" name="empBrthdy" value="${empVO.empBrthdy }">
	            </div>
            </div>
            
            <div style="display:flex ; margin-bottom: 15px;">
	          <div class="mb-3 col-md-6" style="width: 49%;">
	            <label for="empEncpn" class="form-label" >입사일자</label>
	            <input class="form-control" type="text" id="empEncpn" name="empEncpn" value="${empVO.empEncpn }" readonly>
	          </div>
	          <div class="mb-3 col-md-6 " style="width: 49%; margin-left: 20px;">
	            <label for="empEmail" class="form-label" >이메일</label>
	            <input class="form-control" type="text" id="empEmail" name="empEmail" value="${empVO.empEmail }">
	          </div>
            </div>
            
            <div style="display:flex;">
	            <div style="width: 92%; ">
	              <label for="empZip" class="form-label">우편번호</label>
	              <input type="text" class="form-control" id="empZip" name="empZip" value="${empVO.empZip}" >
	            </div>
	            <div style="margin-left: 20px; margin-top: 25px;">
	              <button class="btn btn-primary me-1 mb-3" id="zipSrh">검색</button>
	            </div>
            </div>
            
            <div class="mb-3 col-md-6"  style="width: 100%;">
              <label for="empAddr" class="form-label">기본주소</label>
              <input type="text" class="form-control" id="empAddr" name="empAddr" value="${empVO.empAddr}" >
            </div>
            
            <div class="mb-3 col-md-6" style="width: 100%; margin-bottom: 15px; ">
              <label for="empDtlAddr" class="form-label">상세주소</label>
              <input type="text" class="form-control" id="empDtlAddr" name="empDtlAddr" value="${empVO.empDtlAddr}" >
            </div>
            <div class="mb-3 col-md-6" style="width: 100%;margin-bottom: 15px; ">
              <label for="empPassword" class="form-label">비밀번호</label>
              <input type="password" class="form-control" id="empPassword" name="empPassword" value="" >
            </div>
          
          <div class="mt-2" style="margin-left: 90%" >
            <button type="submit" class="btn btn-primary me-2" >저장</button>
            <button type="reset" class="btn btn-label-secondary">취소</button>
          </div>
        <input type="hidden"></form>
      </div>
      <!-- /Account -->
    </div>
</body>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script>
$(function () {
	$('#zipSrh').on('click', function () {
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete: function (data) {
				$('input[name="empZip"]').val(data.zonecode);
				$('input[name="empAddr"]').val(data.address);
				$('input[name="empDtlAddr"]').val(data.buildingName);
			}
		}).open();
	}); 
})



</script>

</html>