<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CampusKart | ${product.title}</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">
<style>
:root {
	--primary: #14b8a6;
}

body {
	font-family: 'Segoe UI', system_ui, sans-serif;
	background: #f8fafc;
}

.main-image {
    width: 100%;
    height: 420px;
    object-fit: cover;
    border-radius: 16px;
}

.thumbnail {
	height: 80px;
	object-fit: cover;
	border: 3px solid transparent;
	cursor: pointer;
}

.thumbnail.active {
	border-color: var(--primary);
}

.price {
	   font-size: 1.8rem;
	font-weight: 700;
	color: #10b981;
}
</style>
</head>
<body>


	<jsp:include page="components/Navbar.jsp"></jsp:include>

	<div class="container pt-5 mt-5">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="browse.jsp">Browse</a></li>
				<li class="breadcrumb-item"><a href="browse.jsp">Electronics</a></li>
				<li class="breadcrumb-item active">Sony WF-1000XM5 Earbuds</li>
			</ol>
		</nav>

		<div class="row g-5">
			<!-- IMAGE SECTION -->
			<!-- IMAGE SECTION -->
<div class="col-lg-6">

    <!-- MAIN IMAGE -->
    <img id="mainImage"
         src="/uploads/${product.image1}"
         class="main-image w-100 mb-3"
         alt="${product.title}">

    <!-- THUMBNAILS -->
    <div class="d-flex gap-3">
        <img src="/uploads/${product.image1}"
             onclick="changeImage(this)"
             class="thumbnail active rounded">

        <c:if test="${product.image2 != null}">
            <img src="/uploads/${product.image2}"
                 onclick="changeImage(this)"
                 class="thumbnail rounded">
        </c:if>
    </div>

</div>

			<!-- DETAILS SECTION -->
			<div class="col-lg-6">
				<div class="d-flex justify-content-between align-items-start">
					<h2 class="fw-bold mb-2">${product.title}</h2>
					<button onclick="toggleWishlist()"
						class="btn btn-light border-0 fs-4">
						<i id="wishlistIcon" class="bi bi-heart"></i>
					</button>
				</div>

				<div class="d-flex gap-3 align-items-center mt-2">
					<span class="price">₹ ${product.price}</span>

<span class="badge bg-success fs-6 px-3 py-2">
    ${product.productCondition}
</span>
				</div>

				<p class="text-muted small mt-2">
    <i class="bi bi-geo-alt"></i>
    ${collegeAddress}
    • Posted ${product.createdAt}
</p>

				<hr>

				<h5 class="fw-semibold">Description</h5>
				<p class="text-muted">${product.description}</p>

				<div class="row mt-4">
					<div class="col-6">
						<small class="text-muted">Seller</small><br> <strong>@${product.seller.name}</strong>
						<span class="text-muted">• Verified Student</span>
					</div>
					<div class="col-6">
						<small class="text-muted">College</small><br> <strong>${collegeName}</strong>
					</div>
				</div>

				<div class="mt-5">
					<a href="chat?productId=${product.id}"><button 
						class="btn btn-primary btn-lg w-100 py-3 mb-3">
						<i class="bi bi-chat-dots me-2"></i> Chat with Seller
					</button></a>
					<form action="addToWishlist" method="post">
    <input type="hidden" name="productId" value="${product.id}">

    <button class="btn btn-outline-primary btn-lg w-100 py-3">
        <i class="bi bi-heart me-2"></i> Add to Wishlist
    </button>
</form>
				</div>

				<div
					class="alert alert-success mt-4 d-flex align-items-center gap-3">
					<i class="bi bi-shield-check fs-3"></i>
					<div>
						<strong>Safe Campus Trade</strong><br> <small>Meet
							inside ${collegeName} campus gate only</small>
					</div>
				</div>
			</div>
		</div>

		<!-- SIMILAR PRODUCTS -->
		<h4 class="fw-bold mt-5 mb-4">Similar Products from ${collegeName} ${collegeAddress}</h4>
		<div class="row g-4">

<c:forEach var="sp" items="${similarProducts}">

<div class="col-md-4 col-lg-3">
    <div class="card shadow-sm h-100">
        <img src="/uploads/${sp.image1}"
             class="card-img-top"
             style="height:180px;object-fit:cover">

        <div class="card-body">
            <h6 class="fw-semibold">${sp.title}</h6>
            <p class="text-success fw-bold">₹ ${sp.price}</p>

            <a href="viewProduct?id=${sp.id}"
               class="btn btn-sm btn-outline-primary w-100">
               View
            </a>
        </div>
    </div>
</div>

</c:forEach>

</div>
	</div>
	
	<jsp:include page="components/Footer.jsp "></jsp:include>

	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>