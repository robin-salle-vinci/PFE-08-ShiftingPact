import { getToken } from '@/utils/localstorage'
import DashboardView from '@/views/DashboardView.vue'
import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import ESGFormView from '../views/ESGFormView.vue'

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
<<<<<<< HEAD
      path: '/form/esg',
      name: 'esg',
      component: ESGFormView,
=======
      path: '/dashboard',
      name: 'dashboard',
      component: DashboardView,
>>>>>>> 2a6946615ad6846b9d15c88c45c1be1f30e44513
    },
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
