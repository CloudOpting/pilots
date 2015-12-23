node default {

mongodb_database { 'root':
      user    => 'root',
      password => root,
      require => Class['mongodb::server']
}
}