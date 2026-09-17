{% set has_featured = has_featured | default(false) and sections.primary.products %}
{% set has_new = has_new | default(false) and sections.new.products %}
{% set has_sale = has_sale | default(false) and sections.sale.products %}

{% if has_featured %}
	{% set data_store_name = 'featured' %}
{% elseif has_new %}
	{% set data_store_name = 'new' %}
{% else %}
	{% set data_store_name = 'sale' %}
{% endif %}

{% set is_new_section = has_new %}
{% set is_featured_section = has_featured %}
{% set custom_section_styles = '' %}
{% if is_new_section and settings.new_products_colors %}
	{% if settings.new_products_bg_color %}
		{% set custom_section_styles = custom_section_styles ~ 'background-color: ' ~ settings.new_products_bg_color ~ ';' %}
	{% endif %}
	{% if settings.new_products_text_color %}
		{% set custom_section_styles = custom_section_styles ~ 'color: ' ~ settings.new_products_text_color ~ ';' %}
	{% endif %}
{% elseif is_featured_section and settings.featured_products_colors %}
	{% if settings.featured_products_bg_color %}
		{% set custom_section_styles = custom_section_styles ~ 'background-color: ' ~ settings.featured_products_bg_color ~ ';' %}
	{% endif %}
	{% if settings.featured_products_text_color %}
		{% set custom_section_styles = custom_section_styles ~ 'color: ' ~ settings.featured_products_text_color ~ ';' %}
	{% endif %}
{% endif %}

{% if has_featured or has_new or has_sale %}
	<section class="section-featured-home{% if is_new_section and settings.new_products_has_banner %} section-new-products-featured py-4 py-md-5{% elseif is_featured_section and settings.featured_products_has_banner %} section-featured-products-banner py-4 py-md-5{% endif %}" data-store="home-products-{{ data_store_name }}" {% if custom_section_styles %}style="{{ custom_section_styles }}"{% endif %}>

		{{ component('nubesdk-slot', { type: 'before_section_products_' ~ data_store_name }) }}

		{% if has_featured %}
			{% include 'snipplets/home/home-featured-grid.tpl' with {'featured_products': true} %}
		{% endif %}
		{% if has_new %}
			{% include 'snipplets/home/home-featured-grid.tpl' with {'new_products': true} %}
		{% endif %}
		{% if has_sale %}
			{% include 'snipplets/home/home-featured-grid.tpl' with {'sale_products': true} %}
		{% endif %}

		{{ component('nubesdk-slot', { type: 'after_section_products_' ~ data_store_name }) }}

	</section>
{% endif %}
