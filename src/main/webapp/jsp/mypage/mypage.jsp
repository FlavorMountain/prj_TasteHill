<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/header.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/index.css">
<style>

/* 프로필 섹션 */
.profile-section {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 20px;
    margin-left: 10px; /* 왼쪽으로 살짝 이동 */
    margin-top: 50px; /* 위쪽 여백 줄이기 */
    border-radius: 10px;
    width: 90%;
    max-width: 800px;
}

.profile-section img {
	border-radius: 50%;
	width: 100px;
    margin-top: 50px; /* 위쪽 여백 줄이기 */
	height: 100px;
	margin-right: 20px;
}

.profile-details h2 {
    margin: 0 0 20px -200px;
    font-size: 20px;
    justify-content: flex-start;
}

.profile-details p {
    margin: 5px 0 5px -200px;
    color: #666;
    justify-content: flex-start;
}

/* 카드 및 섹션 레이아웃 */
.section {
	margin-left: 20px;
	width: 90%;
	max-width: 800px;
}

.section-title {
	font-size: 20px;
	margin-left: 20px;
	text-align: left;
	color: #333;
}

.more-link {
	float: right;
	margin-top: -45px;
	color: #004d00;
	text-decoration: none;
	font-weight: bold;
}

.card-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: flex-start;
}

.card {
	width: 200px;
	border: 1px solid #ddd;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	background-color: white;
	text-align: center;
}

.card img {
	width: 100%;
	height: 150px;
	object-fit: cover;
}

.card p {
	margin: 10px 0;
	font-size: 16px;
	color: #333;
}
</style>
<script>
        // 이미지 미리보기 기능
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function () {
                var output = document.getElementById('profilePreview');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        // 파일 선택창 열기
        function openFileInput() {
            document.getElementById('profileImageInput').click();
        }
    </script>

</head>
<body>
	<!-- 헤더 -->
	<div class="header">
		<a href="/" class="header-logo">TasteHILL</a> <a href="/mypage"
			class="header-mypage">MyPage</a>
	</div>

	<!-- 프로필 이미지 영역 -->
<div class="profile-section">
    <c:choose>
        <c:when test="${not empty member.profile}">
            <img id="profilePreview" src="${member.profile}" alt="기본프로필 이미지" onclick="openFileInput()">
        </c:when>
    </c:choose>
</div>

<!-- 프로필 이미지 업로드 폼 (숨겨진 파일 입력창) -->
<form action="/mypage/profile/upload" method="post" enctype="multipart/form-data" style="display:none;">
    <input type="file" id="profileImageInput" name="profileImage" accept="image/*" onchange="previewImage(event)">
    <button type="submit" id="uploadButton">업로드</button>
</form>

		<div class="profile-details">
			<h2>nickname ${member.nickname}</h2>
			<p>
				<!-- 내 정보 수정 버튼 (모달 열기 트리거) -->
				<a href="javascript:void(0);" id="editInfoButton"
					style="margin-left: 10px; text-decoration: none; color: #004d00; font-weight: bold;">
					내 정보 수정 > </a>

				<!-- 모달 -->
			<div id="editInfoModal"
				style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
				<h2>내 정보 수정</h2>

				<!-- 닉네임 변경 -->
				<form action="/mypage/profile/update/nickname" method="post">
					<label for="nickname">닉네임 변경:</label> <input type="text"
						name="nickname" required />
					<button type="submit">변경</button>
				</form>

				<!-- 비밀번호 변경 -->
				<form action="/mypage/profile/update/password" method="post">
					<label for="password">비밀번호 변경:</label> <input type="password"
						name="password" required />
					<button type="submit">변경</button>
				</form>

				<!-- 회원 탈퇴 -->
				<form action="/mypage/profile/delete" method="post">
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
			</p>

		</div>
	</div>
	<!-- 나의 동선 섹션 -->
	<div class="section">
		<h3 class="section-title">나의 동선</h3>
		<a href="<%=request.getContextPath()%>/mypage/my-routes"
			class="more-link">더보기 ></a>
		<div class="card-container">
			<c:forEach var="route" items="${myRoutes}">
				<div class="card">
					<img src="${route.image}" alt="동선 이미지">
					<p>${route.title}</p>
					<p>등록일 ${route.date}</p>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 즐겨찾기 섹션 -->
	<div class="section">
		<h3 class="section-title">즐겨찾기</h3>
		<a href="<%=request.getContextPath()%>/mypage/favorites"
			class="more-link">더보기 ></a>
		<div class="card-container">
			<c:forEach var="route" items="${favoriteRoutes}">
				<div class="card">
					<img src="${route.image}" alt="동선 이미지">
					<p>${route.title}</p>
					<p>등록일 ${route.date}</p>
				</div>
			</c:forEach>
		</div>
	</div>


	<!-- 링크 목록 -->
	<nav>
		<a href="<%=request.getContextPath()%>/jsp/main/main.jsp">메인 페이지</a> <a
			href="<%=request.getContextPath()%>/jsp/detail/route_detail.jsp">루트
			상세 페이지</a> <a
			href="<%=request.getContextPath()%>/jsp/route/route_create.jsp">루트
			생성 페이지</a> <a
			href="<%=request.getContextPath()%>/jsp/route/route_list.jsp">루트
			리스트 - 나의 동선</a> <a
			href="<%=request.getContextPath()%>/jsp/route/route_list.jsp">루트
			리스트 - 즐겨찾기</a>
	</nav>
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