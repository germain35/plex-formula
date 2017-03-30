{% from "plex/map.jinja" import plex with context %}

include:
  - plex.install

plex_service:
  service.running:
      - name: {{plex.package_name}}
