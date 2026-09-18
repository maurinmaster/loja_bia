{% if product.variations %}
    {% for variation in product.variations %}
        <div class="js-color-variant-available-{{ loop.index }} {% if variation.name | lower in ['color', 'cor', 'cores'] %}js-color-variant-active{% endif %}" data-value="variation_{{ loop.index }}" data-option="{{ loop.index0 }}" >
            {% if variation.name | lower in ['color', 'cor', 'cores'] %}
                {% if variation.options | length > 1 %}
                    <div class="item-colors d-flex align-items-center">
                        {% for option in variation.options | take(4) %}
                            {% set hex_color = option.custom_data %}
                            {% if not hex_color %}
                                {% set opt_name = option.name | lower | trim %}
                                {% if 'preto' in opt_name or 'black' in opt_name %}
                                    {% set hex_color = '#111111' %}
                                {% elseif 'branco' in opt_name or 'white' in opt_name or 'off white' in opt_name %}
                                    {% set hex_color = '#ffffff' %}
                                {% elseif 'bege' in opt_name or 'nude' in opt_name or 'areia' in opt_name %}
                                    {% set hex_color = '#d8c2aa' %}
                                {% elseif 'marrom' in opt_name or 'caramelo' in opt_name or 'chocolate' in opt_name %}
                                    {% set hex_color = '#7a4b2c' %}
                                {% elseif 'rosa' in opt_name or 'pink' in opt_name or 'rose' in opt_name %}
                                    {% set hex_color = '#e8a5b8' %}
                                {% elseif 'azul' in opt_name or 'blue' in opt_name or 'marinho' in opt_name %}
                                    {% set hex_color = '#274374' %}
                                {% elseif 'verde' in opt_name or 'green' in opt_name or 'militar' in opt_name or 'oliva' in opt_name %}
                                    {% set hex_color = '#436142' %}
                                {% elseif 'vermelho' in opt_name or 'red' in opt_name or 'vinho' in opt_name or 'bordo' in opt_name %}
                                    {% set hex_color = '#8b1e2d' %}
                                {% elseif 'cinza' in opt_name or 'grey' in opt_name or 'gray' in opt_name %}
                                    {% set hex_color = '#9e9e9e' %}
                                {% elseif 'amarelo' in opt_name or 'yellow' in opt_name %}
                                    {% set hex_color = '#f2c94c' %}
                                {% elseif 'laranja' in opt_name or 'orange' in opt_name %}
                                    {% set hex_color = '#f2994a' %}
                                {% elseif 'roxo' in opt_name or 'lilas' in opt_name or 'violeta' in opt_name %}
                                    {% set hex_color = '#9b51e0' %}
                                {% else %}
                                    {% set hex_color = '#cccccc' %}
                                {% endif %}
                            {% endif %}
                            <span title="{{ option.name }}" data-option="{{ option.id }}" data-variation-id="{{ variation.id }}" class="js-color-variant item-colors-bullet" style="background: {{ hex_color }}"></span>
                        {% endfor %}

                        {% if variation.options | length > 4 %}
                            <span class="item-colors-bullet item-colors-bullet-more" title="{{ 'Ver mais cores' | translate }}">+{{ variation.options | length - 4 }}</span>
                        {% endif %}
                    </div>
                {% endif %}
            {% endif %}
        </div>
    {% endfor %}
{% endif %}