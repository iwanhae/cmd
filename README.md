# cmd

CLI tools for working with the [pi](https://pi.dev) coding agent.

## Setup

Source `rc.bash` to add this repo’s tools to your `PATH`:

```bash
source /path/to/cmd/rc.bash
```

## Tools

### `pido` — "pi do"

Run `pi` in the background with live progress streaming.

```bash
# Foreground mode
pido "<prompt>"

# Options
pido --model <model> --provider <provider> --thinking high "<prompt>"
pido --tools read,bash,grep,find,ls "<prompt>"
```

### `search`

Interactive ripgrep + fzf code search with preview and editor opening.

```bash
search
search my_query
```

### `sgo`

Search Go module sources under `~/go/pkg/mod`.

```bash
sgo
sgo http client
```

### `sgit`

Search files under `~/git`.

```bash
sgit
sgit kubernetes
```

### `gs`

Interactively switch Git branches with `fzf`.

```bash
gs
```

### `newbranch`

Update `~/work/main`, create a new Git worktree, and open it in VS Code.

```bash
newbranch
```

### `delbranch`

Update `~/work/main` and interactively remove a Git worktree.

```bash
delbranch
```

### `kctx`

Interactively switch the current Kubernetes context.

```bash
kctx
```

### `kns`

Interactively switch the current Kubernetes namespace.

```bash
kns
```

### `knopo`

Pick a Kubernetes node and watch pods scheduled on it.

```bash
knopo
```

### `knstop`

Python utility for inspecting Kubernetes resource usage.

```bash
knstop
```

### `klog`

Browse pods (`kubectl get pod -o wide`) in the current namespace with `fzf`;
the preview pane lists the pod's containers and shows the logs (via `bat`) of
the selected one.

```bash
klog
```

- `ctrl-o` — pick which container's logs to preview
- `enter` — follow (`kubectl logs -f`) the selected container
- `ctrl-r` — reload the pod list

Type to fuzzy-filter the list by any column, including `NODE`.

### `kdebug`

Pick a Kubernetes node (reusing `knopo`'s node cache) and launch an
interactive debug pod pinned to it via `nodeName` in the current namespace.

```bash
kdebug
```
