<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<style>

		.search-container {
		    display: flex;
		    justify-content: center; /* 가로 정렬 */
		    align-items: center; /* 세로 정렬 */
		    height: 10px; /* 원하는 높이를 설정 */
		    margin-top: 20px; /* 상단 여백 */
		}
		
		.search-container button {
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .search-container input[type="text"] {
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 300px;
        }
        
        .search-bar {
		    display: flex;
		    align-items: center;
		    gap: 30px; /* 입력 필드와 버튼 간 간격 */
		}

		.route-creat{
        	float: right;
        	padding-right: 10%;
		}
		
		.route-creat button{
			height: 30px;
			background-color: white;
            color: #004d00;
            border: 5px;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
		}
		
		.route-creat button:hover {
			height: 30px;
			background-color: rgba(0, 77, 0, 0.8);
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
		}
		
        /* 섹션 제목 */
        .section-title {
            font-size: 18px;
            font-weight: bold;
            margin: 20px 0 10px;
            color: #004d00;
            margin-left: 3%;
        }

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

        /* 카드 리스트 */
        .card-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 10px;
            justify-content: space-between; /* 양쪽 균등 정렬 */
		    margin: 0 5%; /* 왼쪽, 오른쪽 5% 여백 */
        }

        /* 카드 스타일 */
        .card {
            width: 300px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .card .card-title {
            font-size: 16px;
            font-weight: bold;
            margin: 10px 0;
            color: #333;
        }

        .card .card-date {
            font-size: 14px;
            color: #888;
            margin-bottom: 10px;
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
	<!-- 헤더 -->
<!-- 	<div class="header"> -->
<!-- 		<a href="/" class="header-logo">TasteHILL</a> <a href="/mypage" -->
<!-- 			class="header-mypage">MyPage</a> -->
<!-- 	</div> -->
	
		<!-- 검색 바 -->
		<div>
		    <div class="search-container">
			    <div class="search-bar">
			        <form action="/searchList" method="get">
					    <select name="location">
		            	    <option value="">위치</option>
					        <option value="서울">서울</option>
					        <option value="부산">부산</option>
					    </select>
					    <input type="text" name="query" placeholder="search place...">
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
			                    <p class="card-date">등록일:${route.createdAt}</p>
			                </button>
			            </c:if>
			        </c:forEach>
			    <a href="/myroutes" class="see-more">더보기 ></a>
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