node default {

class { 'apache':
      default_mods => false,
      
      servername => sesame,
      default_vhost => true,
    }


}