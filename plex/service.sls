{% from "plex/map.jinja" import plex_settings with context %}

include:
  - plex.install

plex:
  service.running:
      - name: {{plex_settings.service_name}}
      - enable: True
      - require:
        - sls: plex.install
