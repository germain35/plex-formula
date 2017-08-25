{% from "plex/map.jinja" import plex_settings with context %}

include:
  - plex.repo
  - plex.service

{% set osarch  = salt['grains.get']('osarch') %}
{% set version = salt['pillar.get']('plex:version', None) %}

{%- if plex_settings.manage_repo %}
  {%- if plex_settings.version == 'latest' %}
plex_package:
  pkg.latest:
    - name: {{ plex_settings.package_name }}
    - refresh: True
    - require:
      - pkgrepo: plex_repo
  {%- else %}
plex_package:
  pkg.installed:
    - name: {{ plex_settings.package_name }}
    - version: {{ plex_settings.version }}
    - allow_updates: True
    - refresh: True
    - require:
      - pkgrepo: plex_repo
  {%- endif %}
{%- else %}
  {% set source = plex_settings.base_url ~ '/' + version ~ '/' + plex_settings.package_prefix ~  version ~ '_' ~ osarch ~ plex_settings.package_suffix %}
plex_package:
  pkg.installed:
    - sources:
      - {{plex_settings.package_name}}: {{ source }} 
    - watch_in:
      - service: plex
{%- endif %}
