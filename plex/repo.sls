{% from "plex/map.jinja" import plex_settings with context %}

{%- set os         = salt['grains.get']('os') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

{%- if plex_settings.manage_repo %}
  {%- if 'repo' in plex_settings and plex_settings.repo is mapping %}
plex_repo:
  pkgrepo.managed:
    {%- for k, v in plex_settings.repo.iteritems() %}
    - {{k}}: {{v}}
    {%- endfor %}
  {%- endif %}
{%- endif %}
