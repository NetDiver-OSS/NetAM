<script>
import { Client } from 'typesense'
import SearchItem from "./search-item";

export default {
  components: {SearchItem},
  props: {
    typesenseProtocol: {
      type: String,
      required: true
    },
    typesenseHost: {
      type: String,
      required: true
    },
    typesensePort: {
      type: String,
      required: true
    },
    typesenseApiKey: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      search: '',
      collections: [
        'sections',
        'vlans',
        'rackspaces'
      ],
      result: {},
    };
  },
  computed: {
    fields() {
      return {
        search: __('Search...')
      }
    }
  },
  methods: {
    typesenseClient() {
      return new Client({
        'nodes': [{
          'protocol': this.typesenseProtocol,
          'host': this.typesenseHost,
          'port': this.typesensePort
        }],
        'apiKey': this.typesenseApiKey,
        'connectionTimeoutSeconds': 2
      })
    },
    typeSenseQuery() {
      let searchParameters = {
        'q'         : this.search,
        'query_by'  : 'name',
        'per_page'  : 3
      }

      this.collections.forEach((collection) => {
        this.typesenseClient().collections(collection).documents().search(searchParameters).then((searchResults) => {
          this.result[collection] = searchResults.hits
        })
      })
    }
  }
}
</script>

<template>
  <div class="px-4 sm:px-6 lg:px-8">
    <form action="">
      <input type="search" @keypress="typeSenseQuery()" v-model="search" :placeholder="fields.search" class="bg-gray-700 text-white focus:outline-none px-3 h-10 w-full rounded" />
    </form>

    <div v-if="search !== '' && result !== []" class="relative top-15">
      <div class="absolute z-10 w-full bg-white dark:bg-gray-600 divide-y divide-gray-200 dark:divide-gray-700 shadow rounded-b">
        <search-item v-for="(items, resource) in this.result" :resource="resource" :items="items" />
      </div>
    </div>
  </div>
</template>
