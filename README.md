## Installation

Les instructions d'installation sont pour une machine basée sur Debian.

### ElasticSearch

* Installer ElasticSearch à l'aide du [paquet debian][debian-es]
* Démarrer le service `sudo service elasticsearch start`

### Postgresql

* Installer les paquets `postgresql` et `postgresql-contrib`
* Créer un utilisateur `ehstore` dédié à l'application
* Créer la base de développement
* Donner les privilèges à `ehstore` sur la base
* Activer l'extension hstore sur la base

[debian-es]: http://www.elasticsearch.org/overview/elkdownloads/
