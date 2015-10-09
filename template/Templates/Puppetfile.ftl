<#list modData as module>
mod '<#if module['module']?has_content>${module['module']}</#if>',
  <#if module['git']?has_content>:git => '${module['git']}'</#if>

</#list>

mod 'puppetlabs-stdlib',
  :git => "https://github.com/puppetlabs/puppetlabs-stdlib",
  :ref => "4.9.0"

mod 'puppetlabs-concat',
  :git => "https://github.com/puppetlabs/puppetlabs-concat",
  :ref => "1.2.4"

mod 'puppetlabs-vcsrepo',
  :git => "https://github.com/puppetlabs/puppetlabs-vcsrepo",
  :ref => "1.3.1"
