class { 'mysql::server':
      <#if root_password?has_content>root_password => ${root_password},</#if>
      service_enabled => true,
    }


<#foreach childTemplate in childtemplates>
${childTemplate}
</#foreach>
