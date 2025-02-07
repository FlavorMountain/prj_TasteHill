<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/header.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/index.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/searchBar.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/route_card.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/route_card_list.css">
<style>
/* 프로필 섹션 */
.profile-section {
	display: flex;
	align-items: center;
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
	<div class="container" style="margin-top: 130px;">
		<div class="row justify-content-between">
			<div class="col-lg-2"></div>
			<div class="col-lg-6">
				<div class="position-relative mx-auto"></div>
			</div>
			<div class="col-lg-2">
				<div class="position-relative mx-auto">
					<a href="/route"
						class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-3 text-white"
						style="top: 0; right: 0; margin-top: 2px;">동선 작성</a>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid mt-5">
		<div class="container py-2">
			<div class="row g-4 mb-5">
				<div class="col-lg-8 col-xl-9">
					<div class="row g-4">
						<div class="col-lg-2">
							<div class="border rounded">
								<a href="#"> <img src="${member.profile}" id="profilePreview"
									class="img-thumbnail rounded " alt="Image" onclick="openFileInput()" style="max-width: 100%">
								</a>
							</div>
						</div>
						<div class="col-lg-6">
							<h4 class="fw-bold mb-3">${member.nickname}</h4>
							<p class="mb-3">${member.email}</p>
							<p class="mb-4">
								<a href="javascript:void(0);" id="editInfoButton"
									style="margin-left: 10px; text-decoration: none; color: #004d00; font-weight: bold;">
									내 정보 수정 > </a>
							</p>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 숨겨진 파일 입력 -->
	<form id="profileUploadForm" action="/profile/upload" method="post"
		enctype="multipart/form-data">
		<input type="file" id="profileImageInput" name="profileImage"
			accept="image/*" style="display: none;"
			onchange="previewImage(event)">
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

	<div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="tab-class text-center">
				<div class="row g-4 justify-content-between">
					<div class="col-lg-4 text-start">
						<h1>나의 동선</h1>
					</div>
					<div class="col-lg-4 text-end">
						<a href="/myRoutes">더보기 ></a>
					</div>
				</div>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="row g-4">
									<c:forEach var="route" items="${myRoutes}" varStatus="status">
										<c:if test="${status.index < 4}">
											<div class="col-md-6 col-lg-4 col-xl-3">
												<div class="rounded position-relative fruite-item">
													<div class="fruite-img">
														<img src="${route.photo_url}"
															class="img-fluid w-100 rounded-top" alt="">
													</div>
													<div
														class="p-4 border border-secondary border-top-0 rounded-bottom">
														<h5>${route.title}</h5>
														<p>${route.nickname}</p>
														<div class="d-flex justify-content-center flex-lg-wrap">
															<p class="text-dark fs-5 fw-bold mb-1">등록일:${route.createdAt}</p>
															<a href="/detail?seq_route=${route.seq_route}"
																class="btn border border-secondary rounded-pill px-3 text-primary">
																보러가기 </a>
														</div>
													</div>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="tab-class text-center">
				<div class="row g-4 justify-content-between">
					<div class="col-lg-4 text-start">
						<h1>즐겨찾기</h1>
					</div>
					<div class="col-lg-4 text-end">
						<a href="/forkList">더보기 ></a>
					</div>

				</div>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="row g-4">
									<c:forEach var="route" items="${forkRoutes}" varStatus="status">
										<c:if test="${status.index < 4}">
											<div class="col-md-6 col-lg-4 col-xl-3">
												<div class="rounded position-relative fruite-item">
													<div class="fruite-img">
														<img src="${route.photo_url}"
															class="img-fluid w-100 rounded-top" alt="">
													</div>
													<div
														class="p-4 border border-secondary border-top-0 rounded-bottom">
														<h5>${route.title}</h5>
														<p>${route.nickname}</p>
														<div class="d-flex justify-content-center flex-lg-wrap">
															<p class="text-dark fs-5 fw-bold mb-1">등록일:${route.createdAt}</p>
															<a href="/detail?seq_route=${route.seq_route}"
																class="btn border border-secondary rounded-pill px-3 text-primary">
																보러가기 </a>
														</div>
													</div>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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