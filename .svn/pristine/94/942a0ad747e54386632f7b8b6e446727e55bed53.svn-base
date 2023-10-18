<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-layout-mode="dark" data-body-image="img-1" data-preloader="disable">
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<style>
img{
	width: 650px;
	height: 450px;
	margin-left: 33%;
}
</style>
<head>

    <meta charset="utf-8" />
    <title>403 ErrorPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesbrand" name="author" />

</head>

<body>

    <div class="auth-page-wrapper pt-5">

        <!-- auth page content -->
        <div class="auth-page-content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="text-center pt-4" >
                            <div class="mt-n4" style="text-align : center;margin-top:6%;">
                                <h1 class="display-1 fw-medium">서버연결 오류</h1>
                                <h3 class="text-uppercase">서버연결이 원활하지 않습니다.</h3>
                                <p class="text-muted mb-4"> <span id="sec">4</span>초 후 이전화면으로 이동합니다...</p>
                            </div>
                            <div class="">
                                <img src="/resources/images/에러01.jpg" alt="에러" >
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

            </div>
            <!-- end container -->
        </div>
        <!-- end auth page content -->

    </div>
    <!-- end auth-page-wrapper -->

<script>
$(function(){
	countDown();
});

function countDown(){
    var seconds = parseInt($('#sec').html());
    if (seconds > 0) {
    	$('#sec').html(seconds-1)
        setTimeout(countDown, 1000); // 1초(1000밀리초)마다 호출
    } else {
        // 0이 되면 페이지 이동
        history.back();
    }
}
</script>


</body>

</html>