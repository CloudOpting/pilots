apache::vhost { '<#if servername?has_content>${servername}</#if>':
      <#if port?has_content>port    => ${port},</#if>
      <#if vhost_name?has_content>vhost_name    => '${vhost_name}',</#if>
      <#if servername?has_content>servername    => '${servername}',</#if>
      <#if docroot?has_content>docroot => ${docroot},</#if>
}
