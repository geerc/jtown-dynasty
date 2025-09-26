# Netlify CMS component theme

The _Netlify CMS_ component theme for [Cecil](https://cecil.app) provides support of [Netlify CMS](https://www.netlifycms.org).

## Features

- Provides a default Netlify CMS `config.yml` file
- Supports [Netlify Identity](https://docs.netlify.com/visitor-access/identity/)

## Installation

```bash
composer require cecil/theme-netlifycms
```

> Or [download the latest archive](https://github.com/Cecilapp/theme-netlifycms/releases/latest/) and uncompress its content in `themes/netlifycms`.

## Usage

Add `netlify-cms` in the `theme` section of your `config.yml`:

```yaml
theme:
  - netlify-cms
```

Include _Netlify Identity_ template:

```twig
{% include 'partials/identity.html.twig' with {'site': site} only %}
```

Customize CMS configuration by copying [`config.yml`](https://github.com/Cecilapp/theme-netlifycms/blob/main/static/admin/config.yml) into `static/admin/`.

The default route to the CMS is `/admin/`.
