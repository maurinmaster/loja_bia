{% if settings.main_categories and settings.slider_categories and settings.slider_categories is not empty %}
    {% set is_full_width = settings.main_categories_width == 'full' %}
    <section class="section-categories-home position-relative py-4 py-md-5" data-store="home-categories-featured">
        <div class="{% if is_full_width %}container-fluid px-2 px-md-4{% else %}container{% endif %}">
            {% if settings.main_categories_title %}
                <h2 class="home-categories-title text-center text-uppercase mb-3 mb-md-4">{{ settings.main_categories_title }}</h2>
            {% endif %}
            <div class="js-swiper-categories swiper-container">
                <div class="swiper-wrapper">
                    {% for slide in settings.slider_categories %}
                        {% set category_title = slide.title %}
                        {% if not category_title and slide.link %}
                            {% set category_handle = slide.link | trim('/') | split('/') | last %}
                            {% for cat in categories %}
                                {% if cat.handle == category_handle %}
                                    {% set category_title = cat.name %}
                                {% else %}
                                    {% for subcat in cat.subcategories %}
                                        {% if subcat.handle == category_handle %}
                                            {% set category_title = subcat.name %}
                                        {% endif %}
                                    {% endfor %}
                                {% endif %}
                            {% endfor %}
                            {% if not category_title and category_handle %}
                                {% set category_title = category_handle | replace('-', ' ') | capitalize %}
                            {% endif %}
                        {% endif %}

                        <div class="swiper-slide w-auto">
                            {% if slide.link %}
                                <a href="{{ slide.link | setting_url }}" class="home-category-item" aria-label="{{ category_title | default('Categoría' | translate ~ ' ' ~ loop.index) }}">
                            {% else %}
                                <div class="home-category-item">
                            {% endif %}
                                    <div class="home-category-circle-wrapper">
                                        <div class="home-category-circle position-relative">
                                            <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('large') }}" class="swiper-lazy fade-in home-category-circle-img" alt="{{ category_title | default('Categoría' | translate ~ ' ' ~ loop.index) }}">
                                            <div class="placeholder-fade"></div>
                                        </div>
                                    </div>
                                    {% if category_title %}
                                        <span class="home-category-name text-center font-weight-bold">
                                            {{ category_title }}
                                        </span>
                                    {% endif %}
                            {% if slide.link %}
                                </a>
                            {% else %}
                                </div>
                            {% endif %}
                        </div>
                    {% endfor %}
                </div>
            </div>
            <div class="text-center mt-3 mt-md-4 js-categories-controls">
                <div class="js-swiper-categories-prev swiper-button-prev svg-icon-text">
                    <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#arrow-long"/></svg>
                </div>
                <div class="js-swiper-categories-next swiper-button-next svg-icon-text">
                    <svg class="icon-inline icon-lg"><use xlink:href="#arrow-long"/></svg>
                </div>
            </div>
        </div>
    </section>
{% endif %}
