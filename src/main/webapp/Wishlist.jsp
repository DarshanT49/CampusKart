<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>CampusKart | Wishlist</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<style>

body{
    background:#f8fafc;
}

.wishlist-card{
    border-radius:15px;
    transition:0.3s ease;
}

.wishlist-card:hover{
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
    transform:translateY(-3px);
}

.product-img{
    width:100%;
    height:200px;
    object-fit:cover;
    border-radius:15px 15px 0 0;
}

.price{
    font-weight:600;
    color:#14b8a6;
}

</style>
</head>

<body>

<jsp:include page="components/Navbar.jsp"/>

<div class="container mt-5 pt-4">

<h3 class="mb-4 fw-bold">My Wishlist ❤️</h3>

<div class="row">

<c:if test="${empty wishlist}">
    <div class="text-center text-muted">
        <h5>No items in wishlist</h5>
    </div>
</c:if>

<c:forEach var="w" items="${wishlist}">

    <c:set var="p" value="${productMap[w.id]}" />
    <c:set var="c" value="${collegeMap[w.id]}" />

    <div class="col-md-6 col-lg-4 mb-4">

        <div class="card wishlist-card h-100">

            <img src="/uploads/${p.image1}" class="product-img">

            <div class="card-body d-flex flex-column">

                <h5 class="card-title">${p.title}</h5>

                <p class="text-muted small">
                    ${p.description}
                </p>

                <p class="text-muted small">
                    <i class="bi bi-geo-alt"></i> ${c.name}
                </p>

                <div class="price mb-3">
                    ₹ ${p.price}
                </div>

                <div class="mt-auto d-flex justify-content-between">

                    <a href="viewProduct?id=${p.id}"
                       class="btn btn-outline-primary btn-sm">
                       View
                    </a>

                    <a href="chat?productId=${p.id}"
                       class="btn btn-success btn-sm">
                       Chat
                    </a>

                    <form action="removeFromWishlist" method="post">
                        <input type="hidden" name="id" value="${w.id}">
                        <button class="btn btn-danger btn-sm">
                            Remove
                        </button>
                    </form>

                </div>

            </div>

        </div>

    </div>

</c:forEach>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>