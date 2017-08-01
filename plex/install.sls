{% from "plex/map.jinja" import plex with context %}

{% set osarch  = salt['grains.get']('osarch') %}
{% set version = salt['pillar.get']('plex:version', None) %}

{% if version is not none %}
  {% set source = plex.base_url ~ '/' + version ~ '/' + plex.package_prefix ~  version ~ '_' ~ osarch ~ plex.package_suffix %}
plex_package:
  pkg.installed:
    - sources: 
      - {{plex.package_name}}: {{ source }}
    - watch_in:
      - service: plex
{% endif %}
