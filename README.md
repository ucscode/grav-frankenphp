# ![](https://avatars1.githubusercontent.com/u/8237355?v=2&s=50) Grav &plus; FrankenPHP

[![PHPStan](https://img.shields.io/badge/PHPStan-enabled-brightgreen.svg?style=flat)](https://github.com/phpstan/phpstan)
[![Discord](https://img.shields.io/discord/501836936584101899.svg?logo=discord&colorB=728ADA&label=Discord%20Chat)](https://chat.getgrav.org)
 [![PHP Tests](https://github.com/getgrav/grav/workflows/PHP%20Tests/badge.svg?branch=develop)](https://github.com/getgrav/grav/actions?query=workflow%3A%22PHP+Tests%22) [![OpenCollective](https://opencollective.com/grav/tiers/backers/badge.svg?label=Backers&color=brightgreen)](#backers) [![OpenCollective](https://opencollective.com/grav/tiers/supporters/badge.svg?label=Supporters&color=brightgreen)](#supporters) [![OpenCollective](https://opencollective.com/grav/tiers/sponsors/badge.svg?label=Sponsors&color=brightgreen)](#sponsors)

Grav is a **Fast**, **Simple**, and **Flexible**, file-based Web-platform.  There is **Zero** installation required.  Just extract the ZIP archive, and you are already up and running.  It follows similar principles to other flat-file CMS platforms, but has a different design philosophy than most. Grav comes with a powerful **Package Management System** to allow for simple installation and upgrading of plugins and themes, as well as simple updating of Grav itself.

![Grav Dashboard](https://learn.getgrav.org/user/pages/05.admin-panel/01.introduction/admin-dashboard.png)

For more information, see the official grav resources:

- [Grav Github](https://github.com/getgrav/grav)
- [Grav Learn](https://learn.getgrav.org/17)
- [Grav Skeletons](https://getgrav.org/downloads/skeletons)

# Requirements

- PHP 7.3.6 or higher. Check the [required modules list](https://learn.getgrav.org/basics/requirements#php-requirements)

# Features

- Runs via [Docker](https://www.docker.com/)
- Powered by [FrankenPHP](https://frankenphp.dev/) — an advanced PHP app server built on [Caddy](https://caddyserver.com/)
- Provides support for installing custom plugin and theme dependencies
- Command-line workflow for development and production environments

# QuickStart

1. Clone the Grav-FrankenPHP repository
   ```
   git clone https://github.com/ucscode/grav-frankenphp.git
   cd grav-frankenphp
   ```

2. Clone the official Grav CMS into the working directory:
   ```
   git clone -b master https://github.com/getgrav/grav.git
   ```

3. For custom configuration, copy `.env.sample` to `.env`
   ```
   cp .env.sample .env
   ```

4. Build and start the docker container
   ```
   docker compose up -d
   ```

5. Install the default grav dependencies (**plugin** and **theme**)
   ```
   docker compose exec php bin/grav install
   ```

# Accessing Grav on localhost

Set your desired port in `.env`. By default, the local HTTP port is 7000.

Then open Grav in your browser:

```
http://localhost:7000
```

# Install Custom Plugins and Themes

You can install all Grav dependencies listed in the config file using either `make` or a standalone script.

---

#### Option 1: Using `make`

Run the following command to install all dependencies listed in `gpm-dependencies.conf`:

```bash
make install-deps
```

This internally calls `bin/gpm install <plugin>` for each valid entry.

---

#### Option 2: Using the standalone script

You can also run the installer directly, with optional support for custom config files:

```bash
./gpm-install
```

This installs dependencies from the default `gpm-dependencies.conf` file in the project root.

To use a different file:

```bash
./gpm-install path/to/your-deps-file
```

This allows you to maintain different sets of plugins for various environments (e.g., `gpm-deps.dev`, `gpm-deps.prod`, etc.).

---

> Make sure the dependency file is properly formatted, with one plugin name per line and optional `#` comments.

Example `gpm-dependencies`:

```txt
# Required GPM plugins
form
login
admin
```

---

> **Production Notes:** \
> For production, avoid using `compose.override.yaml`.  
> Instead, define only the necessary services and configurations suitable for your deployment environment.  
> **Example:** `docker compose -f compose.yaml -f compose.prod.yaml up` 

---

## References

* [Grav GitHub Repository](https://github.com/getgrav/grav)
* [Grav Documentation](https://learn.getgrav.org/17)
* [Grav Skeletons](https://getgrav.org/downloads/skeletons)
