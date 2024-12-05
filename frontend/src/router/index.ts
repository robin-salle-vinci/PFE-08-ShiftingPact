import DashboardView from '@/views/DashboardView.vue'
import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'

// function isEmployee() {
//   const user = JSON.parse(localStorage.getItem('user') || '{}')
//   return user && user.role === 'employee'
// }

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView,
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: DashboardView,
      // beforeEnter: (to, from, next) => {
      //   if (isEmployee()) {
      //     next()
      //   } else {
      //     next('/login')
      //   }
      // },
    },
  ],
})

export default router
