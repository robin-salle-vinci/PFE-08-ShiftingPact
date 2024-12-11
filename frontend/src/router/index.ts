import { getToken } from '@/utils/localstorage'
import DashboardView from '@/views/DashboardView.vue'
import EsgView from '@/views/EsgView.vue'
import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import PactView from '@/views/PactView.vue'

function isEmployee() {
  const user = JSON.parse(localStorage.getItem('user') || '{}')
  return user && user.role === 'employee'
}

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
    },
    {
      path: '/esg/:id',
      name: 'esg',
      component: EsgView,
      props: true,
    },
    {
      path: '/pact/:id',
      name: 'pact',
      component: PactView,
      props: true,
    }
  ],
})
router.beforeEach((to, from, next) => {
  const token = getToken()
  if (!token && to.path !== '/login') {
    next('/login')
  } else if (token) {
    if (isEmployee() && to.path === '/') {
      next('/dashboard')
    } else if (!isEmployee() && to.path === '/dashboard') {
      next('/')
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router
