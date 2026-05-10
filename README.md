# cmd

CLI tools for working with the [pi](https://pi.dev) coding agent.

## Tools

### `pido` — "pi do"

Run `pi` in the background with live progress streaming.

```bash
# Foreground mode
pido "<prompt>"

# Background mode (tmux)
pido --bg "<prompt>"

# Management
pido --list        # list background agents
pido --attach <id> # watch live progress
pido --wait <id>   # block until done, print result
pido --result <id> # print final result (if done)

# Options
pido --model <model> --thinking high "<prompt>"
```
