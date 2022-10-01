# Icon Library

Useful icons for use across Hotseat, brought to you by [Heroicons](https://heroicons.com).

## ERB-ify

Generally, we can just copy/paste the `svg` code from Heroicons. However, sometimes it is useful to add custom Tailwind classes onto the icons. To do so, add: `class="<%= classes %>"` to the `<svg>` tag. Example:

```erb
<svg class="<%= classes %>" xmlns="http://www.w3.org/2000/svg" ...>
```
