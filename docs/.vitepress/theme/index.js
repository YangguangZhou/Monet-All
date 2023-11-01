// .vitepress/theme/index.js
import DefaultTheme from 'vitepress/theme'
import './custom.css'
import { h } from 'vue'
import Documate from '@documate/vue'
import '@documate/vue/dist/style.css'

export default {
  ...DefaultTheme,
  Layout: h(DefaultTheme.Layout, null, {
    'nav-bar-content-before': () => h(Documate, {
      endpoint: 'https://hej3t2xt2v.us.aircode.run/upload',
    }),
  }),
}