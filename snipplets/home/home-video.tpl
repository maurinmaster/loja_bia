{% set theme_editor = params.preview %}
{% if settings.video_embed or theme_editor %}
    {% set has_video_text = settings.video_title or settings.video_text or (settings.video_button and settings.video_button_url)  %}
    {% set video_url = settings.video_embed %}
    {% set video_format = 
        '/watch?v=' in video_url ? '/watch?v=' :
        '/youtu.be/' in video_url ? '/youtu.be/' :
        '/shorts/' in video_url ? '/shorts/'
    %}
    {% set video_id = video_url|split(video_format)|last %}
    {% set video_has_autoplay = settings.video_type == 'autoplay' %}
    {% set video_has_sound = settings.video_type == 'sound' %}
    {% set has_video_first = settings.home_order_position_1 == 'video' %}
    {% set custom_video_image = "video_image.jpg" | has_custom_image %}
    {% set is_shorts = '/shorts/' in video_url %}

    <div class="floating-video-wrapper js-floating-video-wrapper">
        {# Floating Video Bubble (Portrait 9:16, subtly rounded corners) #}
        <div class="floating-video-bubble js-floating-video-bubble {% if is_shorts %}is-vertical-source{% else %}is-horizontal-source{% endif %}" data-store="floating-video">
            
            {# Top Floating Controls #}
            <div class="floating-video-header">
                <button type="button" class="floating-video-btn floating-video-sound-btn js-floating-video-sound" aria-label="Ativar ou desativar som" title="Som">
                    <svg class="icon-inline icon-sound-muted js-icon-sound-muted" viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon>
                        <line x1="23" y1="9" x2="17" y2="15"></line>
                        <line x1="17" y1="9" x2="23" y2="15"></line>
                    </svg>
                    <svg class="icon-inline icon-sound-on js-icon-sound-on" style="display: none;" viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon>
                        <path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"></path>
                    </svg>
                </button>
                <button type="button" class="floating-video-btn floating-video-close-btn js-floating-video-close" aria-label="Minimizar vídeo" title="Minimizar">
                    <svg class="icon-inline" viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>

            {# Video Body #}
            <div class="floating-video-body">
                <div class="js-home-video-container lazyload home-video position-relative{% if video_has_autoplay %} home-video-autoplay{% endif %}" data-video="{{ video_id }}" data-video-type="{{ settings.video_type }}" data-custom-thumb="{{ custom_video_image ? 'true' : 'false' }}" data-allow-custom-thumb="{{ has_video_first or video_has_sound ? 'true' : 'false' }}">
                    <a href="#" class="js-play-button video-player"{% if video_has_autoplay %} style="display: none"{% endif %}>
                        <div class="video-player-icon">
                            <svg class="icon-inline icon-xs svg-icon-text"><use xlink:href="#play"/></svg>
                        </div>
                    </a>
                    <div class="js-home-video-image floating-video-thumbnail" {% if not (has_video_first or video_has_sound) %} style="display: none"{% endif %}>
                        {% if custom_video_image %}
                            {% set video_image_static_url = "video_image.jpg" | static_url %}
                            {% set video_image_src = video_image_static_url | settings_image_url("large") %}
                        {% else %}
                            {% set video_image_src = 'https://img.youtube.com/vi_webp/' ~ video_id ~ '/maxresdefault.webp' %}
                        {% endif %}
                        <img 
                            class="home-video-image lazyload fade-in" 
                            data-src='{{ video_image_src }}'
                            {% if custom_video_image %}
                                data-srcset='{{ video_image_static_url | settings_image_url("original") }} 1024w, {{ video_image_static_url | settings_image_url("1080p") }} 1920w'
                            {% endif %} 
                            alt="{{ 'Video de' | translate }} {{ store.name }}" 
                        />
                        <div class="placeholder-fade"></div>
                    </div>
                    <div class="js-home-video-iframe" id="player"></div>
                    <div class="home-video-hide-controls js-floating-video-toggle-play" title="Pausar / Reproduzir"></div>
                    <div class="floating-video-play-indicator js-floating-video-play-indicator" style="display: none;">
                        <svg viewBox="0 0 24 24" width="28" height="28" fill="#ffffff"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                    </div>
                </div>
            </div>

            {# Bottom Overlay Info #}
            <div class="js-home-video-text-container floating-video-footer" {% if not has_video_text %}style="display: none;"{% endif %} data-home-video-sound="{{ video_has_sound ? 'true' : 'false' }}">
                <h4 class="js-home-video-title floating-video-title" {% if not settings.video_title %}style="display: none;"{% endif %}>{{ settings.video_title }}</h4>
                <p class="js-home-video-text floating-video-desc" {% if not settings.video_text %}style="display: none;"{% endif %}>{{ settings.video_text }}</p>
                <a href="{{ settings.video_button_url }}" class="js-home-video-button floating-video-cta" {% if not (settings.video_button and settings.video_button_url) %}style="display: none;"{% endif %}>{{ settings.video_button }}</a>
            </div>
        </div>

        {# Minimized Launcher Bubble #}
        <button type="button" class="floating-video-launcher js-floating-video-launcher" style="display: none;" aria-label="Abrir vídeo" title="Abrir vídeo">
            <span class="floating-video-launcher-pulse"></span>
            <span class="floating-video-launcher-icon">
                <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
            </span>
        </button>
    </div>
{% endif %}
