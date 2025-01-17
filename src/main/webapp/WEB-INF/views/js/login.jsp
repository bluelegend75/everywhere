<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    
    <!-- 구글 폰트 및 스타일링 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" />
    
    <!-- CSS 스타일 -->
    <style>
        * {
            margin: 0;
            font-family: "Noto Sans KR", sans-serif;
        }

        a {
            text-decoration: none;
        }

        img {
            display: block;
        }

        ul,
        li {
            padding: 0;
            list-style: none;
            margin: 0;
        }

        .content_zone {
            width: 100%;
            display: flex;
            justify-content: center;
        }

        .content_zone .content_zone_wrap {
            width: 100%;
            max-width: 57rem;
            display: flex;
            justify-content: center;

            align-items: center;
        }

        .content_zone1 {
            height:100vh;
        }



        .login_container {

            width: 100%;
            max-width: 350px;


        }

        .login_container h1 {
            display: flex;
            justify-content: center;
            text-align: center;
            margin-bottom: 20px;
        }

        button {
            width: 100%;

            margin: 5px 0;
            border: none;
            cursor: pointer;

        }

        .kakao_btn {
            background-color: #FFEB00;
            padding: 10px 0px;
            border-radius: 10px;
            box-sizing: border-box;

        }

        .naver_btn {
            background-color: #03C75A;
            color: white;
            padding: 10px 0px;
            border-radius: 10px;
            box-sizing: border-box;
        }


        #input_id {
            font-weight: bold;


        }

        #input_pw {
            font-weight: bold;

        }

        .login_container .text_deco {
            margin-bottom: 10px;
        }

        .login_container .put_user {
            width: 100%;
            margin-bottom: 20px;
            padding: 10px 10px;
            border-radius: 10px;
            border: 2px solid #007bff;
            box-sizing: border-box;

        }


        .tab_container {
            width: 100%;
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            text-align: center;

            margin-bottom: 15px;

        }

        .tab_btn {
            width: 100%;
            border: 1px solid #007bff;
            background-color: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 5px;
            border-radius: 10px;
            color: #007bff;
        }

        .tab_btn.active {
            background-color: #007bff;
            font-weight: bold;
            color: white;
        }

        .login_btn {
            width: 100%;
            background-color: #007bff;
            border: none;
            color: white;
            box-sizing: border-box;
            padding: 10px 0px;
            border-radius: 10px;
            margin-bottom: 5px;
            cursor: pointer;
        }

        .autoLogin_box {
            margin-bottom: 10px;
        }

        .autoLogin_box label {
            font-size: 14px;
        }

        .regi {
            width: 100%;
            border-bottom: 1px solid #b0b0b0;
            margin-top: 10px;
            padding: 0px 0px 10px 0px;
        }

        .regi a {
            color: black;
            font-size: 14px;
        }

        .login_form {
            margin-bottom: 20px;
        }

        .find_user {
            width: 100%;
            display: flex;
            justify-content: space-between;
        }

        .regi_user {
            width: 100%;
            border: 1px solid #007bff;
            box-sizing: border-box;
            padding: 10px 0px;
            border-radius: 10px;
            margin-bottom: 20px;
            cursor: pointer;
            text-align: center;
        }

        .regi_user a {
            color: #007bff;
            font-size: 12px;
        }

        .business_info {
            margin-top: 10px;
            color: red;
            font-size: 12px;
        }
    </style>
    
    <!-- 자바스크립트 라이브러리 및 SDK -->
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	 
    <!-- 페이지 로드 시 동작 -->
    <script type="text/javascript">
        window.onload = function() {
        	
        	
            var hash = window.location.hash.substr(1);
            var params = new URLSearchParams(hash);
            var accessToken = params.get('access_token');
            var state = params.get('state');
            
            if (accessToken && state) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/naver/callback', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.send('accessToken=' + encodeURIComponent(accessToken) + '&state=' + encodeURIComponent(state));

                window.location.href = '/index';
            }

            
        }
        
        $(document).ready(function () {
            // 개인 회원 탭 클릭 시
            $('#personalTab').click(function () {
                $('#personalForm').show();       // 개인 회원 폼 표시
                $('#businessForm').hide();       // 사업자 회원 폼 숨기기
                $(this).addClass('active');      // 현재 탭 활성화
                $('#businessTab').removeClass('active'); // 다른 탭 비활성화
            });

            // 사업자 회원 탭 클릭 시
            $('#businessTab').click(function () {
                $('#personalForm').hide();       // 개인 회원 폼 숨기기
                $('#businessForm').show();       // 사업자 회원 폼 표시
                $(this).addClass('active');      // 현재 탭 활성화
                $('#personalTab').removeClass('active'); // 다른 탭 비활성화
            });
        });
        

        document.addEventListener('DOMContentLoaded', function() {
            const kakaoApiKey = "${kakaoApiKey}";
            window.Kakao.init(kakaoApiKey);
            console.log("카카오 API [정상]");
            forceKakaoUnlink();
            
            const accessToken = window.Kakao.Auth.getAccessToken();
            if (accessToken) {
                console.log("현재 Kakao Access Token:", accessToken);
                checkKakaoLogin();
            } else {
                console.log("카카오 로그인 [가능]");
            }

            const kakaoLoginButton = document.getElementById('kakaoLoginButton');
            if (kakaoLoginButton) {
                kakaoLoginButton.addEventListener('click', kakaoLogin);
            } else {
                console.warn("kakaoLoginButton 요소를 찾을 수 없습니다.");
            }

            kakaoLogout();
        });

        function checkKakaoLogin() {
            const accessToken = window.Kakao.Auth.getAccessToken();
            if (accessToken) {
                window.Kakao.API.request({
                    url: '/v2/user/me',
                    success: function(res) {
                        console.log("로그인 상태로 확인됨", res);
                    },
                    fail: function(error) {
                        console.error("사용자 정보 요청 실패", error);
                        kakaoLogout();
                    }
                });
            } else {
                console.log("로그인 상태가 아닙니다.");
            }
        }

        function kakaoLogin() {
            window.Kakao.Auth.setAccessToken(null); 

            window.Kakao.Auth.login({
                scope: 'profile_nickname, profile_image',
                throughTalk: false,
                success: function(authObj) {
                    console.log("로그인 성공", authObj);
                    window.Kakao.API.request({
                        url: '/v2/user/me',
                        success: function(res) {
                            const kakao_account = res.kakao_account;
                            console.log("사용자 정보", kakao_account);

                            fetch('/kakao/callback', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'accessToken=' + authObj.access_token,
                            }).then(response => {
                                if (response.redirected) {
                                    window.location.href = response.url;
                                } else {
                                    window.location.href = '/index'; 
                                }
                            });
                        },
                        fail: function(error) {
                            console.error("API 요청 실패", error);
                        }
                    });
                },
                fail: function(error) {
                    console.error("로그인 실패", error);
                }
            });
        }

        function kakaoLogout() {
            const accessToken = window.Kakao.Auth.getAccessToken();
            if (!accessToken) {
                return;
            }

            window.Kakao.Auth.logout(function() {
                console.log("카카오 로그아웃 성공");
                window.Kakao.Auth.setAccessToken(null);
                clearStorage();
                
                fetch('/js/logout', {
                    method: 'GET',
                }).then(response => {
                    if (response.ok) {
                        console.log("서버 세션도 정상적으로 무효화되었습니다.");
                        window.location.href = "/js/login"; 
                    } else {
                        console.error("서버 로그아웃 실패");
                    }
                }).catch(error => {
                    console.error("서버 로그아웃 요청 중 오류 발생", error);
                });
            }, function(error) {
                console.error("카카오 로그아웃 오류", error);
                forceLogout();
            });
        }

        function forceKakaoUnlink() {
            const accessToken = window.Kakao.Auth.getAccessToken();
            if (!accessToken) {
                console.log("로그아웃 [정상]");
                return;
            }

            window.Kakao.API.request({
                url: '/v1/user/unlink',
                success: function (response) {
                    console.log("카카오 계정 연결 해제 완료", response);
                    kakaoLogout();
                },
                fail: function (error) {
                    console.error("카카오 계정 연결 해제 실패", error);
                }
            });
        }

        function forceLogout() {
            clearStorage();
            window.Kakao.Auth.setAccessToken(null);
            window.location.href = "/js/login"; 
        }

        function clearStorage() {
            localStorage.clear();
            sessionStorage.clear();
            console.log("LocalStorage와 SessionStorage가 클리어되었습니다.");

            document.cookie.split(";").forEach(function(c) {
                document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/;domain=" + window.location.hostname);
            });
            console.log("쿠키가 클리어되었습니다.");
        }
    </script>
