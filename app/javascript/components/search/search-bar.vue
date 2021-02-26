<script>
import { Client } from 'typesense'
import SearchItem from "./search-item"
import { queryBuilder } from './search_query'

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
      this.typesenseClient().multiSearch.perform(queryBuilder(this.search)).then((result) => {
        this.result = result.results.filter(i => i.hits !== undefined)
      })
    }
  }
}
</script>

<template>
  <div class="px-4 sm:px-6 lg:px-8">
    <form action="">
      <input type="search" @keyup="typeSenseQuery()" v-model="search" :placeholder="fields.search" class="bg-gray-700 text-white focus:outline-none px-3 h-10 w-full rounded" />
    </form>

    <div v-if="search !== '' && result !== []" class="relative top-15">
      <div class="absolute z-10 w-full bg-white dark:bg-gray-600 divide-y divide-gray-200 dark:divide-gray-700 shadow rounded-b">
        <search-item v-for="item in this.result" :resource="item.request_params.collection_name" :items="item.hits" />
      </div>
    </div>
  </div>
</template>
