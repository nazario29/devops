Configure Rabbit
=========

Configuration tasks for Rabbit MQ was tested with the versions from 3.6.x to 3.8.x

Requirements
------------
OS
  - Ubuntu 18.4 or later
  - Windows 2016 or later

RabbitMQ should be installed. The RabbitMQ chocolatey package automatically installs the Erlang dependancy, which is usually the latest version of Erlang.

Role Variables
--------------

None

Dependencies
------------

Erlang and RabbitMQ need to be installed on the target system.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: configure-rabbitmq }