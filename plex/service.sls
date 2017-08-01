{% from "plex/map.jinja" import plex with context %}

include:
  - plex.install

plex:
  service.running:
      - name: {{plex.package_name}}
      - enable: True
      - require:
        - sls: plex.install
