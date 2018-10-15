{% from "plex/map.jinja" import plex with context %}

include:
  - plex.repo
  - plex.service

{% set osarch  = salt['grains.get']('osarch') %}
{% set version = salt['pillar.get']('plex:version', None) %}

{%- if plex.manage_repo %}
  {%- if plex.version == 'latest' %}
plex_package:
  pkg.latest:
    - name: {{ plex.package_name }}
    - refresh: True
    - require:
      - pkgrepo: plex_repo
  {%- else %}
plex_package:
  pkg.installed:
    - name: {{ plex.package_name }}
    - version: {{ plex.version }}
    - allow_updates: True
    - refresh: True
    - require:
      - pkgrepo: plex_repo
  {%- endif %}
{%- else %}
  {% set source = plex.base_url ~ '/' + version ~ '/' + plex.package_prefix ~  version ~ '_' ~ osarch ~ plex.package_suffix %}
plex_package:
  pkg.installed:
    - sources:
      - {{plex.package_name}}: {{ source }}
    - watch_in:
      - service: plex
{%- endif %}
