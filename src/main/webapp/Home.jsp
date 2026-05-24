<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart | The Student Marketplace</title>
    
    <!-- Google Fonts: Inter & Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Animate.css for subtle entry effects -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    
    <style>
        :root {
            --primary: #0d9488;
            --primary-light: #2dd4bf;
            --primary-dark: #0f766e;
            --accent: #f59e0b;
            --bg-glass: rgba(255, 255, 255, 0.7);
            --border-glass: rgba(255, 255, 255, 0.3);
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
            --card-shadow-hover: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        body {
            font-family: 'Inter', sans-serif;
            color: var(--text-main);
            background-color: #f8fafc;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        h1, h2, h3, .navbar-brand {
            font-family: 'Poppins', sans-serif;
        }

        /* --- HERO SECTION --- */
        .hero {
            position: relative;
            min-height: 90vh;
            display: flex;
            align-items: center;
            background: #0f172a;
            overflow: hidden;
            padding: 100px 0;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at 20% 30%, rgba(13, 148, 136, 0.15) 0%, transparent 50%),
                        radial-gradient(circle at 80% 70%, rgba(245, 158, 11, 0.1) 0%, transparent 50%);
            z-index: 1;
        }

        .hero-img-container {
            position: relative;
            z-index: 2;
        }

        .hero-img-container img {
            border-radius: 2rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            transform: perspective(1000px) rotateY(-5deg);
            transition: transform 0.5s ease;
        }

        .hero-img-container:hover img {
            transform: perspective(1000px) rotateY(0deg);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: white;
        }

        .hero-badge {
            display: inline-block;
            padding: 8px 16px;
            background: rgba(13, 148, 136, 0.2);
            border: 1px solid rgba(13, 148, 136, 0.3);
            border-radius: 100px;
            color: var(--primary-light);
            font-weight: 600;
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
        }

        .btn-premium {
            background: var(--primary);
            color: white;
            padding: 14px 32px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            box-shadow: 0 4px 6px -1px rgba(13, 148, 136, 0.4);
            text-decoration: none;
            display: inline-block;
        }

        .btn-premium:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(13, 148, 136, 0.4);
            color: white;
        }

        .btn-premium-outline {
            background: transparent;
            color: white;
            padding: 14px 32px;
            border-radius: 12px;
            font-weight: 600;
            border: 2px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-premium-outline:hover {
            border-color: white;
            background: rgba(255, 255, 255, 0.05);
            color: white;
        }

        /* --- CATEGORIES --- */
        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
            gap: 1.5rem;
        }

        .category-item {
            background: white;
            border-radius: 1.5rem;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid #f1f5f9;
            text-decoration: none;
            color: var(--text-main);
        }

        .category-item:hover {
            transform: translateY(-10px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--primary-light);
        }

        .category-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            transition: transform 0.3s ease;
        }

        .category-item:hover .category-icon {
            transform: scale(1.15);
        }

        /* --- PRODUCT CARDS --- */
        .product-card {
            background: white;
            border-radius: 1.25rem;
            overflow: hidden;
            border: 1px solid #f1f5f9;
            transition: all 0.4s ease;
            height: 100%;
        }

        .product-card:hover {
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-5px);
        }

        .product-img-wrapper {
            position: relative;
            overflow: hidden;
            aspect-ratio: 4/3;
        }

        .product-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .product-card:hover .product-img-wrapper img {
            transform: scale(1.08);
        }

        .product-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.025em;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(4px);
            z-index: 2;
        }

        .price-tag {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-dark);
        }

        /* --- HOW IT WORKS --- */
        .step-container {
            position: relative;
            padding: 2rem;
            background: white;
            border-radius: 2rem;
            box-shadow: var(--card-shadow);
        }

        .step-number {
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 45px;
            height: 45px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            box-shadow: 0 4px 10px rgba(13, 148, 136, 0.3);
        }

        /* --- SECTION HEADERS --- */
        .section-title {
            font-weight: 700;
            font-size: clamp(2rem, 5vw, 2.75rem);
            margin-bottom: 1rem;
            background: linear-gradient(90deg, #1e2937, #4b5563);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .section-subtitle {
            color: var(--text-muted);
            font-size: 1.125rem;
            max-width: 600px;
            margin: 0 auto 3rem;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #f1f1f1; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .float-anim {
            animation: float 4s ease-in-out infinite;
        }

    </style>
</head>
<body>
    <!-- NAVBAR -->
    <jsp:include page="components/Navbar.jsp"></jsp:include>

    <!-- HERO SECTION -->
    <section class="hero">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6 animate__animated animate__fadeInLeft">
                    <div class="hero-content">
                        <span class="hero-badge">Exclusively for Students</span>
                        <h1 class="display-3 fw-bold mb-4">Your Campus,<br><span style="color: var(--primary-light)">Your Marketplace.</span></h1>
                        <p class="lead mb-5 opacity-75 fs-5">
                            Join thousands of students from COEP, PICT, VIT, and MIT. 
                            Trade textbooks, electronics, and hostel essentials securely within your campus walls.
                        </p>
                        
                        <div class="d-flex flex-wrap gap-3">
                            <a href="#browse" class="btn btn-premium btn-lg">
                                <i class="bi bi-grid-fill me-2"></i>Explore Market
                            </a>
                            <a href="sell.jsp" class="btn btn-premium-outline btn-lg">
                                <i class="bi bi-plus-circle me-2"></i>Start Selling
                            </a>
                        </div>
                        
                        <div class="mt-5 d-flex gap-4">
                            <div class="text-center">
                                <h4 class="fw-bold mb-0">5k+</h4>
                                <small class="text-white-50">Students</small>
                            </div>
                            <div class="vr opacity-25"></div>
                            <div class="text-center">
                                <h4 class="fw-bold mb-0">12k+</h4>
                                <small class="text-white-50">Items</small>
                            </div>
                            <div class="vr opacity-25"></div>
                            <div class="text-center">
                                <h4 class="fw-bold mb-0">98%</h4>
                                <small class="text-white-50">Safe</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 d-none d-lg-block animate__animated animate__fadeInRight">
                    <div class="hero-img-container float-anim">
                        <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&q=80&w=1000" class="img-fluid" alt="Campus Life">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CATEGORIES SECTION -->
    <section id="categories" class="py-5">
        <div class="container py-5">
            <div class="text-center">
                <h2 class="section-title">Shop by Category</h2>
                <p class="section-subtitle">Find exactly what you need for your semester.</p>
            </div>
            
           <div class="category-grid">
<c:forEach var="cat" items="${categories}">
    <a href="browse?category=${cat.name}" class="category-item">
        <div class="category-icon">
            <i class="bi ${categoryIcons[cat.name] != null ? categoryIcons[cat.name] : 'bi-grid'}"></i>
        </div>
        <h6 class="fw-bold mb-0">${cat.name}</h6>
    </a>
</c:forEach>
</div>
        </div>
    </section>

    <!-- FEATURED PRODUCTS -->
    <section id="browse" class="py-5 bg-white">
        <div class="container py-5">
            <div class="d-md-flex justify-content-between align-items-end mb-5">
                <div>
                    <h2 class="section-title mb-0">Featured Listings</h2>
                    <p class="text-muted mb-0">Freshly listed items from Pune campuses</p>
                </div>
                <a href="Browse.jsp" class="btn btn-outline-dark rounded-pill px-4 mt-3 mt-md-0">View All Items <i class="bi bi-arrow-right ms-1"></i></a>
            </div>
            
            <div class="row g-4">

<c:forEach var="p" items="${featuredProducts}">

<div class="col-sm-6 col-lg-3">
    <div class="product-card">

        <div class="product-img-wrapper position-relative">

            <!-- 🔥 Wishlist Icon -->
            <a href="toggleWishlist?id=${p.id}"
               class="position-absolute top-0 end-0 m-3 text-dark fs-5 bg-white rounded-circle p-2 shadow-sm">
                <i class="bi bi-heart"></i>
            </a>

            <img src="/uploads/${p.image1}" alt="${p.title}">
        </div>

        <div class="p-4">
            <h6 class="fw-bold text-truncate mb-1">${p.title}</h6>

            <p class="small text-muted mb-3">
                <i class="bi bi-geo-alt me-1"></i>
                ${collegeMap[p.seller.collegeId]}
            </p>

            <div class="d-flex justify-content-between align-items-center">
                <span class="price-tag">₹${p.price}</span>

                <a href="viewProduct?id=${p.id}"
                   class="btn btn-sm btn-premium">
                    View
                </a>
            </div>
        </div>

    </div>
</div>

</c:forEach>

</div>
        </div>
    </section>

    <!-- HOW IT WORKS -->
    <section class="py-5 bg-light">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="section-title">How It Works</h2>
                <p class="section-subtitle">Simplified peer-to-peer trading for the modern student.</p>
            </div>
            
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="step-container text-center h-100">
                        <div class="step-number">1</div>
                        <h5 class="fw-bold mt-3">Verify</h5>
                        <p class="text-muted small">Sign up using your college ID to ensure a safe environment.</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="step-container text-center h-100">
                        <div class="step-number">2</div>
                        <h5 class="fw-bold mt-3">List Item</h5>
                        <p class="text-muted small">Upload a few photos and set your price in under 60 seconds.</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="step-container text-center h-100">
                        <div class="step-number">3</div>
                        <h5 class="fw-bold mt-3">Chat</h5>
                        <p class="text-muted small">Connect with interested buyers via our secure in-app chat.</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="step-container text-center h-100">
                        <div class="step-number">4</div>
                        <h5 class="fw-bold mt-3">Deal</h5>
                        <p class="text-muted small">Meet up at a campus spot and complete the exchange.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <jsp:include page="components/Footer.jsp"></jsp:include>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (navbar) {
                if (window.scrollY > 50) {
                    navbar.classList.add('bg-white', 'shadow-sm');
                    navbar.style.padding = '10px 0';
                } else {
                    navbar.classList.remove('bg-white', 'shadow-sm');
                    navbar.style.padding = '20px 0';
                }
            }
        });
    </script>
</body>
</html>