</head>

<body>
    <%@ include file="/WEB-INF/views/include/header.jsp"%>
    <section class="content_zone content_zone1">
        <div class="content_zone_wrap">
           <div class="login_container">
                <h1>방방곡곡 로그인</h1>

                <!-- 탭 버튼 -->
                <div class="tab_container">
                    <div class="tab_btn active" id="personalTab">개인 회원</div>
                    <div class="tab_btn" id="businessTab">사업자 회원</div>
                </div>

                <!-- 개인 회원 폼 -->
                <div id="personalForm">
                    <form action="/login_success" method="post" class="login_form">
                        <p id="input_id" class="text_deco" >아이디 </p>
                        <input class="put_user" type="text" placeholder="아이디 입력" name="user_id">
                        <p id="input_pw" class="text_deco">비밀번호 </p>
                        <input class="put_user" type="password" placeholder="비밀번호 입력" name="user_pw">
                        <div class="autoLogin_box">
                            <input type="checkbox" id="autoLogin" name="email_auto" value="autoLogin">
                            <label for="autoLogin">자동 로그인</label>
                        </div>

                        <input class="login_btn" type="submit" value="로그인">
                        <div class="regi">

                            <div class="regi_user">
                                <a href="/email_login">
                                    <p>회원가입하기</p>
                                </a>
                            </div>
                            <div class="find_user">
                                <a href="/js/userIdFind">
                                    <p>아이디 찾기</p>
                                </a>
                                <a href="/js/userPwFind">
                                    <p>비밀번호 찾기</p>
                                </a>
                            </div>
                        </div>

                    </form>


                    <!-- 카카오 로그인 버튼 -->
                    <button id="kakaoLoginButton" class="kakao_btn">카카오 로그인</button>

                    <!-- 네이버 로그인 버튼 -->
                    <form method="get" action="/naver/callback">
                        <div id="naver_id_login"></div>
                        <button type="button" onclick="location.href='${url}'" class="naver_btn">네이버 로그인</button>
                    </form>
                </div>

                <!-- 사업자 회원 폼 -->
                <div id="businessForm" style="display: none;">
                    <form action="/biz_success" method="post" class="login_form">
                        <p id="input_id" class="text_deco" >사업자번호 </p>
                        <input class="put_user" type="text" placeholder="사업자번호 입력" name="biz_no">
                        <p id="input_pw" class="text_deco">비밀번호 </p>
                        <input class="put_user" type="password" placeholder="비밀번호 입력" name="biz_pw">
                        <div class="autoLogin_box">
                            <input type="checkbox" id="autoLogin" name="email_auto" value="autoLogin">
                            <label for="autoLogin">자동 로그인</label>
                        </div>

                        <input class="login_btn" type="submit" value="로그인">
                        <div class="regi">

                            <div class="regi_user">
                                <a href="/b2b_login">
                                    <p>회원가입하기</p>
                                </a>
                            </div>
                            <div class="find_user">
                                <a href="">
                                    <p>아이디 찾기</p>
                                </a>
                                <a href="">
                                    <p>비밀번호 찾기</p>
                                </a>
                            </div>
                        </div>

                        <div class="business_info">
                        	<a href="/admin">admin로그인 이동</a>
                            <p>사업자는 본 홈페이지의 회원가입을 통해서만 이용이 가능합니다.</p>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </section>
</body>
</html>