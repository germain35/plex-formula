{% from "plex/map.jinja" import plex with context %}

{%- set os         = salt['grains.get']('os') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

{%- if plex.manage_repo %}
  {%- if 'repo' in plex and plex.repo is mapping %}
plex_repo:
  pkgrepo.managed:
    {%- for k, v in plex.repo.iteritems() %}
    - {{k}}: {{v}}
    {%- endfor %}
  {%- endif %}
{%- endif %}
