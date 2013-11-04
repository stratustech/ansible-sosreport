Ansible Playbook for Sosreport
==============================

[![Build Status](https://travis-ci.org/stratustech/ansible-sosreport.png)](https://travis-ci.org/stratustech/ansible-sosreport)

This playbook provides the `generate.yml` play to install a locally provided
`sosreport` package, run `sosreport` to generate a diagnostic tarball and then
fetch the tarballs from all hosts to a local directory.

# Prerequisites

You must have [Ansible](http://www.ansibleworks.com) installed (see
[Ansible Installation](http://www.ansibleworks.com/docs/intro_installation.html)
for directions).  You must also either have an
[ansible inventory file](http://www.ansibleworks.com/docs/intro_inventory.html)
that enumerates the hosts in your environment or call `ansible-playbook` with the
`-i` flag, specifying comma-separated hostnames explicitly.

# Playbook Configuration

See [config/default.yml](config/default.yml) for playbook configuration variables.
Configuration variables can either be set through a `config/custom.yml` file or
via the command-line via *extra vars* (e.g. `ansible-playbook -e`).

# Running the `generate.yml` Play

By default the [generate.yml](generate.yml) play will run `sosreport` on *all* hosts
and fetch the diagnostic files to the local `diags` directory.

```
> ansible-playbook generate.yml
```

To change the local `diag_path` where the sosreports are fetched to, use the `-e` or `--extra-vars`
flag to override the `diag_path` variable.

```
> ansible-playbook generate.yml -e diag_path=$HOME/diags
```

To limit the hosts where diags are gathered, use the `-l` or `--limit` with host patterns.

```
> ansible-playbook generate.yml -l dbservers
```

To customize the arguments passed to `sosreport` set the `sosreport_args` variable.

```
> ansible-playbook generate.yml -l dbservers -e -e "sosreport_args='--alloptions' diag_path=$HOME/diags"
```

# Custom sosreport Packages

By default, the OS distro `sosreport` packages are installed and used. Custom '.deb'
and '.rpm' packages can be used instead by setting some variables in the `config/custom.yml`
file.  For example, to install [omnibus-sosreport](http://github.com/jdutton/omnibus-sosreport)
packages built from source, you could create a `config/custom.yml` file as follows:

```
---
sosreport_path: /opt/sosreport/bin
custom_sosreport_pkgs: yes
rpm: pkg/sosreport-3.0_master-1.el6.x86_64.rpm
deb: pkg/sosreport_3.0-master-1.ubuntu.12.04_amd64.deb
```

Note the `rpm` and `deb` variables specify the full or relative path to the sosreport packages
to install.
