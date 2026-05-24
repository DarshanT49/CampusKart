<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CampusKart | Authentication</title>

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap"
	rel="stylesheet">
<!-- Bootstrap 5.3.3 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">

<style>
:root {
	--primary: #0d9488;
	--primary-light: #2dd4bf;
	--primary-dark: #0f766e;
	--bg-auth: #f1f5f9;
	--text-main: #1e293b;
}

body {
	font-family: 'Inter', sans-serif;
	background-color: var(--bg-auth);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 20px;
	overflow-x: hidden;
}

/* --- AUTH CARD --- */
.auth-card {
	background: white;
	border-radius: 24px;
	box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 950px;
	min-height: 650px;
	display: flex;
	overflow: hidden;
	position: relative;
}

/* --- INFO OVERLAY PANEL --- */
.info-panel {
	flex: 1;
	background: linear-gradient(135deg, var(--primary-dark), var(--primary));
	color: white;
	padding: 50px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	transition: all 0.6s cubic-bezier(0.68, -0.55, 0.27, 1.55);
	z-index: 5;
}

.info-panel h2 {
	font-family: 'Poppins', sans-serif;
	font-weight: 700;
	margin-bottom: 20px;
}

/* --- FORM PANEL --- */
.form-panel {
	flex: 1.4;
	padding: 40px 50px;
	background: white;
	transition: all 0.6s ease;
}

.form-panel h3 {
	font-family: 'Poppins', sans-serif;
	font-weight: 700;
	margin-bottom: 25px;
	color: var(--text-main);
}

/* --- TRANSITIONS --- */
.auth-card.register-active .info-panel {
	transform: translateX(140%);
	border-radius: 0 24px 24px 0;
}

.auth-card.register-active .form-panel {
	transform: translateX(-71.5%);
}

/* --- FORM STYLING --- */
.form-control, .form-select {
	border-radius: 12px;
	padding: 10px 16px;
	border: 1px solid #e2e8f0;
	font-size: 0.9rem;
	margin-bottom: 3px;
}

.form-control:focus {
	border-color: var(--primary-light);
	box-shadow: 0 0 0 4px rgba(45, 212, 191, 0.1);
}

.btn-auth {
	background: var(--primary);
	color: white;
	border-radius: 12px;
	padding: 12px;
	font-weight: 600;
	border: none;
	width: 100%;
	margin-top: 15px;
	transition: all 0.3s;
}

.btn-auth:hover {
	background: var(--primary-dark);
	transform: translateY(-2px);
}

.toggle-link {
	color: var(--primary);
	font-weight: 600;
	text-decoration: none;
	cursor: pointer;
}

.x-small {
	font-size: 0.75rem;
}

/* Hidden section for unlisted college */
#otherCollegeSection {
	display: none;
	background: #f8fafc;
	padding: 15px;
	border-radius: 12px;
	border: 1px dashed #cbd5e1;
	margin-top: 10px;
}

