node default {

class { 'apache':
      default_mods => false,
      
      servername => root,
      default_vhost => true,
    }


}