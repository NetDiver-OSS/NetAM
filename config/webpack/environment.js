const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

environment.plugins.append('Define', new webpack.DefinePlugin({
  VERSION: JSON.stringify(require("../../package.json").version)
}))

module.exports = environment
