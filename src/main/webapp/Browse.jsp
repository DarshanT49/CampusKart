<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Browse Marketplace | CampusKart</title>

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">

<style>
body {
	font-family: 'Inter', sans-serif;
	background: #f8fafc;
	padding-top: 80px;
}

.filter-sidebar {
	background: white;
	border-radius: 20px;
	padding: 24px;
	border: 1px solid #e2e8f0;
}

.product-card {
	background: white;
	border-radius: 16px;
	border: 1px solid #f1f5f9;
	transition: .3s;
	height: 100%;
}

.product-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
}

.product-img-container {
	aspect-ratio: 16/11;
	overflow: hidden;
}

.product-img-container img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.condition-badge {
	position: absolute;
	top: 10px;
	left: 10px;
	background: white;
	padding: 4px 10px;
	border-radius: 50px;
	font-size: 12px;
	font-weight: 600;
}

.product-price {
	font-weight: 700;
	font-size: 18px;
	color: #0d9488;
}
</style>
</head>

<body>

	<jsp:include page="components/Navbar.jsp"></jsp:include>

	<main class="container-fluid px-lg-5 py-4">
		<div class="row g-4">

			<!-- ===================== SIDEBAR ===================== -->
			<aside class="col-lg-3 col-xl-2">
				<div class="filter-sidebar shadow-sm">

					<form method="get" action="browse">

						<h5
							class="fw-bold mb-4 d-flex justify-content-between align-items-center">
							Filters <a href="browse"
								class="btn btn-sm btn-link text-danger text-decoration-none fw-semibold">
								Clear </a>
						</h5>

						<!-- My Campus -->
						<c:if test="${sessionScope.loggedUser != null 
            and sessionScope.loggedUser.status == 'ACTIVE'}">

<div class="mb-4">
    <div class="form-check form-switch">
        <input class="form-check-input"
               type="checkbox"
               name="myCampus"
               value="true"
               ${param.myCampus == 'true' ? 'checked' : ''}
               onchange="this.form.submit()">

        <label class="form-check-label small fw-medium">
            My Campus Only
        </label>
    </div>
</div>

</c:if>

						<!-- Categories -->
						<div class="mb-4">
							<label class="fw-bold small text-muted mb-2">Category</label>

							<c:forEach var="cat" items="${categories}">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										value="${cat.name}"
										${param.category == cat.name ? 'checked' : ''}
										onchange="this.form.submit()"> <label
										class="form-check-label small">${cat.name}</label>
								</div>
							</c:forEach>

						</div>

						<!-- Colleges (Campus) -->
						<div class="mb-4">
							<label class="fw-bold small text-muted mb-2">Campus</label>

							<c:forEach var="col" items="${colleges}">
								<c:if test="${col.status == 'ACTIVE'}">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="collegeId"
											value="${col.id}"
											${param.collegeId == col.id ? 'checked' : ''}
											onchange="this.form.submit()"> <label
											class="form-check-label small"> <c:choose>
												<c:when test="${col.shortName != null}">
${col.shortName}
</c:when>
												<c:otherwise>
${col.name}
</c:otherwise>
											</c:choose>
										</label>
									</div>
								</c:if>
							</c:forEach>

						</div>

						<!-- Price Range -->
						<!-- Price Range -->
						<div class="mb-4">
							<label class="fw-bold small text-muted mb-2">Price Range</label>

							<div class="d-flex gap-2">
								<input type="number" name="minPrice" value="${param.minPrice}"
									class="form-control form-control-sm" placeholder="Min">

								<input type="number" name="maxPrice" value="${param.maxPrice}"
									class="form-control form-control-sm" placeholder="Max">
							</div>

							<div class="d-flex gap-2 mt-2">
								<button class="btn btn-primary btn-sm w-100">Apply</button>

								<a href="browse" class="btn btn-outline-secondary btn-sm w-100">
									Reset </a>
							</div>
						</div>

					</form>

				</div>
			</aside>

			<!-- ===================== PRODUCTS ===================== -->
			<div class="col-lg-9 col-xl-10">

				<div
					class="bg-white p-4 rounded-4 border mb-4 shadow-sm d-flex justify-content-between align-items-center">
					<h4 class="fw-bold mb-0">Marketplace</h4>
					<span
						class="badge bg-light text-dark border px-3 py-2 rounded-pill">
						${products.size()} Results </span>
				</div>

				<div
					class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-4">

					<c:forEach var="p" items="${products}">
						<div class="col">
							<div class="product-card">

								<div class="product-img-container position-relative">
									<span class="condition-badge">${p.productCondition}</span> <img
										src="/uploads/${p.image1}" alt="${p.title}">
								</div>

								<div class="p-3">

									<div class="small text-muted fw-bold mb-1">
										${p.category.name}</div>

									<h6 class="fw-bold text-truncate mb-2">${p.title}</h6>

									<div class="d-flex justify-content-between align-items-center">
										<div class="product-price">₹${p.price}</div>

										<div class="small text-muted">
											${collegeMap[p.seller.collegeId]}</div>
									</div>

									<div class="d-flex gap-2 mt-3">

										<a href="viewProduct?id=${p.id}"
											class="btn btn-outline-primary btn-sm w-50"> View Details
										</a> <a href="addToWishlist?productId=${p.id}"
   class="btn btn-primary btn-sm w-50">
   Add to Wishlist
</a>

									</div>

								</div>
							</div>
						</div>
					</c:forEach>

				</div>

			</div>
		</div>
	</main>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>
	<jsp:include page="components/Footer.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>