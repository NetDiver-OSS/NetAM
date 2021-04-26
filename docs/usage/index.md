# Usage guide

## Login / Register
-------------------

![Login](img/main/login.png)

This is where you login after creating an account or using your LDAP server.

![Register](img/main/register.png)

When you don't use your LDAP server, you will create your account here.

We recommend using a strong password.

# Main
------

After login , you will be redirected on the main page.

![main](img/main/main.png)

On the top center, you will have the search bar where you can find all your sections and access them.

On the center, you will have all the information of :

* The control node
    * CPU core
    * Memory Usage
    * Load Average
    * Uptime
*  Agent node

On the top right, you can change the theme (light / dark), change your language and user settings.

On the left, you have all the tools proposed by NetAM.

# Section
---------

![section](img/section/section.png)

This is where you can see all of your sections created with usage info, buttons to View, Scan, Edit or Delete a section

## View Section

![section](img/section/section_view.png)

On the View page, you have all the information of your network :

* Section VLAN
* Affected worker
* Last scan time

Network information :

* Locked IP
* Down IP
* Activated IP
* DHCP IP
* Free IP

On the bottom, you have 3 tabs where you can see your network in a different view.

### Address table

![section](img/section/section_view_table.png)

### Address Matrix

![section](img/section/section_view_matrix.png)

### All Jobs

![section](img/section/section_view_jobs.png)

Here are some logs for each job executed on this network.

## Create Section

![section_create](img/section/section_create.png)

After creating your section, you will return on the section page.

# Vlans
-------

![vlans](img/vlans/vlans.png)

This is where you can see all of your vlans created with info, button for View, Edit or Delete vlan.

Note : The default vlan here has been manually created.

## Vlan view

![vlan_view](img/vlans/vlans_view.png)

On this page, you can see all sections using a chosen vlan.

## Vlan edit

![vlan_view](img/vlans/vlans_edit.png)

## Create Vlan

![vlans_create](img/vlans/vlans_create.png)

* Vlan ID (Vid)
* Name of your vlan
* Description

# Devices
---------

![devices](img/devices/devices.png)

Define a device. You can edit their:

* Type (cf. [device_type](#devices_type)) of your devices
* Rack Height
* Depth Type
    * Small
    * Half
    * Full
* Rackspace
* Rack anchor

## Create Device

![devices_create](img/devices/devices_create.png)

## Edit Device

![devices_edit](img/devices/devices_edit.png)

# Devices Type
--------------

![devices_type](img/devices_type/devices_type.png)

Define a type of devices, you can change the color of the devices.

## Create Device Type

![devices_type_create](img/devices_type/devices_type_create.png)

## Edit Device Type

![devices_type_edit](img/devices_type/devices_type_edit.png)

# Rackspaces
------------

![rackspaces](img/rackspaces/rackspaces.png)

Rackspace section where you can create your rackspace for organization.

## Create Rackspaces

![rackspaces_create](img/rackspaces/rackspaces_create.png)

## Edit Rackspaces

![rackspaces_edit](img/rackspaces/rackspaces_edit.png)

## View Rackspaces

![rackspaces_view](img/rackspaces/rackspaces_view.png)

# Utils
-------

## IP Calculator

![ip_calculator](img/utils/ip_calculator.png)

Calculate network range per subnet.

## MAC Vendor

![mac_vendor](img/utils/mac_vendor.png)

Found a vendor with a Mac Address.

## Network Splitter

![network_splitter](img/utils/network_splitter.png)

Split a network range by a number of subnet.

## PTR Resolver

![ptr_resolver](img/utils/ptr_resolver.png)

Resolve a PTR

## DNS Resolver

![dns_resolver](img/utils/dns_resolver.png)

Resolve a DNS information

## Whois

![whois](img/utils/whois.png)

Whois tools for DNS / IP address info.

