const resultPerPage = 3

function queryBuilder(search) {
  let query = { 'searches': [] }

  query.searches.push(
    {
      'collection': 'vlans',
      'query_by': 'name',
      'q': search,
    }
  )

  query.searches.push(
    {
      'collection': 'sections',
      'query_by': 'name',
      'q': search,
    }
  )

  query.searches.push(
    {
      'collection': 'rackspaces',
      'query_by': 'name',
      'q': search,
    }
  )

  query.searches.push(
    {
      'collection': 'devices',
      'query_by': 'name',
      'q': search,
    }
  )

  query.searches.push(
    {
      'collection': 'device_types',
      'query_by': 'name',
      'q': search,
    }
  )

  query.searches.push(
    {
      'collection': 'usages',
      'query_by': 'ip_used, fqdn, description, state',
      'q': search,
    }
  )

  return query
}

export { queryBuilder }
