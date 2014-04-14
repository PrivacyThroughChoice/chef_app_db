name             'chef_app_db'
maintainer       'Fraser Scott'
maintainer_email 'admin@privacythroughchoice.org'

license          'MIT'
description      'Installs/Configures chef_app_db'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'mysql'
depends 'database', '~> 2.1'
