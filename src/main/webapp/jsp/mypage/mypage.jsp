<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/index.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/searchBar.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/route_card.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/route_card_list.css">
<style>
		/* 프로필 섹션 */
		.profile-section {
			display: flex;
			align-items: center;
			padding: 20px;
			margin-left: 200px;
		    margin-top: 30px; /* 위쪽 여백 줄이기 */
			border-radius: 10px;
			width: 90%;
			max-width: 800px;
		}
		
		.profile-section img {
			border-radius: 50%;
			width: 100px;
			height: 100px;
			margin-right: 20px;
		}
		
		.profile-details {
			margin-left: 400px;
		    margin-top: -40px;
			text-align: left;
		}
		
		.profile-details h2 {
			margin: 0 0 20px 0;
			font-size: 20px;
		    justify-content: flex-start;
		}
		
		.profile-details p {
			margin: 5px 0;
			color: #666;
		    justify-content: flex-start;
		}

        .see-more {
        	float: right;
        	color: #004d00;
        	padding-right: 3%;
        }
</style>
<script>
function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function () {
        var output = document.getElementById('profilePreview');
        if (output) {
            output.src = reader.result; // 미리보기 기능
        }
    };

    if (event.target.files.length > 0) {
        reader.readAsDataURL(event.target.files[0]);

        // 서버에 파일 업로드 요청
        var formData = new FormData();
        formData.append("profileImage", event.target.files[0]);

        fetch("/profile/upload", {
            method: "POST",
            body: formData
        })
        .then(response => response.text())
        .then(fileUrl => {
            console.log("업로드된 이미지 URL:", fileUrl);

            // 업로드된 파일을 즉시 반영 (캐싱 방지용 timestamp 추가)
            document.getElementById('profilePreview').src = fileUrl + "?t=" + new Date().getTime();
        })
        .catch(error => {
            console.error("파일 업로드 실패:", error);
        });
    }
}

// 파일 입력창 열기
function openFileInput() {
    document.getElementById('profileImageInput').click();
}
</script>

</head>
<body>
		<div>
		    <div class="search-container">
			    <div class="search-bar">
			        <form action="/searchList" method="get">
					    <select name="searchGubun">
					        <option value="formatted_address">주소</option>
					        <option value="name">장소</option>
					    </select>
					    <input type="text" name="searchStr" placeholder="search place...">
					    <button type="submit">🔍</button>
					</form>
			        
			    </div>
		    </div>
		 </div>
		 
		 <br>
		 
		 <div class="route-creat">
		  	<button onclick="location.href='/route'">새 동선 만들기</button>
		 </div> 
		 
  <!-- 프로필 섹션 -->
    <div class="profile-section">
        <!-- 프로필 이미지 -->
        <img id="profilePreview" 
			 src="${member.profile}" 
			 alt="프로필 이미지" 
			 onclick="openFileInput()" />

        <!-- 프로필 정보 -->
            <h2>${member.nickname}</h2>
            <p>${member.email}</p>
            <!-- 내 정보 수정 버튼 (모달 열기 트리거) -->
				<a href="javascript:void(0);" id="editInfoButton"
					style="margin-left: 10px; text-decoration: none; color: #004d00; font-weight: bold;">
					내 정보 수정 > </a>
    </div>

    <!-- 숨겨진 파일 입력 -->
    <form id="profileUploadForm" action="/profile/upload" method="post" enctype="multipart/form-data">
        <input type="file" id="profileImageInput" name="profileImage" accept="image/*" style="display: none;" onchange="previewImage(event)">
    </form>
				<!-- 모달 -->
				<div id="editInfoModal"
				style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
				<h2>내 정보 수정</h2>

				<!-- 닉네임 변경 -->
				<form action="/profile/update/nickname" method="post">
					<label for="nickname">닉네임 변경:</label> <input type="text"
						name="nickname" required />
					<button type="submit">변경</button>
				</form>

				<!-- 비밀번호 변경 -->
				<form action="/profile/update/password" method="post">
					<label for="password">비밀번호 변경:</label> <input type="password"
						name="password" required />
					<button type="submit">변경</button>
				</form>

				<!-- 회원 탈퇴 -->
				<form action="/profile/delete" method="post">
					<button type="submit" style="color: red;">회원 탈퇴</button>
				</form>

				<!-- 닫기 버튼 -->
				<button onclick="closeModal()">닫기</button>
			</div>

			<script>
    const modal = document.getElementById('editInfoModal');
    const button = document.getElementById('editInfoButton');

    // 클릭 시 모달 열기
    button.addEventListener('click', () => {
        modal.style.display = 'block';
    });

    // 닫기 버튼 클릭 시 모달 닫기
    function closeModal() {
        modal.style.display = 'none';
    }
</script>

	<!-- 나의 동선 섹션 -->
			<div>
			    <h2 class="section-title">나의 동선</h2>
			    <div class="card-list">
			     	<c:forEach var="route" items="${myRoutes}" varStatus="status">
				        <c:if test="${status.index < 4}">
			                <button class="card" onclick="location.href='/detail?seq_route=${route.seq_route}'">
			                    <p class="card-title">${route.title}</p>
			                    <img src="${route.photo_url}" alt="${route.title}" width="200px" height="150px">
			                     <p class="card-title">${route.nickname}</p>  
			                    <p class="card-date">등록일:${route.createdAt}</p>
			                </button>
			            </c:if>
			        </c:forEach>
			    <a href="/myRoutes" class="see-more">더보기 ></a>
			    </div>
			    <br>
			</div>

	<!-- 즐겨찾기 섹션 -->
			<div>
			    <h2 class="section-title">즐겨찾기</h2>
			    <div class="card-list">
			     	<c:forEach var="route" items="${forkRoutes}" varStatus="status">
				        <c:if test="${status.index < 4}">
			                <button class="card" onclick="location.href='/detail?seq_route=${route.seq_route}'">
			                    <p class="card-title">${route.title}</p>
			                     <img src="${route.photo_url}" alt="${route.title}" width="200px" height="150px">
			                     <p class="card-title">${route.nickname}</p>  
			                    <p class="card-date">등록일:${route.createdAt}</p>
			                </button>
			            </c:if>
			        </c:forEach>
			    <a href="/forkList" class="see-more">더보기 ></a>
			    </div>
			    <br>
			</div>


</body>
<script>
    const modal = document.getElementById('editInfoModal');
    const button = document.getElementById('editInfoButton');

    button.addEventListener('click', () => {
        modal.style.display = 'block';
    });

    function closeModal() {
        modal.style.display = 'none';
    }
	</script>
</html>