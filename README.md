# A GitHub action to run Doctum

|Series|Badges|
|------|------|
|5.x|[![Build docker image](https://github.com/sudo-bot/action-doctum/actions/workflows/build.yml/badge.svg?branch=5.x)](https://github.com/sudo-bot/action-doctum/actions/workflows/build.yml) [![build doctum docs](https://github.com/sudo-bot/action-doctum/actions/workflows/doctum.yml/badge.svg?branch=5.x)](https://github.com/sudo-bot/action-doctum/actions/workflows/doctum.yml)|
|dev|[![Build docker image](https://github.com/sudo-bot/action-doctum/actions/workflows/build.yml/badge.svg?branch=dev)](https://github.com/sudo-bot/action-doctum/actions/workflows/build.yml) [![build doctum docs](https://github.com/sudo-bot/action-doctum/actions/workflows/doctum.yml/badge.svg?branch=dev)](https://github.com/sudo-bot/action-doctum/actions/workflows/doctum.yml)|
|latest|[![Build docker image](https://github.com/sudo-bot/action-doctum/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/sudo-bot/action-doctum/actions/workflows/build.yml) [![build doctum docs](https://github.com/sudo-bot/action-doctum/actions/workflows/doctum.yml/badge.svg?branch=main)](https://github.com/sudo-bot/action-doctum/actions/workflows/doctum.yml)|


Go to [Doctum](https://github.com/code-lts/doctum#readme) at GitHub

You can find the image on [Docker Hub](https://hub.docker.com/r/botsudo/action-doctum)

[![Docker Pulls](https://img.shields.io/docker/pulls/botsudo/action-doctum.svg)](https://hub.docker.com/r/botsudo/action-doctum)

## Example usage for 5.x series

```yml
  - uses: actions/checkout@v3
  - name: build doctum docs
    uses: sudo-bot/action-doctum@v5
    with:
        config-file: doctum.php
        # parse, render or update
        method: "update"
        # (optional) defaults to '--output-format=github --no-ansi --no-progress -v'
        cli-args: "--output-format=github --no-ansi --no-progress -v"
```

## Example usage for latest series

```yml
  - uses: actions/checkout@v3
  - name: build doctum docs
    uses: sudo-bot/action-doctum@latest
    with:
        config-file: doctum.php
        # parse, render or update
        method: "update"
        # (optional) defaults to '--output-format=github --no-ansi --no-progress -v'
        cli-args: "--output-format=github --no-ansi --no-progress -v"
```

## Example usage for dev series

```yml
  - uses: actions/checkout@v3
  - name: build doctum docs
    uses: sudo-bot/action-doctum@dev
    with:
        config-file: doctum.php
        # parse, render or update
        method: "update"
        # (optional) defaults to '--output-format=github --no-ansi --no-progress -v'
        cli-args: "--output-format=github --no-ansi --no-progress -v"
```

## Example for a zero-config setup to parse/lint phpdocs

```yml
name: Lint phpdocs

on: [push]

jobs:
  lint-phpdoc:
    name: lint-phpdoc
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Create a config file
        # Scan all the src folder
        run: echo "<?php return new Doctum\Doctum('src/');" > doctum-config.php
      - name: lint doctum docs
        uses: sudo-bot/action-doctum@v5
        with:
          config-file: doctum-config.php
          method: "parse"
          # (optional) defaults to '--output-format=github --no-ansi --no-progress -v'
          cli-args: "--output-format=github --no-ansi --no-progress -v"
```
