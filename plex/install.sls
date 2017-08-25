{% from "plex/map.jinja" import plex_settings with context %}

include:
  - plex.repo
  - plex.service

{% set osarch  = salt['grains.get']('osarch') %}
{% set version = salt['pillar.get']('plex:version', None) %}

{% if version is not none %}
  {% set source = plex_settings.base_url ~ '/' + version ~ '/' + plex_settings.package_prefix ~  version ~ '_' ~ osarch ~ plex_settings.package_suffix %}
{% endif %}

plex_package:
  pkg.installed:
    {%- if plex_settings.manage_repo %}
    - name: {{ plex_settings.package_name }}
    - require:
      - pkgrepo: plex_repo
    {%- else %}
    - sources:
      - {{plex_settings.package_name}}: {{ source }}
    {%- endif %}
    - watch_in:
      - service: plex
