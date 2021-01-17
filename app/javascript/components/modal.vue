<script>
export default {
  props: {
    title: {
      type: String,
      required: true
    },
    message: {
      type: String,
      required: true
    }
  },
  data: function () {
    return {
      open: false,
    }
  },
  methods: {
    toggleClass() {
      this.$refs.bg_modal.classList.toggle('opacity-0')
      this.$refs.bg_modal.classList.toggle('opacity-100')

      this.$refs.modal.classList.toggle('opacity-0')
      this.$refs.modal.classList.toggle('translate-y-4')
      this.$refs.modal.classList.toggle('sm:translate-y-0')
      this.$refs.modal.classList.toggle('sm:scale-95')
      this.$refs.modal.classList.toggle('opacity-100')
      this.$refs.modal.classList.toggle('translate-y-0')
      this.$refs.modal.classList.toggle('sm:scale-100')
    },
    closeModal () {
      this.toggleClass()

      setTimeout(() => {
        this.open = false
      }, 500)
    }
  },
  computed: {
    fields() {
      return {
        close: __('Close'),
      }
    }
  },
  mounted() {
    this.open = true
    setTimeout(() => {
      this.toggleClass()
    }, 200)
  }
}
</script>

<template>
  <div v-if="open" class="fixed z-50 inset-0 overflow-y-auto">
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      <div class="fixed inset-0 transition-opacity ease-in-out duration-200 opacity-0" ref="bg_modal" aria-hidden="true">
        <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
      </div>

      <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

      <div class="inline-block ease-in-out duration-200 opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95 align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" ref="modal" role="dialog" aria-modal="true" aria-labelledby="modal-headline">
        <div class="bg-white dark:bg-gray-600 px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
          <div class="sm:flex sm:items-start">
            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
              <h3 class="text-lg leading-6 font-medium text-gray-900 dark:text-gray-100">
                {{ title }}
              </h3>
              <div class="mt-2">
                <p class="text-sm text-gray-500 dark:text-gray-400">
                  {{ message }}
                </p>
              </div>
            </div>
          </div>
        </div>
        <div class="bg-gray-50 dark:bg-gray-500 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
          <slot name="button" />
          <button type="button" @click="closeModal" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 dark:border-gray-700 shadow-sm px-4 py-2 bg-white dark:bg-gray-600 text-base font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
            {{ fields.close }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
