class icinganode {
  
  class{'::icinga':
    initdb           => true,
    enabled_features => ['statusdata', 'compatlog', 'command'],
  }

  class{'::icinga::classicui':
  }

  class{'::icinga::webgui':
    initdb              => true,    
  }
  
  class { '::mysql::server':
    root_password           => 'strongpassword',
    remove_default_accounts => true,
    override_options        => $override_options
  }
  
  class { 'apache':
    purge_configs => false,   
  }
  class {'::apache::mod::php': }
  
  mysql::db { 'icinga':
    user     => 'icinga',
    password => 'icinga',
    host     => 'localhost',
    grant    => ['ALL'],
  }
  mysql::db { 'icinga_web':
    user     => 'icinga_web',
    password => 'icinga_web',
    host     => 'localhost',
    grant    => ['ALL'],
  }
}

node centos6 {
  class{'::icinga':
    initdb           => true,
    enabled_features => ['statusdata', 'compatlog', 'command'],
  }
  
#  include icinganode
}

node ubuntu14 {

  package{"software-properties-common":
    ensure => present
  }
  class{'::icinga':
    initdb           => true,
    enabled_features => ['statusdata', 'compatlog', 'command'],
  }

  class{'::icinga::webgui':
    initdb => true,
  }
    
  class { '::mysql::server':
    root_password           => 'strongpassword',
    remove_default_accounts => true,
    override_options        => $override_options
  }
  
 # class { 'apache':
 #   purge_configs => false,   
 # }
 # class {'::apache::mod::php': }
  
  mysql::db { 'icinga':
    user     => 'icinga',
    password => 'icinga',
    host     => 'localhost',
    grant    => ['ALL'],
  }
  mysql::db { 'icinga_web':
    user     => 'icinga_web',
    password => 'icinga_web',
    host     => 'localhost',
    grant    => ['ALL'],
  }
}
