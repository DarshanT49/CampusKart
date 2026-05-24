<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CampusKart | Sell Your Item</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">
<style>
:root {
	--primary: #14b8a6;
	--primary-hover: #0d9488;
}

body {
	font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
	background: #f1f5f9;
	color: #1e293b;
}

.navbar {
	background: rgba(255, 255, 255, 0.9) !important;
	backdrop-filter: blur(12px);
	border-bottom: 1px solid #e2e8f0;
}

.card {
	border-radius: 20px;
	overflow: hidden;
}

.form-label {
	font-size: 0.9rem;
	margin-bottom: 0.5rem;
	color: #475569;
}

.form-control, .form-select {
	border-radius: 10px;
	padding: 12px 16px;
	border: 1px solid #cbd5e1;
	transition: all 0.2s ease;
}

.form-control:focus, .form-select:focus {
	border-color: var(--primary);
	box-shadow: 0 0 0 4px rgba(20, 184, 166, 0.1);
}

.btn-primary {
	background-color: var(--primary);
	border: none;
	border-radius: 12px;
	font-weight: 600;
	padding: 14px;
	transition: all 0.3s;
}

.btn-primary:hover {
	background-color: var(--primary-hover);
	transform: translateY(-1px);
}

.upload-box {
	border: 2px dashed #cbd5e1;
	border-radius: 12px;
	padding: 20px;
	text-align: center;
	cursor: pointer;
	transition: all 0.2s;
}

.upload-box:hover {
	border-color: var(--primary);
	background: #f0fdfa;
}

.section-title {
	font-size: 1.1rem;
	font-weight: 700;
	color: #0f172a;
	border-left: 4px solid var(--primary);
	padding-left: 12px;
	margin-bottom: 20px;
}
</style>
</head>
<body>

	<!-- NAVBAR -->
	<jsp:include page="components/Navbar.jsp"></jsp:include>

	<div class="container py-5 mt-5">
		<div class="row justify-content-center">
			<div class="col-lg-10 col-xl-8">

				<c:if test="${param.success == 'true'}">

					<c:if test="${param.error == 'invalidImage'}">
						<div
							class="alert alert-danger alert-dismissible fade show mb-4 rounded-4"
							role="alert">
							<strong>Error!</strong> Only JPG and PNG images are allowed.
							<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
						</div>
					</c:if>

					<div
						class="alert alert-success alert-dismissible fade show mb-4 rounded-4"
						role="alert">
						<strong>Awesome!</strong> Your product has been listed
						successfully.
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:if>

				<div class="card shadow-lg border-0">
					<div class="card-header bg-white border-0 pt-5 text-center">
						<span
							class="badge bg-soft-primary text-primary mb-2 px-3 py-2 rounded-pill"
							style="background: #ccfbf1; color: #0f766e;">MARKETPLACE</span>
						<h2 class="fw-bold text-dark">Sell Something Amazing</h2>
						<p class="text-muted">Fill in the details below to reach your
							campus community.</p>
					</div>

					<div class="card-body p-4 p-md-5">
						<form action="addProduct" method="POST"
							enctype="multipart/form-data">

							<!-- Basic Information -->
							<div class="section-title">Basic Details</div>
							<div class="row g-4 mb-5">
								<div class="col-12">
									<label class="form-label fw-medium">Product Title</label> <input
										type="text" name="title" class="form-control"
										placeholder="e.g., Apple MacBook Air M2 2023" required>
								</div>
								<div class="col-12">
									<label class="form-label fw-medium">Short Description
										(One liner)</label> <input type="text" name="shortDescription"
										class="form-control"
										placeholder="e.g., 8GB RAM, 256GB SSD, Space Grey, 6 months warranty"
										required>
								</div>
								<div class="col-md-6">
									<label class="form-label fw-medium">Category</label> <select
										name="categoryId" class="form-select" required>
										<option value="" selected disabled>Select Category</option>
										<c:forEach items="${categories}" var="cat">
											<c:if test="${cat.status == 'ACTIVE'}">
												<option value="${cat.id}">${cat.name}</option>
												
											</c:if>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-6">
									<label class="form-label fw-medium">Price (₹)</label>
									<div class="input-group">
										<span class="input-group-text bg-white border-end-0">₹</span>
										<input type="number" name="price"
											class="form-control border-start-0" placeholder="0.00"
											required>
									</div>
								</div>
							</div>

							<!-- Additional Details -->
							<div class="section-title">Product Details</div>
							<div class="row g-4 mb-5">
								<div class="col-md-6">
									<label class="form-label fw-medium">Condition</label> <select
										name="productCondition" class="form-select">
										<option value="Brand New">Brand New</option>
										<option value="Like New">Like New</option>
										<option value="Good Condition" selected>Good
											Condition</option>
										<option value="Fair">Fair</option>
									</select>
								</div>
								<div class="col-md-6">
									<label class="form-label fw-medium">Brand (Optional)</label> <input
										type="text" name="brand" class="form-control"
										placeholder="e.g., Apple, Sony, HP">
								</div>
								<div class="col-12">
									<label class="form-label fw-medium">Full Description</label>
									<textarea name="description" class="form-control" rows="4"
										placeholder="Mention features, defects, or reason for selling..."
										required></textarea>
								</div>

							</div>

							<!-- Media -->
							<div class="section-title">Upload Photos</div>
							<div class="row g-4 mb-5">
								<div class="col-md-6">
									<label class="form-label fw-medium">Primary Image</label> <input
										type="file" name="imageFile1" class="form-control"
										accept="image/png, image/jpeg" required>
								</div>

								<div class="col-md-6">
									<label class="form-label fw-medium">Secondary Image</label> <input
										type="file" name="imageFile2" accept="image/png, image/jpeg"
										class="form-control">
								</div>
							</div>

							<div class="pt-3">
								<button type="submit"
									class="btn btn-primary btn-lg w-100 py-3 shadow-sm">
									<i class="bi bi-rocket-takeoff me-2"></i> List Product Now
								</button>
								<p class="text-center mt-3 small text-muted">By listing, you
									agree to our Marketplace Guidelines.</p>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>
	<!-- FOOTER -->
	<jsp:include page="components/Footer.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
