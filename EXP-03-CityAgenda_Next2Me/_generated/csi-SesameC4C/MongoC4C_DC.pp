node default {

mongodb_database { 'sesame':
      user    => 'sesame',
      password => sesame,
      require => Class['mongodb::server']
}
}