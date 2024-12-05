import { fileURLToPath, URL } from 'node:url'

import vue from '@vitejs/plugin-vue'
import { defineConfig } from 'vite'
import vueDevTools from 'vite-plugin-vue-devtools' // TODO : remove vueDevTools in production

export default defineConfig({
  plugins: [vue(), vueDevTools()], // TODO : remove vueDevTools in production
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  server: {
    port: 3000,
    host: true,
  },
  define: {
    'process.env.API_URL': JSON.stringify(process.env.API_URL),
  },
})
