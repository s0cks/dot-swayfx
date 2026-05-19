# swayfx configuration

A swayfx configuration for [@s0cks](https://github.com/s0cks).

## Theme

This configuration adopts the [Flexoki](https://stephango.com/flexoki), by [@kepano](https://github.com/kepano), colors for its color scheme.

## Installation

### Prerequisites

You will need the following to install the configuration:

- [swayfx](https://github.com/WillPower3309/swayfx)
- [git](https://git-scm.com/)
- [jsonnet](https://jsonnet.org/)

### Install

You can install this configuration by doing the following:

```sh
git clone --depth 1 git@github.com:s0cks/dot-swayfx.git ~/.config/sway # create a shallow clone of this config in ~/.config/sway
jsonnet -S -m . config.jsonnet # generate the config file using Jsonnet
```