.animate-fade {
	animation: fadeIn 0.5s ease;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@media ( max-width : 992px) {
	.auth-card {
		flex-direction: column;
		max-width: 500px;
	}
	.info-panel {
		display: none;
	}
	.auth-card.register-active .form-panel {
		transform: none;
	}
}
</style>
</head>
<body>

	<!-- Back to Home Button -->
	<a href="home"
		class="btn btn-white shadow-sm position-absolute top-0 start-0 m-4 rounded-pill border">
		<i class="bi bi-arrow-left me-2"></i> Home
	</a>

	<div class="auth-card shadow-lg" id="authCard">

		<!-- INFO PANEL: Content is "opposite" to the active form -->
		<div class="info-panel" id="infoPanel">
			<!-- Show this when LOGIN form is visible -->
			<div id="loginInfo">
				<h2>New to the Campus?</h2>
				<p class="opacity-75 mb-4">Start your journey today! Join
					thousands of students buying and selling study materials. It's
					safe, fast, and exclusive to your campus community.</p>
				<button class="btn btn-outline-light rounded-pill px-4 fw-bold"
					onclick="toggleAuth(true)">Create Account</button>
			</div>
			<!-- Show this when REGISTER form is visible -->
			<div id="registerInfo" style="display: none;">
				<h2>Welcome Back!</h2>
				<p class="opacity-75 mb-4">Already have an account? Log in to
					manage your listings, chat with interested buyers, and discover the
					best deals for your next semester.</p>
				<button class="btn btn-outline-light rounded-pill px-4 fw-bold"
					onclick="toggleAuth(false)">Sign In</button>
			</div>
		</div>

		<!-- FORM PANEL -->
		<div class="form-panel">

			<!-- LOGIN SECTION -->
			<div id="loginSection" class="animate-fade">
				<h3>Member Login</h3>
				<p class="text-muted small mb-4">Access your marketplace and
					connect with peers.</p>

				<form action="loginUser" method="POST">
					<div class="mb-3">
						<label class="form-label small fw-bold">College Email</label> <input
							type="email" name="email" class="form-control"
							placeholder="you@college.edu.in" required>
					</div>
					<div class="mb-4">
						<label class="form-label small fw-bold">Password</label> <input
							type="password" name="password" class="form-control"
							placeholder="••••••••" required>
					</div>
					<button type="submit" class="btn-auth mb-3 shadow-sm">Sign
						In</button>
					<p class="text-center small text-muted d-lg-none">
						New user? <span class="toggle-link" onclick="toggleAuth(true)">Register
							Now</span>
					</p>
				</form>
			</div>

			<!-- REGISTER SECTION -->
			<div id="registerSection" style="display: none;" class="animate-fade">
				<h3>Join CampusKart</h3>
				<p class="text-muted small mb-4">Register to start trading
					within your campus.</p>

				<form action="registerUser" method="POST">
					<div class="row g-2">
						<div class="col-md-6 mb-2">
							<label class="form-label x-small fw-bold">Full Name</label> <input
								type="text" name="name" class="form-control"
								placeholder="John Doe" required>
						</div>
						<div class="col-md-6 mb-2">
							<label class="form-label x-small fw-bold">Email</label> <input
								type="email" name="email" class="form-control"
								placeholder="you@college.edu" required>
						</div>
					</div>

					<div class="row g-2">
						<div class="col-md-6 mb-2">
							<label class="form-label x-small fw-bold">Phone Number</label> <input
								type="tel" name="phone" class="form-control"
								placeholder="+91 98765 43210" required>
						</div>
						<div class="col-md-6 mb-2">
							<label class="form-label x-small fw-bold">College</label> <select
								class="form-select" name="collegeId" id="collegeSelect"
								onchange="checkCollege(this)" required>

								<option value="">Select</option>

								<c:forEach var="college" items="${colleges}">
									<option value="${college.id}">${college.name}</option>
								</c:forEach>

								<!-- 🔥 Not Listed Option -->
								<option value="0">Not Listed?</option>

							</select>
						</div>
					</div>

					<div id="otherCollegeSection" class="animate-fade mb-2">
						<input type="text" class="form-control mb-2" id="otherCollegeName"
							name="collegeName" placeholder="Full College Name"> <input
							type="text" class="form-control mb-2" id="otherCollegeAddress"
							name="address" placeholder="College Address"> <input
							type="number" class="form-control" id="otherCollegePin"
							name="pincode" placeholder="Pincode">
					</div>

					<div class="row g-2">
						<div class="col-md-6 mb-3">
							<label class="form-label x-small fw-bold">Password</label> <input
								type="password" name="password" id="regPass"
								class="form-control" placeholder="••••••••" required>
						</div>
						<div class="col-md-6 mb-3">
							<label class="form-label x-small fw-bold">Confirm
								Password</label> <input type="password" id="regConfirmPass"
								class="form-control" placeholder="••••••••" required>
						</div>
					</div>

					<button type="submit" class="btn-auth mb-3 shadow-sm">Create
						Account</button>
					<p class="text-center small text-muted d-lg-none">
						Already a member? <span class="toggle-link"
							onclick="toggleAuth(false)">Login</span>
					</p>
				</form>
			</div>

		</div>
	</div>

	<!-- Toast Container -->
	<div
		class="toast-container position-fixed bottom-0 start-50 translate-middle-x p-3">
		<div id="authToast"
			class="toast align-items-center text-white bg-dark border-0"
			role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body" id="toastMsg"></div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>
	</div>
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        function toggleAuth(isRegister) {
            const card = document.getElementById('authCard');
            const loginSection = document.getElementById('loginSection');
            const registerSection = document.getElementById('registerSection');
            const loginInfo = document.getElementById('loginInfo');
            const registerInfo = document.getElementById('registerInfo');

            if (isRegister) {
                card.classList.add('register-active');
                loginSection.style.display = 'none';
                registerSection.style.display = 'block';
                loginInfo.style.display = 'none';
                registerInfo.style.display = 'block';
            } else {
                card.classList.remove('register-active');
                loginSection.style.display = 'block';
                registerSection.style.display = 'none';
                loginInfo.style.display = 'block';
                registerInfo.style.display = 'none';
            }
        }

        function checkCollege(select) {
            const otherSection = document.getElementById('otherCollegeSection');
            const fields = ['otherCollegeName', 'otherCollegeAddress', 'otherCollegePin'];
            if (select.value === '0') {
                otherSection.style.display = 'block';
                fields.forEach(f => document.getElementById(f).required = true);
            } else {
                otherSection.style.display = 'none';
                fields.forEach(f => document.getElementById(f).required = false);
            }
        }
    </script>
</body>
</html>
