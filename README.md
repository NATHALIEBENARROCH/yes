# Public corporate website https://jdlabs.co

# Staging websites

* https://beta.jdlabs.co/    --> /en/
* https://beta.jdlabs.co/fr/ --> /fr/

# Development

## Framework

This website uses the [Hugo](https://gohugo.io) static website framework. Documentation available at: https://gohugo.io/documentation/

## Where to change code

Do your changes in the `/en/` folder. Everything, except for the `data/` folder and `config.yaml`, will be copied over
to the `/fr/` folder.

## Testing locally

Move to the `/en/` folder and launch Hugo, which will compile the
```
cd en
hugo serve
```

## Editor plugin

There's a few editors plugins available to aid in your development:
https://gohugo.io/tools/editors/
