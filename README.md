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
        # You can change them, defaults to '--output-format=github --no-ansi --no-progress' (optional)
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
        # You can change them, defaults to '--output-format=github --no-ansi --no-progress' (optional)
        cli-args: "--output-format=github --no-ansi --no-progress"
```
