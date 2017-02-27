gentoo-overlay
==============

## Adding the overlay using layman

First create a local overlay list:

```sh
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE repositories SYSTEM "/dtd/repositories.dtd">
<repositories xmlns="" version="1.0">
  <repo quality="experimental" status="unofficial">
    <name>toaster</name>
    <description>toasters own ebuilds</description>
    <homepage>https://github.com/toaster/gentoo-overlay</homepage>
    <owner type="project">
       <email>tilo@pruetz.net</email>
       <name>Tilo Prütz</name>
    </owner>
    <source type="git">https://github.com/toaster/gentoo-overlay.git</source>
    <feed>https://github.com/feeds/toaster/commits/gentoo-overlay/master</feed>
  </repo>
</repositories>' > /etc/layman/overlays/toaster.xml
```

Then make it known to layman and add it to your local overlays:

```sh
layman -L
layman -a toaster
```
