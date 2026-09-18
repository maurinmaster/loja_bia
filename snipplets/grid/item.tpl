{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}

{% if template == 'home'%}
    {% set columns_desktop = section_columns_desktop %}
    {% set columns_mobile = section_columns_mobile %}
    {% set section_slider = section_slider %}
{% else %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    {% if template == 'product'%}
        {% set section_slider = true %}
    {% endif %}
{% endif %}

{# Subscription only detection #}
{% set is_subscription_only = product.isSubscriptionOnly() %}

{# Item image slider #}

{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider 
    and not slide_item
    and not reduced_item 
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'item-slider-controls-container svg-icon-text d-none d-md-block' %}
    {% set control_next_svg_id = 'arrow-long' %}
    {% set control_prev_svg_id = 'arrow-long' %}
{% endif %}

{# Secondary images #}

{% set show_secondary_image = settings.product_hover %}

{% if not fashion_card_styles_included %}
    {% set fashion_card_styles_included = true %}
    <style>
    /* Minimalist Fashion Card - 4:5 Full Cover Ratio & Zero Borders */
    .item-product {
      border: none !important;
      box-shadow: none !important;
      background: transparent !important;
    }
    .item-image {
      position: relative !important;
      border: none !important;
      box-shadow: none !important;
      background: #f7f7f7 !important;
      overflow: hidden !important;
      width: 100% !important;
    }
    .item-image .js-item-image-padding,
    .item-image-fashion-padding {
      padding-bottom: 125% !important; /* 4:5 aspect ratio */
      height: 0 !important;
      display: block !important;
      position: relative !important;
      overflow: hidden !important;
      width: 100% !important;
    }
    .item-image img,
    .item-image-fashion-img,
    .item-image .item-image-featured,
    .item-image .item-image-secondary {
      position: absolute !important;
      top: 0 !important;
      left: 0 !important;
      right: 0 !important;
      bottom: 0 !important;
      width: 100% !important;
      min-width: 100% !important;
      max-width: 100% !important;
      height: 100% !important;
      min-height: 100% !important;
      max-height: 100% !important;
      object-fit: cover !important;
      object-position: center !important;
      transform: none !important;
      -webkit-transform: none !important;
      transition: transform 0.45s ease-out, opacity 0.3s ease !important;
    }
    .item-product:hover .item-image img {
      transform: scale(1.03) !important;
      -webkit-transform: scale(1.03) !important;
    }
    </style>
{% endif %}

{% if slide_item %}
    <div class="swiper-slide">
{% endif %}
    <div class="js-item-product{% if slide_item %} js-item-slide p-0{% endif %}{% if not slide_item %} col-{% if columns_mobile == 1 %}12{% else %}6{% endif %} col-md-{% if columns_desktop == 2 %}6{% elseif columns_desktop == 3 %}4{% elseif columns_desktop == 5 %}2-4{% else %}3{% endif %}{% endif %} item-product {% if reduced_item %}item-product-reduced{% endif %} col-grid" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">
        <div class="js-item-info-container item{% if slide_item %} mb-0{% endif %}">
            {% if not reduced_item %}
                <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %} position-relative" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}">
            {% endif %}
            {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

            {# Set how much viewport space the images will take to load correct image #}

            {% if params.preview %}
                {% set mobile_image_viewport_space = '100' %}
                {% set desktop_image_viewport_space = '50' %}
            {% else %}
                {% if columns_mobile == 2 %}
                    {% set mobile_image_viewport_space = '50' %}
                {% else %}
                    {% set mobile_image_viewport_space = '100' %}
                {% endif %}

                {% if columns_desktop == 4 %}
                    {% set desktop_image_viewport_space = '25' %}
                {% elseif columns_desktop == 3 %}
                    {% set desktop_image_viewport_space = '33' %}
                {% else %}
                    {% set desktop_image_viewport_space = '50' %}
                {% endif %}
            {% endif %}

            {% set image_classes = 'js-item-image lazyautosizes ' ~ (not image_priority_high ? 'lazyload') ~ ' fade-in item-image-fashion-img' %}
            {% set data_expand = show_image_slider ? '50' : '-10' %}

            {% set floating_elements %}
                {% if not reduced_item %}
                    {% include 'snipplets/labels.tpl' with {labels_floating: true} %}

                    {# Floating Wishlist Button - Top Right #}
                    <button type="button" class="item-floating-action item-floating-wishlist js-item-wishlist" data-product-id="{{ product.id }}" title="{{ 'Favoritos' | translate }}" aria-label="{{ 'Favoritos' | translate }}">
                        <svg class="item-wishlist-icon" viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                        </svg>
                    </button>

                    {# Floating Quick Add FAB - Bottom Right #}
                    {% if product.available and product.display_price %}
                        <div class="item-floating-action item-floating-quickadd">
                            {% if product.isSubscribable() and is_subscription_only %}
                                <a href="{{ product_url_with_selected_variant }}" class="item-floating-fab" title="{{ 'our_components.subscriptions.subscribe' | tt }}" aria-label="{{ 'our_components.subscriptions.subscribe' | tt }}">
                                    <svg class="item-fab-bag-icon" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                                        <line x1="3" y1="6" x2="21" y2="6"></line>
                                        <path d="M16 10a4 4 0 0 1-8 0"></path>
                                    </svg>
                                    <span class="item-fab-plus">+</span>
                                </a>
                            {% elseif product.variations %}
                                <button type="button" class="item-floating-fab js-quickshop-modal-open js-fullscreen-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open" data-toggle="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}">
                                    <svg class="item-fab-bag-icon" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                                        <line x1="3" y1="6" x2="21" y2="6"></line>
                                        <path d="M16 10a4 4 0 0 1-8 0"></path>
                                    </svg>
                                    <span class="item-fab-plus">+</span>
                                </button>
                            {% else %}
                                <form class="js-product-form item-fab-form m-0" method="post" action="{{ store.cart_url }}">
                                    <input type="hidden" name="add_to_cart" value="{{ product.id }}" />
                                    <button type="submit" class="item-floating-fab js-addtocart js-prod-submit-form" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}">
                                        <svg class="item-fab-bag-icon" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                                            <line x1="3" y1="6" x2="21" y2="6"></line>
                                            <path d="M16 10a4 4 0 0 1-8 0"></path>
                                        </svg>
                                        <span class="item-fab-plus">+</span>
                                    </button>
                                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {direct_add: true, custom_class: "item-fab-placeholder"} %}
                                </form>
                            {% endif %}
                        </div>
                    {% endif %}
                {% endif %}
            {% endset %}

            {{ component(
                'product-item-image', {
                    image_lazy: true,
                    image_lazy_js: true,
                    image_data_expand: data_expand,
                    image_secondary_data_sizes: 'auto',
                    image_sizes: '(max-width: 768px)' ~ mobile_image_viewport_space ~ 'vw, (min-width: 769px)' ~ desktop_image_viewport_space ~ 'vw',
                    secondary_image: show_secondary_image,
                    slider: show_image_slider,
                    placeholder: true,
                    image_priority_high: image_priority_high,
                    custom_content: floating_elements,
                    slider_pagination_container: true,
                    product_item_image_classes: {
                        image_container: 'item-image' ~ (columns == 1 ? ' item-image-big') ~ (show_image_slider ? ' item-image-slider'),
                        image_padding_container: 'js-item-image-padding position-relative d-block item-image-fashion-padding',
                        image: image_classes,
                        image_featured: 'item-image-featured item-image-fashion-img',
                        image_secondary: 'item-image-secondary item-image-fashion-img',
                        slider_container: 'swiper-container position-absolute h-100 w-100',
                        slider_wrapper: 'swiper-wrapper',
                        slider_slide: 'swiper-slide item-image-slide',
                        slider_control_pagination_container: 'item-slider-pagination-container d-md-none',
                        slider_control_pagination: 'swiper-pagination item-slider-pagination',
                        slider_control: 'icon-inline icon-lg',
                        slider_control_prev_container: 'swiper-button-prev ' ~ slider_controls_container_class,
                        slider_control_prev: 'icon-flip-horizontal',
                        slider_control_next_container: 'swiper-button-next ' ~ slider_controls_container_class,
                        more_images_message: 'item-more-images-message',
                        placeholder: 'placeholder-fade',
                    },
                    control_next_svg_id: control_next_svg_id,
                    control_prev_svg_id: control_prev_svg_id,
                })
            }}

            {% if 
                product.available 
                and product.display_price 
                and product.variations 
                and not reduced_item 
            %}

                {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}

                <div class="js-item-variants hidden">
                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                        {% if product.variations %}
                            {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                        {% endif %}
                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                        {# Add to cart CTA #}

                        {% set show_product_quantity = product.available and product.display_price %}

                        <div class="row">

                            {% if show_product_quantity %}
                                {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
                            {% endif %}

                            <div class="js-buy-button-container {% if show_product_quantity %}col-8 pl-md-0{% else %}col-12{% endif %} buy-button-container">

                                <input type="submit" class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                                {# Fake add to cart CTA visible during add to cart event #}

                                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}
                            </div>
                        </div>
                    </form>
                </div>

            {% endif %}
            {% set show_labels = not product.has_stock or product.compare_at_price or product.hasVisiblePromotionLabel %}
            <div class="item-description text-left" data-store="product-item-info-{{ product.id }}">
                <div class="item-header-row d-flex align-items-center justify-content-between">
                    <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link item-title-link">
                        {{ component('nubesdk-slot', { type: "before_product_grid_item_name" }) }}
                        <div class="js-item-name item-name" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                        {{ component('nubesdk-slot', { type: "after_product_grid_item_name" }) }}
                    </a>

                    {% if not reduced_item %}
                        <div class="item-colors-side">
                            {% include 'snipplets/grid/item-colors.tpl' %}
                        </div>
                    {% endif %}
                </div>

                <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link item-price-link">
                    {{ component('nubesdk-slot', { type: "before_product_grid_item_price" }) }}

                    {% if product.display_price %}
                        <div class="item-price-container" data-store="product-item-price-{{ product.id }}">
                            <span class="js-price-display item-price" data-product-price="{{ product.price }}">
                                {{ product.price | money }}
                            </span>
                            {% if not reduced_item %}
                                <span class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %}style="display:inline-block;"{% endif %}>
                                    {{ product.compare_at_price | money }}
                                </span>
                            {% endif %}
                        </div>
                    {% endif %}

                    {{ component('nubesdk-slot', { type: "after_product_grid_item_price" }) }}
                </a>
            </div>
            {% if not reduced_item %}
                </div>{# This closes the quickshop tag #}
            {% endif %}

            {# Structured data to provide information for Google about the product content #}
            {{ component('structured-data', {'item': true}) }}
        </div>
    </div>
{% if slide_item %}
    </div>
{% endif %}