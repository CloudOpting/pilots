class { 'apache':
      <#if servername?has_content>servername => ${servername},</#if>
      mpm_module => 'prefork',
      }

package {["php-mysql"]: ensure => "installed", }

<#foreach childTemplate in childtemplates>
${childTemplate}
</#foreach>
