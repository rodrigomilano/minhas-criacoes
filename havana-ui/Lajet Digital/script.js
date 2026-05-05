// Accordion Logic from Design System
const accordionHeaders = document.querySelectorAll('.accordion-header');

accordionHeaders.forEach(header => {
    header.addEventListener('click', () => {
        header.classList.toggle('active');
        const body = header.nextElementSibling;
        const item = header.parentElement;
        
        item.classList.toggle('is-open');

        if (header.classList.contains('active')) {
            body.style.maxHeight = body.scrollHeight + "px";
        } else {
            body.style.maxHeight = 0;
        }
    });
});

// Navbar background on scroll
const navbar = document.querySelector('.navbar');
window.addEventListener('scroll', () => {
    if (window.scrollY > 50) {
        navbar.style.background = 'rgba(20, 14, 11, 0.95)';
        navbar.style.boxShadow = 'var(--shadow-hard)';
    } else {
        navbar.style.background = 'rgba(20, 14, 11, 0.9)';
        navbar.style.boxShadow = 'none';
    }
});

// Smooth Scroll for Anchor Links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const targetId = this.getAttribute('href');
        if(targetId === '#') return;
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
            window.scrollTo({
                top: targetElement.offsetTop - 80, // Adjust for navbar height
                behavior: 'smooth'
            });
        }
    });
});
