mysql::db { '<#if dbname?has_content>${dbname}</#if>':
      <#if user?has_content>user    => '${user}',</#if>
      <#if password?has_content>password => ${password},</#if>
      <#if host?has_content>host => ${host},</#if>

}
