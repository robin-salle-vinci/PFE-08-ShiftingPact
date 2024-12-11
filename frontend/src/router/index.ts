import { getToken } from '@/utils/localstorage'
import DashboardView from '@/views/DashboardView.vue'
import EsgView from '@/views/EsgView.vue'
import ListPactView from '@/views/ListPactView.vue'
import PactView from '@/views/PactView.vue'
import axios from 'axios'
import { createRouter, createWebHistory } from 'vue-router'
import ESGFormView from '../views/ESGFormView.vue'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import ScoresView from '../views/ScoresView.vue'

function isEmployee() {
  const user = JSON.parse(localStorage.getItem('user') || '{}')
  return user && user.role === 'employee'
}

async function hasOpenEsg() {
  const response = await axios
    .get(`${import.meta.env.VITE_API_URL}/modules/`, {
      headers: {
        Authorization: `Bearer ${getToken()}`,
      },
    })
    .catch()
  for (const module of response.data) {
    if (module.state === 'open') {
      return true
    }
  }
  return false
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
      path: '/form/esg',
      name: 'formesg',
      component: ESGFormView,
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
      meta: { requiresEmployee: true },
    },
    {
      path: '/pact/:id',
      name: 'pact',
      component: PactView,
    },
    { path: '/listpact', name: 'listpact', component: ListPactView },
    {
      path: '/scores/:id',
      name: 'scores',
      component: ScoresView,
    },
  ],
})

router.beforeEach(async (to, from, next) => {
  const token = getToken()

  if (!token && to.path !== '/login') {
    next('/login')
  } else if (token) {
    const esgOpen = await hasOpenEsg()
    if (isEmployee() && to.path === '/') {
      next('/dashboard')
    } else if (!isEmployee() && to.path === '/dashboard') {
      next('/')
    } else if (to.matched.some((record) => record.meta.requiresEmployee) && !isEmployee()) {
      next('/')
    } else if (to.path === '/' && esgOpen) {
      next('/form/esg')
    } else if (to.path === '/' && !esgOpen) {
      next('/listpact')
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router
