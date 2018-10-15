{% from "plex/map.jinja" import plex with context %}

include:
  - plex.install

plex:
  service.running:
      - name: {{plex.service_name}}
      - enable: True
      - require:
        - sls: plex.install
