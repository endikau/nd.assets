document.addEventListener("DOMContentLoaded", function () {
    let openTrigger = null;
    const popTemplate = '<div class="popover nd-popover" role="tooltip"><div class="popover-arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>';
    function ensureHeaderCloseButton(popEl) {
        const header = popEl.querySelector(".popover-header");
        if (!header) return;
        if (header.querySelector(".nd-close")) return;
        const btn = document.createElement("button");
        btn.type = "button";
        // btn.className="btn nd-close btn-sm btn-primary text-light";
        btn.className = "btn nd-close p-0 border-0 bg-transparent text-primary";
        btn.role = "button";
        btn.setAttribute("aria-label", "Close");
        // btn.innerHTML = '<i class="fa-solid fa-window-close"></i>';
        btn.innerHTML = '<i class="fa-solid fa-xmark"></i>';
        header.appendChild(btn);
    }
    document.querySelectorAll('[data-bs-toggle="popover"]').forEach(function (el) {
        bootstrap.Popover.getInstance(el)?.dispose();
        const tplId = el.getAttribute("data-bs-template-id");
        const tpl = tplId ? document.getElementById(tplId) : null;
        const pop = new bootstrap.Popover(el, { trigger: "manual", html: true, sanitize: false, container: "body", template: popTemplate, title: el.getAttribute("data-bs-title") || "", content: function () { return tpl ? tpl.innerHTML : ""; } });
        el.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (openTrigger && openTrigger !== el) { bootstrap.Popover.getInstance(openTrigger)?.hide(); }
            if (openTrigger === el) { pop.hide(); openTrigger = null; return; }
            pop.show();
            openTrigger = el;
            const popId = el.getAttribute("aria-describedby");
            if (popId) {
                const popEl = document.getElementById(popId);
                if (popEl) ensureHeaderCloseButton(popEl);
            }
        });
    });
    document.addEventListener("click", function (e) {
        const closeBtn = e.target.closest(".nd-close");
        if (closeBtn) {
            const popEl = closeBtn.closest(".popover");
            const trigger = document.querySelector('[aria-describedby="' + popEl.id + '"]');
            bootstrap.Popover.getInstance(trigger)?.hide();
            openTrigger = null;
            return;
        }
        if (e.target.closest(".nd-popover")) return;
        if (e.target.closest('[data-bs-toggle="popover"]')) return;
        if (openTrigger) { bootstrap.Popover.getInstance(openTrigger)?.hide(); openTrigger = null; }
    });
    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape" && openTrigger) { bootstrap.Popover.getInstance(openTrigger)?.hide(); openTrigger = null; }
    });
});
