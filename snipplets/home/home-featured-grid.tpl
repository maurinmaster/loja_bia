{# /*============================================================================
  #Home featured grid
==============================================================================*/

#Properties

#Featured Slider

#}

{% set featured_products = featured_products | default(false) %}
{% set new_products = new_products | default(false) %}
{% set sale_products = sale_products | default(false) %}

{# Check if slider is used #}

{% set has_featured_products_and_slider = featured_products and settings.featured_products_format == 'slider' %}
{% set has_new_products_and_slider = new_products and settings.new_products_format == 'slider' %}
{% set has_sale_products_and_slider = sale_products and settings.sale_products_format == 'slider' %}
{% set use_slider = has_featured_products_and_slider or has_new_products_and_slider or has_sale_products_and_slider %}

{% if featured_products %}
    {% set sections_products = sections.primary.products %}
    {% set section_name = 'primary' %}
    {% set section_columns_desktop = settings.featured_products_desktop %}
    {% set section_columns_mobile = settings.featured_products_mobile %}
    {% set section_slider = settings.featured_products_format == 'slider' %}
    {% set section_format = settings.featured_products_format %}
    {% set section_id = 'featured' %}
    {% set section_title = settings.featured_products_title %}
{% endif %}
{% if new_products %}
    {% set sections_products = sections.new.products %}
    {% set section_name = 'new' %}
    {% set section_columns_desktop = settings.new_products_desktop %}
    {% set section_columns_mobile = settings.new_products_mobile %}
    {% set section_slider = settings.new_products_format == 'slider' %}
    {% set section_format = settings.new_products_format %}
    {% set section_id = 'new' %}
    {% set section_title = settings.new_products_title %}
{% endif %}
{% if sale_products %}
    {% set sections_products = sections.sale.products %}
    {% set section_name = 'sale' %}
    {% set section_columns_desktop = settings.sale_products_desktop %}
    {% set section_columns_mobile = settings.sale_products_mobile %}
    {% set section_slider = settings.sale_products_format == 'slider' %}
    {% set section_format = settings.sale_products_format %}
    {% set section_id = 'sale' %}
    {% set section_title = settings.sale_products_title %}
{% endif %}

{% set show_new_banner = new_products and settings.new_products_has_banner %}
{% set is_full_width = new_products and ((settings.new_products_width == 'full') or (settings.new_products_width is not defined and settings.new_products_has_banner)) %}

<div class="js-products-{{ section_id }}-container {% if is_full_width %}container-fluid px-2 px-md-3 px-lg-4{% else %}container{% endif %}">
    {% if not show_new_banner %}
        <div class="row">
            <div class="col-12">
                <h2 class="js-products-{{ section_id }}-title section-title h3 mt-3 mb-4 pb-2 text-center" {% if not section_title %} style="display:none;"{% endif %}>{{ section_title }}</h2>
                {% if use_slider %}
                    <div class="js-swiper-{{ section_id }} swiper-container">
                {% endif %}
                        <div class="js-products-{{ section_id }}-grid {% if use_slider %} swiper-wrapper{% else %}row row-grid{% endif %}" data-desktop-columns="{{ section_columns_desktop }}" data-mobile-columns="{{ section_columns_mobile }}" data-format="{{ section_format }}">
                            {% for product in sections_products %}
                                {% if use_slider %}
                                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name, 'section_columns_desktop': section_columns_desktop, 'section_columns_mobile': section_columns_mobile } %}
                                {% else %}
                                    {% include 'snipplets/grid/item.tpl' %}
                                {% endif %}
                            {% endfor %}
                        </div>
                {% if use_slider %}
                    </div>
                    <div class="js-products-{{ section_id }}-controls mt-2 text-center">
                        <div class="js-swiper-{{ section_id }}-prev swiper-button-prev svg-icon-text">
                            <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#arrow-long"/></svg>
                        </div>
                        <div class="js-swiper-{{ section_id }}-pagination swiper-pagination-fraction"></div>
                        <div class="js-swiper-{{ section_id }}-next swiper-button-next svg-icon-text">
                            <svg class="icon-inline icon-lg"><use xlink:href="#arrow-long"/></svg>
                        </div>
                    </div>
                {% endif %}
            </div>
        </div>
    {% else %}
        {% set banner_has_custom = "new_products_banner.jpg" | has_custom_image %}
        {% set banner_img_src = banner_has_custom ? ("new_products_banner.jpg" | static_url | settings_image_url('1080p')) : ('images/new_products_banner.jpg' | static_url) %}
        
        <div class="row align-items-center no-gutters new-products-split-wrapper">
            {# Left Column: Hero Promo Banner #}
            <div class="col-12 col-lg-5 col-xl-4 mb-4 mb-lg-0 pr-lg-3">
                <div class="new-products-banner-box position-relative h-100 overflow-hidden d-flex flex-column justify-content-between p-4 p-md-5">
                    <div class="new-products-banner-bg" style="background-image: url('{{ banner_img_src }}');"></div>
                    
                    <div class="new-products-banner-content position-relative z-index-2 d-flex flex-column justify-content-between h-100">
                        <div class="new-products-banner-top">
                            {% if settings.new_products_banner_title %}
                                <h2 class="new-products-banner-title mb-2" style="{% if settings.new_products_colors and settings.new_products_text_color %}color: {{ settings.new_products_text_color }};{% endif %}">
                                    {{ settings.new_products_banner_title | nl2br }}
                                </h2>
                            {% endif %}
                            
                            <div class="new-products-banner-divider my-3" style="{% if settings.new_products_colors and settings.new_products_text_color %}background-color: {{ settings.new_products_text_color }};{% endif %}"></div>

                            {% if settings.new_products_banner_subtitle %}
                                <p class="new-products-banner-subtitle mb-4" style="{% if settings.new_products_colors and settings.new_products_text_color %}color: {{ settings.new_products_text_color }};{% endif %}">
                                    {{ settings.new_products_banner_subtitle }}
                                </p>
                            {% endif %}
                        </div>

                        {% if settings.new_products_banner_button_text %}
                            <div class="new-products-banner-bottom mt-auto pt-3">
                                <a href="{{ settings.new_products_banner_button_url | default('/produtos') }}" class="btn new-products-banner-btn text-uppercase font-weight-bold" style="{% if settings.new_products_colors and settings.new_products_btn_bg_color %}background-color: {{ settings.new_products_btn_bg_color }}; border-color: {{ settings.new_products_btn_bg_color }};{% endif %}{% if settings.new_products_colors and settings.new_products_btn_text_color %}color: {{ settings.new_products_btn_text_color }};{% endif %}">
                                    <span>{{ settings.new_products_banner_button_text }}</span>
                                    <span class="ml-2 font-weight-bold">&gt;</span>
                                </a>
                            </div>
                        {% endif %}
                    </div>
                    {% if settings.new_products_banner_button_url and not settings.new_products_banner_button_text %}
                        <a href="{{ settings.new_products_banner_button_url }}" class="stretched-link" aria-label="{{ settings.new_products_banner_title }}"></a>
                    {% endif %}
                </div>
            </div>

            {# Right Column: Products Carousel / Grid #}
            {% set effective_desktop_columns = show_new_banner ? ((section_columns_desktop - 1) | default(3)) : section_columns_desktop %}
            {% if effective_desktop_columns < 1 %}{% set effective_desktop_columns = 1 %}{% endif %}
            <div class="col-12 col-lg-7 col-xl-8 pl-lg-2 d-flex flex-column justify-content-center">
                {% if use_slider %}
                    <div class="js-swiper-{{ section_id }} swiper-container new-products-swiper-desktop w-100" style="--new-products-columns: {{ effective_desktop_columns }};">
                {% endif %}
                        <div class="js-products-{{ section_id }}-grid {% if use_slider %} swiper-wrapper{% else %}row row-grid{% endif %}" data-desktop-columns="{{ effective_desktop_columns }}" data-mobile-columns="{{ section_columns_mobile }}" data-format="{{ section_format }}">
                            {% for product in sections_products %}
                                {% if use_slider %}
                                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name, 'section_columns_desktop': section_columns_desktop, 'section_columns_mobile': section_columns_mobile } %}
                                {% else %}
                                    {% include 'snipplets/grid/item.tpl' %}
                                {% endif %}
                            {% endfor %}
                        </div>
                {% if use_slider %}
                    </div>
                {% endif %}
            </div>
        </div>
    {% endif %}
</div>
