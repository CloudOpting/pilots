node default {

mongodb_database { 'MongoC4C':
      user    => 'MongoC4C',
      password => MongoC4C,
      require => Class['mongodb::server']
}
}