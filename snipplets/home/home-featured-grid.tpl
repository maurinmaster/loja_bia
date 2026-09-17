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
{% set show_featured_banner = featured_products and settings.featured_products_has_banner %}
{% set has_promo_banner = show_new_banner or show_featured_banner %}

{% if show_featured_banner %}
    {% set is_full_width = (settings.featured_products_width == 'full') or (settings.featured_products_width is not defined and settings.featured_products_has_banner) %}
{% elseif show_new_banner %}
    {% set is_full_width = (settings.new_products_width == 'full') or (settings.new_products_width is not defined and settings.new_products_has_banner) %}
{% else %}
    {% set is_full_width = false %}
{% endif %}

<div class="js-products-{{ section_id }}-container {% if is_full_width %}container-fluid px-2 px-md-3 px-lg-4{% else %}container{% endif %}">
    {% if not has_promo_banner %}
        <div class="row">
            <div class="col-12">
                <h2 class="js-products-{{ section_id }}-title section-title h3 mt-3 mb-4 pb-2 text-center" {% if not section_title %} style="display:none;"{% endif %}>{{ section_title }}</h2>
                {% if use_slider %}
                    <div class="js-swiper-{{ section_id }} swiper-container">
                {% endif %}
                        <div class="js-products-{{ section_id }}-grid {% if use_slider %} swiper-wrapper{% else %}row row-grid{% endif %}" data-desktop-columns="{{ section_columns_desktop }}" data-mobile-columns="{{ section_columns_mobile }}" data-format="{{ section_format }}">
                            {% set grid_products = not use_slider ? (sections_products | slice(0, section_columns_desktop)) : sections_products %}
                            {% for product in grid_products %}
                                {% if use_slider %}
                                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name, 'section_columns_desktop': section_columns_desktop, 'section_columns_mobile': section_columns_mobile } %}
                                {% else %}
                                    {% include 'snipplets/grid/item.tpl' with {'section_columns_desktop': section_columns_desktop, 'section_columns_mobile': section_columns_mobile, 'section_name': section_name } %}
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
        {% set banner_image_name = show_featured_banner ? "featured_products_banner.jpg" : "new_products_banner.jpg" %}
        {% set banner_fallback_path = show_featured_banner ? 'images/featured_products_banner.jpg' : 'images/new_products_banner.jpg' %}
        {% set banner_has_custom = banner_image_name | has_custom_image %}
        {% set banner_img_src = banner_has_custom ? (banner_image_name | static_url | settings_image_url('1080p')) : (banner_fallback_path | static_url) %}

        {% set banner_title = show_featured_banner ? settings.featured_products_banner_title : settings.new_products_banner_title %}
        {% set banner_subtitle = show_featured_banner ? settings.featured_products_banner_subtitle : settings.new_products_banner_subtitle %}
        {% set banner_button_text = show_featured_banner ? settings.featured_products_banner_button_text : settings.new_products_banner_button_text %}
        {% set banner_button_url = show_featured_banner ? settings.featured_products_banner_button_url : settings.new_products_banner_button_url %}

        {% set has_colors = show_featured_banner ? settings.featured_products_colors : settings.new_products_colors %}
        {% set text_color = show_featured_banner ? settings.featured_products_text_color : settings.new_products_text_color %}
        {% set btn_bg_color = show_featured_banner ? settings.featured_products_btn_bg_color : settings.new_products_btn_bg_color %}
        {% set btn_text_color = show_featured_banner ? settings.featured_products_btn_text_color : settings.new_products_btn_text_color %}

        {% set effective_desktop_columns = (section_columns_desktop - 1) | default(3) %}
        {% if effective_desktop_columns < 1 %}{% set effective_desktop_columns = 1 %}{% endif %}

        <div class="row align-items-center no-gutters new-products-split-wrapper {% if show_featured_banner %}featured-products-split-wrapper{% endif %}">
            {# Banner Column: On left for new_products, on right for featured_products #}
            <div class="col-12 col-lg-5 col-xl-4 {% if show_featured_banner %}order-2 order-lg-2 pl-lg-3 mt-4 mt-lg-0{% else %}order-1 order-lg-1 pr-lg-3 mb-4 mb-lg-0{% endif %}">
                <div class="new-products-banner-box {% if show_featured_banner %}featured-products-banner-box{% endif %} position-relative h-100 overflow-hidden d-flex flex-column justify-content-between p-4 p-md-5">
                    <div class="new-products-banner-bg {% if show_featured_banner %}featured-products-banner-bg{% endif %}" style="background-image: url('{{ banner_img_src }}');"></div>
                    
                    <div class="new-products-banner-content {% if show_featured_banner %}featured-products-banner-content{% endif %} position-relative z-index-2 d-flex flex-column justify-content-between h-100">
                        <div class="new-products-banner-top">
                            {% if banner_title %}
                                <h2 class="new-products-banner-title {% if show_featured_banner %}featured-products-banner-title{% endif %} mb-2" style="{% if has_colors and text_color %}color: {{ text_color }};{% endif %}">
                                    {{ banner_title | nl2br }}
                                </h2>
                            {% endif %}
                            
                            <div class="new-products-banner-divider {% if show_featured_banner %}featured-products-banner-divider{% endif %} my-3" style="{% if has_colors and text_color %}background-color: {{ text_color }};{% endif %}"></div>

                            {% if banner_subtitle %}
                                <p class="new-products-banner-subtitle {% if show_featured_banner %}featured-products-banner-subtitle{% endif %} mb-4" style="{% if has_colors and text_color %}color: {{ text_color }};{% endif %}">
                                    {{ banner_subtitle }}
                                </p>
                            {% endif %}
                        </div>

                        {% if banner_button_text %}
                            <div class="new-products-banner-bottom mt-auto pt-3">
                                <a href="{{ banner_button_url | default('/produtos') }}" class="btn new-products-banner-btn {% if show_featured_banner %}featured-products-banner-btn{% endif %} text-uppercase font-weight-bold" style="{% if has_colors and btn_bg_color %}background-color: {{ btn_bg_color }}; border-color: {{ btn_bg_color }};{% endif %}{% if has_colors and btn_text_color %}color: {{ btn_text_color }};{% endif %}">
                                    <span>{{ banner_button_text }}</span>
                                    <span class="ml-2 font-weight-bold">&gt;</span>
                                </a>
                            </div>
                        {% endif %}
                    </div>
                    {% if banner_button_url and not banner_button_text %}
                        <a href="{{ banner_button_url }}" class="stretched-link" aria-label="{{ banner_title }}"></a>
                    {% endif %}
                </div>
            </div>

            {# Products Column: On right for new_products, on left for featured_products #}
            <div class="col-12 col-lg-7 col-xl-8 {% if show_featured_banner %}order-1 order-lg-1 pr-lg-2{% else %}order-2 order-lg-2 pl-lg-2{% endif %} d-flex flex-column justify-content-center">
                {% if use_slider %}
                    <div class="js-swiper-{{ section_id }} swiper-container new-products-swiper-desktop {% if show_featured_banner %}featured-products-swiper-desktop{% endif %} w-100" style="--new-products-columns: {{ effective_desktop_columns }}; --featured-products-columns: {{ effective_desktop_columns }};">
                {% endif %}
                        <div class="js-products-{{ section_id }}-grid {% if use_slider %} swiper-wrapper{% else %}row row-grid justify-content-center{% endif %}" data-desktop-columns="{{ effective_desktop_columns }}" data-mobile-columns="{{ section_columns_mobile }}" data-format="{{ section_format }}">
                            {% set grid_products = not use_slider ? (sections_products | slice(0, effective_desktop_columns)) : sections_products %}
                            {% for product in grid_products %}
                                {% if use_slider %}
                                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name, 'section_columns_desktop': section_columns_desktop, 'section_columns_mobile': section_columns_mobile } %}
                                {% else %}
                                    {% include 'snipplets/grid/item.tpl' with {'section_columns_desktop': effective_desktop_columns, 'section_columns_mobile': section_columns_mobile, 'section_name': section_name } %}
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
