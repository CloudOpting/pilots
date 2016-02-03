node default {

mongodb_database { 'HttpC4C':
      user    => 'HttpC4C',
      password => HttpC4C,
      require => Class['mongodb::server']
}
}