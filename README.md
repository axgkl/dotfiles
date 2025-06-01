# OSX Setup

## Screencapture
One key to mouse selection in clipboard

[https://heise.de](http://heise.de)

g80 1/5 -> control + f5 -> ke bin/hotkey screenshot ->

```bash
function screenshot {
    n "screenshot" "space: mouse/win toggle"
    local fn && fn="capt-$(date +%Y-%m-%d_%H-%M-%S).png"
    screencapture -c -i "$H/Pictures/shots/$fn"
    ln -sf "$H/Pictures/shots/$fn" "$H/Pictures/shots/last.png"
}
```
