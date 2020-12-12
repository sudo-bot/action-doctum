# A GitHub action to run Doctum

[Doctum](https://github.com/code-lts/doctum#readme)

## Example usage for 5.x series

```yml
  - uses: actions/checkout@v2
  - name: build doctum docs
    uses: sudo-bot/action-doctum@v5
    with:
        config-file: doctum.php
        # parse, render or update
        method: "update"
        # (optional) defaults to '--output-format=github --no-ansi --no-progress -v'
        cli-args: "--output-format=github --no-ansi --no-progress"
```

## Example usage for latest series

```yml
  - uses: actions/checkout@v2
  - name: build doctum docs
    uses: sudo-bot/action-doctum@latest
    with:
        config-file: doctum.php
        # parse, render or update
        method: "update"
        # (optional) defaults to '--output-format=github --no-ansi --no-progress -v'
        cli-args: "--output-format=github --no-ansi --no-progress"
```

## Example usage for dev series

```yml
  - uses: actions/checkout@v2
  - name: build doctum docs
    uses: sudo-bot/action-doctum@dev
    with:
        config-file: doctum.php
        # parse, render or update
        method: "update"
        # (optional) defaults to '--output-format=github --no-ansi --no-progress -v'
        cli-args: "--output-format=github --no-ansi --no-progress"
```
