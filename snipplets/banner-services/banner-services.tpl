{% macro for_each_banner_include(template) %}
    {% set num_banners_services = 0 %}
    {% set available_banners = []%}
    {% for banner in ['banner_services_01', 'banner_services_02', 'banner_services_03', 'banner_services_04'] %}
        {% set banner_services_icon = attribute(settings,"#{banner}_icon") %}
        {% set banner_services_title = attribute(settings,"#{banner}_title") %}
        {% set banner_services_description = attribute(settings,"#{banner}_description") %}
        {% set banner_services_url = attribute(settings,"#{banner}_url") %}
        {% set has_banner_services =  banner_services_title or banner_services_description %}
        {% if has_banner_services %}
            {% set num_banners_services = num_banners_services + 1 %}
            {% set available_banners = available_banners | merge([banner]) %}
        {% endif %}
    {% endfor %}
    {% for banner in available_banners %}
        {% set banner_services_title = attribute(settings,"#{banner}_title") %}
        {% set banner_services_image = "#{banner}.jpg" | has_custom_image %}
        {% set banner_services_icon = attribute(settings,"#{banner}_icon") %}
        {% set banner_services_description = attribute(settings,"#{banner}_description") %}
        {% set banner_services_url = attribute(settings,"#{banner}_url") %}
        {% include template %}
    {% endfor %}
{% endmacro %}
{% import _self as banner_services %}
{% if settings.banner_services and (settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_01_description or settings.banner_services_02_description or settings.banner_services_03_description) %}
    <style>
    /* Compact Informative Banners (Frete, Pagamentos, Troca, Compra Segura) */
    .section-informative-banners {
      padding: 14px 0 !important;
      background-color: #fafafa !important;
      border-top: 1px solid #f0f0f0 !important;
      border-bottom: 1px solid #f0f0f0 !important;
      margin: 0 !important;
    }
    .section-informative-banners .container {
      max-width: 1200px;
    }
    .section-informative-banners .swiper-container {
      margin: 0 !important;
      overflow: hidden;
    }
    .service-item-link {
      text-decoration: none !important;
      color: inherit !important;
      display: block;
    }
    .service-item-content {
      display: flex !important;
      align-items: center !important;
      justify-content: center !important;
      gap: 12px;
      text-align: left !important;
      padding: 2px 8px;
    }
    .service-item-icon {
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      width: 30px;
      height: 30px;
      color: #111111;
    }
    .service-item-icon .service-icon {
      width: 22px !important;
      height: 22px !important;
      stroke-width: 1.5;
      color: #111111;
    }
    .service-item-icon img.service-item-image {
      max-height: 24px !important;
      max-width: 24px !important;
      object-fit: contain;
    }
    .service-item-text {
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .service-item-title {
      font-size: 0.8125rem !important;
      font-weight: 600 !important;
      line-height: 1.25 !important;
      color: #111111 !important;
      margin: 0 !important;
      letter-spacing: -0.01em;
      white-space: nowrap;
    }
    .service-item-desc {
      font-size: 0.72rem !important;
      font-weight: 400 !important;
      line-height: 1.25 !important;
      color: #666666 !important;
      margin: 2px 0 0 0 !important;
      white-space: nowrap;
    }
    @media (min-width: 768px) {
      .section-informative-banners {
        padding: 16px 0 !important;
      }
      .section-informative-banners .swiper-wrapper {
        display: flex !important;
        justify-content: space-around !important;
        transform: none !important;
        flex-wrap: nowrap !important;
      }
      .section-informative-banners .swiper-slide {
        width: auto !important;
        flex: 1 1 0 !important;
        position: relative;
      }
      .section-informative-banners .swiper-slide:not(:last-child)::after {
        content: "";
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 1px;
        height: 22px;
        background-color: #e5e5e5;
      }
    }
    @media (max-width: 767px) {
      .section-informative-banners {
        padding: 10px 0 !important;
      }
      .section-informative-banners .swiper-container {
        padding: 0 8px;
      }
      .service-item-content {
        gap: 9px;
        padding: 2px 4px;
        justify-content: center !important;
      }
      .service-item-icon {
        width: 24px;
        height: 24px;
      }
      .service-item-icon .service-icon {
        width: 18px !important;
        height: 18px !important;
      }
      .service-item-title {
        font-size: 0.78rem !important;
      }
      .service-item-desc {
        font-size: 0.69rem !important;
        margin-top: 1px !important;
      }
      .section-informative-banners .text-center.mt-4.d-block.d-md-none,
      .section-informative-banners .swiper-button-prev,
      .section-informative-banners .swiper-button-next {
        display: none !important;
      }
    }
    </style>
    <section class="section-informative-banners {% if settings.banner_services_colors %}section-informative-banners-colors{% endif %}" data-store="banner-services">
        <div class="container">
            <div class="js-informative-banners swiper-container">
                <div class="swiper-wrapper">
                    {{ banner_services.for_each_banner_include('snipplets/banner-services/banner-services-item.tpl') }}
                </div>
            </div>
        </div>
    </section>
{% endif %}